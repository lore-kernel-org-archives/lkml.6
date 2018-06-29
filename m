Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EED4C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B981E27D2C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B981E27D2C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754680AbeF2Nkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 09:40:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34480 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752934AbeF2Nka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 09:40:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9750980D;
        Fri, 29 Jun 2018 06:40:30 -0700 (PDT)
Received: from red-moon (unknown [10.1.206.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6709E3F5C0;
        Fri, 29 Jun 2018 06:40:29 -0700 (PDT)
Date:   Fri, 29 Jun 2018 14:42:17 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: xilinx: add missing of_node_put()
Message-ID: <20180629134217.GD9643@red-moon>
References: <1528910444-25593-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528910444-25593-1-git-send-email-hofrat@osadl.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 07:20:44PM +0200, Nicholas Mc Guire wrote:
>  The call to of_get_next_child() returns a node pointer with refcount
> incremented thus it must be explicitly decremented here after the last
> usage.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: commit 8961def56845 ("PCI: xilinx: Add Xilinx AXI PCIe Host Bridge IP driver")
> ---
> 
> Problem found by an experimental cocinelle script
> 
> Patch was compile tested with: multi_v7_defconfig + ARCH_ZYNQ=y,
> COMPILE_TEST=y, PCIE_XILINX=y
> (with one sparse warning though not related to the change proposed)
> 
> Patch is against 4.17.0 (localversion-next is next-20180613)
> 
>  drivers/pci/controller/pcie-xilinx.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to pci/controller-fixes to be tentatively merged for
-rc4, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
> index b110a3a..7b1389d 100644
> --- a/drivers/pci/controller/pcie-xilinx.c
> +++ b/drivers/pci/controller/pcie-xilinx.c
> @@ -509,6 +509,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
>  	port->leg_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
>  						 &intx_domain_ops,
>  						 port);
> +	of_node_put(pcie_intc_node);
>  	if (!port->leg_domain) {
>  		dev_err(dev, "Failed to get a INTx IRQ domain\n");
>  		return -ENODEV;
> -- 
> 2.1.4
> 
