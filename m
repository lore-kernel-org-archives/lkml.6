Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3ECC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E57C2183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864906;
	bh=+ABmv3dlTr/MpUlhaiEFB0iF4kXfdBOlNtsdh02a9ZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r8V2e8aNs2JiL95xwNDez3f7uxMs4b6Mg1PxJWU64g3CJfgqdY9rGxgSVuCtdVeSK
	 NQK1n3/Vk27bixHfTmJPmB4LpuW48vmgnbspJM2dBC9PlyQNbbZ+aIr6Ekw4Dl0EzH
	 IwSDYoXXrwO9m0l40BljqMJh4ulOAVLvGt274xqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfAGMlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:41:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:57072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbfAGMlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:41:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96A5721855;
        Mon,  7 Jan 2019 12:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864903;
        bh=+ABmv3dlTr/MpUlhaiEFB0iF4kXfdBOlNtsdh02a9ZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=14lpfnY3X/M1GoTiGoqVVUJlo4IKEOBb7ZybgAPqaj44539YAtNsfurl9+VRaaCgc
         OC/lXqsiec8/u934OPPxAwwTdTnlK45FcFo6wRGxboGrPHIU80NwMIP+i5efFVOnnB
         iu3+XOrGeSS0BQf3I6WEpByY2eFUS3S+UjtUaGWA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.20 060/145] platform-msi: Free descriptors in platform_msi_domain_free()
Date:   Mon,  7 Jan 2019 13:31:37 +0100
Message-Id: <20190107104445.109919968@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit 81b1e6e6a8590a19257e37a1633bec098d499c57 upstream.

Since the addition of platform MSI support, there were two helpers
supposed to allocate/free IRQs for a device:

    platform_msi_domain_alloc_irqs()
    platform_msi_domain_free_irqs()

In these helpers, IRQ descriptors are allocated in the "alloc" routine
while they are freed in the "free" one.

Later, two other helpers have been added to handle IRQ domains on top
of MSI domains:

    platform_msi_domain_alloc()
    platform_msi_domain_free()

Seen from the outside, the logic is pretty close with the former
helpers and people used it with the same logic as before: a
platform_msi_domain_alloc() call should be balanced with a
platform_msi_domain_free() call. While this is probably what was
intended to do, the platform_msi_domain_free() does not remove/free
the IRQ descriptor(s) created/inserted in
platform_msi_domain_alloc().

One effect of such situation is that removing a module that requested
an IRQ will let one orphaned IRQ descriptor (with an allocated MSI
entry) in the device descriptors list. Next time the module will be
inserted back, one will observe that the allocation will happen twice
in the MSI domain, one time for the remaining descriptor, one time for
the new one. It also has the side effect to quickly overshoot the
maximum number of allocated MSI and then prevent any module requesting
an interrupt in the same domain to be inserted anymore.

This situation has been met with loops of insertion/removal of the
mvpp2.ko module (requesting 15 MSIs each time).

Fixes: 552c494a7666 ("platform-msi: Allow creation of a MSI-based stacked irq domain")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/platform-msi.c |    6 ++++--
 include/linux/msi.h         |    2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -368,14 +368,16 @@ void platform_msi_domain_free(struct irq
 			      unsigned int nvec)
 {
 	struct platform_msi_priv_data *data = domain->host_data;
-	struct msi_desc *desc;
-	for_each_msi_entry(desc, data->dev) {
+	struct msi_desc *desc, *tmp;
+	for_each_msi_entry_safe(desc, tmp, data->dev) {
 		if (WARN_ON(!desc->irq || desc->nvec_used != 1))
 			return;
 		if (!(desc->irq >= virq && desc->irq < (virq + nvec)))
 			continue;
 
 		irq_domain_free_irqs_common(domain, desc->irq, 1);
+		list_del(&desc->list);
+		free_msi_entry(desc);
 	}
 }
 
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -116,6 +116,8 @@ struct msi_desc {
 	list_first_entry(dev_to_msi_list((dev)), struct msi_desc, list)
 #define for_each_msi_entry(desc, dev)	\
 	list_for_each_entry((desc), dev_to_msi_list((dev)), list)
+#define for_each_msi_entry_safe(desc, tmp, dev)	\
+	list_for_each_entry_safe((desc), (tmp), dev_to_msi_list((dev)), list)
 
 #ifdef CONFIG_PCI_MSI
 #define first_pci_msi_entry(pdev)	first_msi_entry(&(pdev)->dev)


