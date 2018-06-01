Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbeFABHn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 21:07:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:61910 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750929AbeFABHa (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 21:07:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,464,1520924400";
   d="scan'208";a="46392506"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 2/3] perf script python: Add more PMU fields
Date: Fri,  1 Jun 2018 17:01:02 +0800
Message-Id: <1527843663-32288-3-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527843663-32288-1-git-send-email-yao.jin@linux.intel.com>
References: <1527843663-32288-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing pmu sampling and then running a script with
perf script -s script.py, the process_event function gets
dictionary with some fields from the perf ring buffer
(like ip, sym, callchain etc).

But we miss quite a few fields we report now, for example,
LBRs,data source,weight,transaction,iregs,uregs,and etc.

This patch reports these fields for perf script python
processing.

New created keys/items:
-----------------------
key  : brstack
items: from, to, from_dsoname, to_dsoname, mispred,
       predicted, in_tx, abort, cycles.

key  : brstacksym
items: from, to, pred, in_tx, abort (converted string)

key  : datasrc
key  : datasrc_decode (decoded string)
key  : iregs
key  : uregs
key  : weight
key  : transaction

v2:
---
Add new fields for dso.
Use PyBool_FromLong() for mispred/predicted/in_tx/abort

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 .../util/scripting-engines/trace-event-python.c    | 227 ++++++++++++++++++++-
 1 file changed, 226 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index f863e96..9c29cfa3 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -48,6 +48,7 @@
 #include "cpumap.h"
 #include "print_binary.h"
 #include "stat.h"
+#include "mem-events.h"
 
 #if PY_MAJOR_VERSION < 3
 #define _PyUnicode_FromString(arg) \
@@ -455,6 +456,166 @@ static PyObject *python_process_callchain(struct perf_sample *sample,
 	return pylist;
 }
 
