Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D47ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC322064D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CAUhkLm/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RlOCcxkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC322064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388626AbeGXPys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:54:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33080 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388430AbeGXPys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:54:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0062060B1E; Tue, 24 Jul 2018 14:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532443679;
        bh=yOfTUgYS69JDVcxmvpcsCF6UImBeIwL1V6QQw5BlV+k=;
        h=From:To:Cc:Subject:Date:From;
        b=CAUhkLm/ZHZMqbraUg4yTduGmjKKtO7icHl4koSU0xAnfqOv/v0z4KshmJvWOyfMH
         s0pGAbQ/uxF3lVbwE7XmEwthuPClHDwYEYW7tz04/RkKVY/AHB8eWq53HBLk/Tdbf5
         U53huDrbMALlWTxEku7gR7ate/rGLPrNoTUxkos4=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B5F3605A4;
        Tue, 24 Jul 2018 14:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532443678;
        bh=yOfTUgYS69JDVcxmvpcsCF6UImBeIwL1V6QQw5BlV+k=;
        h=From:To:Cc:Subject:Date:From;
        b=RlOCcxkVRYsRKPMEEfRKvstr0Vhqt+JJmcuN8dTSmwjYxy9tw4AjSPenAEfhLyBUL
         fKmqdpLEG8f/gFnOdKr4tYhtT8wq+ESTpTaiacowKnPhERZ44PoxxXP3Xv4aGfkqfh
         DtzXZ12iWOm8sMvI5IxQyTjA+BCN9C6zcMXCgC1w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B5F3605A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     gkohli@codeaurora.org, neeraju@codeaurora.org,
        Mukesh Ojha <mojha@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH v2] cpu/hotplug: Fix cpuhp_step name for timers
Date:   Tue, 24 Jul 2018 20:17:48 +0530
Message-Id: <1532443668-26810-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 249d4a9b3246 ("timers: Reinitialize per cpu bases
on hotplug") i.e introduction of state CPUHP_TIMERS_PREPARE
instead of CPUHP_TIMERS_DEAD the cpuhp_step name "timers:dead"
for timer looks to be invalid. So, better to name it as
"timers:prepare".

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Brendan Jackman <brendan.jackman@arm.com>
Cc: Mathieu Malaterre <malat@debian.org>
---
Changes in v2:
 - Updated commit text.

 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 0db8938..8e6606a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1274,7 +1274,7 @@ static int __init cpu_hotplug_pm_sync_init(void)
 	 * otherwise a RCU stall occurs.
 	 */
 	[CPUHP_TIMERS_PREPARE] = {
-		.name			= "timers:dead",
+		.name			= "timers:prepare",
 		.startup.single		= timers_prepare_cpu,
 		.teardown.single	= timers_dead_cpu,
 	},
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

