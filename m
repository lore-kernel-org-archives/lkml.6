Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6628EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3513220824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3513220824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387529AbeKXFOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:14:19 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51063 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730778AbeKXFOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 00:14:19 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gQGCD-0003e4-36; Fri, 23 Nov 2018 19:28:53 +0100
Date:   Fri, 23 Nov 2018 19:28:46 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dou Liyang <douliyangs@gmail.com>
cc:     linux-kernel@vger.kernel.org, kashyap.desai@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, sumit.saxena@broadcom.com,
        ming.lei@redhat.com, hch@lst.de, bhelgaas@google.com
Subject: Re: [RFC PATCH v2] gen/irq: Change the way to differentiate between
 managed and unmanaged interrupts by bitmap
In-Reply-To: <20181109163849.21699-1-douliyangs@gmail.com>
Message-ID: <alpine.DEB.2.21.1811231834450.1684@nanos.tec.linutronix.de>
References: <20181109163849.21699-1-douliyangs@gmail.com>
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

Dou,

On Sat, 10 Nov 2018, Dou Liyang wrote:

sorry for late reply. Travel, conferences ....

> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -673,14 +674,17 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
>  			      const struct irq_affinity *affd)
>  {
>  	struct cpumask *curmsk, *masks = NULL;
> +	DECLARE_BITMAP(managed, nvec);

This is not working as it creates a variable length array (VLA). We just
got rid of all VLAs in the kernel and the compiler will catch this and
complain.

>  	struct msi_desc *entry;
>  	int ret, i;
>  
> +	memset(managed, 0, sizeof(managed));
>  	if (affd)
> -		masks = irq_create_affinity_masks(nvec, affd);
> +		masks = irq_create_affinity_masks(nvec, affd, managed);

So rather than changing the world and everything by adding new arguments,
what about the following:

-struct cpumask *irq_create_affinity_masks(int nvec, const struct irq_affinity *affd);
+struct irq_affinity_desc * irq_create_affinity_masks(int nvec, struct irq_affinity *affd);

struct irq_affinity_desc {
	struct cpumask	mask;
	unsigned long	flags;
};

or something like that. Let irq_create_affinity_masks() allocate an array
of those and store the information in the flags field. In the allocation
functions just replace the cpumask pointer with a irq_affinity_desc pointer
and hand that through to the irqdesc core, where you can evaluate the
flags. Way less things to modify and the data structure allows to expand
this in the future without touching all the functions ever again.

Can you please work against the tip irq/core branch as that has already
other changes in the affinity spreading code queued?

Thanks,

	tglx


