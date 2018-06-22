Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B20C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD6E241C4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD6E241C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754134AbeFVM0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:26:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40237 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbeFVM0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:26:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5MCQXJr066568
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 05:26:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5MCQWWo066565;
        Fri, 22 Jun 2018 05:26:32 -0700
Date:   Fri, 22 Jun 2018 05:26:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yang Yingliang <tipbot@zytor.com>
Message-ID: <tip-c1797b11a09c8323c92b074fd48b89a936c991d0@git.kernel.org>
Cc:     sumit.garg@linaro.org, alexandre.belloni@bootlin.com,
        yangyingliang@huawei.com, linux-kernel@vger.kernel.org,
        jason@lakedaemon.net, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, marc.zyngier@arm.com
Reply-To: mingo@kernel.org, hpa@zytor.com, marc.zyngier@arm.com,
          tglx@linutronix.de, yangyingliang@huawei.com,
          sumit.garg@linaro.org, alexandre.belloni@bootlin.com,
          linux-kernel@vger.kernel.org, jason@lakedaemon.net
In-Reply-To: <20180622095254.5906-5-marc.zyngier@arm.com>
References: <20180622095254.5906-5-marc.zyngier@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] irqchip/gic-v3-its: Don't bind LPI to unavailable
 NUMA node
Git-Commit-ID: c1797b11a09c8323c92b074fd48b89a936c991d0
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

Commit-ID:  c1797b11a09c8323c92b074fd48b89a936c991d0
Gitweb:     https://git.kernel.org/tip/c1797b11a09c8323c92b074fd48b89a936c991d0
Author:     Yang Yingliang <yangyingliang@huawei.com>
AuthorDate: Fri, 22 Jun 2018 10:52:51 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Jun 2018 14:22:01 +0200

irqchip/gic-v3-its: Don't bind LPI to unavailable NUMA node

On a NUMA system, if an ITS is local to an offline node, the ITS driver may
pick an offline CPU to bind the LPI.  In this case, pick an online CPU (and
the first one will do).

But on some systems, binding an LPI to non-local node CPU may cause
deadlock (see Cavium erratum 23144).  In this case, just fail the activate
and return an error code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180622095254.5906-5-marc.zyngier@arm.com

---
 drivers/irqchip/irq-gic-v3-its.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5377d7e2afba..cae53937feeb 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2310,7 +2310,14 @@ static int its_irq_domain_activate(struct irq_domain *domain,
 		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
 
 	/* Bind the LPI to the first possible CPU */
-	cpu = cpumask_first(cpu_mask);
+	cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
+	if (cpu >= nr_cpu_ids) {
+		if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144)
+			return -EINVAL;
+
+		cpu = cpumask_first(cpu_online_mask);
+	}
+
 	its_dev->event_map.col_map[event] = cpu;
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
