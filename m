Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4A5C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A4721501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A4721501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732523AbeHBOuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:50:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59781 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732287AbeHBOuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:50:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w72Cwn2F3506759
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 05:58:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w72Cwn5B3506756;
        Thu, 2 Aug 2018 05:58:49 -0700
Date:   Thu, 2 Aug 2018 05:58:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sudeep Holla <tipbot@zytor.com>
Message-ID: <tip-fbfa9260085b5b578a049a90135e5c51928c5f7f@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, sudeep.holla@arm.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
          sudeep.holla@arm.com, mingo@kernel.org
In-Reply-To: <1531308264-24220-3-git-send-email-sudeep.holla@arm.com>
References: <1531308264-24220-3-git-send-email-sudeep.holla@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] clockevents: Warn if cpu_all_mask is used as
 cpumask
Git-Commit-ID: fbfa9260085b5b578a049a90135e5c51928c5f7f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  fbfa9260085b5b578a049a90135e5c51928c5f7f
Gitweb:     https://git.kernel.org/tip/fbfa9260085b5b578a049a90135e5c51928c5f7f
Author:     Sudeep Holla <sudeep.holla@arm.com>
AuthorDate: Wed, 11 Jul 2018 12:24:24 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 2 Aug 2018 14:55:53 +0200

clockevents: Warn if cpu_all_mask is used as cpumask

Using cpu_all_mask in clockevents cpumask may result in issues while
comparing multiple clockevent devices to choose the preferred one.

On one of the platforms with 2 system (i.e. non per-CPU) timers with
different ratings, having cpu_all_mask for one of the device resulted in a
boot hang due to a endless loop in clockevents_notify_released() as both
were clocksources were selected as preferred.

In order to prevent such issues in the future, warn if any clockevent
driver sets cpu_all_mask as it's cpumask and just override it to use
cpu_possible_mask. All the existing occurrences of cpu_all_mask are already
replaced with cpu_possible_mask.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Link: https://lkml.kernel.org/r/1531308264-24220-3-git-send-email-sudeep.holla@arm.com

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
