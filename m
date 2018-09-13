Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14864C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A330D20C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A330D20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeIMQJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:09:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45567 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbeIMQJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:09:21 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g0PMB-0007bD-RE; Thu, 13 Sep 2018 13:00:19 +0200
Date:   Thu, 13 Sep 2018 13:00:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dou Liyang <dou_liyang@163.com>
cc:     LKML <linux-kernel@vger.kernel.org>, kashyap.desai@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, sumit.saxena@broadcom.com,
        ming.lei@redhat.com, Christoph Hellwig <hch@lst.de>,
        douly.fnst@cn.fujitsu.com, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH] irq/affinity: Mark the pre/post vectors as regular
 interrupts
In-Reply-To: <20180913031011.17376-1-dou_liyang@163.com>
Message-ID: <alpine.DEB.2.21.1809131135540.1473@nanos.tec.linutronix.de>
References: <20180913031011.17376-1-dou_liyang@163.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018, Dou Liyang wrote:
> So, clear these affinity mask and check it in alloc_desc() to leave them
> as regular interrupts which can be affinity controlled and also can move
> freely on hotplug.

This is the wrong direction as it does not allow to do initial affinity
assignement for the non-managed interrupts on allocation time. And that's
what Kashyap and Sumit are looking for.

The trivial fix for the possible breakage when irq_default_affinity !=
cpu_possible_mask is to set the affinity for the pre/post vectors to
cpu_possible_mask and be done with it.

One other thing I noticed while staring at that is the fact, that the PCI
code does not care about the return value of irq_create_affinity_masks() at
all. It just proceeds if masks is NULL as if the stuff was requested with
the affinity descriptor pointer being NULL. I don't think that's a
brilliant idea because the drivers might rely on the interrupt being
managed, but it might be a non-issue and just result in bad locality.

Christoph?

So back to the problem at hand. We need to change the affinity management
scheme in a way which lets us differentiate between managed and unmanaged
interrupts, so it allows to automatically assign (initial) affinity to all
of them.

Right now everything is bound to the cpumasks array, which does not allow
to convey more information. So we need to come up with something different.

Something like the below (does not compile and is just for reference)
should do the trick. I'm not sure whether we want to convey the information
(masks and bitmap) in a single data structure or not, but that's an
implementation detail.

Thanks,

	tglx

8<---------
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -535,15 +535,16 @@ static struct msi_desc *
 msi_setup_entry(struct pci_dev *dev, int nvec, const struct irq_affinity *affd)
 {
 	struct cpumask *masks = NULL;
+	unsigned long managed = 0;
 	struct msi_desc *entry;
 	u16 control;
 
 	if (affd)
-		masks = irq_create_affinity_masks(nvec, affd);
+		masks = irq_create_affinity_masks(nvec, affd, &managed);
 
 
 	/* MSI Entry Initialization */
-	entry = alloc_msi_entry(&dev->dev, nvec, masks);
+	entry = alloc_msi_entry(&dev->dev, nvec, masks, managed);
 	if (!entry)
 		goto out;
 
@@ -672,15 +673,22 @@ static int msix_setup_entries(struct pci
 			      struct msix_entry *entries, int nvec,
 			      const struct irq_affinity *affd)
 {
+	/*
+	 * MSIX_MAX_VECTORS = 2048, i.e. 256 bytes. Might need runtime
+	 * allocation. OTOH, are 2048 vectors realistic?
+	 */
+	DECLARE_BITMAP(managed, MSIX_MAX_VECTORS);
 	struct cpumask *curmsk, *masks = NULL;
 	struct msi_desc *entry;
 	int ret, i;
 
 	if (affd)
-		masks = irq_create_affinity_masks(nvec, affd);
+		masks = irq_create_affinity_masks(nvec, affd, managed);
 
 	for (i = 0, curmsk = masks; i < nvec; i++) {
-		entry = alloc_msi_entry(&dev->dev, 1, curmsk);
+		unsigned long m = test_bit(i, managed) ? 1 : 0;
+
+		entry = alloc_msi_entry(&dev->dev, 1, curmsk, m);
 		if (!entry) {
 			if (!i)
 				iounmap(base);
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -27,7 +27,8 @@
  * and the affinity masks from @affinity are copied.
  */
 struct msi_desc *
-alloc_msi_entry(struct device *dev, int nvec, const struct cpumask *affinity)
+alloc_msi_entry(struct device *dev, int nvec, const struct cpumask *affinity,
+		unsigned long managed)
 {
 	struct msi_desc *desc;
 
@@ -38,6 +39,7 @@ alloc_msi_entry(struct device *dev, int
 	INIT_LIST_HEAD(&desc->list);
 	desc->dev = dev;
 	desc->nvec_used = nvec;
+	desc->managed = managed;
 	if (affinity) {
 		desc->affinity = kmemdup(affinity,
 			nvec * sizeof(*desc->affinity), GFP_KERNEL);
@@ -416,7 +418,7 @@ int msi_domain_alloc_irqs(struct irq_dom
 
 		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
 					       dev_to_node(dev), &arg, false,
-					       desc->affinity);
+					       desc->affinity, desc->managed);
 		if (virq < 0) {
 			ret = -ENOSPC;
 			if (ops->handle_error)
