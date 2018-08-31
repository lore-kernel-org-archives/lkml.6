Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B770C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1157820835
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H9wLNJSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1157820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeHaX3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:29:18 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42688 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeHaX3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:29:17 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VJKDSr117964;
        Fri, 31 Aug 2018 14:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535743213;
        bh=gDdm0RdbADdHbMA3OWdOpYCbUyi2UQrHebekyGn7fEA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=H9wLNJSysfnbgdKZbi1HCyr8JK2PHD0EhZy5yJuVkl1XyxxwuQPTqSfmtsMuCslPd
         XDGyMdB1ilgiBuoP1LzopMFlLRPf7QLFKm0XnM+1CGRP2r2X9kCgC+gs+wwSpKXwnt
         yHUn4yASW6RGsEKlCUGPH4P49CQzpFhEQf74vB5g=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJKDd8025648;
        Fri, 31 Aug 2018 14:20:13 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 14:20:13 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 14:20:13 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJKDSg015498;
        Fri, 31 Aug 2018 14:20:13 -0500
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w7VJKDx13941;
        Fri, 31 Aug 2018 14:20:13 -0500 (CDT)
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     <bigeasy@linutronix.de>, <linux-rt-users@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>, Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [4.14.66-rt TEST PATCH 1/3] irqchip/gic-v3-its: Make its_lock a raw_spin_lock_t
Date:   Fri, 31 Aug 2018 14:20:07 -0500
Message-ID: <20180831192009.17257-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
In-Reply-To: <20180830091456.mz73o26ohrc3rq2f@linutronix.de>
References: <20180830091456.mz73o26ohrc3rq2f@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index c564443..0b691d1 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -154,7 +154,7 @@ static struct {
 } vpe_proxy;
 
 static LIST_HEAD(its_nodes);
-static DEFINE_SPINLOCK(its_lock);
+static DEFINE_RAW_SPINLOCK(its_lock);
 static struct rdists *gic_rdists;
 static struct irq_domain *its_parent;
 
@@ -1854,7 +1854,7 @@ static void its_cpu_init_collection(void)
 	struct its_node *its;
 	int cpu;
 
-	spin_lock(&its_lock);
+	raw_spin_lock(&its_lock);
 	cpu = smp_processor_id();
 
 	list_for_each_entry(its, &its_nodes, entry) {
@@ -1896,7 +1896,7 @@ static void its_cpu_init_collection(void)
 		its_send_invall(its, &its->collections[cpu]);
 	}
 
-	spin_unlock(&its_lock);
+	raw_spin_unlock(&its_lock);
 }
 
 static struct its_device *its_find_device(struct its_node *its, u32 dev_id)
@@ -3109,9 +3109,9 @@ static int __init its_probe_one(struct resource *res,
 	if (err)
 		goto out_free_tables;
 
-	spin_lock(&its_lock);
+	raw_spin_lock(&its_lock);
 	list_add(&its->entry, &its_nodes);
-	spin_unlock(&its_lock);
+	raw_spin_unlock(&its_lock);
 
 	return 0;
 
-- 
2.10.5

