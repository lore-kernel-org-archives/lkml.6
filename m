Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10A0C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9418208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN5tjSV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9418208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388156AbeG0Nig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:38:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730205AbeG0Nig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:38:36 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D922208AD;
        Fri, 27 Jul 2018 12:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532693816;
        bh=Cx8bgZ/4bb4qCrMtB8ILVPYfj40i7XTj6zsakcaeV5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eN5tjSV2cEKD2FKL8rXtaZhYxSFyNE6fuOAlNvSsqm3/26+llNohKnFJCA84aCfiA
         SmgGDdci/CP8pzxLsuZWeYsHGix10owBV6hbz0y/Qn8L7aT6Bj7zKAKQKUJXcRGbjL
         QC7qauDk2ryq552L9pHfHupCmPGeHsMpzTe7qJwU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/25] selftests/ftrace: Test kprobe-event argument with various bitsize
Date:   Fri, 27 Jul 2018 21:16:33 +0900
Message-Id: <153269379362.3084.6493537345417100466.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153269339575.3084.16279591141931053689.stgit@devbox>
References: <153269339575.3084.16279591141931053689.stgit@devbox>
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

