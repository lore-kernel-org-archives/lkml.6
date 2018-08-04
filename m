Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1E2C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 07:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D3E2178F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 07:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D3E2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeHDJA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 05:00:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41259 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeHDJA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 05:00:59 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1flqYx-0002LU-Ck; Sat, 04 Aug 2018 09:01:19 +0200
Date:   Sat, 4 Aug 2018 09:01:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] PCI: set flag IRQCHIP_ONESHOT_SAFE for PCI-MSI
 irqchip's
In-Reply-To: <9f18bc20-cf27-bc3c-71e5-4e24a6c983c7@gmail.com>
Message-ID: <alpine.DEB.2.21.1808040900150.1658@nanos.tec.linutronix.de>
References: <9f18bc20-cf27-bc3c-71e5-4e24a6c983c7@gmail.com>
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

On Fri, 3 Aug 2018, Heiner Kallweit wrote:

> PCI-MSI is oneshot-safe, therefore set flag IRQCHIP_ONESHOT_SAFE to
> avoid unneeded masking/unmasking. See also discussion here:
> https://marc.info/?l=linux-pci&m=153332526101128&w=2

This changelog really wants a bit more detailed information.

> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pci/msi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 4d88afdf..f2ef8964 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1446,6 +1446,9 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
>  	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
>  		info->flags |= MSI_FLAG_MUST_REACTIVATE;
>  
> +	/* PCI-MSI is oneshot-safe */
> +	info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
> +
>  	domain = msi_create_irq_domain(fwnode, info, parent);
>  	if (!domain)
>  		return NULL;
> -- 
> 2.18.0
> 
> 