+static PyObject *python_process_brstack(struct perf_sample *sample,
+					struct thread *thread)
+{
+	struct branch_stack *br = sample->branch_stack;
+	PyObject *pylist;
+	u64 i;
+
+	pylist = PyList_New(0);
+	if (!pylist)
+		Py_FatalError("couldn't create Python list");
+
+	if (!(br && br->nr))
+		goto exit;
+
+	for (i = 0; i < br->nr; i++) {
+		PyObject *pyelem;
+		struct addr_location al;
+		const char *dsoname;
+
+		pyelem = PyDict_New();
+		if (!pyelem)
+			Py_FatalError("couldn't create Python dictionary");
+
+		pydict_set_item_string_decref(pyelem, "from",
+		    PyLong_FromUnsignedLongLong(br->entries[i].from));
+		pydict_set_item_string_decref(pyelem, "to",
+		    PyLong_FromUnsignedLongLong(br->entries[i].to));
+		pydict_set_item_string_decref(pyelem, "mispred",
+		    PyBool_FromLong(br->entries[i].flags.mispred));
+		pydict_set_item_string_decref(pyelem, "predicted",
+		    PyBool_FromLong(br->entries[i].flags.predicted));
+		pydict_set_item_string_decref(pyelem, "in_tx",
+		    PyBool_FromLong(br->entries[i].flags.in_tx));
+		pydict_set_item_string_decref(pyelem, "abort",
+		    PyBool_FromLong(br->entries[i].flags.abort));
+		pydict_set_item_string_decref(pyelem, "cycles",
+		    PyLong_FromUnsignedLongLong(br->entries[i].flags.cycles));
+
+		thread__find_map(thread, sample->cpumode,
+				 br->entries[i].from, &al);
+		dsoname = get_dsoname(al.map);
+		pydict_set_item_string_decref(pyelem, "from_dsoname",
+					      _PyUnicode_FromString(dsoname));
+
+		thread__find_map(thread, sample->cpumode,
+				 br->entries[i].to, &al);
+		dsoname = get_dsoname(al.map);
+		pydict_set_item_string_decref(pyelem, "to_dsoname",
+					      _PyUnicode_FromString(dsoname));
+
+		PyList_Append(pylist, pyelem);
+		Py_DECREF(pyelem);
+	}
+
+exit:
+	return pylist;
+}
+
+static unsigned long get_offset(struct symbol *sym, struct addr_location *al)
+{
+	unsigned long offset;
+
+	if (al->addr < sym->end)
+		offset = al->addr - sym->start;
+	else
+		offset = al->addr - al->map->start - sym->start;
+
+	return offset;
+}
+
+static int get_symoff(struct symbol *sym, struct addr_location *al,
+		      bool print_off, char *bf, int size)
+{
+	unsigned long offset;
+
+	if (!sym || !sym->name)
+		return scnprintf(bf, size, "%s", "[unknown]");
+
+	if (!print_off)
+		return scnprintf(bf, size, "%s", sym->name);
+
+	offset = get_offset(sym, al);
+
+	return scnprintf(bf, size, "%s+0x%x", sym->name, offset);
+}
+
+static int get_br_mspred(struct branch_flags *flags, char *bf, int size)
+{
+	if (!flags->mispred  && !flags->predicted)
+		return scnprintf(bf, size, "%s", "-");
+
+	if (flags->mispred)
+		return scnprintf(bf, size, "%s", "M");
+
+	return scnprintf(bf, size, "%s", "P");
+}
+
+static PyObject *python_process_brstacksym(struct perf_sample *sample,
+					   struct thread *thread)
+{
+	struct branch_stack *br = sample->branch_stack;
+	PyObject *pylist;
+	u64 i;
+	char bf[512];
+	struct addr_location al;
+
+	pylist = PyList_New(0);
+	if (!pylist)
+		Py_FatalError("couldn't create Python list");
+
+	if (!(br && br->nr))
+		goto exit;
+
+	for (i = 0; i < br->nr; i++) {
+		PyObject *pyelem;
+
+		pyelem = PyDict_New();
+		if (!pyelem)
+			Py_FatalError("couldn't create Python dictionary");
+
+		thread__find_symbol(thread, sample->cpumode,
+				    br->entries[i].from, &al);
+		get_symoff(al.sym, &al, true, bf, sizeof(bf));
+		pydict_set_item_string_decref(pyelem, "from",
+					      _PyUnicode_FromString(bf));
+
+		thread__find_symbol(thread, sample->cpumode,
+				    br->entries[i].to, &al);
+		get_symoff(al.sym, &al, true, bf, sizeof(bf));
+		pydict_set_item_string_decref(pyelem, "to",
+					      _PyUnicode_FromString(bf));
+
+		get_br_mspred(&br->entries[i].flags, bf, sizeof(bf));
+		pydict_set_item_string_decref(pyelem, "pred",
+					      _PyUnicode_FromString(bf));
+
+		if (br->entries[i].flags.in_tx) {
+			pydict_set_item_string_decref(pyelem, "in_tx",
+					      _PyUnicode_FromString("X"));
+		} else {
+			pydict_set_item_string_decref(pyelem, "in_tx",
+					      _PyUnicode_FromString("-"));
+		}
+
+		if (br->entries[i].flags.abort) {
+			pydict_set_item_string_decref(pyelem, "abort",
+					      _PyUnicode_FromString("A"));
+		} else {
+			pydict_set_item_string_decref(pyelem, "abort",
+					      _PyUnicode_FromString("-"));
+		}
+
+		PyList_Append(pylist, pyelem);
+		Py_DECREF(pyelem);
+	}
+
+exit:
+	return pylist;
+}
+
 static PyObject *get_sample_value_as_tuple(struct sample_read_value *value)
 {
 	PyObject *t;
@@ -505,12 +666,63 @@ static void set_sample_read_in_dict(PyObject *dict_sample,
 	pydict_set_item_string_decref(dict_sample, "values", values);
 }
 
+static void set_sample_datasrc_in_dict(PyObject *dict,
+				       struct perf_sample *sample)
+{
+	struct mem_info mi = { .data_src.val = sample->data_src };
+	char decode[100];
+
+	pydict_set_item_string_decref(dict, "datasrc",
+			PyLong_FromUnsignedLongLong(sample->data_src));
+
+	perf_script__meminfo_scnprintf(decode, 100, &mi);
+
+	pydict_set_item_string_decref(dict, "datasrc_decode",
+			_PyUnicode_FromString(decode));
+}
+
+static int regs_map(struct regs_dump *regs, uint64_t mask, char *bf, int size)
+{
+	unsigned int i = 0, r;
+	int printed = 0;
+
+	bf[0] = 0;
+
+	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
+		u64 val = regs->regs[i++];
+
+		printed += scnprintf(bf + printed, size - printed,
+				     "%5s:0x%" PRIx64 " ",
+				     perf_reg_name(r), val);
+	}
+
+	return printed;
+}
+
+static void set_regs_in_dict(PyObject *dict,
+			     struct perf_sample *sample,
+			     struct perf_evsel *evsel)
+{
+	struct perf_event_attr *attr = &evsel->attr;
+	char bf[512];
+
+	regs_map(&sample->intr_regs, attr->sample_regs_intr, bf, sizeof(bf));
+
+	pydict_set_item_string_decref(dict, "iregs",
+			_PyUnicode_FromString(bf));
+
+	regs_map(&sample->user_regs, attr->sample_regs_user, bf, sizeof(bf));
+
+	pydict_set_item_string_decref(dict, "uregs",
+			_PyUnicode_FromString(bf));
+}
+
 static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 					 struct perf_evsel *evsel,
 					 struct addr_location *al,
 					 PyObject *callchain)
 {
-	PyObject *dict, *dict_sample;
+	PyObject *dict, *dict_sample, *brstack, *brstacksym;
 
 	dict = PyDict_New();
 	if (!dict)
@@ -541,6 +753,11 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 	pydict_set_item_string_decref(dict_sample, "addr",
 			PyLong_FromUnsignedLongLong(sample->addr));
 	set_sample_read_in_dict(dict_sample, sample, evsel);
+	pydict_set_item_string_decref(dict_sample, "weight",
+			PyLong_FromUnsignedLongLong(sample->weight));
+	pydict_set_item_string_decref(dict_sample, "transaction",
+			PyLong_FromUnsignedLongLong(sample->transaction));
+	set_sample_datasrc_in_dict(dict_sample, sample);
 	pydict_set_item_string_decref(dict, "sample", dict_sample);
 
 	pydict_set_item_string_decref(dict, "raw_buf", _PyBytes_FromStringAndSize(
@@ -558,6 +775,14 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 
 	pydict_set_item_string_decref(dict, "callchain", callchain);
 
+	brstack = python_process_brstack(sample, al->thread);
+	pydict_set_item_string_decref(dict, "brstack", brstack);
+
+	brstacksym = python_process_brstacksym(sample, al->thread);
+	pydict_set_item_string_decref(dict, "brstacksym", brstacksym);
+
+	set_regs_in_dict(dict, sample, evsel);
+
 	return dict;
 }
 
-- 
2.7.4
