Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B59C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF8A20835
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF8A20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732824AbeGKL2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:28:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33700 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732586AbeGKL2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:28:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54B04168F;
        Wed, 11 Jul 2018 04:24:49 -0700 (PDT)
Received: from usa.arm.com (unknown [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6A97D3F589;
        Wed, 11 Jul 2018 04:24:48 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 3/3] clockevents: warn if cpu_all_mask is used for cpumask while registering new device
Date:   Wed, 11 Jul 2018 12:24:24 +0100
Message-Id: <1531308264-24220-3-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531308264-24220-1-git-send-email-sudeep.holla@arm.com>
References: <1531308264-24220-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using cpu_all_mask in clockevents cpumask may result in issues while
comparing multiple clockevent devices to choose the preferred one.
On one of the platforms with 2 system(i.e. non per-CPU) timers with
different ratings, having cpu_all_mask for one of the device resulted
in boot hang with forever loop in clockevents_notify_released as both
were being selected as preferred.

In order to prevent such issues in future, let's warn if any clockevent
drivers sets cpu_all_mask as it's cpumask and just override it to use
cpu_possible_mask. All the existing occurrences of cpu_all_mask are
already replaced with cpu_possible_mask.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 kernel/time/clockevents.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 16c027e9cc73..8c0e4092f661 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -463,6 +463,12 @@ void clockevents_register_device(struct clock_event_device *dev)
 		dev->cpumask = cpumask_of(smp_processor_id());
 	}

+	if (dev->cpumask == cpu_all_mask) {
+		WARN(1, "%s cpumask == cpu_all_mask, using cpu_possible_mask instead\n",
+		     dev->name);
+		dev->cpumask = cpu_possible_mask;
+	}
+
 	raw_spin_lock_irqsave(&clockevents_lock, flags);

 	list_add(&dev->list, &clockevent_devices);
--
2.7.4

