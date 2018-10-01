Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D496DC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE152084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE152084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbeJAQmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:42:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46152 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729242AbeJAQmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:42:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24A1715AD;
        Mon,  1 Oct 2018 03:05:34 -0700 (PDT)
Received: from filthy-habits.Emea.Arm.com (filthy-habits.emea.arm.com [10.4.13.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B8273F5B3;
        Mon,  1 Oct 2018 03:05:33 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/2] genirq/debugfs: Reinstate full OF path for domain name
Date:   Mon,  1 Oct 2018 11:05:22 +0100
Message-Id: <20181001100522.180054-3-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001100522.180054-1-marc.zyngier@arm.com>
References: <20181001100522.180054-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a DT based system, we use the of_node full name to name the
corresponding irq domain. We expect that name to be unique, so
so that domains with the same base name won't clash (this
happens on multi-node topologies, for example).

Since a7e4cfb0a7ca ("of/fdt: only store the device node basename
in full_name"), of_node_full_name() lies and only returns the
basename. This breaks the above requirement, and we end-up with
only a subset of the domains in /sys/kernel/debug/irq/domains.

Let's reinstate the feature by using the fancy new %pOF format
specifier, which happens to do the right thing.

Fixes: a7e4cfb0a7ca ("of/fdt: only store the device node basename in full_name")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 95a0acbdd4e6..3b30a4aeb0db 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -183,7 +183,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 		 * unhappy about. Replace them with ':', which does
 		 * the trick and is not as offensive as '\'...
 		 */
-		name = kstrdup(of_node_full_name(of_node), GFP_KERNEL);
+		name = kasprintf(GFP_KERNEL, "%pOF", of_node);
 		if (!name) {
 			kfree(domain);
 			return NULL;
-- 
2.19.0

