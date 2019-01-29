Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77227C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A6420880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763029;
	bh=VlEW2lhWiEuEwLCvSvJnzwocdGkUu5CytewinW2bMlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uTpgC13bFgiUMGmHQ0ggR/khLKWvr3hYQHDZMn/2tjLVIM1BcY4RmB+CM/A+2pdYJ
	 bh5+imuGv5FK+NcMkf6kEERPIiy77OT0uyC2dDo+sjr+qtMXsnjn2IwS3vekwvn/6P
	 jn0JHTxYzupUcEHIJZ+Eq+xOurg2PF81e5cyvgTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbfA2LtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:49:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:40266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731434AbfA2LtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:49:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B58BF2148E;
        Tue, 29 Jan 2019 11:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762554;
        bh=VlEW2lhWiEuEwLCvSvJnzwocdGkUu5CytewinW2bMlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y4Ut4+/LMBYEpiwqkdSgFATRYEQpeukWLBoJM0BWeYl0xMoxrYhAYa3ucJdyGw7Ap
         Z6fv9cfeBfauhLgvmxJPhIuYf3I5UmJ5KBsaUh3p4/ov+C+1PRFDDuhrAcQigYEpY0
         1rpgOBUsWrEQznF0VnmGtw/vBcyDLicqnr8BwTt8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.14 46/68] irqchip/gic-v3-its: Align PCI Multi-MSI allocation on their size
Date:   Tue, 29 Jan 2019 12:36:08 +0100
Message-Id: <20190129113135.906462811@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
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

commit 8208d1708b88b412ca97f50a6d951242c88cbbac upstream.

The way we allocate events works fine in most cases, except
when multiple PCI devices share an ITS-visible DevID, and that
one of them is trying to use MultiMSI allocation.

In that case, our allocation is not guaranteed to be zero-based
anymore, and we have to make sure we allocate it on a boundary
that is compatible with the PCI Multi-MSI constraints.

Fix this by allocating the full region upfront instead of iterating
over the number of MSIs. MSI-X are always allocated one by one,
so this shouldn't change anything on that front.

Fixes: b48ac83d6bbc2 ("irqchip: GICv3: ITS: MSI support")
Cc: stable@vger.kernel.org
Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-gic-v3-its.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2086,13 +2086,14 @@ static void its_free_device(struct its_d
 	kfree(its_dev);
 }
 
-static int its_alloc_device_irq(struct its_device *dev, irq_hw_number_t *hwirq)
+static int its_alloc_device_irq(struct its_device *dev, int nvecs, irq_hw_number_t *hwirq)
 {
 	int idx;
 
-	idx = find_first_zero_bit(dev->event_map.lpi_map,
-				  dev->event_map.nr_lpis);
-	if (idx == dev->event_map.nr_lpis)
+	idx = bitmap_find_free_region(dev->event_map.lpi_map,
+				      dev->event_map.nr_lpis,
+				      get_count_order(nvecs));
+	if (idx < 0)
 		return -ENOSPC;
 
 	*hwirq = dev->event_map.lpi_base + idx;
@@ -2188,21 +2189,21 @@ static int its_irq_domain_alloc(struct i
 	int err;
 	int i;
 
-	for (i = 0; i < nr_irqs; i++) {
-		err = its_alloc_device_irq(its_dev, &hwirq);
-		if (err)
-			return err;
+	err = its_alloc_device_irq(its_dev, nr_irqs, &hwirq);
+	if (err)
+		return err;
 
-		err = its_irq_gic_domain_alloc(domain, virq + i, hwirq);
+	for (i = 0; i < nr_irqs; i++) {
+		err = its_irq_gic_domain_alloc(domain, virq + i, hwirq + i);
 		if (err)
 			return err;
 
 		irq_domain_set_hwirq_and_chip(domain, virq + i,
-					      hwirq, &its_irq_chip, its_dev);
+					      hwirq + i, &its_irq_chip, its_dev);
 		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(virq + i)));
 		pr_debug("ID:%d pID:%d vID:%d\n",
-			 (int)(hwirq - its_dev->event_map.lpi_base),
-			 (int) hwirq, virq + i);
+			 (int)(hwirq + i - its_dev->event_map.lpi_base),
+			 (int)(hwirq + i), virq + i);
 	}
 
 	return 0;


