Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BF9C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD8A208AD
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Co8+u4Lr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD8A208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732094AbeG0NhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:37:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729431AbeG0NhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:37:11 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93900208AF;
        Fri, 27 Jul 2018 12:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532693731;
        bh=kEAJAQ+i3bNCv1b9F1B5u13CahTnHgcfQKwlFPJ+fDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Co8+u4LrLnNo5KcgvhHLNApC+db0jjhYnoVSIXbAkl04+IsVG0LInbbHxGn7+i8Z6
         pcg+JWlm2LuuI18Sd/QMkapXSsP0Jdzz9BIzdpeVtYwY/jLa5lsLitG/R/wcB+Uvcn
         xTTQnkdlHZsM8v0UXL8U3h5G3KRfAtuqHvOTePWs=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/25] selftests/ftrace: Improve kprobe on module testcase to load/unload module
Date:   Fri, 27 Jul 2018 21:15:08 +0900
Message-Id: <153269370853.3084.10985190108092225790.stgit@devbox>
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
index b01924c71c09..766669592173 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -4,3 +4,7 @@ CONFIG_FUNCTION_PROFILER=y
 CONFIG_TRACER_SNAPSHOT=y
 CONFIG_STACK_TRACER=y
 CONFIG_HIST_TRIGGERS=y
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

