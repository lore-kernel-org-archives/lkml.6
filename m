Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FE5C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A72B2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iLNxntR9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mHhQUpuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A72B2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeIEKUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 06:20:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52546 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeIEKUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 06:20:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 75D95607DC; Wed,  5 Sep 2018 05:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536126739;
        bh=Bjj9runRAgUuvtri2C2sPVPUxv/h61rXCc2V7svh0i4=;
        h=From:To:Cc:Subject:Date:From;
        b=iLNxntR9soSEPb9Fltwz25/lMGu54ZXz6m2wTR4FVy0pNRXrkRJQg/jhogfVi5Ip0
         hpFkmqAIrHvjFcaXbwg/pcnquQoSYF9e1QQ8w2u6ZcfBkII9Gf3fvBxejeHLQ7AYqn
         RZN0UDLk09iD7GJCdEifM3PJa6qJikfbIjkJjKhw=
Received: from neeraju-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7BA276038E;
        Wed,  5 Sep 2018 05:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536126738;
        bh=Bjj9runRAgUuvtri2C2sPVPUxv/h61rXCc2V7svh0i4=;
        h=From:To:Cc:Subject:Date:From;
        b=mHhQUpuLKusuzkUQKx5ONtcbAfpxCS53jI7MTkb3YOga9OnTWxtP/O6oafnz07h8+
         PpVe4QbENLpjtMWB7jJL2gIJfboj44m/cBrDpORhNPKlPnJLFJFaFPwz4G1vc/yRBb
         Nmc1U1jHVjvnMcdOiKwTv2GzZSLomrbVnd9E943o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7BA276038E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     tglx@linutronix.de, josh@joshtriplett.org, peterz@infradead.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dzickus@redhat.com,
        brendan.jackman@arm.com, malat@debian.org, mojha@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, sramana@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] cpu/hotplug: Fix acquire of st->should_run in cpuhp_thread_fun()
Date:   Wed,  5 Sep 2018 11:22:07 +0530
Message-Id: <1536126727-11629-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The smp_mb() in cpuhp_thread_fun() appears to be misplaced, and
need to be after the load of st->should_run, to prevent
reordering of the later load/stores w.r.t. the load of
st->should_run.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index aa7fe85..eb4041f 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -607,15 +607,15 @@ static void cpuhp_thread_fun(unsigned int cpu)
 	bool bringup = st->bringup;
 	enum cpuhp_state state;
 
+	if (WARN_ON_ONCE(!st->should_run))
+		return;
+
 	/*
 	 * ACQUIRE for the cpuhp_should_run() load of ->should_run. Ensures
 	 * that if we see ->should_run we also see the rest of the state.
 	 */
 	smp_mb();
 
-	if (WARN_ON_ONCE(!st->should_run))
-		return;
-
 	cpuhp_lock_acquire(bringup);
 
 	if (st->single) {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

