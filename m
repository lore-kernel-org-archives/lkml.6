Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF58DC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB7D218D9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479072;
	bh=WrfjRCGK8svepgJ/tL2+M3Iowuu+TnGf019cJH882VM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IF8lX+5OtUOSo8OsQYI+pblbtVD3PPL59of6RsCzXZoZ6d5y9hVp87XXOQDteN31P
	 eepBU6xV23qzuAlL4xed7y7jxlA0tyXfy95CeONqU/xT7bBrxnGvI22GmL9eKVnRwk
	 W/YHZgb7Q9ZGMRMpBUkefc5Sv4b5bYQlg7Aidv6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfBFSvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:51:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbfBFSvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:51:08 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B59C218D4;
        Wed,  6 Feb 2019 18:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549479067;
        bh=WrfjRCGK8svepgJ/tL2+M3Iowuu+TnGf019cJH882VM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k6ltzIwUcoLBroRjgU9whe8f3ad8DLxGeAx8TgUdhXQOwQ75mZn9C9Qy7iM6SuZCw
         jvFJs0Pz4Uaefo9XG1du655hD5LnOBXAEgsOekqICAw2wC/Z3ELc9CcqidgKSk5uKX
         Md8GCFWf5o9R1735L4M8aRchBb7NR2LP22kwVxGM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 35/53] perf tools: Add documentation for BPF event selection
Date:   Wed,  6 Feb 2019 15:48:45 -0300
Message-Id: <20190206184903.24054-36-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

Add documentation for how to pass a BPF program as a perf event.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190201134651.12373-1-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 31 ++++++++++++++++++++++++
 tools/perf/Documentation/perf-record.txt | 14 +++++++++++
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
-- 
2.20.1

