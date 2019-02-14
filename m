Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA333C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C525C2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407094AbfBNNh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:37:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42830 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390652AbfBNNhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:37:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so6489725wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 05:37:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2TPQjiV6xQsQotsGD5Gl7ytK6qqlrpzeFWoF3gGp2z0=;
        b=Fe2smVOxKTKeUfzxvi+BfkywmfhPlIY8FsLoN4tcYFr5XHwNFAWzvXy3Gi8wrEL31b
         nMswXLl3m15AjZky033Q6CEfCSiBUTTnn0oqTtFSmjWdXQPcRB5ho57dAZ7xkwTNHE7/
         Rhp2UHHbUXVjrnGn2YnDXsy5ledV/AIMllqiVtXzKJn4TPBq1uLVq5UIyWVrvdTt7tYE
         dHZ+Sb6ZDPmgZEwvmtugZjTC7KygzykTqYetvXgAWVowuBXEZZzTglbbXORzF3s1v0P2
         +Iel9aeZZm/XyW8nM2bAU43/u/yeRz6j+grqatsn+7GZV/p3t+phVTkLVi2GgOyla4Kw
         9qfQ==
X-Gm-Message-State: AHQUAua7UiV2fUyaJ2oVgEkPHK7v5inIL2O6HcH3qk1ZZ/oTjNaif6Kw
        4he+gY7pXOcHx1G2rkly5vrwSQ==
X-Google-Smtp-Source: AHgI3IbtzZ09QmbvboBFSZ9QOG/NgpKuCCzMLGec7TdCiUi+rJnjH4J2gPtTKU4+4bfQ2OrnXRvUwA==
X-Received: by 2002:adf:f145:: with SMTP id y5mr3112808wro.240.1550151463718;
        Thu, 14 Feb 2019 05:37:43 -0800 (PST)
Received: from localhost.localdomain.com ([151.29.175.58])
        by smtp.gmail.com with ESMTPSA id b13sm4008566wmj.42.2019.02.14.05.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 05:37:43 -0800 (PST)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     tglx@linutronix.de, bigeasy@linutronix.de
Cc:     linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        williams@redhat.com, Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH RT 1/2] time/hrtimer: Add PINNED_HARD mode for realtime hrtimers
Date:   Thu, 14 Feb 2019 14:37:15 +0100
Message-Id: <20190214133716.10187-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190214133716.10187-1-juri.lelli@redhat.com>
References: <20190214133716.10187-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running cyclictest on isolated CPUs I noticed the following odd
behavior, where CPU0 is one of the housekeeping CPUs and CPU2 is
isolated:

     <idle>-0     [000] ... hrtimer_cancel:       hrtimer=0xffffb4a74be7fe70
     <idle>-0     [000] ... hrtimer_expire_entry: hrtimer=0xffffb4a74be7fe70 now=144805770984 function=hrtimer_wakeup/0x0
     <idle>-0     [000] ... sched_wakeup:         cyclictest:1171 [4] success=1 CPU:002
     <idle>-0     [000] ... hrtimer_expire_exit:  hrtimer=0xffffb4a74be7fe70
     <idle>-0     [002] ... sched_switch:         swapper/2:0 [120] R ==> cyclictest:1171 [4]
 cyclictest-1171  [002] ... hrtimer_init:         hrtimer=0xffffb4a74be7fe70 clockid=CLOCK_MONOTONIC mode=0x8
 cyclictest-1171  [002] ... hrtimer_start:        hrtimer=0xffffb4a74be7fe70 function=hrtimer_wakeup/0x0 ...
 cyclictest-1171  [002] ... sched_switch:         cyclictest:1171 [4] S ==> swapper/2:0 [120]

While cyclitest was arming the hrtimer while running on isolated CPU2
(by means of clock_nanosleep), the hrtimer was then firing on CPU0. This
is due to the fact that switch_hrtimer_base(), called at hrtimer enqueue
time, will prefer to enqueue the timer on an housekeeping !idle CPU, if
the timer is not pinned, as it is currently the case.

The problem with this is that we are measuring wake up latencies across
isolated and !isolated domains, which is against the purpose of
configuring the latter.

Since PREEMPT_RT_FULL already forces HARD mode for hrtimers armed by
tasks running with RT policies, it makes sense to also force PINNED mode
under the same conditions.

This patch implements this behavior, achieving something like the
following:

     <idle>-0     [002] ... hrtimer_cancel:       hrtimer=0xffffafbacc19fe78
     <idle>-0     [002] ... hrtimer_expire_entry: hrtimer=0xffffafbacc19fe78 now=104335855898 function=hrtimer_wakeup/0x0
     <idle>-0     [002] ... sched_wakeup:         cyclictest:1165 [4] success=1 CPU:002
     <idle>-0     [002] ... hrtimer_expire_exit:  hrtimer=0xffffafbacc19fe78
     <idle>-0     [002] ... sched_switch:         swapper/2:0 [120] R ==> cyclictest:1165 [4]
 cyclictest-1165  [002] ... hrtimer_init:         hrtimer=0xffffafbacc19fe78 clockid=CLOCK_MONOTONIC mode=0xa
 cyclictest-1165  [002] ... hrtimer_start:        hrtimer=0xffffafbacc19fe78 function=hrtimer_wakeup/0x0 ...
 cyclictest-1165  [002] ... sched_switch:         cyclictest:1165 [4] S ==> swapper/2:0 [120]

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/hrtimer.h | 2 ++
 kernel/time/hrtimer.c   | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 2bdb047c7656..c6d4941c7dd8 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -56,6 +56,8 @@ enum hrtimer_mode {
 	HRTIMER_MODE_ABS_HARD	= HRTIMER_MODE_ABS | HRTIMER_MODE_HARD,
 	HRTIMER_MODE_REL_HARD	= HRTIMER_MODE_REL | HRTIMER_MODE_HARD,
 
+	HRTIMER_MODE_PINNED_HARD = HRTIMER_MODE_PINNED | HRTIMER_MODE_HARD,
+
 	HRTIMER_MODE_ABS_PINNED_HARD = HRTIMER_MODE_ABS_PINNED | HRTIMER_MODE_HARD,
 	HRTIMER_MODE_REL_PINNED_HARD = HRTIMER_MODE_REL_PINNED | HRTIMER_MODE_HARD,
 };
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 851b2134e77f..4a905fb721a1 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1717,7 +1717,7 @@ static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
 #ifdef CONFIG_PREEMPT_RT_FULL
 	if (!(mode & (HRTIMER_MODE_SOFT | HRTIMER_MODE_HARD))) {
 		if (task_is_realtime(current) || system_state != SYSTEM_RUNNING)
-			mode |= HRTIMER_MODE_HARD;
+			mode |= HRTIMER_MODE_PINNED_HARD;
 		else
 			mode |= HRTIMER_MODE_SOFT;
 	}
-- 
2.17.2

