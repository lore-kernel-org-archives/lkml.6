Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F51C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590D02087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 590D02087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933495AbeGIPpv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:45:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33426 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932688AbeGIPpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:45:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1426ED1;
        Mon,  9 Jul 2018 08:45:46 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.211.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 82E293F589;
        Mon,  9 Jul 2018 08:45:45 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] Revert "tick: Prefer a lower rating device only if it's CPU local device"
Date:   Mon,  9 Jul 2018 16:45:35 +0100
Message-Id: <1531151136-18297-1-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 1332a90558013ae4242e3dd7934bdcdeafb06c0d.

The original issue was not because of incorrect checking of cpumask for
both new and old tick device. It was incorrectly analysed was due to the
misunderstanding of the comment and misinterpretation of the return
value from tick_check_preferred. The main issue is with the clockevent
driver that sets the cpumask to cpu_all_mask instead of cpu_possible_mask.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 kernel/time/tick-common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Hi Thomas,

As mentioned in the other thread, this needs to be reverted. Sorry for
the misunderstanding the original issue and producing wrong fix.

Regards,
Sudeep

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
--
2.7.4

