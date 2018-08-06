Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A4BC46470
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B33219DD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OzwfUUxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B33219DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbeHFFwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 01:52:00 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41647 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbeHFFwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 01:52:00 -0400
Received: by mail-qt0-f194.google.com with SMTP id e19-v6so12346052qtp.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 20:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ufwBP4h/LAxECB+z/iUgFOQX7GqOPGw7sq/TLQ1GE60=;
        b=OzwfUUxOEazPzlfkqrYFKv4zzadRWfsGPw9+fp8o7QIu2LH54RP847FPKIvwqSzwia
         Gdl/O5qrlVhFy52TODWmh28AwbHTEvidOnuCN/6to40lQlplI9QtBp88qO3eSZE23Wf5
         Ka41UdVtu1Zxxx0PsxMsb5/8lkbsFAA3SoOaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ufwBP4h/LAxECB+z/iUgFOQX7GqOPGw7sq/TLQ1GE60=;
        b=GXGkIINvwlnwrAPjIDrMOJiJcRbAU1Z8SOTtSwSDorB2cHPu8ibO+Ai6hkhKwnCjAc
         6DUSbR0gO0anwvFLbg7zvw39OGiCbzKTR1tAv5sUWIplAi80Q3l86ySe6Rsk23UsZzom
         G3sNd1B80FwG8dL7pfbS5mJBfeEWmR8sxYgbfQGfHl3oHoYuS4Ogxo0KHaiUKtq2EpDk
         XZlXZJrT0is/gwJJN7tBBerif6QXzSuVuDRMRueTYuhCCczPcOTHxTRKKmYD35DolNkt
         paImtzdicSHM+jfY46F8p7Fw4rnO45XwAzoGrmvdbok1RpZROrdd9wxVuyBdkIP0RLrI
         6tmg==
X-Gm-Message-State: AOUpUlFB2PduzMq03N4L2TLfnNLw5FZbPv+eFLolagx/zp9VWn+eGXHx
        b9vuc/BVU8ii6PtBXgAdKYQfpD/obxmeEw==
X-Google-Smtp-Source: AAOMgpeTDMvxPxjBEu6IFqPbXAWQGSEwSw0AZOszEMIOTzrOeP8lVxZ5/ofCxdgvwxxzIvqvsWlWyQ==
X-Received: by 2002:a0c:d7c3:: with SMTP id g3-v6mr11546569qvj.85.1533527094608;
        Sun, 05 Aug 2018 20:44:54 -0700 (PDT)
Received: from joelaf-glaptop0.roam.corp.google.com ([4.78.42.66])
        by smtp.gmail.com with ESMTPSA id i1-v6sm4982327qtj.65.2018.08.05.20.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 20:44:54 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        paulmck@linux.vnet.ibm.com, mathieu.desnoyers@efficios.com,
        namhyung@kernel.org, peterz@infradead.org
Subject: [RFC] tracepoint: Run tracepoints even after CPU is offline
Date:   Sun,  5 Aug 2018 20:44:37 -0700
Message-Id: <20180806034437.68464-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f37755490fe9 ("tracepoints: Do not trace when cpu is offline")
causes a problem for lockdep using tracepoint code. Once a CPU is
offline, tracepoints donot get called, however this causes a big problem
for lockdep probes that need to run so that IRQ annotations are marked
correctly.

An issue is possible where while the CPU is going offline, an interrupt
can come in and then a lockdep assert causes an annotation warning:

[  106.551354] IRQs not enabled as expected
[  106.551785] WARNING: CPU: 1 PID: 0 at kernel/time/tick-sched.c:982
                                         tick_nohz_idle_enter+0x99/0xb0
[  106.552964] Modules linked in:
[  106.553299] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W

We need tracepoints to run as late as possible. This commit tries to fix
the issue by removing the cpu_online check in tracepoint code that was
introduced in the mentioned commit, however now we run the risk of
running dereferencing probes that aren't RCU protected, which gives an
RCU warning like so on boot up:
[    0.030159] x86: Booting SMP configuration:
[    0.030169] .... node  #0, CPUs:      #1
[    0.001000]
[    0.001000] =============================
[    0.001000] WARNING: suspicious RCU usage
[    0.001000] 4.18.0-rc6+ #42 Not tainted
[    0.001000] -----------------------------
[    0.001000] ./include/trace/events/timer.h:38 suspicious
				rcu_dereference_check() usage!
[    0.001000]
[    0.001000] other info that might help us debug this:
[    0.001000]
[    0.001000]
[    0.001000] RCU used illegally from offline CPU!
[    0.001000] rcu_scheduler_active = 1, debug_locks = 1
[    0.001000] no locks held by swapper/1/0.
[    0.001000]

Any ideas on how we can fix this? Basically we need RCU to work here
even after !cpu_online. I thought of just using SRCU for all tracepoints
however that may mean we can't use tracepoints from NMI..

Tries-to-Fix: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints and
                             unify their usage")
Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/tracepoint.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index d9a084c72541..020885714a0f 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -365,19 +365,17 @@ extern void syscall_unregfunc(void);
  * "void *__data, proto" as the callback prototype.
  */
 #define DECLARE_TRACE_NOARGS(name)					\
-	__DECLARE_TRACE(name, void, ,					\
-			cpu_online(raw_smp_processor_id()),		\
+	__DECLARE_TRACE(name, void, , 1,				\
 			void *__data, __data)
 
 #define DECLARE_TRACE(name, proto, args)				\
-	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
-			cpu_online(raw_smp_processor_id()),		\
+	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args), 1,		\
 			PARAMS(void *__data, proto),			\
 			PARAMS(__data, args))
 
 #define DECLARE_TRACE_CONDITION(name, proto, args, cond)		\
 	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
-			cpu_online(raw_smp_processor_id()) && (PARAMS(cond)), \
+			PARAMS(cond),					\
 			PARAMS(void *__data, proto),			\
 			PARAMS(__data, args))
 
-- 
2.18.0.597.ga71716f1ad-goog

