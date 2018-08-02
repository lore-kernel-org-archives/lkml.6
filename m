Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B160C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E512145D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E512145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbeHBKCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:02:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60029 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeHBKCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:02:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w728CXQf3431267
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 01:12:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w728CXJp3431264;
        Thu, 2 Aug 2018 01:12:33 -0700
Date:   Thu, 2 Aug 2018 01:12:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-83868bf71d2eb7700b37f1ea188007f0125e4ee4@git.kernel.org>
Cc:     tglx@linutronix.de, brueckner@linux.ibm.com, stli@linux.ibm.com,
        heiko.carstens@de.ibm.com, tmricht@linux.ibm.com, acme@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        schwidefsky@de.ibm.com, acme@kernel.org, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, acme@redhat.com,
          tmricht@linux.ibm.com, heiko.carstens@de.ibm.com,
          stli@linux.ibm.com, brueckner@linux.ibm.com, tglx@linutronix.de,
          mingo@kernel.org, schwidefsky@de.ibm.com, acme@kernel.org
In-Reply-To: <20180731073254.91090-1-tmricht@linux.ibm.com>
References: <20180731073254.91090-1-tmricht@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf build: Fix installation directory for eBPF
Git-Commit-ID: 83868bf71d2eb7700b37f1ea188007f0125e4ee4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  83868bf71d2eb7700b37f1ea188007f0125e4ee4
Gitweb:     https://git.kernel.org/tip/83868bf71d2eb7700b37f1ea188007f0125e4ee4
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Tue, 31 Jul 2018 09:32:54 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 31 Jul 2018 10:54:50 -0300

perf build: Fix installation directory for eBPF

The perf tool build and install is controlled via a Makefile. The
'install' rule creates directories and copies files. Among them are
header files installed in /usr/lib/include/perf/bpf/.

However all listed examples are installing its header files in

  /usr/lib/<tool-name>/...[/include]/header.h

and not in

  /usr/lib/include/<tool-name>/.../header.h.

Background information:

Building the Fedora 28 glibc RPM on s390x and s390 fails on s390 (gcc
-m31) as gcc is not able to find header-files like stdbool.h.

In the glibc.spec file, you can see that glibc is configured with
"--with-headers". In this case, first -nostdinc is added to the CFLAGS
and then further include paths are added via -isystem.  One of those
paths should contain header files like stdbool.h.

In order to get this path, gcc is invoked with:

- on Fedora 28 (with 4.18 kernel):

  $ gcc -print-file-name=include
  /usr/lib/gcc/s390x-redhat-linux/8/include
  $ gcc -m31 -print-file-name=include
  /usr/lib/gcc/s390x-redhat-linux/8/../../../../lib/include
  => If perf is installed, this is: /usr/lib/include
  On my machine this directory is only containing the directory "perf".
  If perf is not installed gcc returns: /usr/lib/gcc/s390x-redhat-linux/8/include

- on Ubuntu 18.04 (with 4.15 kernel):

  $ gcc  -print-file-name=include
  /usr/lib/gcc/s390x-linux-gnu/7/include
  $ gcc -m31 -print-file-name=include
  /usr/lib/gcc/s390x-linux-gnu/7/include
  => gcc returns the correct path even if perf is installed.

In each case, the introduction of the subdirectory /usr/lib/include
leads to the regression that one can not build the glibc RPM for s390
anymore as gcc can not find headers like stdbool.h.

To remedy this install bpf.h to /usr/lib/perf/include/bpf/bpf.h

Output before using the command 'perf test -Fv 40':

  echo '...[bpf-program-source]...' | /usr/bin/clang ... \
		   -I/root/lib/include/perf/bpf ...
                               ^^^^^^^^^^^^
...
  [root@p23lp27 perf]# perf test -F 40
  40: BPF filter                                            :
  40.1: Basic BPF filtering                                 : Ok
  40.2: BPF pinning                                         : Ok
  40.3: BPF prologue generation                             : Ok
  40.4: BPF relocation checker                              : Ok
  [root@p23lp27 perf]#

Output after using command 'perf test -Fv 40':

  echo '...[bpf-program-source]...' | /usr/bin/clang ... \
		 -I/root/lib/perf/include/bpf ...
                             ^^^^^^^^^^^^
...
  [root@p23lp27 perf]# perf test -F 40
  40: BPF filter                                            :
  40.1: Basic BPF filtering                                 : Ok
  40.2: BPF pinning                                         : Ok
  40.3: BPF prologue generation                             : Ok
  40.4: BPF relocation checker                              : Ok
  [root@p23lp27 perf]#

Committer testing:

While the above 'perf test -F 40' (or 'perf test bpf') will allow us
to see that the correct path is now added via -I, to actually test this
we better try to use a bpf script that includes files in the changed
directory.

We have the files that now reside in /root/lib/perf/examples/bpf/ to do
just that:

  # tail -8 /root/lib/perf/examples/bpf/5sec.c
  #include <bpf.h>

  int probe(hrtimer_nanosleep, rqtp->tv_sec)(void *ctx, int err, long sec)
  {
	  return sec == 5;
  }

  license(GPL);
  # perf trace -e *sleep -e /root/lib/perf/examples/bpf/5sec.c sleep 4
       0.333 (4000.086 ms): sleep/9248 nanosleep(rqtp: 0x7ffc155f3300) = 0
  # perf trace -e *sleep -e /root/lib/perf/examples/bpf/5sec.c sleep 5
       0.287 (         ): sleep/9659 nanosleep(rqtp: 0x7ffeafe38200) ...
       0.290 (         ): perf_bpf_probe:hrtimer_nanosleep:(ffffffff9911efe0) tv_sec=5
       0.287 (5000.059 ms): sleep/9659  ... [continued]: nanosleep()) = 0
  # perf trace -e *sleep -e /root/lib/perf/examples/bpf/5sec.c sleep 6
       0.247 (5999.951 ms): sleep/10068 nanosleep(rqtp: 0x7fff2086d900) = 0
  # perf trace -e *sleep -e /root/lib/perf/examples/bpf/5sec.c sleep 5.987
       0.293 (         ): sleep/10489 nanosleep(rqtp: 0x7ffdd4fc10e0) ...
       0.296 (         ): perf_bpf_probe:hrtimer_nanosleep:(ffffffff9911efe0) tv_sec=5
       0.293 (5986.912 ms): sleep/10489  ... [continued]: nanosleep()) = 0
  #

Suggested-by: Stefan Liebler <stli@linux.ibm.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Fixes: 1b16fffa389d ("perf llvm-utils: Add bpf include path to clang command line")
Link: http://lkml.kernel.org/r/20180731073254.91090-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index d3318f99006c..f6d1a03c7523 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -907,8 +907,8 @@ bindir = $(abspath $(prefix)/$(bindir_relative))
 mandir = share/man
 infodir = share/info
 perfexecdir = libexec/perf-core
-perf_include_dir = lib/include/perf
-perf_examples_dir = lib/examples/perf
+perf_include_dir = lib/perf/include
+perf_examples_dir = lib/perf/examples
 sharedir = $(prefix)/share
 template_dir = share/perf-core/templates
 STRACE_GROUPS_DIR = share/perf-core/strace/groups
