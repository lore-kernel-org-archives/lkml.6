Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F912ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB8A2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB8A2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbeIREU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:20:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44962 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeIREU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:20:26 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5387ECAC;
        Mon, 17 Sep 2018 22:51:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 41/56] iommu/ipmmu-vmsa: Fix allocation in atomic context
Date:   Tue, 18 Sep 2018 00:42:14 +0200
Message-Id: <20180917213829.621814849@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917213827.913122591@linuxfoundation.org>
References: <20180917213827.913122591@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 46583e8c48c5a094ba28060615b3a7c8c576690f ]

When attaching a device to an IOMMU group with
CONFIG_DEBUG_ATOMIC_SLEEP=y:

    BUG: sleeping function called from invalid context at mm/slab.h:421
    in_atomic(): 1, irqs_disabled(): 128, pid: 61, name: kworker/1:1
    ...
    Call trace:
     ...
     arm_lpae_alloc_pgtable+0x114/0x184
     arm_64_lpae_alloc_pgtable_s1+0x2c/0x128
     arm_32_lpae_alloc_pgtable_s1+0x40/0x6c
     alloc_io_pgtable_ops+0x60/0x88
     ipmmu_attach_device+0x140/0x334

ipmmu_attach_device() takes a spinlock, while arm_lpae_alloc_pgtable()
allocates memory using GFP_KERNEL.  Originally, the ipmmu-vmsa driver
had its own custom page table allocation implementation using
GFP_ATOMIC, hence the spinlock was fine.

Fix this by replacing the spinlock by a mutex, like the arm-smmu driver
does.

Fixes: f20ed39f53145e45 ("iommu/ipmmu-vmsa: Use the ARM LPAE page table allocator")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/ipmmu-vmsa.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -44,7 +44,7 @@ struct ipmmu_vmsa_domain {
 	struct io_pgtable_ops *iop;
 
 	unsigned int context_id;
-	spinlock_t lock;			/* Protects mappings */
+	struct mutex mutex;			/* Protects mappings */
 };
 
 struct ipmmu_vmsa_archdata {
@@ -464,7 +464,7 @@ static struct iommu_domain *ipmmu_domain
 	if (!domain)
 		return NULL;
 
-	spin_lock_init(&domain->lock);
+	mutex_init(&domain->mutex);
 
 	return &domain->io_domain;
 }
@@ -488,7 +488,6 @@ static int ipmmu_attach_device(struct io
 	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
 	struct ipmmu_vmsa_device *mmu = archdata->mmu;
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
-	unsigned long flags;
 	unsigned int i;
 	int ret = 0;
 
@@ -497,7 +496,7 @@ static int ipmmu_attach_device(struct io
 		return -ENXIO;
 	}
 
-	spin_lock_irqsave(&domain->lock, flags);
+	mutex_lock(&domain->mutex);
 
 	if (!domain->mmu) {
 		/* The domain hasn't been used yet, initialize it. */
@@ -513,7 +512,7 @@ static int ipmmu_attach_device(struct io
 		ret = -EINVAL;
 	}
 
-	spin_unlock_irqrestore(&domain->lock, flags);
+	mutex_unlock(&domain->mutex);
 
 	if (ret < 0)
 		return ret;


