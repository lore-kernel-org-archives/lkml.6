Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELtgwDdbmZVo36BOsTvQMs0XVvXxEj/ArH6CWZO/+PqXhUpMf7zqxksvOznWPLeIMx0mMegc
ARC-Seal: i=1; a=rsa-sha256; t=1520945740; cv=none;
        d=google.com; s=arc-20160816;
        b=RDRGtuQ+Vv9SnKst8btfNePy996LDU7rllWCrN4IJTpbjSkp6e7p+JJ1DrDw6kDcyG
         J7P7UBJMQ1NKG3NzlpLjEDfJrLcZW95mEt7KyV8yRETEVpbatnm48nNP9iMO3XVdisey
         TRAfXNnmldJt4b8qkuzUUBc/r0TNikNRTdz1lAk2t1GlxB2CM1loxEFSZqkS2P6InL+J
         unWFU6TH8bOSGCH+G7ZuN/KdyekduzZU8shsHUhpIEwwoKFKXzLIkqUrIM2K+V+BcPaD
         GJddaY5ANkj2W9JvEob2QQ4Zins68892+ZGYHYmuxT2LfAvURuHg914C+uSmagJtu5Tu
         iBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=qpbJBXI1HDBlINj5lpvL2THZB0yP4nBX8rLFMAK5Y4A=;
        b=s9HJ1BZ0lQTdE0eeeE1E8CkMRMtm9iSG6T8mJ9as+zAAKeJqn9PasKiqaLV9Pzry84
         StoPIs+9NCX7dhIXn8dItyA+zPxpJQJCMIMLH/R3bwdMEU/JX7e98uYTtQVGSHujC4JT
         hzZaIrCWnLeYBmi5q/j1+aMnHjUKmkOkjSWGf6PNK487Itgb03LHzGAFzdYahOJ74VMT
         oPIwsjDBBGI0sgwffBwGjzHOlcOUMeF5NTNU7EPW7d7nFbGvhRHuChpq/FEiXJEwhEG9
         0sDxc+9vOYP7ZRAy2BDp5H0Sc6q44RDheNYHetjmIHYOSfuMtdmq1X8G0OHuaXXQC1/k
         GzpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
        srikar@linux.vnet.ibm.com
Cc: acme@kernel.org, ananth@linux.vnet.ibm.com, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, alexis.berlemont@gmail.com,
        corbet@lwn.net, dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        huawei.libin@huawei.com, hughd@google.com, jack@suse.cz,
        jglisse@redhat.com, jolsa@redhat.com, kan.liang@intel.com,
        kirill.shutemov@linux.intel.com, kjlx@templeofstupid.com,
        kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com, pombredanne@nexb.com,
        rostedt@goodmis.org, tglx@linutronix.de, tmricht@linux.vnet.ibm.com,
        willy@infradead.org, yao.jin@linux.intel.com, fengguang.wu@intel.com,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH 7/8] perf probe: Support SDT markers having reference counter (semaphore)
Date: Tue, 13 Mar 2018 18:26:02 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18031312-0040-0000-0000-0000041F00A3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031312-0041-0000-0000-000026222B87
Message-Id: <20180313125603.19819-8-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803130154
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827200789621673?=
X-GMAIL-MSGID: =?utf-8?q?1594827200789621673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

With this, perf buildid-cache will save SDT markers with reference
counter in probe cache. Perf probe will be able to probe markers
having reference counter. Ex,

  # readelf -n /tmp/tick | grep -A1 loop2
    Name: loop2
    ... Semaphore: 0x0000000010020036

  # ./perf buildid-cache --add /tmp/tick
  # ./perf probe sdt_tick:loop2
  # ./perf stat -e sdt_tick:loop2 /tmp/tick
    hi: 0
    hi: 1
    hi: 2
    ^C
     Performance counter stats for '/tmp/tick':
                 3      sdt_tick:loop2
       2.561851452 seconds time elapsed

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 tools/perf/util/probe-event.c | 21 +++++++++++++++++----
 tools/perf/util/probe-event.h |  1 +
 tools/perf/util/probe-file.c  | 22 +++++++++++++++++++---
 tools/perf/util/symbol-elf.c  | 10 ++++++++++
 tools/perf/util/symbol.h      |  1 +
 5 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index e1dbc98..2cbe68a 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1832,6 +1832,12 @@ int parse_probe_trace_command(const char *cmd, struct probe_trace_event *tev)
 			tp->offset = strtoul(fmt2_str, NULL, 10);
 	}
 
