Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AB6C6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 02:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C93520873
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 02:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgXsqOFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C93520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389487AbeG1Drd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 23:47:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389093AbeG1Drd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 23:47:33 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A12D20862;
        Sat, 28 Jul 2018 02:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532744575;
        bh=zBNgFys+OoLYf4LbEJsjIZmsKvb0ZNyKPMgIhEVPSdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EgXsqOFbJhLXxl/5X/LGiCk8/dpp5AyqoHtAkxQ+Xakr8ZUu6dtW5c3HqmWiiHnie
         1NQ5rfUH9EAmdy7GDiD9Fvere7+Y6wIeVpnqchDFg43wb7PTgiPBmB7qk2iK2gg8fa
         pd9lcmBDj7iM228ERCYScxEvV6AbXZ+p7MG5b+2w=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     rostedt@goodmis.org,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, Shuah Khan <shuah@kernel.org>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] selftests/ftrace: Fix kprobe string testcase to not probe notrace function
Date:   Sat, 28 Jul 2018 11:22:32 +0900
Message-Id: <153274455223.14940.8646138329186304758.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153274446603.14940.16028811307915635132.stgit@devbox>
References: <153274446603.14940.16028811307915635132.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kprobe string argument testcase to not probe notrace
function. Instead, it probes tracefs function which must
be available with ftrace.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v3:
  - Fix probepoint testcase too.
---
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |   30 ++++++++------------
 .../selftests/ftrace/test.d/kprobe/probepoint.tc   |    2 +
 2 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
index a0002563e9ee..1ad70cdaf442 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
@@ -9,28 +9,22 @@ echo > kprobe_events
 
 case `uname -m` in
 x86_64)
-  ARG2=%si
-  OFFS=8
+  ARG1=%di
 ;;
 i[3456]86)
-  ARG2=%cx
-  OFFS=4
+  ARG1=%ax
 ;;
 aarch64)
-  ARG2=%x1
-  OFFS=8
+  ARG1=%x0
 ;;
 arm*)
-  ARG2=%r1
-  OFFS=4
+  ARG1=%r0
 ;;
 ppc64*)
-  ARG2=%r4
-  OFFS=8
+  ARG1=%r3
 ;;
 ppc*)
-  ARG2=%r4
-  OFFS=4
+  ARG1=%r3
 ;;
 *)
   echo "Please implement other architecture here"
@@ -38,17 +32,17 @@ ppc*)
 esac
 
 : "Test get argument (1)"
-echo "p:testprobe create_trace_kprobe arg1=+0(+0(${ARG2})):string" > kprobe_events
+echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
-! echo test >> kprobe_events
-tail -n 1 trace | grep -qe "testprobe.* arg1=\"test\""
+echo "p:test _do_fork" >> kprobe_events
+grep -qe "testprobe.* arg1=\"test\"" trace
 
 echo 0 > events/kprobes/testprobe/enable
 : "Test get argument (2)"
-echo "p:testprobe create_trace_kprobe arg1=+0(+0(${ARG2})):string arg2=+0(+${OFFS}(${ARG2})):string" > kprobe_events
+echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string arg2=+0(${ARG1}):string" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
-! echo test1 test2 >> kprobe_events
-tail -n 1 trace | grep -qe "testprobe.* arg1=\"test1\" arg2=\"test2\""
+echo "p:test _do_fork" >> kprobe_events
+grep -qe "testprobe.* arg1=\"test\" arg2=\"test\"" trace
 
 echo 0 > events/enable
 echo > kprobe_events
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc b/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
index 4fda01a08da4..519d2763f5d2 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/probepoint.tc
@@ -4,7 +4,7 @@
 
 [ -f kprobe_events ] || exit_unsupported # this is configurable
 
-TARGET_FUNC=create_trace_kprobe
+TARGET_FUNC=tracefs_create_dir
 
 dec_addr() { # hexaddr
   printf "%d" "0x"`echo $1 | tail -c 8`

