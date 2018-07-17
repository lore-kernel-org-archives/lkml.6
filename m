Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5DCECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF2C20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF2C20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbeGQMMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:12:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34405 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbeGQMMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:12:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6HBdx7u1495288
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 04:39:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6HBdwCq1495285;
        Tue, 17 Jul 2018 04:39:58 -0700
Date:   Tue, 17 Jul 2018 04:39:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for RAGHU Halharvi <tipbot@zytor.com>
Message-ID: <tip-d91cfeb0aa79445fcfa9f523a5b57c5e9f4113ec@git.kernel.org>
Cc:     raghuhack78@gmail.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, hpa@zytor.com, raghuhack78@gmail.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180717102009.7708-1-raghuhack78@gmail.com>
References: <20180717102009.7708-1-raghuhack78@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Remove redundant NULL pointer check in
 __free_irq()
Git-Commit-ID: d91cfeb0aa79445fcfa9f523a5b57c5e9f4113ec
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

Commit-ID:  d91cfeb0aa79445fcfa9f523a5b57c5e9f4113ec
Gitweb:     https://git.kernel.org/tip/d91cfeb0aa79445fcfa9f523a5b57c5e9f4113ec
Author:     RAGHU Halharvi <raghuhack78@gmail.com>
AuthorDate: Tue, 17 Jul 2018 15:50:09 +0530
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 17 Jul 2018 13:35:44 +0200

genirq: Remove redundant NULL pointer check in __free_irq()

The NULL pointer check in __free_irq() triggers a 'dereference before NULL
pointer check' warning in static code analysis. It turns out that the check
is redundant because all callers have a NULL pointer check already.

Remove it.

Signed-off-by: RAGHU Halharvi <raghuhack78@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20180717102009.7708-1-raghuhack78@gmail.com

---
 kernel/irq/manage.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1f8be33572a7..a66c58f91bff 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1570,9 +1570,6 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 
 	WARN(in_interrupt(), "Trying to free IRQ %d from IRQ context!\n", irq);
 
-	if (!desc)
-		return NULL;
-
 	mutex_lock(&desc->request_mutex);
 	chip_bus_lock(desc);
 	raw_spin_lock_irqsave(&desc->lock, flags);
