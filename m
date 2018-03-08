Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755064AbeCHO5w (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 09:57:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752060AbeCHO5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 09:57:48 -0500
From: Thomas Richter <tmricht@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH] perf stat: Fix core dump when flag T is used
Date: Thu,  8 Mar 2018 15:57:35 +0100
X-Mailer: git-send-email 2.13.5
X-TM-AS-GCONF: 00
x-cbid: 18030814-0008-0000-0000-000004D96CDF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030814-0009-0000-0000-00001E6C8D5B
Message-Id: <20180308145735.64717-1-tmricht@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803080174
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Executing command 'perf stat -T -- ls' dumps core on x86 and s390.
Here is the call back chain (done on x86):
 # gdb ./perf
 ....
 (gdb) r stat -T -- ls
...
Program received signal SIGSEGV, Segmentation fault.
0x00007ffff56d1963 in vasprintf () from /lib64/libc.so.6
(gdb) where
 #0  0x00007ffff56d1963 in vasprintf () from /lib64/libc.so.6
 #1  0x00007ffff56ae484 in asprintf () from /lib64/libc.so.6
 #2  0x00000000004f1982 in __parse_events_add_pmu (parse_state=0x7fffffffd580,
    list=0xbfb970, name=0xbf3ef0 "cpu",
    head_config=0xbfb930, auto_merge_stats=false) at util/parse-events.c:1233
 #3  0x00000000004f1c8e in parse_events_add_pmu (parse_state=0x7fffffffd580,
    list=0xbfb970, name=0xbf3ef0 "cpu",
    head_config=0xbfb930) at util/parse-events.c:1288
 #4  0x0000000000537ce3 in parse_events_parse (_parse_state=0x7fffffffd580,
    scanner=0xbf4210) at util/parse-events.y:234
 #5  0x00000000004f2c7a in parse_events__scanner (str=0x6b66c0
    "task-clock,{instructions,cycles,cpu/cycles-t/,cpu/tx-start/}",
    parse_state=0x7fffffffd580, start_token=258) at util/parse-events.c:1673
 #6  0x00000000004f2e23 in parse_events (evlist=0xbe9990, str=0x6b66c0
    "task-clock,{instructions,cycles,cpu/cycles-t/,cpu/tx-start/}", err=0x0)
    at util/parse-events.c:1713
 #7  0x000000000044e137 in add_default_attributes () at builtin-stat.c:2281
 #8  0x000000000044f7b5 in cmd_stat (argc=1, argv=0x7fffffffe3b0) at
    builtin-stat.c:2828
 #9  0x00000000004c8b0f in run_builtin (p=0xab01a0 <commands+288>, argc=4,
    argv=0x7fffffffe3b0) at perf.c:297
 #10 0x00000000004c8d7c in handle_internal_command (argc=4,
    argv=0x7fffffffe3b0) at perf.c:349
 #11 0x00000000004c8ece in run_argv (argcp=0x7fffffffe20c,
   argv=0x7fffffffe200) at perf.c:393
 #12 0x00000000004c929c in main (argc=4, argv=0x7fffffffe3b0) at perf.c:537
(gdb)

It turns out that a NULL pointer is referenced. Here are the
function calls:

  ...
  cmd_stat()
  +---> add_default_attributes()
	+---> parse_events(evsel_list, transaction_attrs, NULL);
	             3rd parameter set to NULL

Function parse_events(xx, xx, struct parse_events_error *err) dives
into a bison generated scanner and creates
parser state information for it first:

   struct parse_events_state parse_state = {
                .list   = LIST_HEAD_INIT(parse_state.list),
                .idx    = evlist->nr_entries,
                .error  = err,   <--- NULL POINTER !!!
                .evlist = evlist,
        };

Now various functions inside the bison scanner are called to end up
in __parse_events_add_pmu(struct parse_events_state *parse_state, ..)
with first parameter being a pointer to above structure definition.

Now the PMU event name is not found (because being executed in a VM)
and this function tries to create an error message with
   asprintf(&parse_state->error.str, ....)
which references a NULL pointer and dumps core.

Fix this by providing a pointer to the necessary error information
instead of NULL. Technically only the else part is needed to avoid
the core dump, just lets be save...

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/builtin-stat.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 98bf9d32f222..86c8c8a9229c 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2274,11 +2274,16 @@ static int add_default_attributes(void)
 		return 0;
 
 	if (transaction_run) {
+		struct parse_events_error errinfo;
+
 		if (pmu_have_event("cpu", "cycles-ct") &&
 		    pmu_have_event("cpu", "el-start"))
-			err = parse_events(evsel_list, transaction_attrs, NULL);
+			err = parse_events(evsel_list, transaction_attrs,
+					   &errinfo);
 		else
-			err = parse_events(evsel_list, transaction_limited_attrs, NULL);
+			err = parse_events(evsel_list,
+					   transaction_limited_attrs,
+					   &errinfo);
 		if (err) {
 			fprintf(stderr, "Cannot set up transaction events\n");
 			return -1;
-- 
2.14.3
