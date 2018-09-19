Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02159C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60592098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60592098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbeISQHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:07:07 -0400
Received: from foss.arm.com ([217.140.101.70]:57336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbeISQHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:07:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACB8F7A9;
        Wed, 19 Sep 2018 03:29:51 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.Emea.Arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5849E3F703;
        Wed, 19 Sep 2018 03:29:50 -0700 (PDT)
Date:   Wed, 19 Sep 2018 11:29:44 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] PCI: kirin: Fix section mismatch warning
Message-ID: <20180919102944.GA15014@e107981-ln.cambridge.arm.com>
References: <20180919053829.4858-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919053829.4858-1-natechancellor@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiaowei, Binghui,

On Tue, Sep 18, 2018 at 10:38:29PM -0700, Nathan Chancellor wrote:
> WARNING: vmlinux.o(.text+0x4758cc): Section mismatch in reference from
> the function kirin_pcie_probe() to the function
> .init.text:kirin_add_pcie_port()
> The function kirin_pcie_probe() references
> the function __init kirin_add_pcie_port().
> This is often because kirin_pcie_probe lacks a __init
> annotation or the annotation of kirin_add_pcie_port is wrong.
> 
> Remove '__init' from kirin_add_pcie_port so there is no mismatch.

I think that instead of removing __init section tag we should add
it to kirin_pcie_probe().

Please let me know and ACK accordingly.

Lorenzo

> Fixes: fc5165db245a ("PCI: kirin: Add HiSilicon Kirin SoC PCIe controller driver")
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-kirin.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index 5352e0c3be82..9b599296205d 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -467,8 +467,8 @@ static int kirin_pcie_add_msi(struct dw_pcie *pci,
>  	return 0;
>  }
>  
> -static int __init kirin_add_pcie_port(struct dw_pcie *pci,
> -				      struct platform_device *pdev)
> +static int kirin_add_pcie_port(struct dw_pcie *pci,
> +			       struct platform_device *pdev)
>  {
>  	int ret;
>  
> -- 
> 2.19.0
> 
