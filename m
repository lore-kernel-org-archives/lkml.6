Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8663C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7687520833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtUEC6cS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7687520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731495AbeGYTOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:14:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbeGYTOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:14:51 -0400
Received: from jouet.infradead.org (189-94-96-116.3g.claro.net.br [189.94.96.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A71F20893;
        Wed, 25 Jul 2018 18:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532541725;
        bh=l/MzquTLkPGFst83hWXHlgQxj+DqrxK7sSEN9apeIRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MtUEC6cSA1EVgQb8NoClvfy9PZ176salx+gPYtopvm9dZqKLY5RrxY3SgBwTQCXSv
         umPtbqKJlH/ACjIv47OIFW5wq2oqvCtM98RMApMhewqBdGzoTUUJ23X3nQd9CIl/AZ
         Be+Fw8JCZdOGBHKYWi+Pf21fCLy1/ZGmu9VwlVoo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Sandipan Das <sandipan@linux.ibm.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 19/27] perf script: Show correct offsets for DWARF-based unwinding
Date:   Wed, 25 Jul 2018 14:59:53 -0300
Message-Id: <20180725180001.15108-20-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandipan Das <sandipan@linux.ibm.com>

When perf/data is recorded with the dwarf call-graph option, the
callchain shown by 'perf script' still shows the binary offsets of the
userspace symbols instead of their virtual addresses. Since the symbol
offset calculation is based on using virtual address as the ip, we see
incorrect offsets as well.

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

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Fixes: 67540759151a ("perf unwind: Use addr_location::addr instead of ip for entries")
Link: http://lkml.kernel.org/r/20180703120555.32971-1-sandipan@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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

