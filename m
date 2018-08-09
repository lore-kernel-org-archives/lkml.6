Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EC9C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2195821EFA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DdlyQn2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2195821EFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732585AbeHITqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:46:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40468 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732368AbeHITqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:46:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15-v6so5799475wrs.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 10:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IUTn/7Ft69NSuwqT7EL06ov7KVYywUssQb8ZEx9fLWo=;
        b=DdlyQn2sJuKY7nfD4FeXcQ5s6TI3OzihOHCstPdxBYVinlwuFWOQG/R2cdpwnYV7M+
         SI9IwaTluiiaBCM2qLgfGFaHMfoAgCSS0+tApx99vnO16Z0iBl+QVhfudsTS468gYeSN
         TYm6lsgVfPCCXlh7sqYDBHV7CHuo2KfqBie/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IUTn/7Ft69NSuwqT7EL06ov7KVYywUssQb8ZEx9fLWo=;
        b=FiXDQSY0uMEmrTShE/4BLzEgU0UehKh21VR0SZ4KMf7OuQq8oRrsnEufb0fbi221ZF
         kWBhxDiHWNl2AMI643nLKWi3hkuEMafqCiTej2G47AEU7Bx+YxMCCqk0A9RzRaBpJ5Cb
         /mBiYTzrpXUqXlDDZoJbZFHloXwOpPn6tIXNtFCFfsxin/aJHAAh92jKkNmrYLYBZH1g
         jKG9yX0aKCnU1O/ZpM+VKyjFfDKO/bAQw1/HwQk68eKkjWzFw50R53hipO9fqQLQ2jy1
         iDDT3kqeV9Sc3DG/vhgZgttsVujmFCYWzo1UKRUPNccz5wSm8DhfxM68wIStoqzD4WxX
         tQ2Q==
X-Gm-Message-State: AOUpUlGLQV6Q4+AkDgvtWTnyc1fjHV9EfnSV8pEB+CTOnfBqD68O9ah3
        Va5Hwv6KU310mJwKcuEdSlj3I/018K/NhpBR
X-Google-Smtp-Source: AA+uWPwV2llBRFdNMoohNIfmugGq0PIKs6twHNJL1s5xKwguSvH4NrsiyK1eHlvaXGqiujQ2m1bGrg==
X-Received: by 2002:adf:9443:: with SMTP id 61-v6mr1930785wrq.193.1533835215037;
        Thu, 09 Aug 2018 10:20:15 -0700 (PDT)
Received: from localhost.localdomain ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id u4-v6sm1815056wro.47.2018.08.09.10.20.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Aug 2018 10:20:14 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [RESEND PATCH v1 0/2] Optimization CPU idle state impacted by tick
Date:   Fri, 10 Aug 2018 01:20:01 +0800
Message-Id: <1533835203-5789-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After Rafael's patch series 'sched/cpuidle: Idle loop rework' has been
merged in mainline kernel, it perfectly resolved the Powernightmares
issue [1] with not stopping the tick during the idle loop; we verified
this patch series on Arm platform (96boards Hikey620 with octa CA53
CPUs) with the rt-app [2] program to generate workloads: a single task
with below combinded configurations with period 5ms and duty cycle
1%/3%/5%/10%/20%/30%/40%.

After run these testing cases, we found the CPU cannot stay in deepest
idle state as expected, the issues essentialy are related with sched
tick:

The prominent issue is the criteria for decision stopping tick; now
the criteria is checking expected interval is less than TICK_USEC, but
this doesn't consider from the perspective of idle state parameters, so
we can observe the CPU even has enough sleeping time but it cannot run
into deepest idle state; this is very serious for some specific ducy
cycle cases.

Another issue is after tick keeping running in idle state, the tick
can heavily impact on 'menu' governor metrics, especially it will
introduce many noise for next event correction factors.

This patch series tries to fix these two issues; patch 0001 wants to
define a time point to distinguish for stopping or not, this time point
consideres the factors from tick period and the maximum target residency
and use prediction period to compare this time point to decide if need
to stop tick.  Patch 0002 wants to always to give compensation for tick
event so that dimiss the tick impaction on correction factors for next
time prediction.

Blow table are comparison results for testing cases between without and
with this patch series; we run the test case with single task with period
5ms with different dutycycle, the total running time is 10s.  Based on
the tracing log, we do statistics for all CPUs for all idle states
duration, the unit is second (s), on Hikey board the result shows the C2
state (the CPU deepest state) selection improvement.

Some notations are used in the table:

state: C0: WFI; C1: CPU OFF; C2: Cluster OFF

All testing cases have single task with 5ms period:

		 Without patches                  With patches                   Difference
            -----------------------------  -----------------------------  -------------------------------
Duty cycle      C0        C1        C2         C0        C1         C2         C0        C1         C2
  1%        0.218589  4.208460  87.995606  0.119723  0.847116  91.940569  -0.098866  -3.361344  +3.944963
  3%        0.801521  5.031361  86.444753  0.147346  0.820276  91.761191  -0.654175  -4.211085  +5.316438
  5%        0.590236  2.733048  88.284541  0.149237  1.042383  90.490482  -0.440999  -1.690665  +2.205941
 10%        0.601922  6.282368  84.899870  0.169491  1.304985  89.725754  -0.432431  -4.977383  +4.825884
 20%        1.381870  8.531687  80.627691  0.307390  3.302562  86.686887  -1.074480  -5.229125  +6.059196
 30%        1.785221  6.974483  81.083312  0.548050  5.319929  83.551747  -1.237171  -1.654554  +2.468435
 40%        1.403247  6.474203  80.577176  0.467686  6.366482  81.983384  -0.935561  -0.107721  +1.406208


Leo Yan (2):
  cpuidle: menu: Correct the criteria for stopping tick
  cpuidle: menu: Dismiss tick impaction on correction factors

 drivers/cpuidle/governors/menu.c | 55 ++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 10 deletions(-)

-- 
2.7.4

