Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25303C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61F72147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfBUJ6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:58:09 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3714 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727219AbfBUJ6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:58:08 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 91A39B5B1F06E4889C2B;
        Thu, 21 Feb 2019 17:58:04 +0800 (CST)
Received: from euler.huawei.com (10.175.104.193) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Thu, 21 Feb 2019 17:58:00 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <yao.jin@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf: fix getting source line failure in annotate
Date:   Thu, 21 Feb 2019 17:57:16 +0800
Message-ID: <20190221095716.39529-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.193]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The output of "perf annotate -l --stdio xxx" changed since commit 425859ff0de33 ("perf
annotate: No need to calculate notes->start twice") removed notes->start assignment
in symbol__calc_lines(). It will get failed in find_address_in_section() from
symbol__tty_annotate() subroutine as the a2l->addr is wrong. So the annotate summary
doesn't report the line number of source code correctly.

Before fix:

liwei@euler:~/main_code/hulk_work/hulk/tools/perf$ cat common_while_1.c 
void hotspot_1(void)
{
	volatile int i;

	for (i = 0; i < 0x10000000; i++);
	for (i = 0; i < 0x10000000; i++);
	for (i = 0; i < 0x10000000; i++);
}

int main(void)
{
	hotspot_1();

	return 0;
}
liwei@euler:~/main_code/hulk_work/hulk/tools/perf$ gcc common_while_1.c -g -o common_while_1

liwei@euler:~/main_code/hulk_work/hulk/tools/perf$ sudo ./perf record ./common_while_1
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.488 MB perf.data (12498 samples) ]
liwei@euler:~/main_code/hulk_work/hulk/tools/perf$ sudo ./perf annotate -l -s hotspot_1 --stdio

Sorted summary for file /home/liwei/main_code/hulk_work/hulk/tools/perf/common_while_1
----------------------------------------------

   19.30 common_while_1[32]
   19.03 common_while_1[4e]
   19.01 common_while_1[16]
    5.04 common_while_1[13]
    4.99 common_while_1[4b]
    4.78 common_while_1[2c]
    4.77 common_while_1[10]
    4.66 common_while_1[2f]
    4.59 common_while_1[51]
    4.59 common_while_1[35]
    4.52 common_while_1[19]
    4.20 common_while_1[56]
    0.51 common_while_1[48]
 Percent |      Source code & Disassembly of common_while_1 for cycles:ppp (12480 samples, percent: local period)
-----------------------------------------------------------------------------------------------------------------
         :
         :
         :
         :         Disassembly of section .text:
         :
         :         00000000000005fa <hotspot_1>:
         :         hotspot_1():
         :         void hotspot_1(void)
         :         {
    0.00 :   5fa:   push   %rbp
    0.00 :   5fb:   mov    %rsp,%rbp
         :                 volatile int i;
         :
         :                 for (i = 0; i < 0x10000000; i++);
    0.00 :   5fe:   movl   $0x0,-0x4(%rbp)
    0.00 :   605:   jmp    610 <hotspot_1+0x16>
    0.00 :   607:   mov    -0x4(%rbp),%eax
 common_while_1[10]    4.77 :   60a:   add    $0x1,%eax
 common_while_1[13]    5.04 :   60d:   mov    %eax,-0x4(%rbp)
 common_while_1[16]   19.01 :   610:   mov    -0x4(%rbp),%eax
 common_while_1[19]    4.52 :   613:   cmp    $0xfffffff,%eax
    0.00 :   618:   jle    607 <hotspot_1+0xd>
         :                 for (i = 0; i < 0x10000000; i++);
...

After fix:

liwei@euler:~/main_code/hulk_work/hulk/tools/perf$ sudo ./perf record ./common_while_1
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.488 MB perf.data (12500 samples) ]
liwei@euler:~/main_code/hulk_work/hulk/tools/perf$ sudo ./perf annotate -l -s hotspot_1 --stdio

Sorted summary for file /home/liwei/main_code/hulk_work/hulk/tools/perf/common_while_1
----------------------------------------------

   33.34 common_while_1.c:5
   33.34 common_while_1.c:6
   33.32 common_while_1.c:7
 Percent |      Source code & Disassembly of common_while_1 for cycles:ppp (12482 samples, percent: local period)
-----------------------------------------------------------------------------------------------------------------
         :
         :
         :
         :         Disassembly of section .text:
         :
         :         00000000000005fa <hotspot_1>:
         :         hotspot_1():
         :         void hotspot_1(void)
         :         {
    0.00 :   5fa:   push   %rbp
    0.00 :   5fb:   mov    %rsp,%rbp
         :                 volatile int i;
         :
         :                 for (i = 0; i < 0x10000000; i++);
    0.00 :   5fe:   movl   $0x0,-0x4(%rbp)
    0.00 :   605:   jmp    610 <hotspot_1+0x16>
    0.00 :   607:   mov    -0x4(%rbp),%eax
 common_while_1.c:5    4.70 :   60a:   add    $0x1,%eax
    4.89 :   60d:   mov    %eax,-0x4(%rbp)
 common_while_1.c:5   19.03 :   610:   mov    -0x4(%rbp),%eax
 common_while_1.c:5    4.72 :   613:   cmp    $0xfffffff,%eax
    0.00 :   618:   jle    607 <hotspot_1+0xd>
         :                 for (i = 0; i < 0x10000000; i++);
    0.00 :   61a:   movl   $0x0,-0x4(%rbp)
    0.00 :   621:   jmp    62c <hotspot_1+0x32>
    0.00 :   623:   mov    -0x4(%rbp),%eax
 common_while_1.c:6    4.54 :   626:   add    $0x1,%eax
    4.73 :   629:   mov    %eax,-0x4(%rbp)
 common_while_1.c:6   19.54 :   62c:   mov    -0x4(%rbp),%eax
 common_while_1.c:6    4.54 :   62f:   cmp    $0xfffffff,%eax
...

Fixes: 425859ff0de33 ("perf annotate: No need to calculate notes->start twice")
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/perf/util/annotate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 70de8f6b3aee..9142fd294e76 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1889,6 +1889,7 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 		     struct annotation_options *options,
 		     struct arch **parch)
 {
+	struct annotation *notes = symbol__annotation(sym);
 	struct annotate_args args = {
 		.privsize	= privsize,
 		.evsel		= evsel,
@@ -1919,6 +1920,7 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 
 	args.ms.map = map;
 	args.ms.sym = sym;
+	notes->start = map__rip_2objdump(map, sym->start);
 
 	return symbol__disassemble(sym, &args);
 }
@@ -2794,8 +2796,6 @@ int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *ev
 
 	symbol__calc_percent(sym, evsel);
 
-	notes->start = map__rip_2objdump(map, sym->start);
-
 	annotation__set_offsets(notes, size);
 	annotation__mark_jump_targets(notes, sym);
 	annotation__compute_ipc(notes, size);
-- 
2.17.1

