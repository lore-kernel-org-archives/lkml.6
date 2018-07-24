Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DA7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1829520852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mz7p7KmT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xzl/NnPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1829520852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388631AbeGXPoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:44:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51082 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388495AbeGXPoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:44:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B8B0260B74; Tue, 24 Jul 2018 14:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532443071;
        bh=pyhlGJKjLTaGq4dTTwUBbeKdu5zUV9YzWzlxod0Rt2o=;
        h=From:To:Cc:Subject:Date:From;
        b=Mz7p7KmT5UzL00HvBswtlO2PpNF9xFKw5Jg/3Os7J9XPaqtzBMwGJHkZ+tkKGH9P0
         pgkqNADpQTSZYkVJxfeFK/dscscY7+wniGLPcZ3Uv6OgMyY9UIEtv1XOdcN0U/rB9c
         TtOjzhIIBuwGgFFci7mQVRWpy0yKGOLOMFDF0QWk=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 08C7560285;
        Tue, 24 Jul 2018 14:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532443070;
        bh=pyhlGJKjLTaGq4dTTwUBbeKdu5zUV9YzWzlxod0Rt2o=;
        h=From:To:Cc:Subject:Date:From;
        b=Xzl/NnPUB0cGnSsJ8g8sRBGCHuoSJfWJXPNv7snn2U4L0kM5x05jtCZtn7pI+4dJd
         QqEionnuZCGMkOSNcwgvBey9pV1Ei77TDV818xfUkTBwNQIeDf7OKMjsh2neawEVAr
         pwtCB5Osu7M3pFw08NOUaJF8QokDSLUtpmqzFcHY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 08C7560285
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     gkohli@qti.qualcomm.com, neeraju@qti.qualcomm.com,
        Mukesh Ojha <mojha@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Mathieu Malaterre <malat@debian.org>
Subject: [PATCH] cpu/hotplug: Fix cpuhp_step name for timers
Date:   Tue, 24 Jul 2018 20:07:38 +0530
Message-Id: <1532443058-22343-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 249d4a9b3246 ("timers: Reinitialize per cpu bases
on hotplug") i.e introduction of state CPUHP_TIMERS_PREPARE
instead of CPUHP_TIMERS_DEAD the cpuhp_step name "timers:dead"
for timer looks to invalid. So, better to name it as
"timers:prepare".

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Brendan Jackman <brendan.jackman@arm.com>
Cc: Mathieu Malaterre <malat@debian.org>
---
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

