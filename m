Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884FAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436A720C0D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ts+1+blP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436A720C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392478AbeHPTif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:38:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392441AbeHPTif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:38:35 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A26C220C0D;
        Thu, 16 Aug 2018 16:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534437540;
        bh=EGV+Ihps72t2MSg3/tUq2WAvUqqkMOUJ8oZozMfUsuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ts+1+blPL3kHFLTIWaJPFoqNfbMlFKibE0I9FMLb/538YPWYbGHNyGM6ExlV71iv5
         NkCn//fsbVBQ5go8MSNPeEmW8uF9wxmMswVRTgRmAlWIy1Zfn18bryBw86pu0jus2z
         Zd1lfeMPaECezNFiUzviR6zcqU8ulmIb6maKXyDw=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/32] selftests/ftrace: Add kprobe-event with symbol argument test
Date:   Fri, 17 Aug 2018 01:38:37 +0900
Message-Id: <153443751761.23257.743998194793037725.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153443695002.23257.13628220023468200991.stgit@devbox>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a testcase for kprobe-event with @symbol argument.
Since @symbol needs to refer the kernel data symbol
(linux_proc_banner), it requires CONFIG_KALLSYMS_ALL.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/testing/selftests/ftrace/config              |    1 +
 .../ftrace/test.d/kprobe/kprobe_args_symbol.tc     |   39 ++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc

diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
index 32cf61b6bb54..b7ac74fcb0fa 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -11,3 +11,4 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_SAMPLES=y
 CONFIG_SAMPLE_TRACE_PRINTK=m
+CONFIG_KALLSYMS_ALL=y
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
new file mode 100644
index 000000000000..2b6dd33f9076
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_symbol.tc
@@ -0,0 +1,39 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe event symbol argument
+
+[ -f kprobe_events ] || exit_unsupported # this is configurable
+
+SYMBOL="linux_proc_banner"
+
+if [ ! -f /proc/kallsyms ]; then
+  echo "Can not check the target symbol - please enable CONFIG_KALLSYMS"
+  exit_unresolved
+elif ! grep "$SYMBOL\$" /proc/kallsyms; then
+  echo "Linux banner is not exported - please enable CONFIG_KALLSYMS_ALL"
+  exit_unresolved
+fi
+
+: "Test get basic types symbol argument"
+echo "p:testprobe_u _do_fork arg1=@linux_proc_banner:u64 arg2=@linux_proc_banner:u32 arg3=@linux_proc_banner:u16 arg4=@linux_proc_banner:u8" > kprobe_events
+echo "p:testprobe_s _do_fork arg1=@linux_proc_banner:s64 arg2=@linux_proc_banner:s32 arg3=@linux_proc_banner:s16 arg4=@linux_proc_banner:s8" >> kprobe_events
+if grep -q "x8/16/32/64" README; then
+  echo "p:testprobe_x _do_fork arg1=@linux_proc_banner:x64 arg2=@linux_proc_banner:x32 arg3=@linux_proc_banner:x16 arg4=@linux_proc_banner:x8" >> kprobe_events
+fi
+echo "p:testprobe_bf _do_fork arg1=@linux_proc_banner:b8@4/32" >> kprobe_events
+echo 1 > events/kprobes/enable
+(echo "forked")
+echo 0 > events/kprobes/enable
+grep "testprobe_[usx]:.* arg1=.* arg2=.* arg3=.* arg4=.*" trace
+grep "testprobe_bf:.* arg1=.*" trace
+
+: "Test get string symbol argument"
+echo "p:testprobe_str _do_fork arg1=@linux_proc_banner:string" > kprobe_events
+echo 1 > events/kprobes/enable
+(echo "forked")
+echo 0 > events/kprobes/enable
+RESULT=`grep "testprobe_str" trace | sed -e 's/.* arg1=\(.*\)/\1/'`
+
+RESULT=`echo $RESULT | sed -e 's/.* \((.*)\) \((.*)\) .*/\1 \2/'`
+ORIG=`cat /proc/version | sed -e 's/.* \((.*)\) \((.*)\) .*/\1 \2/'`
+test "$RESULT" = "$ORIG"

