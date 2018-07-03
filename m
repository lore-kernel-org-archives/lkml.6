Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CA6C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BDF24C8E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BDF24C8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753156AbeGCMGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:06:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752185AbeGCMGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:06:07 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63C4e3E066264
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 08:06:06 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k05hdghmu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:06:06 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Tue, 3 Jul 2018 13:06:01 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 13:05:58 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w63C5vTv36438156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 12:05:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D7234204D;
        Tue,  3 Jul 2018 15:06:23 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D1B042045;
        Tue,  3 Jul 2018 15:06:22 +0100 (BST)
Received: from localhost.localdomain (unknown [9.195.22.129])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 15:06:22 +0100 (BST)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com,
        namhyung@kernel.org, milian.wolff@kdab.com,
        ravi.bangoria@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH] perf script: Show correct offsets for DWARF-based unwinding
Date:   Tue,  3 Jul 2018 17:35:55 +0530
X-Mailer: git-send-email 2.14.4
X-TM-AS-GCONF: 00
x-cbid: 18070312-0008-0000-0000-0000024F2FFB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070312-0009-0000-0000-000021B53E60
Message-Id: <20180703120555.32971-1-sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When perf data is recorded with the dwarf call-graph option, the
callchain shown by perf script still shows the binary offsets of
the userspace symbols instead of their virtual addresses. Since
the symbol offset calculation is based on using virtual address
as the ip, we see incorrect offsets as well.

The use of virtual addresses affects the ability to find out the
line number in the corresponding source file to which an address
maps to as described in commit 67540759151a ("perf unwind: Use
addr_location::addr instead of ip for entries").

This has also been addressed by temporarily converting the virtual
address to the correponding binary offset so that it can be mapped
to the source line number correctly.

This is a follow-up for commit 19610184693c ("perf script: Show
virtual addresses instead of offsets").

This can be verified on a powerpc64le system running Fedora 27 as
shown below:

  # perf probe -x /usr/lib64/libc-2.26.so -a inet_pton
  # perf record -e probe_libc:inet_pton --call-graph=dwarf ping -6 -c 1 ::1

Before:

  # perf report --stdio --no-children -s sym,srcline -g address

  # Samples: 1  of event 'probe_libc:inet_pton'
  # Event count (approx.): 1
  #
  # Overhead  Symbol                Source:Line
  # ........  ....................  ...........
  #
     100.00%  [.] __GI___inet_pton  inet_pton.c
              |
              ---gaih_inet getaddrinfo.c:537 (inlined)
                 __GI_getaddrinfo getaddrinfo.c:2304 (inlined)
                 main ping.c:519
                 generic_start_main libc-start.c:308 (inlined)
                 __libc_start_main libc-start.c:102
  ...

  # perf script -F comm,ip,sym,symoff,srcline,dso

  ping
                    15af28 __GI___inet_pton+0xffff000099160008 (/usr/lib64/libc-2.26.so)
    libc-2.26.so[ffff80004ca0af28]
                    10fa53 gaih_inet+0xffff000099160f43
    libc-2.26.so[ffff80004c9bfa53] (inlined)
                    1105b3 __GI_getaddrinfo+0xffff000099160163
    libc-2.26.so[ffff80004c9c05b3] (inlined)
                      2d6f main+0xfffffffd9f1003df (/usr/bin/ping)
    ping[fffffffecf882d6f]
                     2369f generic_start_main+0xffff00009916013f
    libc-2.26.so[ffff80004c8d369f] (inlined)
                     23897 __libc_start_main+0xffff0000991600b7 (/usr/lib64/libc-2.26.so)
    libc-2.26.so[ffff80004c8d3897]

After:

  # perf report --stdio --no-children -s sym,srcline -g address

  # Samples: 1  of event 'probe_libc:inet_pton'
  # Event count (approx.): 1
  #
  # Overhead  Symbol                Source:Line
  # ........  ....................  ...........
  #
     100.00%  [.] __GI___inet_pton  inet_pton.c
              |
              ---gaih_inet.constprop.7 getaddrinfo.c:537
                 getaddrinfo getaddrinfo.c:2304
                 main ping.c:519
                 generic_start_main.isra.0 libc-start.c:308
                 __libc_start_main libc-start.c:102
  ...

  # perf script -F comm,ip,sym,symoff,srcline,dso

  ping
              7fffb38aaf28 __GI___inet_pton+0x8 (/usr/lib64/libc-2.26.so)
    inet_pton.c:68
              7fffb385fa53 gaih_inet.constprop.7+0xf43 (/usr/lib64/libc-2.26.so)
    getaddrinfo.c:537
              7fffb38605b3 getaddrinfo+0x163 (/usr/lib64/libc-2.26.so)
    getaddrinfo.c:2304
                 130782d6f main+0x3df (/usr/bin/ping)
    ping.c:519
              7fffb377369f generic_start_main.isra.0+0x13f (/usr/lib64/libc-2.26.so)
    libc-start.c:308
              7fffb3773897 __libc_start_main+0xb7 (/usr/lib64/libc-2.26.so)
    libc-start.c:102

Fixes: 67540759151a ("perf unwind: Use addr_location::addr instead of ip for entries")
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/perf/util/machine.c                | 9 ++++++++-
 tools/perf/util/unwind-libdw.c           | 2 +-
 tools/perf/util/unwind-libunwind-local.c | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e7b4a8b513f2..22dbb6612b41 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2272,6 +2272,7 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 {
 	struct callchain_cursor *cursor = arg;
 	const char *srcline = NULL;
+	u64 addr;
 
 	if (symbol_conf.hide_unresolved && entry->sym == NULL)
 		return 0;
@@ -2279,7 +2280,13 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	if (append_inlines(cursor, entry->map, entry->sym, entry->ip) == 0)
 		return 0;
 
-	srcline = callchain_srcline(entry->map, entry->sym, entry->ip);
+	/*
+	 * Convert entry->ip from a virtual address to an offset in
+	 * its corresponding binary.
+	 */
+	addr = map__map_ip(entry->map, entry->ip);
+
+	srcline = callchain_srcline(entry->map, entry->sym, addr);
 	return callchain_cursor_append(cursor, entry->ip,
 				       entry->map, entry->sym,
 				       false, NULL, 0, 0, 0, srcline);
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 538db4e5d1e6..6f318b15950e 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -77,7 +77,7 @@ static int entry(u64 ip, struct unwind_info *ui)
 	if (__report_module(&al, ip, ui))
 		return -1;
 
-	e->ip  = al.addr;
+	e->ip  = ip;
 	e->map = al.map;
 	e->sym = al.sym;
 
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 6a11bc7e6b27..79f521a552cf 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -575,7 +575,7 @@ static int entry(u64 ip, struct thread *thread,
 	struct addr_location al;
 
 	e.sym = thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
-	e.ip = al.addr;
+	e.ip  = ip;
 	e.map = al.map;
 
 	pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
-- 
2.14.4

