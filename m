Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752352AbeEQGdl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:33:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752301AbeEQGdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:33:37 -0400
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@redhat.com
Cc: linux-kernel@vger.kernel.org, ravi.bangoria@linux.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH 2/2] perf script: Show symbol offsets by default
Date: Thu, 17 May 2018 12:03:26 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180517063326.6319-1-sandipan@linux.vnet.ibm.com>
References: <20180517063326.6319-1-sandipan@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051706-0040-0000-0000-0000045A515E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051706-0041-0000-0000-000020FE873F
Message-Id: <20180517063326.6319-2-sandipan@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805170059
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the ip shown for a symbol is now always a virtual address,
it becomes difficult to correlate this with objdump output and
determine the exact instruction address. So, we always show the
offset from the start of the symbol.

This can be verified on a powerpc64le system running Fedora 27
as follows:

  # perf probe -a sys_write
  # perf record -e probe:sys_write -g ~/test

Before applying this patch:

  # perf script

  test  9710 [013] 95614.332431: probe:sys_write: (c0000000004025b0)
          c0000000004025b0 sys_write (/lib/modules/4.17.0-rc4+/build/vmlinux)
          c00000000000b9e0 system_call (/lib/modules/4.17.0-rc4+/build/vmlinux)
              7fffb70d8234 __GI___libc_write (/usr/lib64/libc-2.26.so)
              7fffb7052c74 _IO_file_write@@GLIBC_2.17 (/usr/lib64/libc-2.26.so)
                  5afc1818 [unknown] ([unknown])
              7fffb7051a60 new_do_write (/usr/lib64/libc-2.26.so)
              7fffb7054638 _IO_do_write@@GLIBC_2.17 (/usr/lib64/libc-2.26.so)
              7fffb7054bbc _IO_file_overflow@@GLIBC_2.17 (/usr/lib64/libc-2.26.so)
              7fffb7055a24 __overflow (/usr/lib64/libc-2.26.so)
              7fffb7044548 _IO_puts (/usr/lib64/libc-2.26.so)
                  10000440 main (/home/sandipan/test)
              7fffb6fe36a0 generic_start_main.isra.0 (/usr/lib64/libc-2.26.so)
              7fffb6fe3898 __libc_start_main (/usr/lib64/libc-2.26.so)
                         0 [unknown] ([unknown])
  ...

After applying this patch:

  # perf script

  test  9710 [013] 95614.332431: probe:sys_write: (c0000000004025b0)
          c0000000004025b0 sys_write+0x10 (/lib/modules/4.17.0-rc4+/build/vmlinux)
          c00000000000b9e0 system_call+0x58 (/lib/modules/4.17.0-rc4+/build/vmlinux)
              7fffb70d8234 __GI___libc_write+0x24 (/usr/lib64/libc-2.26.so)
              7fffb7052c74 _IO_file_write@@GLIBC_2.17+0x44 (/usr/lib64/libc-2.26.so)
                  5afc1818 [unknown] ([unknown])
              7fffb7051a60 new_do_write+0x90 (/usr/lib64/libc-2.26.so)
              7fffb7054638 _IO_do_write@@GLIBC_2.17+0x38 (/usr/lib64/libc-2.26.so)
              7fffb7054bbc _IO_file_overflow@@GLIBC_2.17+0x14c (/usr/lib64/libc-2.26.so)
              7fffb7055a24 __overflow+0x64 (/usr/lib64/libc-2.26.so)
              7fffb7044548 _IO_puts+0x218 (/usr/lib64/libc-2.26.so)
                  10000440 main+0x20 (/home/sandipan/test)
              7fffb6fe36a0 generic_start_main.isra.0+0x140 (/usr/lib64/libc-2.26.so)
              7fffb6fe3898 __libc_start_main+0xb8 (/usr/lib64/libc-2.26.so)
                         0 [unknown] ([unknown])
  ...

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
 tools/perf/builtin-script.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index fa2c7a288750..cefc8813e91e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -153,8 +153,8 @@ static struct {
 		.fields = PERF_OUTPUT_COMM | PERF_OUTPUT_TID |
 			      PERF_OUTPUT_CPU | PERF_OUTPUT_TIME |
 			      PERF_OUTPUT_EVNAME | PERF_OUTPUT_IP |
-			      PERF_OUTPUT_SYM | PERF_OUTPUT_DSO |
-			      PERF_OUTPUT_PERIOD,
+			      PERF_OUTPUT_SYM | PERF_OUTPUT_SYMOFFSET |
+			      PERF_OUTPUT_DSO | PERF_OUTPUT_PERIOD,
 
 		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
 	},
