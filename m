Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB0EC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421A527F59
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421A527F59
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935805AbeF2Nlb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 09:41:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34520 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933017AbeF2Nla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 09:41:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E38480D;
        Fri, 29 Jun 2018 06:41:30 -0700 (PDT)
Received: from red-moon (unknown [10.1.206.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DE873F5C0;
        Fri, 29 Jun 2018 06:41:29 -0700 (PDT)
Date:   Fri, 29 Jun 2018 14:43:17 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: xilinx-nwl: add missing of_node_put()
Message-ID: <20180629134317.GE9643@red-moon>
References: <1528967074-30024-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528967074-30024-1-git-send-email-hofrat@osadl.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 11:04:34AM +0200, Nicholas Mc Guire wrote:
>  The call to of_get_next_child() returns a node pointer with
> refcount incremented thus it must be explicitly decremented
> here after the last usage.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: commit ab597d35ef11 ("PCI: xilinx-nwl: Add support for Xilinx NWL PCIe Host Controller")
> ---
> 
> Problem found by an experimental cocinelle script
> 
> Patch was compile tested with: multi_v7_defconfig + ARCH_ZYNQ=y,
> COMPILE_TEST=y, PCIE_XILINX_NWL=y
> (one sparse warning though not related to the change proposed though)
> 
> Patch is against 4.17.0 (localversion-next is next-20180613)
> 
>  drivers/pci/controller/pcie-xilinx-nwl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/controller-fixes to be tentatively merged for
-rc4, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index 6a4bbb5..fb32840 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -559,7 +559,7 @@ static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
>  							PCI_NUM_INTX,
>  							&legacy_domain_ops,
>  							pcie);
> -
> +	of_node_put(legacy_intc_node);
>  	if (!pcie->legacy_irq_domain) {
>  		dev_err(dev, "failed to create IRQ domain\n");
>  		return -ENOMEM;
> -- 
> 2.1.4
> 
