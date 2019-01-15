Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCE0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9039020651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfAOK2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:28:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54159 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfAOK2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:28:00 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0FARtpi2475616
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Jan 2019 02:27:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0FARtLC2475613;
        Tue, 15 Jan 2019 02:27:55 -0800
Date:   Tue, 15 Jan 2019 02:27:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Srinivas Ramana <tipbot@zytor.com>
Message-ID: <tip-bddda606ec76550dd63592e32a6e87e7d32583f7@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, sramana@codeaurora.org
Reply-To: sramana@codeaurora.org, linux-kernel@vger.kernel.org,
          hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <1545312957-8504-1-git-send-email-sramana@codeaurora.org>
References: <1545312957-8504-1-git-send-email-sramana@codeaurora.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] genirq: Make sure the initial affinity is not
 empty
Git-Commit-ID: bddda606ec76550dd63592e32a6e87e7d32583f7
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

Commit-ID:  bddda606ec76550dd63592e32a6e87e7d32583f7
Gitweb:     https://git.kernel.org/tip/bddda606ec76550dd63592e32a6e87e7d32583f7
Author:     Srinivas Ramana <sramana@codeaurora.org>
AuthorDate: Thu, 20 Dec 2018 19:05:57 +0530
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 15 Jan 2019 11:23:27 +0100

genirq: Make sure the initial affinity is not empty

If all CPUs in the irq_default_affinity mask are offline when an interrupt
is initialized then irq_setup_affinity() can set an empty affinity mask for
a newly allocated interrupt.

Fix this by falling back to cpu_online_mask in case the resulting affinity
mask is zero.

Signed-off-by: Srinivas Ramana <sramana@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-msm@vger.kernel.org
Link: https://lkml.kernel.org/r/1545312957-8504-1-git-send-email-sramana@codeaurora.org

---
 kernel/irq/manage.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index a4888ce4667a..84b54a17b95d 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -393,6 +393,9 @@ int irq_setup_affinity(struct irq_desc *desc)
 	}
 
 	cpumask_and(&mask, cpu_online_mask, set);
+	if (cpumask_empty(&mask))
+		cpumask_copy(&mask, cpu_online_mask);
+
 	if (node != NUMA_NO_NODE) {
 		const struct cpumask *nodemask = cpumask_of_node(node);
 