@@ -165,8 +165,9 @@ static struct {
 		.fields = PERF_OUTPUT_COMM | PERF_OUTPUT_TID |
 			      PERF_OUTPUT_CPU | PERF_OUTPUT_TIME |
 			      PERF_OUTPUT_EVNAME | PERF_OUTPUT_IP |
-			      PERF_OUTPUT_SYM | PERF_OUTPUT_DSO |
-			      PERF_OUTPUT_PERIOD | PERF_OUTPUT_BPF_OUTPUT,
+			      PERF_OUTPUT_SYM | PERF_OUTPUT_SYMOFFSET |
+			      PERF_OUTPUT_DSO | PERF_OUTPUT_PERIOD |
+			      PERF_OUTPUT_BPF_OUTPUT,
 
 		.invalid_fields = PERF_OUTPUT_TRACE,
 	},
@@ -185,10 +186,10 @@ static struct {
 		.fields = PERF_OUTPUT_COMM | PERF_OUTPUT_TID |
 			      PERF_OUTPUT_CPU | PERF_OUTPUT_TIME |
 			      PERF_OUTPUT_EVNAME | PERF_OUTPUT_IP |
-			      PERF_OUTPUT_SYM | PERF_OUTPUT_DSO |
-			      PERF_OUTPUT_PERIOD |  PERF_OUTPUT_ADDR |
-			      PERF_OUTPUT_DATA_SRC | PERF_OUTPUT_WEIGHT |
-			      PERF_OUTPUT_PHYS_ADDR,
+			      PERF_OUTPUT_SYM | PERF_OUTPUT_SYMOFFSET |
+			      PERF_OUTPUT_DSO | PERF_OUTPUT_PERIOD |
+			      PERF_OUTPUT_ADDR | PERF_OUTPUT_DATA_SRC |
+			      PERF_OUTPUT_WEIGHT | PERF_OUTPUT_PHYS_ADDR,
 
 		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
 	},
@@ -199,8 +200,8 @@ static struct {
 		.fields = PERF_OUTPUT_COMM | PERF_OUTPUT_TID |
 			      PERF_OUTPUT_CPU | PERF_OUTPUT_TIME |
 			      PERF_OUTPUT_EVNAME | PERF_OUTPUT_IP |
-			      PERF_OUTPUT_SYM | PERF_OUTPUT_DSO |
-			      PERF_OUTPUT_PERIOD,
+			      PERF_OUTPUT_SYM | PERF_OUTPUT_SYMOFFSET |
+			      PERF_OUTPUT_DSO | PERF_OUTPUT_PERIOD,
 
 		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
 	},
@@ -211,8 +212,8 @@ static struct {
 		.fields = PERF_OUTPUT_COMM | PERF_OUTPUT_TID |
 			      PERF_OUTPUT_CPU | PERF_OUTPUT_TIME |
 			      PERF_OUTPUT_EVNAME | PERF_OUTPUT_IP |
-			      PERF_OUTPUT_SYM | PERF_OUTPUT_DSO |
-			      PERF_OUTPUT_SYNTH,
+			      PERF_OUTPUT_SYM | PERF_OUTPUT_SYMOFFSET |
+			      PERF_OUTPUT_DSO | PERF_OUTPUT_SYNTH,
 
 		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
 	},
@@ -544,6 +545,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
 			if (attr->sample_type & PERF_SAMPLE_CALLCHAIN) {
 				output[j].fields |= PERF_OUTPUT_IP;
 				output[j].fields |= PERF_OUTPUT_SYM;
+				output[j].fields |= PERF_OUTPUT_SYMOFFSET;
 				output[j].fields |= PERF_OUTPUT_DSO;
 				set_print_ip_opts(attr);
 				goto out;
-- 
2.14.3
