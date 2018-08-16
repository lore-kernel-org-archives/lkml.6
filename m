Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02009C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B147320C0D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xLWNBXAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B147320C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404406AbeHPTer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:34:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729181AbeHPTer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:34:47 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C42421486;
        Thu, 16 Aug 2018 16:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534437314;
        bh=XhyNu/kQumpkPmPHBTweSx0HrDPPSWBy9vrMYXJthoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xLWNBXAYZDtbNYudhJr/rRrGiJKd2DM1DrHi7SJwyUtXjzeOMxGJ3jckNIeCVl60M
         wf3JzXV5rzYnuPtf6rQyKrZTN0DIBHaq7aXMuAVOQ4BL9XrsLl70P3nYpB5xVM9Ayg
         RulGJOz411EvDUxRa+ygErjdhwDXDse73no0xlVc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/32] selftests/ftrace: Improve kprobe on module testcase to load/unload module
Date:   Fri, 17 Aug 2018 01:34:51 +0900
Message-Id: <153443729154.23257.15704810148795897178.stgit@devbox>
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

Improve kprobe events on module testcase to check module
load/unload with disabled/enabled events. This also change
the target module to trace_printk.ko, so it depends on
CONFIG_SAMPLE_TRACE_PRINTK=m.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/testing/selftests/ftrace/config              |    4 ++
 .../ftrace/test.d/kprobe/kprobe_module.tc          |   35 ++++++++++++++++++--
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
index 07db5ab09cc7..32cf61b6bb54 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -7,3 +7,7 @@ CONFIG_HIST_TRIGGERS=y
 CONFIG_PREEMPT_TRACER=y
 CONFIG_IRQSOFF_TRACER=y
 CONFIG_PREEMPTIRQ_DELAY_TEST=m
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_SAMPLES=y
+CONFIG_SAMPLE_TRACE_PRINTK=m
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
index ec6c5fffef1e..1efe9e616bc4 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
@@ -4,11 +4,18 @@
 
 [ -f kprobe_events ] || exit_unsupported # this is configurable
 
+rmmod trace-printk ||:
+if ! modprobe trace-printk.ko ; then
+  echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=
+m"
+  exit_unresolved;
+fi
+
+MOD=trace_printk
+FUNC=trace_printk_irq_work
+
 :;: "Add an event on a module function without specifying event name" ;:
 
-MOD=`lsmod | head -n 2 | tail -n 1 | cut -f1 -d" "`
-FUNC=`grep -m 1 ".* t .*\\[$MOD\\]" /proc/kallsyms | xargs | cut -f3 -d" "`
-[ "x" != "x$MOD" -a "y" != "y$FUNC" ] || exit_unresolved
 echo "p $MOD:$FUNC" > kprobe_events
 PROBE_NAME=`echo $MOD:$FUNC | tr ".:" "_"`
 test -d events/kprobes/p_${PROBE_NAME}_0 || exit_failure
@@ -22,3 +29,25 @@ test -d events/kprobes/event1 || exit_failure
 
 echo "p:kprobes1/event1 $MOD:$FUNC" > kprobe_events
 test -d events/kprobes1/event1 || exit_failure
+
+:;: "Remove target module, but event still be there" ;:
+if ! rmmod trace-printk ; then
+  echo "Failed to unload module - please enable CONFIG_MODULE_UNLOAD"
+  exit_unresolved;
+fi
+test -d events/kprobes1/event1
+
+:;: "Check posibility to defining events on unloaded module";:
+echo "p:event2 $MOD:$FUNC" >> kprobe_events
+
+:;: "Target is gone, but we can prepare for next time";:
+echo 1 > events/kprobes1/event1/enable
+
+:;: "Load module again, which means the event1 should be recorded";:
+modprobe trace-printk.ko
+grep "event1:" trace
+
+:;: "Remove the module again and check the event is not locked"
+rmmod trace-printk
+echo 0 > events/kprobes1/event1/enable
+echo "-:kprobes1/event1" >> kprobe_events

