Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DBDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CE5218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407075AbfBNNhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:37:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34444 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389825AbfBNNho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:37:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id f14so6549763wrg.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 05:37:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x1gj8uFt46DTSxyp1zJkRsl0k2blNJgN6cMbREriW7g=;
        b=mCVzGXSjpoL4jN0IFyOB13m1mcLWZ35DHskkgp1gg7uSAQHSca5cPvW6j3GXL69jH5
         BbBPMwLQfe6O1FqHw5jowJT1MyXb/mfGacOAtb4zAafav5UvdPP7+iSeFFpqEmWmH26m
         dhxJZbYbzbGdhCYgFs3GOvw4DBH3Jp8IWknD3+aRdfBjzYU3xoKwIPTHMR18R7NVh4FS
         TVkAGiAW74C6OgWgRQw/+ZuXspwYgO2l0R2XKreXsYh8l4fZdhCTmDUsNCgSF4iLLPrG
         8b5qTuFX+qFfNcMFhX9Gb1hwcGM7P6UNCGcKLBLYm+DuWCw0mcOyzKRgaxzbDocO5LrM
         ubFQ==
X-Gm-Message-State: AHQUAuaVkI2coxFgnMwj8umxSr0wO0IvMbUi8D8ICDWw/1lG19Tnlmoz
        PATUawtUiU/m8FSWxLcMXe8d/Q==
X-Google-Smtp-Source: AHgI3IYs3pUL1Aq0JX7mzToB36nbokT46pMoWk38K62GKe53nRQRUAetn5ZFI9AQ8lqLhMGPWsDhWQ==
X-Received: by 2002:adf:eb12:: with SMTP id s18mr2893360wrn.120.1550151462641;
        Thu, 14 Feb 2019 05:37:42 -0800 (PST)
Received: from localhost.localdomain.com ([151.29.175.58])
        by smtp.gmail.com with ESMTPSA id b13sm4008566wmj.42.2019.02.14.05.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 05:37:42 -0800 (PST)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     tglx@linutronix.de, bigeasy@linutronix.de
Cc:     linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        williams@redhat.com, Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH RT 0/2] Add PINNED_HARD mode to hrtimers
Date:   Thu, 14 Feb 2019 14:37:14 +0100
Message-Id: <20190214133716.10187-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been experimenting with 4.19.15-rt12 and I found out that, while
running cyclictest on isolated CPUs, the following thing, where CPU0 is
one of the housekeeping CPUs and CPU2 is isolated, was happening:

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

This looked odd to me, as the problem with this seems to be that we are
measuring wake up latencies across isolated and !isolated domains, which
is against the purpose of configuring the latter.

Since PREEMPT_RT_FULL already forces HARD mode for hrtimers armed by
tasks running with RT policies, it seems to make sense to also force
PINNED mode under the same conditions.

This set implements the behavior, achieving something like the
following:

     <idle>-0     [002] ... hrtimer_cancel:       hrtimer=0xffffafbacc19fe78
     <idle>-0     [002] ... hrtimer_expire_entry: hrtimer=0xffffafbacc19fe78 now=104335855898 function=hrtimer_wakeup/0x0
     <idle>-0     [002] ... sched_wakeup:         cyclictest:1165 [4] success=1 CPU:002
     <idle>-0     [002] ... hrtimer_expire_exit:  hrtimer=0xffffafbacc19fe78
     <idle>-0     [002] ... sched_switch:         swapper/2:0 [120] R ==> cyclictest:1165 [4]
 cyclictest-1165  [002] ... hrtimer_init:         hrtimer=0xffffafbacc19fe78 clockid=CLOCK_MONOTONIC mode=0xa
 cyclictest-1165  [002] ... hrtimer_start:        hrtimer=0xffffafbacc19fe78 function=hrtimer_wakeup/0x0 ...
 cyclictest-1165  [002] ... sched_switch:         cyclictest:1165 [4] S ==> swapper/2:0 [120]

Now, I'm sending this and an RFC, as I'm wondering if the first behavior
is actually what we want, and it is not odd at all for reasons that are
not evident to me at the moment. In this case this posting might also
function as a question: why we need things to work as they are today?

Thanks!

- Juri

Juri Lelli (2):
  time/hrtimer: Add PINNED_HARD mode for realtime hrtimers
  time/hrtimer: Embed hrtimer mode into hrtimer_sleeper

 include/linux/hrtimer.h |  4 ++++
 kernel/time/hrtimer.c   | 13 +++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.17.2

