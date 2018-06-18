Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7282EC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E8A20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E8A20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965592AbeFRIWw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:22:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55640 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935849AbeFRIWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:22:49 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6063BC7F;
        Mon, 18 Jun 2018 08:22:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jagannathan Raman <jag.raman@oracle.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 163/279] iommu/vt-d: Fix usage of force parameter in intel_ir_reconfigure_irte()
Date:   Mon, 18 Jun 2018 10:12:28 +0200
Message-Id: <20180618080615.569482551@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jagannathan Raman <jag.raman@oracle.com>

[ Upstream commit aa7528fe3576d11f4a10237178a723a1f080a547 ]

It was noticed that the IRTE configured for guest OS kernel
was over-written while the guest was running. As a result,
vt-d Posted Interrupts configured for the guest are not being
delivered directly, and instead bounces off the host. Every
interrupt delivery takes a VM Exit.

It was noticed that the following stack is doing the over-write:
[  147.463177]  modify_irte+0x171/0x1f0
[  147.463405]  intel_ir_set_affinity+0x5c/0x80
[  147.463641]  msi_domain_set_affinity+0x32/0x90
[  147.463881]  irq_do_set_affinity+0x37/0xd0
[  147.464125]  irq_set_affinity_locked+0x9d/0xb0
[  147.464374]  __irq_set_affinity+0x42/0x70
[  147.464627]  write_irq_affinity.isra.5+0xe1/0x110
[  147.464895]  proc_reg_write+0x38/0x70
[  147.465150]  __vfs_write+0x36/0x180
[  147.465408]  ? handle_mm_fault+0xdf/0x200
[  147.465671]  ? _cond_resched+0x15/0x30
[  147.465936]  vfs_write+0xad/0x1a0
[  147.466204]  SyS_write+0x52/0xc0
[  147.466472]  do_syscall_64+0x74/0x1a0
[  147.466744]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2

reversing the sense of force check in intel_ir_reconfigure_irte()
restores proper posted interrupt functionality

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Fixes: d491bdff888e ('iommu/vt-d: Reevaluate vector configuration on activate()')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/intel_irq_remapping.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -1136,7 +1136,7 @@ static void intel_ir_reconfigure_irte(st
 	irte->dest_id = IRTE_DEST(cfg->dest_apicid);
 
 	/* Update the hardware only if the interrupt is in remapped mode. */
-	if (!force || ir_data->irq_2_iommu.mode == IRQ_REMAPPING)
+	if (force || ir_data->irq_2_iommu.mode == IRQ_REMAPPING)
 		modify_irte(&ir_data->irq_2_iommu, irte);
 }
 


