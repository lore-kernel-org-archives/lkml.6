Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E50C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38361241D2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38361241D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753944AbeFVM2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:28:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52551 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbeFVM2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:28:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5MCRZwL066808
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Jun 2018 05:27:35 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5MCRZ7g066805;
        Fri, 22 Jun 2018 05:27:35 -0700
Date:   Fri, 22 Jun 2018 05:27:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Marc Zyngier <tipbot@zytor.com>
Message-ID: <tip-205e065d91d72e6afad112ea84f0ca60b30bf5ab@git.kernel.org>
Cc:     marc.zyngier@arm.com, yangyingliang@huawei.com, hpa@zytor.com,
        tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com
Reply-To: linux-kernel@vger.kernel.org, sumit.garg@linaro.org,
          mingo@kernel.org, alexandre.belloni@bootlin.com,
          marc.zyngier@arm.com, jason@lakedaemon.net, tglx@linutronix.de,
          hpa@zytor.com, yangyingliang@huawei.com
In-Reply-To: <20180622095254.5906-7-marc.zyngier@arm.com>
References: <20180622095254.5906-7-marc.zyngier@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] irqchip/gic-v3-its: Only emit VSYNC if targetting
 a valid collection
Git-Commit-ID: 205e065d91d72e6afad112ea84f0ca60b30bf5ab
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

Commit-ID:  205e065d91d72e6afad112ea84f0ca60b30bf5ab
Gitweb:     https://git.kernel.org/tip/205e065d91d72e6afad112ea84f0ca60b30bf5ab
Author:     Marc Zyngier <marc.zyngier@arm.com>
AuthorDate: Fri, 22 Jun 2018 10:52:53 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Jun 2018 14:22:01 +0200

irqchip/gic-v3-its: Only emit VSYNC if targetting a valid collection

Similarily to the SYNC operation, it must be verified that the VPE
targetted by a VLPI is backed by a valid collection in the GIC driver data
structures.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Link: https://lkml.kernel.org/r/20180622095254.5906-7-marc.zyngier@arm.com

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
