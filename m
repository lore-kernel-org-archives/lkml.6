Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03B6C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFAD21B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898553;
	bh=kqw8wKY54iYanuPTfWmlTuwART1MAM0LgEZUnp1EWN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zcUlJckobESgUgIQQFT3jPtpTwkguCFas47s69JBgzFFv3uO+HJxz22/G+80KCbyv
	 90XRxCZSdJXa/Vnxa3tB4RjkkcXawu0eyGlM9fTKE++yl1oA/Hlgl0zbBkUcYA5CIe
	 uzkbfNnsWJb23xap3abJR7TYNsNnypQ7BabsU/E0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391878AbfBKPWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:22:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:52682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729044AbfBKPDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:03:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62231222AD;
        Mon, 11 Feb 2019 15:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897431;
        bh=kqw8wKY54iYanuPTfWmlTuwART1MAM0LgEZUnp1EWN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TVpChFbOGJv5E9krbHz0s9zZXy4+cnTd2IgEykQ39kbvnOADi53dtqiiCo81sUYcZ
         o7sGGMJWIsIbTM2okpMBG6VJVFenSeQL0S2l8H8WB+WPvCVHmGfMONoKToesk4AfkS
         f6r9NwhWLgizD98xG7j+JYPTouawxWlEF/EOiCGY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zheng Xiang <zhengxiang9@huawei.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.14 184/205] irqchip/gic-v3-its: Plug allocation race for devices sharing a DevID
Date:   Mon, 11 Feb 2019 15:19:42 +0100
Message-Id: <20190211141840.437259248@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit 9791ec7df0e7b4d80706ccea8f24b6542f6059e9 upstream.

On systems or VMs where multiple devices share a single DevID
(because they sit behind a PCI bridge, or because the HW is
broken in funky ways), we reuse the save its_device structure
in order to reflect this.

It turns out that there is a distinct lack of locking when looking
up the its_device, and two device being probed concurrently can result
in double allocations. That's obviously not nice.

A solution for this is to have a per-ITS mutex that serializes device
allocation.

A similar issue exists on the freeing side, which can run concurrently
with the allocation. On top of now taking the appropriate lock, we
also make sure that a shared device is never freed, as we have no way
to currently track the life cycle of such object.

Reported-by: Zheng Xiang <zhengxiang9@huawei.com>
Tested-by: Zheng Xiang <zhengxiang9@huawei.com>
Cc: stable@vger.kernel.org
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-gic-v3-its.c |   32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -87,9 +87,14 @@ struct its_baser {
  * The ITS structure - contains most of the infrastructure, with the
  * top-level MSI domain, the command queue, the collections, and the
  * list of devices writing to it.
+ *
+ * dev_alloc_lock has to be taken for device allocations, while the
+ * spinlock must be taken to parse data structures such as the device
+ * list.
  */
 struct its_node {
 	raw_spinlock_t		lock;
+	struct mutex		dev_alloc_lock;
 	struct list_head	entry;
 	void __iomem		*base;
 	phys_addr_t		phys_base;
@@ -138,6 +143,7 @@ struct its_device {
 	void			*itt;
 	u32			nr_ites;
 	u32			device_id;
+	bool			shared;
 };
 
 static struct {
@@ -2109,6 +2115,7 @@ static int its_msi_prepare(struct irq_do
 	struct its_device *its_dev;
 	struct msi_domain_info *msi_info;
 	u32 dev_id;
+	int err = 0;
 
 	/*
 	 * We ignore "dev" entierely, and rely on the dev_id that has
@@ -2131,6 +2138,7 @@ static int its_msi_prepare(struct irq_do
 		return -EINVAL;
 	}
 
+	mutex_lock(&its->dev_alloc_lock);
 	its_dev = its_find_device(its, dev_id);
 	if (its_dev) {
 		/*
@@ -2138,18 +2146,22 @@ static int its_msi_prepare(struct irq_do
 		 * another alias (PCI bridge of some sort). No need to
 		 * create the device.
 		 */
+		its_dev->shared = true;
 		pr_debug("Reusing ITT for devID %x\n", dev_id);
 		goto out;
 	}
 
 	its_dev = its_create_device(its, dev_id, nvec, true);
-	if (!its_dev)
-		return -ENOMEM;
+	if (!its_dev) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	pr_debug("ITT %d entries, %d bits\n", nvec, ilog2(nvec));
 out:
+	mutex_unlock(&its->dev_alloc_lock);
 	info->scratchpad[0].ptr = its_dev;
-	return 0;
+	return err;
 }
 
 static struct msi_domain_ops its_msi_domain_ops = {
@@ -2252,6 +2264,7 @@ static void its_irq_domain_free(struct i
 {
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+	struct its_node *its = its_dev->its;
 	int i;
 
 	for (i = 0; i < nr_irqs; i++) {
@@ -2266,8 +2279,14 @@ static void its_irq_domain_free(struct i
 		irq_domain_reset_irq_data(data);
 	}
 
-	/* If all interrupts have been freed, start mopping the floor */
-	if (bitmap_empty(its_dev->event_map.lpi_map,
+	mutex_lock(&its->dev_alloc_lock);
+
+	/*
+	 * If all interrupts have been freed, start mopping the
+	 * floor. This is conditionned on the device not being shared.
+	 */
+	if (!its_dev->shared &&
+	    bitmap_empty(its_dev->event_map.lpi_map,
 			 its_dev->event_map.nr_lpis)) {
 		its_lpi_free_chunks(its_dev->event_map.lpi_map,
 				    its_dev->event_map.lpi_base,
@@ -2279,6 +2298,8 @@ static void its_irq_domain_free(struct i
 		its_free_device(its_dev);
 	}
 
+	mutex_unlock(&its->dev_alloc_lock);
+
 	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
 }
 
@@ -2966,6 +2987,7 @@ static int __init its_probe_one(struct r
 	}
 
 	raw_spin_lock_init(&its->lock);
+	mutex_init(&its->dev_alloc_lock);
 	INIT_LIST_HEAD(&its->entry);
 	INIT_LIST_HEAD(&its->its_device_list);
 	typer = gic_read_typer(its_base + GITS_TYPER);


