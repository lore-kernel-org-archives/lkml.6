Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A08C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2B127F5D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2B127F5D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936604AbeF2Nmi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 09:42:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34598 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935810AbeF2Nmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 09:42:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3507D80D;
        Fri, 29 Jun 2018 06:42:36 -0700 (PDT)
Received: from red-moon (unknown [10.1.206.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27E973F5C0;
        Fri, 29 Jun 2018 06:42:35 -0700 (PDT)
Date:   Fri, 29 Jun 2018 14:44:23 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: faraday: add missing of_node_put()
Message-ID: <20180629134423.GF9643@red-moon>
References: <1529766899-1994-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529766899-1994-1-git-send-email-hofrat@osadl.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 05:14:59PM +0200, Nicholas Mc Guire wrote:
>  The call to of_get_next_child() returns a node pointer with refcount
> incremented thus it must be explicitly decremented here in the error
> path and after the last usage.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: commit d3c68e0a7e34 ("PCI: faraday: Add Faraday Technology FTPCI100 PCI Host Bridge driver")
> ---
> 
> Patch found my experimental coccinelle script
> 
> Patch was compile tested with: gemini_defconfig (implies CONFIG_PCI_FTPCI100=y)
> 
> Patch is against 4.18-rc1 (localversion-next is next-20180621)
> 
>  drivers/pci/controller/pci-ftpci100.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to pci/controller-fixes to be tentatively merged for -rc4,
thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
> index a1ebe9e..20bb256 100644
> --- a/drivers/pci/controller/pci-ftpci100.c
> +++ b/drivers/pci/controller/pci-ftpci100.c
> @@ -355,11 +355,13 @@ static int faraday_pci_setup_cascaded_irq(struct faraday_pci *p)
>  	irq = of_irq_get(intc, 0);
>  	if (irq <= 0) {
>  		dev_err(p->dev, "failed to get parent IRQ\n");
> +		of_node_put(intc);
>  		return irq ?: -EINVAL;
>  	}
>  
>  	p->irqdomain = irq_domain_add_linear(intc, PCI_NUM_INTX,
>  					     &faraday_pci_irqdomain_ops, p);
> +	of_node_put(intc);
>  	if (!p->irqdomain) {
>  		dev_err(p->dev, "failed to create Gemini PCI IRQ domain\n");
>  		return -EINVAL;
> -- 
> 2.1.4
> 
