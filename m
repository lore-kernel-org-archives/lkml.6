Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbeFABHc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 21:07:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:61910 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750729AbeFABH2 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 21:07:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,464,1520924400";
   d="scan'208";a="46392501"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 1/3] perf script python: Move dsoname code to a new function
Date: Fri,  1 Jun 2018 17:01:01 +0800
Message-Id: <1527843663-32288-2-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527843663-32288-1-git-send-email-yao.jin@linux.intel.com>
References: <1527843663-32288-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates a new function get_dsoname() and move the
code which gets the dsoname string to this function.

That's because in next patch, when we process LBR data, we will
also need get_dsoname() to return dsoname for branch from/to.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 .../util/scripting-engines/trace-event-python.c    | 23 ++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 7f8afac..f863e96 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -372,6 +372,19 @@ static PyObject *get_field_numeric_entry(struct event_format *event,
 	return obj;
 }
 
+static const char *get_dsoname(struct map *map)
+{
+	const char *dsoname = "[unknown]";
+
+	if (map && map->dso) {
+		if (symbol_conf.show_kernel_path && map->dso->long_name)
+			dsoname = map->dso->long_name;
+		else
+			dsoname = map->dso->name;
+	}
+
+	return dsoname;
+}
 
 static PyObject *python_process_callchain(struct perf_sample *sample,
 					 struct perf_evsel *evsel,
@@ -427,14 +440,8 @@ static PyObject *python_process_callchain(struct perf_sample *sample,
 		}
 
 		if (node->map) {
-			struct map *map = node->map;
-			const char *dsoname = "[unknown]";
-			if (map && map->dso) {
-				if (symbol_conf.show_kernel_path && map->dso->long_name)
-					dsoname = map->dso->long_name;
-				else
-					dsoname = map->dso->name;
-			}
+			const char *dsoname = get_dsoname(node->map);
+
 			pydict_set_item_string_decref(pyelem, "dso",
 					_PyUnicode_FromString(dsoname));
 		}
-- 
2.7.4
