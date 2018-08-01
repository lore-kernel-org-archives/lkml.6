Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3272C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AC5208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMmkTvv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AC5208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732668AbeHATwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:52:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729616AbeHATwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:52:04 -0400
Received: from [10.82.12.2] (unknown [131.107.159.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5B222083D;
        Wed,  1 Aug 2018 18:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533146709;
        bh=74v+EfS6PzK8Jdd/UwS08bJu9i2C5azdxT3XO9pFltg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eMmkTvv6SUgh69oQ5wFmPzH2HURTwF95wzi2YG+2PQxdbhLwyflzyBXXEvyT6tBPk
         tsiD3r9FTCjmN9hxLICFGYa4CjKe5zfTTs2X06C4phdKJi/lCJ9X7u47B8/1P72OHd
         zgnfRKqzUSCyB1RdYkWseS+1XSBH2vy3wkweGwxo=
Subject: Re: [PATCH 3/3] PCI/portdrv: Add support for sharing xilinx
 controller irq with AER
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhelgaas@google.com, rgummal@xilinx.com
References: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1533141889-19962-4-git-send-email-bharat.kumar.gogada@xilinx.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <7d5ae8ed-5623-3cd2-7769-77702448b2d6@kernel.org>
Date:   Wed, 1 Aug 2018 11:05:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533141889-19962-4-git-send-email-bharat.kumar.gogada@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/2018 9:44 AM, Bharat Kumar Gogada wrote:
> Xilinx ZynqMP PS PCIe does not report AER interrupts using Advanced
> Error Interrupt Message Number. The controller has dedicated interrupt line
> for reporting PCIe errors along with AER.
> 
> Using dedicated controller irq number for AER which is shared with misc
> interrupt handler in pcie-xilinx-nwl. This irq number is set
> using PCI quirk.
> 
> Signed-off-by: Bharat Kumar Gogada<bharat.kumar.gogada@xilinx.com>
> ---
>   drivers/pci/pcie/portdrv_core.c |    4 ++++
>   1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index e0261ad..fa9150e 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -264,6 +264,10 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
>   	int retval;
>   	struct pcie_device *pcie;
>   	struct device *device;
> +#if defined(CONFIG_ARCH_ZYNQMP) && defined(CONFIG_PCIE_XILINX_NWL)
> +	if (service == PCIE_PORT_SERVICE_AER && pdev->sysdata)
> +		irq = *(int *)pdev->sysdata;
> +#endif
>   

I remember seeing a similar patch before. The patch above looks ugly to
be honest. Need to find a way to generalize this. Can you search the
mailing list archive to find out what the history is?

