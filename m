Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BF8C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A312075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A312075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757269AbeFSL4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:56:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48436 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757254AbeFSL4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:56:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF4ED165C;
        Tue, 19 Jun 2018 04:56:14 -0700 (PDT)
Received: from approximate.cambridge.arm.com (approximate.cambridge.arm.com [10.1.206.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1DF13F557;
        Tue, 19 Jun 2018 04:56:13 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 6/6] irqchip/gic-v3-its: Only emit VSYNC if targetting a valid collection
Date:   Tue, 19 Jun 2018 12:55:46 +0100
Message-Id: <20180619115546.12196-7-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619115546.12196-1-marc.zyngier@arm.com>
References: <20180619115546.12196-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarily to the SYNC operation, we need to verify that the VPE
targetted by a VLPI is backed by a valid collection in the
GIC driver data structures.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fcfc96f8e0de..0269ffb93f6e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -190,6 +190,14 @@ static struct its_collection *valid_col(struct its_collection *col)
 	return col;
 }
 
+static struct its_vpe *valid_vpe(struct its_node *its, struct its_vpe *vpe)
+{
+	if (valid_col(its->collections + vpe->col_idx))
+		return vpe;
+
+	return NULL;
+}
+
 /*
  * ITS command descriptors - parameters to be encoded in a command
  * block.
@@ -562,7 +570,7 @@ static struct its_vpe *its_build_vinvall_cmd(struct its_node *its,
 
 	its_fixup_cmd(cmd);
 
-	return desc->its_vinvall_cmd.vpe;
+	return valid_vpe(its, desc->its_vinvall_cmd.vpe);
 }
 
 static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
@@ -584,7 +592,7 @@ static struct its_vpe *its_build_vmapp_cmd(struct its_node *its,
 
 	its_fixup_cmd(cmd);
 
-	return desc->its_vmapp_cmd.vpe;
+	return valid_vpe(its, desc->its_vmapp_cmd.vpe);
 }
 
 static struct its_vpe *its_build_vmapti_cmd(struct its_node *its,
@@ -607,7 +615,7 @@ static struct its_vpe *its_build_vmapti_cmd(struct its_node *its,
 
 	its_fixup_cmd(cmd);
 
-	return desc->its_vmapti_cmd.vpe;
+	return valid_vpe(its, desc->its_vmapti_cmd.vpe);
 }
 
 static struct its_vpe *its_build_vmovi_cmd(struct its_node *its,
@@ -630,7 +638,7 @@ static struct its_vpe *its_build_vmovi_cmd(struct its_node *its,
 
 	its_fixup_cmd(cmd);
 
-	return desc->its_vmovi_cmd.vpe;
+	return valid_vpe(its, desc->its_vmovi_cmd.vpe);
 }
 
 static struct its_vpe *its_build_vmovp_cmd(struct its_node *its,
@@ -648,7 +656,7 @@ static struct its_vpe *its_build_vmovp_cmd(struct its_node *its,
 
 	its_fixup_cmd(cmd);
 
-	return desc->its_vmovp_cmd.vpe;
+	return valid_vpe(its, desc->its_vmovp_cmd.vpe);
 }
 
 static u64 its_cmd_ptr_to_offset(struct its_node *its,
-- 
2.17.1

