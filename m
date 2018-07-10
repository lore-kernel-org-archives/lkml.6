Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2442C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8807B20834
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8807B20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732491AbeGJUQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 16:16:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58931 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732378AbeGJUQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 16:16:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6AKFvNT3265157
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 10 Jul 2018 13:15:57 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6AKFur33265154;
        Tue, 10 Jul 2018 13:15:56 -0700
Date:   Tue, 10 Jul 2018 13:15:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sudeep Holla <tipbot@zytor.com>
Message-ID: <tip-5b5ccbc2b041f98f26b984e013d303b7f9e6fb8e@git.kernel.org>
Cc:     marc.zyngier@arm.com, mingo@kernel.org, sudeep.holla@arm.com,
        martin.blumenstingl@googlemail.com, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, tglx@linutronix.de, hpa@zytor.com
Reply-To: khilman@baylibre.com, tglx@linutronix.de, hpa@zytor.com,
          marc.zyngier@arm.com, mingo@kernel.org, sudeep.holla@arm.com,
          martin.blumenstingl@googlemail.com, linux-kernel@vger.kernel.org
In-Reply-To: <1531151136-18297-1-git-send-email-sudeep.holla@arm.com>
References: <1531151136-18297-1-git-send-email-sudeep.holla@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] Revert "tick: Prefer a lower rating device only
 if it's CPU local device"
Git-Commit-ID: 5b5ccbc2b041f98f26b984e013d303b7f9e6fb8e
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

Commit-ID:  5b5ccbc2b041f98f26b984e013d303b7f9e6fb8e
Gitweb:     https://git.kernel.org/tip/5b5ccbc2b041f98f26b984e013d303b7f9e6fb8e
Author:     Sudeep Holla <sudeep.holla@arm.com>
AuthorDate: Mon, 9 Jul 2018 16:45:35 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 10 Jul 2018 22:12:47 +0200

Revert "tick: Prefer a lower rating device only if it's CPU local device"

This reverts commit 1332a90558013ae4242e3dd7934bdcdeafb06c0d.

The original issue was not because of incorrect checking of cpumask for
both new and old tick device. It was incorrectly analysed was due to the
misunderstanding of the comment and misinterpretation of the return value
from tick_check_preferred. The main issue is with the clockevent driver
that sets the cpumask to cpu_all_mask instead of cpu_possible_mask.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Marc Zyngier <marc.zyngier@arm.com>
Link: https://lkml.kernel.org/r/1531151136-18297-1-git-send-email-sudeep.holla@arm.com

---
 kernel/time/tick-common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

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
