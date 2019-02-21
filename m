Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06309C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D5D214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550738041;
	bh=LZmkfaZUb4yeiZ8AKXuXgClzv8dR6p3n1MDXWMajbws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rwHIqEX50ehLgEJuKrn9BOMfN1epxzFO7Y/hRv+sTAO2BLFmncsmeFsIETh77KduZ
	 ndbtJ64bJ9pP5pLyWkE9Yzy172iCIFn2XEFXjTzFbnfVoR6vS0jsdeORybiwVa5Vj6
	 Yy6feD1lpxNOmBmiZ3VfcjBuE5JO9ceUPTRV2q60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfBUIeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:34:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbfBUId7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:33:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CEB920842;
        Thu, 21 Feb 2019 08:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550738039;
        bh=LZmkfaZUb4yeiZ8AKXuXgClzv8dR6p3n1MDXWMajbws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BBvMWR0J+fKcniyk95GjFqngdVHq/+aPgNq7+1Nako5HYZlhNH89OD4J8Gm8yfAJD
         UVr9PEPcxWEYjElGvKdNebGwZmxvRpTrKQ4bSEcuiUsxbT7+S/lTB/XoXfbKqS5eP/
         isB0+phWQm94+HbdlV0SupVs8fQ1sS9s7oeQkhAE=
Date:   Thu, 21 Feb 2019 09:33:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matt Hsiao <matt.hsiao@hpe.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        david.altobelli@hpe.com, mark.rusk@hpe.com, jerry.hoemann@hpe.com
Subject: Re: [PATCH 2/4] misc: hpilo: Exclude unsupported device via blacklist
Message-ID: <20190221083355.GB6397@kroah.com>
References: <1550736282-25416-1-git-send-email-matt.hsiao@hpe.com>
 <1550736282-25416-3-git-send-email-matt.hsiao@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550736282-25416-3-git-send-email-matt.hsiao@hpe.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 04:04:40PM +0800, Matt Hsiao wrote:
> Instead of having explicit if statments excluding devices,
> use a pci_device_id table of devices to blacklist.
> 
> Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
> ---
>  drivers/misc/hpilo.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
> index 01c407a..0224e50 100644
> --- a/drivers/misc/hpilo.c
> +++ b/drivers/misc/hpilo.c
> @@ -29,6 +29,11 @@
>  static unsigned int ilo_major;
>  static unsigned int max_ccb = 16;
>  static char ilo_hwdev[MAX_ILO_DEV];
> +static const struct pci_device_id ilo_blacklist[] = {
> +	/* auxiliary iLO */
> +	{PCI_DEVICE_SUB(PCI_VENDOR_ID_HP, 0x3307, PCI_VENDOR_ID_HP, 0x1979)},
> +	{}
> +};
>  
>  static inline int get_entry_id(int entry)
>  {
> @@ -763,10 +768,10 @@ static int ilo_probe(struct pci_dev *pdev,
>  	int devnum, minor, start, error = 0;
>  	struct ilo_hwinfo *ilo_hw;
>  
> -	/* Ignore auxiliary iLO device */
> -	if (pdev->subsystem_vendor == PCI_VENDOR_ID_HP &&
> -	    pdev->subsystem_device == 0x1979)
> -		return 0;
> +	if (pci_match_id(ilo_blacklist, pdev)) {
> +		dev_dbg(&pdev->dev, "Not supported on this device\n");
> +		return -ENODEV;
> +	}

Why not just merge this into the previous patch?

And why do some devices need to be blacklisted, shouldn't there only be
a whitelist in the first place?  Do you need to tighten up your original
device ids?

thanks,

greg k-h
