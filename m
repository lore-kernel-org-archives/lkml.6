Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAACC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5413921A5E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIajLhCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5413921A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732717AbeHFXHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 19:07:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730220AbeHFXHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 19:07:07 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18D0C21770;
        Mon,  6 Aug 2018 20:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533588976;
        bh=L8me44Nio2ogO64rPqljvIxIdJbjjq7JnZBQR2HU5sA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KIajLhCgPRex0F3FEx05FjDps12hyNdN0PcV3dbuXxRrOTIWuH4+0kS7RDK4+sJEC
         2rh2D9lqwaQ7X3kyOH8Lx8MeXYCf6bovNVZZO6vo6Glggc9CQiRyduDCoqLvD1rQdW
         d8TFqA9Bo5lCmL0qfA8TGAIBV7RzmnQJNCxMxDs8=
Date:   Mon, 6 Aug 2018 15:56:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, rgummal@xilinx.com
Subject: Re: [PATCH 3/3] PCI/portdrv: Add support for sharing xilinx
 controller irq with AER
Message-ID: <20180806205614.GC30691@bhelgaas-glaptop.roam.corp.google.com>
References: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1533141889-19962-4-git-send-email-bharat.kumar.gogada@xilinx.com>
 <7d5ae8ed-5623-3cd2-7769-77702448b2d6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d5ae8ed-5623-3cd2-7769-77702448b2d6@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 11:05:09AM -0700, Sinan Kaya wrote:
> On 8/1/2018 9:44 AM, Bharat Kumar Gogada wrote:
> > Xilinx ZynqMP PS PCIe does not report AER interrupts using Advanced
> > Error Interrupt Message Number. The controller has dedicated interrupt line
> > for reporting PCIe errors along with AER.
> > 
> > Using dedicated controller irq number for AER which is shared with misc
> > interrupt handler in pcie-xilinx-nwl. This irq number is set
> > using PCI quirk.
> > 
> > Signed-off-by: Bharat Kumar Gogada<bharat.kumar.gogada@xilinx.com>
> > ---
> >   drivers/pci/pcie/portdrv_core.c |    4 ++++
> >   1 files changed, 4 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> > index e0261ad..fa9150e 100644
> > --- a/drivers/pci/pcie/portdrv_core.c
> > +++ b/drivers/pci/pcie/portdrv_core.c
> > @@ -264,6 +264,10 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
> >   	int retval;
> >   	struct pcie_device *pcie;
> >   	struct device *device;
> > +#if defined(CONFIG_ARCH_ZYNQMP) && defined(CONFIG_PCIE_XILINX_NWL)
> > +	if (service == PCIE_PORT_SERVICE_AER && pdev->sysdata)
> > +		irq = *(int *)pdev->sysdata;
> > +#endif
> 
> I remember seeing a similar patch before. 

Are you thinking of [1]?

> The patch above looks ugly to be honest. Need to find a way to
> generalize this. Can you search the mailing list archive to find out
> what the history is?

I agree, the patch above is too ugly as-is because (a) it puts very
arch-specific code in a generic code path and (b) it uses a
compile-time test, which means it probably breaks generic arm64
kernels that contain support for several platforms.

We also need to know whether this is a hardware defect or just
something that is allowed by the spec but Linux doesn't support yet.
The diagram in PCIe r4.0, sec 6.2.6, does leave room for MSI, MSI-X,
INTx, and platform-specific interrupt schemes.

[1] https://lkml.kernel.org/r/1464242406-20203-1-git-send-email-po.liu@nxp.com
