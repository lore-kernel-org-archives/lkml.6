Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D913CECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBF720864
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S57suh+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBF720864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731880AbeGMURa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:17:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40048 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbeGMURa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:17:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id t6-v6so26189134wrn.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 13:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Q1XkoERuiu8MrNv2prcOIYe3l/6+Dq92tA6am7eGOvc=;
        b=S57suh+uRc19bG2+q5Rza0zU3yzP2FlJ09WHhRlQ340J0kBuUpiLtJbla5No7i4PtT
         zNi2QolHIKPlGpzhkmUGQIn4AqCEWVYhLBxpGVqLDIJ/YmJ1rXhncV4Gr2/NH4UlO1KM
         f9jl9WCi3xeujj4DAVgXa6/v2TAG+lGHct+TKizBsTGG38D6aTx9UueHUUbWv5sZxPdB
         y0hBEXbrN4B5VXcEOVD9VY3Cv5Og6loByToZaM/LCBU2AKliCFkwwfKCbiZ7ECMobbme
         xg0OuEL73YAFwWWOFJXlI5aAAzFURpjdXn4EeM6jGKTh5KJ7+uebKN8EX9cCV78IHCiZ
         UM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Q1XkoERuiu8MrNv2prcOIYe3l/6+Dq92tA6am7eGOvc=;
        b=HZ11V0cH5mwh94mwTygge+EDqDhqWNICpG0EepFcHV5nSwgBzjvB924vWBZTbY+fsU
         /2JqNzV34yUlydArKlZURWAvYxz/0Ygy8tQmBr2N/knAD8ZApI1186V8C+CufbRJmXnz
         anxaR6RR9WwcS4kR1qBv3ynCaDbmoSxXVTOXJDZStY43Zcxqg01JLJRxEbS/Kll+AW8Z
         9GXnuZxmHBiGrx/lEwkcWfnxlpAPvfaSHkwb8f6ZE68fpFE5dqZLTNloINENB8P1U3Cw
         +TD5m18w8oALs+ni6C5AuXDUDwR03T3dDkW3wL0RWVqI+r7sDfFohFuTx2c9u435d/T5
         1rAg==
X-Gm-Message-State: AOUpUlENatakM/jHQ9eweWl4CHBfaTQXrxsAOLll6K2+Sug4XLul9qft
        1tilXJ26XgDy5pcNI3tAbf0=
X-Google-Smtp-Source: AAOMgpdMfg/BVFAanUM3zS8CqT+pwPvXkgSxcLixXaefCIjawRD+WPvngcGHwFYGsZrjHYR9moZxlQ==
X-Received: by 2002:adf:959a:: with SMTP id p26-v6mr5688838wrp.202.1531512083864;
        Fri, 13 Jul 2018 13:01:23 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id p3-v6sm40913574wrg.47.2018.07.13.13.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 13:01:23 -0700 (PDT)
Date:   Fri, 13 Jul 2018 22:01:21 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] timer fixes
Message-ID: <20180713200121.GA10560@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

   # HEAD: 5e18e412973d6bb1804de1d4d30a891c774b006e clocksource: arm_arch_timer: Set arch_mem_timer cpumask to cpu_possible_mask

A clocksource driver fix and a revert.

 Thanks,

	Ingo

------------------>
Sudeep Holla (2):
      Revert "tick: Prefer a lower rating device only if it's CPU local device"
      clocksource: arm_arch_timer: Set arch_mem_timer cpumask to cpu_possible_mask


 drivers/clocksource/arm_arch_timer.c | 2 +-
 kernel/time/tick-common.c            | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 57cb2f00fc07..d8c7f5750cdb 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -735,7 +735,7 @@ static void __arch_timer_setup(unsigned type,
 		clk->features |= CLOCK_EVT_FEAT_DYNIRQ;
 		clk->name = "arch_mem_timer";
 		clk->rating = 400;
-		clk->cpumask = cpu_all_mask;
+		clk->cpumask = cpu_possible_mask;
 		if (arch_timer_mem_use_virtual) {
 			clk->set_state_shutdown = arch_timer_shutdown_virt_mem;
 			clk->set_state_oneshot_stopped = arch_timer_shutdown_virt_mem;
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index b7005dd21ec1..14de3727b18e 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -277,8 +277,7 @@ static bool tick_check_preferred(struct clock_event_device *curdev,
 	 */
 	return !curdev ||
 		newdev->rating > curdev->rating ||
-	       (!cpumask_equal(curdev->cpumask, newdev->cpumask) &&
-	        !tick_check_percpu(curdev, newdev, smp_processor_id()));
+	       !cpumask_equal(curdev->cpumask, newdev->cpumask);
 }
 
 /*