+	if (tev->uprobes) {
+		fmt2_str = strchr(p, '(');
+		if (fmt2_str)
+			tp->ref_ctr_offset = strtoul(fmt2_str + 1, NULL, 0);
+	}
+
 	tev->nargs = argc - 2;
 	tev->args = zalloc(sizeof(struct probe_trace_arg) * tev->nargs);
 	if (tev->args == NULL) {
@@ -2054,15 +2060,22 @@ char *synthesize_probe_trace_command(struct probe_trace_event *tev)
 	}
 
 	/* Use the tp->address for uprobes */
-	if (tev->uprobes)
-		err = strbuf_addf(&buf, "%s:0x%lx", tp->module, tp->address);
-	else if (!strncmp(tp->symbol, "0x", 2))
+	if (tev->uprobes) {
+		if (tp->ref_ctr_offset)
+			err = strbuf_addf(&buf, "%s:0x%lx(0x%lx)", tp->module,
+					  tp->address, tp->ref_ctr_offset);
+		else
+			err = strbuf_addf(&buf, "%s:0x%lx", tp->module,
+					  tp->address);
+	} else if (!strncmp(tp->symbol, "0x", 2)) {
 		/* Absolute address. See try_to_find_absolute_address() */
 		err = strbuf_addf(&buf, "%s%s0x%lx", tp->module ?: "",
 				  tp->module ? ":" : "", tp->address);
-	else
+	} else {
 		err = strbuf_addf(&buf, "%s%s%s+%lu", tp->module ?: "",
 				tp->module ? ":" : "", tp->symbol, tp->offset);
+	}
+
 	if (err)
 		goto error;
 
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index 45b14f0..15a98c3 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -27,6 +27,7 @@ struct probe_trace_point {
 	char		*symbol;	/* Base symbol */
 	char		*module;	/* Module name */
 	unsigned long	offset;		/* Offset from symbol */
+	unsigned long	ref_ctr_offset;	/* SDT reference counter offset */
 	unsigned long	address;	/* Actual address of the trace point */
 	bool		retprobe;	/* Return probe flag */
 };
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 4ae1123..08ba3a6 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -701,6 +701,12 @@ static unsigned long long sdt_note__get_addr(struct sdt_note *note)
 		 : (unsigned long long)note->addr.a64[0];
 }
 
+static unsigned long long sdt_note__get_ref_ctr_offset(struct sdt_note *note)
+{
+	return note->bit32 ? (unsigned long long)note->addr.a32[2]
+		: (unsigned long long)note->addr.a64[2];
+}
+
 static const char * const type_to_suffix[] = {
 	":s64", "", "", "", ":s32", "", ":s16", ":s8",
 	"", ":u8", ":u16", "", ":u32", "", "", "", ":u64"
@@ -776,14 +782,24 @@ static char *synthesize_sdt_probe_command(struct sdt_note *note,
 {
 	struct strbuf buf;
 	char *ret = NULL, **args;
-	int i, args_count;
+	int i, args_count, err;
+	unsigned long long ref_ctr_offset;
 
 	if (strbuf_init(&buf, 32) < 0)
 		return NULL;
 
-	if (strbuf_addf(&buf, "p:%s/%s %s:0x%llx",
+	ref_ctr_offset = sdt_note__get_ref_ctr_offset(note);
+
+	if (ref_ctr_offset)
+		err = strbuf_addf(&buf, "p:%s/%s %s:0x%llx(0x%llx)",
 				sdtgrp, note->name, pathname,
-				sdt_note__get_addr(note)) < 0)
+				sdt_note__get_addr(note), ref_ctr_offset);
+	else
+		err = strbuf_addf(&buf, "p:%s/%s %s:0x%llx",
+				sdtgrp, note->name, pathname,
+				sdt_note__get_addr(note));
+
+	if (err < 0)
 		goto error;
 
 	if (!note->args)
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 2de7705..76c7b54 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1928,6 +1928,16 @@ static int populate_sdt_note(Elf **elf, const char *data, size_t len,
 		}
 	}
 
+	/* Adjust reference counter offset */
+	if (elf_section_by_name(*elf, &ehdr, &shdr, SDT_PROBES_SCN, NULL)) {
+		if (shdr.sh_offset) {
+			if (tmp->bit32)
+				tmp->addr.a32[2] -= (shdr.sh_addr - shdr.sh_offset);
+			else
+				tmp->addr.a64[2] -= (shdr.sh_addr - shdr.sh_offset);
+		}
+	}
+
 	list_add_tail(&tmp->note_list, sdt_notes);
 	return 0;
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 70c16741..ad0c4f2 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -384,6 +384,7 @@ struct sdt_note {
 int cleanup_sdt_note_list(struct list_head *sdt_notes);
 int sdt_notes__get_count(struct list_head *start);
 
+#define SDT_PROBES_SCN ".probes"
 #define SDT_BASE_SCN ".stapsdt.base"
 #define SDT_NOTE_SCN  ".note.stapsdt"
 #define SDT_NOTE_TYPE 3
-- 
1.8.3.1
