Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DF5C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E43B20855
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfBIMvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:51:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59443 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIMvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:51:06 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CoruO2632609
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:50:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CorpV2632606;
        Sat, 9 Feb 2019 04:50:53 -0800
Date:   Sat, 9 Feb 2019 04:50:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Changbin Du <tipbot@zytor.com>
Message-ID: <tip-55fa8b8c0a37618c94df38d50d6871cb3e755ad2@git.kernel.org>
Cc:     acme@redhat.com, namhyung@kernel.org, changbin.du@gmail.com,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, jolsa@redhat.com, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, jolsa@redhat.com, hpa@zytor.com,
          mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
          changbin.du@gmail.com, acme@redhat.com, namhyung@kernel.org
In-Reply-To: <20190201134651.12373-1-changbin.du@gmail.com>
References: <20190201134651.12373-1-changbin.du@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add documentation for BPF event
 selection
Git-Commit-ID: 55fa8b8c0a37618c94df38d50d6871cb3e755ad2
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

Commit-ID:  55fa8b8c0a37618c94df38d50d6871cb3e755ad2
Gitweb:     https://git.kernel.org/tip/55fa8b8c0a37618c94df38d50d6871cb3e755ad2
Author:     Changbin Du <changbin.du@gmail.com>
AuthorDate: Fri, 1 Feb 2019 21:46:51 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:40 -0300

perf tools: Add documentation for BPF event selection

Add documentation for how to pass a BPF program as a perf event.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190201134651.12373-1-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 31 +++++++++++++++++++++++++++++++
 tools/perf/Documentation/perf-record.txt | 14 ++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 4ac7775fbc11..86f3dcc15f83 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -120,6 +120,10 @@ Given a $HOME/.perfconfig like this:
 		children = true
 		group = true
 
+	[llvm]
+		dump-obj = true
+		clang-opt = -g
+
 You can hide source code of annotate feature setting the config to false with
 
 	% perf config annotate.hide_src_code=true
@@ -553,6 +557,33 @@ trace.*::
 	trace.show_zeros::
 		Do not suppress syscall arguments that are equal to zero.
 
+llvm.*::
+	llvm.clang-path::
+		Path to clang. If omit, search it from $PATH.
+
+	llvm.clang-bpf-cmd-template::
+		Cmdline template. Below lines show its default value. Environment
+		variable is used to pass options.
+		"$CLANG_EXEC -D__KERNEL__ $CLANG_OPTIONS $KERNEL_INC_OPTIONS \
+		-Wno-unused-value -Wno-pointer-sign -working-directory \
+		$WORKING_DIR  -c $CLANG_SOURCE -target bpf -O2 -o -"
+
+	llvm.clang-opt::
+		Options passed to clang.
+
+	llvm.kbuild-dir::
+		kbuild directory. If not set, use /lib/modules/`uname -r`/build.
+		If set to "" deliberately, skip kernel header auto-detector.
+
+	llvm.kbuild-opts::
+		Options passed to 'make' when detecting kernel header options.
+
+	llvm.dump-obj::
+		Enable perf dump BPF object files compiled by LLVM.
+
+	llvm.opts::
+		Options passed to llc.
+
 SEE ALSO
 --------
 linkperf:perf[1]
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index d232b13ea713..02b4aa2621e7 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -88,6 +88,20 @@ OPTIONS
           If you want to profile write accesses in [0x1000~1008), just set
           'mem:0x1000/8:w'.
 
+        - a BPF source file (ending in .c) or a precompiled object file (ending
+          in .o) selects one or more BPF events.
+          The BPF program can attach to various perf events based on the ELF section
+          names.
+
+          When processing a '.c' file, perf searches an installed LLVM to compile it
+          into an object file first. Optional clang options can be passed via the
+          '--clang-opt' command line option, e.g.:
+
+            perf record --clang-opt "-DLINUX_VERSION_CODE=0x50000" \
+                        -e tests/bpf-script-example.c
+
+          Note: '--clang-opt' must be placed before '--event/-e'.
+
 	- a group of events surrounded by a pair of brace ("{event1,event2,...}").
 	  Each event is separated by commas and the group should be quoted to
 	  prevent the shell interpretation.  You also need to use --group on
