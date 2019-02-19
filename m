Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C244AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD0D2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfBSP5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:57:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:51974 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728201AbfBSP5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:57:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E5DA1AEB8;
        Tue, 19 Feb 2019 15:57:40 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/10] genirq/irqdomain: fall back to default domain when creating hierarchy domain
Date:   Tue, 19 Feb 2019 16:57:23 +0100
Message-Id: <20190219155728.19163-10-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190219155728.19163-1-tbogendoerfer@suse.de>
References: <20190219155728.19163-1-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating hierarchy domains use irq_default_domain as parent, if no
parent was given by the caller. This avoids adding helper code for
querying the underlying platform irq domain.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 kernel/irq/irqdomain.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 8b0be4bd6565..617c482d0778 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1021,7 +1021,10 @@ struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
 	else
 		domain = irq_domain_create_tree(fwnode, ops, host_data);
 	if (domain) {
-		domain->parent = parent;
+		if (parent)
+			domain->parent = parent;
+		else
+			domain->parent = irq_default_domain;
 		domain->flags |= flags;
 	}
 
-- 
2.13.7

