Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBCBC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CE72073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2CR9mJnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CE72073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbeH3SVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:21:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729069AbeH3SVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:21:48 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1661A2073D;
        Thu, 30 Aug 2018 14:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535638766;
        bh=Cx8bgZ/4bb4qCrMtB8ILVPYfj40i7XTj6zsakcaeV5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2CR9mJnfsCqEKN0d3FBcoqmZp0pWKpUlkbm4Y+tMhdGZZRdbsIzbsov3j0nC67bdK
         JaMxSTO2uP/lytLl5me6BUjrQwj5hUk/XAwl11WL1n9Ha6h6iDPB2TmXgLXRbXYSOR
         04JYD52e0I+dgvbolooQ3TijSBgjvXV7NzKr9dnU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/28] selftests/ftrace: Test kprobe-event argument with various bitsize
Date:   Thu, 30 Aug 2018 23:19:03 +0900
Message-Id: <153563874302.29700.17341920238751505933.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153563834333.29700.11242968505215651399.stgit@devbox>
References: <153563834333.29700.11242968505215651399.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the kprobe-event with argument types testcase
to test it with various bitsize.
kprobe-event argument can be recorded in given types with
various bitsize (8, 16, 32, 64), thus the type testcase
should test the different bitsize too.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_args_type.tc       |   48 +++++++++++++-------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
index 37443dd23d15..1bcb67dcae26 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_type.tc
@@ -6,29 +6,45 @@
 
 grep "x8/16/32/64" README > /dev/null || exit_unsupported # version issue
 
-echo 'p:testprobe _do_fork $stack0:s32 $stack0:u32 $stack0:x32 $stack0:b8@4/32' > kprobe_events
-grep testprobe kprobe_events
-test -d events/kprobes/testprobe
-
-echo 1 > events/kprobes/testprobe/enable
-( echo "forked")
-echo 0 > events/kprobes/testprobe/enable
-ARGS=`tail -n 1 trace | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
+gen_event() { # Bitsize
+  echo "p:testprobe _do_fork \$stack0:s$1 \$stack0:u$1 \$stack0:x$1 \$stack0:b4@4/$1"
+}
 
-check_types() {
-  X1=`printf "%x" $1 | tail -c 8`
+check_types() { # s-type u-type x-type bf-type width
+  test $# -eq 5
+  CW=$5
+  CW=$((CW / 4))
+  X1=`printf "%x" $1 | tail -c ${CW}`
   X2=`printf "%x" $2`
   X3=`printf "%x" $3`
   test $X1 = $X2
   test $X2 = $X3
   test 0x$X3 = $3
 
-  B4=`printf "%02x" $4`
-  B3=`echo -n $X3 | tail -c 3 | head -c 2`
+  B4=`printf "%1x" $4`
+  B3=`printf "%03x" 0x$X3 | tail -c 2 | head -c 1`
   test $B3 = $B4
 }
-check_types $ARGS
 
-echo "-:testprobe" >> kprobe_events
-clear_trace
-test -d events/kprobes/testprobe && exit_fail || exit_pass
+for width in 64 32 16 8; do
+  : "Add new event with basic types"
+  gen_event $width > kprobe_events
+  grep testprobe kprobe_events
+  test -d events/kprobes/testprobe
+
+  : "Trace the event"
+  echo 1 > events/kprobes/testprobe/enable
+  ( echo "forked")
+  echo 0 > events/kprobes/testprobe/enable
+
+  : "Confirm the arguments is recorded in given types correctly"
+  ARGS=`grep "testprobe" trace | sed -e 's/.* arg1=\(.*\) arg2=\(.*\) arg3=\(.*\) arg4=\(.*\)/\1 \2 \3 \4/'`
+  check_types $ARGS $width
+
+  : "Clear event for next loop"
+  echo "-:testprobe" >> kprobe_events
+  clear_trace
+
+done
+
+exit_pass

