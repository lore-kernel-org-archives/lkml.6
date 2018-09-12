Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E59C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7152087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZWzpNCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7152087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeILWid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:38:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbeILWic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:38:32 -0400
Received: from localhost (unknown [146.7.4.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C269A20854;
        Wed, 12 Sep 2018 17:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536773580;
        bh=tg/nK/g30ZEUbWLtL9sqr1WtNkynBI11+flTm2QUTqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZZWzpNCpNlr46tBqPYfC2tvMTlmwavM573kWbPGp/R6FY16Wd1y3knNh4GxFrqflI
         f1LZlJhsceVDxaKhesJGFLiclIuNAigmk2cG3LLvzSfpXqyDMr5gQzgUgDOu4uj0lz
         42P9R2ydDAV6VXh93kTP/CXnrMhNDluErTRY9Dho=
Date:   Wed, 12 Sep 2018 12:32:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, linuxarm@huawei.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] pci: Pick up the acpi numa node value if it is
 specified at the device level.
Message-ID: <20180912173258.GJ118330@bhelgaas-glaptop.roam.corp.google.com>
References: <20180912152140.3676-1-Jonathan.Cameron@huawei.com>
 <20180912152140.3676-2-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912152140.3676-2-Jonathan.Cameron@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc ACPI folks, LKML]

On Wed, Sep 12, 2018 at 04:21:40PM +0100, Jonathan Cameron wrote:
> The ACPI specification allows you to provide _PXM entries for devices based
> on their location on a particular bus.  Let us use that if it is provided
> rather than just assuming it makes sense to put the device into the proximity
> domain of the root.
> 
> An example DSDT entry that will supply this is:
> 
>   Device (PCI2)
>   {
>     Name (_HID, "PNP0A08") // PCI Express Root Bridge
>     Name (_CID, "PNP0A03") // Compatible PCI Root Bridge
>     Name(_SEG, 2) // Segment of this Root complex
>     Name(_BBN, 0xF8) // Base Bus Number
>     Name(_CCA, 1)
>     Method (_PXM, 0, NotSerialized) {
>       Return(0x00)
>     }
> 
> ...
>     Device (BRI0) {
>       Name (_HID, "19E51610")
>       Name (_ADR, 0)
>       Name (_BBN, 0xF9)
>       Device (CAR0) {
>         Name (_HID, "97109912")
>         Name (_ADR, 0)
>         Method (_PXM, 0, NotSerialized) {
>           Return(0x02)
>         }
>       }
>     }
>   }
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Applied with subject:

  ACPI/PCI: Pay attention to device-specific _PXM node values

to pci/enumeration for v4.20, thanks!

> ---
>  drivers/pci/pci-acpi.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 738e3546abb1..f2f5f0ddd60e 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -753,10 +753,15 @@ static void pci_acpi_setup(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	int node;
>  
>  	if (!adev)
>  		return;
>  
> +	node = acpi_get_node(adev->handle);
> +	if (node != NUMA_NO_NODE)
> +		set_dev_node(dev, node);
> +	
>  	pci_acpi_optimize_delay(pci_dev, adev->handle);
>  
>  	pci_acpi_add_pm_notifier(adev, pci_dev);
> -- 
> 2.18.0
> 
> 
