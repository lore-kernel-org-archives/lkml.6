Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A33DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71002148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71002148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbeKLGV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:21:27 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50300 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730364AbeKLFsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:18 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvse-0000oF-T1; Sun, 11 Nov 2018 19:58:49 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsa-0001tZ-UY; Sun, 11 Nov 2018 19:58:44 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Mike Galbraith" <efault@gmx.de>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "David Ahern" <dsahern@gmail.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Don Zickus" <dzickus@redhat.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "Jiri Olsa" <jolsa@redhat.com>,
        "Frederic Weisbecker" <fweisbec@gmail.com>,
        "Stephane Eranian" <eranian@google.com>,
        "Paul Mackerras" <paulus@samba.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.81754596@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 361/366] perf trace: Fix up fd -> pathname resolution
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit cdcd1e6bd8a92f8353fc2f37003c6eae2d1e6903 upstream.

There was a brown paper bag bug in the patch that introduced a reference
implementation on using 'perf probe' made wannabe tracepoints that broke fd ->
pathname resolution, fix it:

  [root@zoo ~]# perf probe 'vfs_getname=getname_flags:65 pathname=result->name:string'
  Added new event:
    probe:vfs_getname    (on getname_flags:65 with pathname=result->name:string)

  You can now use it in all perf tools, such as:

	perf record -e probe:vfs_getname -aR sleep 1

  [root@zoo ~]

Before:

  [acme@zoo linux]$ trace touch -e open,fstat /tmp/b
     1.159 ( 0.007 ms): open(filename: 0x7fd73f2fe088, flags: CLOEXEC                         ) = 3
     1.163 ( 0.002 ms): fstat(fd: 3, statbuf: 0x7fff1b25e610                                  ) = 0
     1.192 ( 0.009 ms): open(filename: 0x7fd73f4fedb8, flags: CLOEXEC                         ) = 3
     1.201 ( 0.002 ms): fstat(fd: 3, statbuf: 0x7fff1b25e660                                  ) = 0
     1.501 ( 0.013 ms): open(filename: 0x7fd73f0a1610, flags: CLOEXEC                         ) = 3
     1.505 ( 0.002 ms): fstat(fd: 3, statbuf: 0x7fd73f2ddb60                                  ) = 0
     1.581 ( 0.011 ms): open(filename: 0x7fff1b2603da, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: 438) = 3
  [acme@zoo linux]$

After:

  [acme@zoo linux]$ trace touch -e open,fstat,dup2,mmap,close /tmp/b
     1.105 ( 0.004 ms): mmap(len: 4096, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS, fd: -1    ) = 0x2fbf000
     1.136 ( 0.008 ms): open(filename: 0x7f8902dbc088, flags: CLOEXEC                         ) = 3
     1.140 ( 0.002 ms): fstat(fd: 3</etc/ld.so.cache>, statbuf: 0x7fff19889ef0                ) = 0
     1.146 ( 0.004 ms): mmap(len: 86079, prot: READ, flags: PRIVATE, fd: 3</etc/ld.so.cache>  ) = 0x2fa9000
     1.149 ( 0.001 ms): close(fd: 3</etc/ld.so.cache>                                         ) = 0
     1.170 ( 0.010 ms): open(filename: 0x7f8902fbcdb8, flags: CLOEXEC                         ) = 3
     1.178 ( 0.002 ms): fstat(fd: 3</lib64/libc.so.6>, statbuf: 0x7fff19889f40                ) = 0
     1.188 ( 0.006 ms): mmap(len: 3924576, prot: EXEC|READ, flags: PRIVATE|DENYWRITE, fd: 3</lib64/libc.so.6>) = 0x29e2000
     1.207 ( 0.007 ms): mmap(addr: 0x7f8902d96000, len: 24576, prot: READ|WRITE, flags: PRIVATE|DENYWRITE|FIXED, fd: 3</lib64/libc.so.6>, off: 1785856) = 0x2d96000
     1.217 ( 0.004 ms): mmap(addr: 0x7f8902d9c000, len: 16992, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS|FIXED, fd: -1) = 0x2d9c000
     1.228 ( 0.002 ms): close(fd: 3</lib64/libc.so.6>                                         ) = 0
     1.243 ( 0.003 ms): mmap(len: 4096, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS, fd: -1    ) = 0x2fa8000
     1.250 ( 0.003 ms): mmap(len: 8192, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS, fd: -1    ) = 0x2fa6000
     1.452 ( 0.010 ms): open(filename: 0x7f8902b5f610, flags: CLOEXEC                         ) = 3
     1.455 ( 0.002 ms): fstat(fd: 3</usr/lib/locale/locale-archive>, statbuf: 0x7f8902d9bb60  ) = 0
     1.461 ( 0.004 ms): mmap(len: 106070960, prot: READ, flags: PRIVATE, fd: 3</usr/lib/locale/locale-archive>) = 0xfc4b9000
     1.469 ( 0.002 ms): close(fd: 3</usr/lib/locale/locale-archive>                           ) = 0
     1.528 ( 0.010 ms): open(filename: 0x7fff1988c3da, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: 438) = 3
     1.532 ( 0.002 ms): dup2(oldfd: 3</tmp/b>                                                 ) = 0
     1.535 ( 0.001 ms): close(fd: 3</tmp/b>                                                   ) = 0
     1.544 ( 0.001 ms): close(                                                                ) = 0
     1.555 ( 0.001 ms): close(fd: 1                                                           ) = 0
     1.558 ( 0.001 ms): close(fd: 2                                                           ) = 0
  [acme@zoo linux]$

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/n/tip-vcm22xpjxc3j4hbyuzjzf7ik@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 tools/perf/builtin-trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1276,11 +1276,11 @@ static const char *thread__fd_path(struc
 	if (fd < 0)
 		return NULL;
 
-	if ((fd > ttrace->paths.max || ttrace->paths.table[fd] == NULL))
+	if ((fd > ttrace->paths.max || ttrace->paths.table[fd] == NULL)) {
 		if (!trace->live)
 			return NULL;
 		++trace->stats.proc_getname;
-		if (thread__read_fd_path(thread, fd)) {
+		if (thread__read_fd_path(thread, fd))
 			return NULL;
 	}
 

