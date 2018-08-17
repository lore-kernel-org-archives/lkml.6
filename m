Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B10AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E6321A2E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRGLkTBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E6321A2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeHQT3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:29:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbeHQT3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:29:35 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB26C2154F;
        Fri, 17 Aug 2018 16:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534523136;
        bh=v5Q2t5q4kuaLq+L+hzYlFVxuM8+8vALnwBcrMfBdF9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sRGLkTBfXyxKYbYICD3IpIiUFu7kVTCzkezBhaYb0aQ2VLwFh0HTXPTVC6oTg6080
         p+B4mSFeQVY1ds86lIGBw/so/tJUQQ1oAkxvpBWxl45InQa9QggOcoY83Yt1/a081c
         txkEIkLIDHHCn33RG1NzcimfpJIvNrGF6Nyqnro4=
Date:   Fri, 17 Aug 2018 11:25:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-pci@vger.kernel.org, Hari Vyas <hari.vyas@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>, Lukas Wunner <lukas@wunner.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/6] pci: Set pci_dev->is_added before calling
 device_add
Message-ID: <20180817162534.GD128050@bhelgaas-glaptop.roam.corp.google.com>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
 <20180817044902.31420-3-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817044902.31420-3-benh@kernel.crashing.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 02:48:58PM +1000, Benjamin Herrenschmidt wrote:
> This re-fixes the bug reported by Hari Vyas <hari.vyas@broadcom.com>
> after my revert of his commit but in a much simpler way.
> 
> The main issues is that is_added was being set after the driver
> got bound and started, and thus setting it could race with other
> changes to struct pci_dev.

The "bind driver, then set dev->added = 1" order seems to have been
there since the beginning of dev->is_added:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=8a1bc9013a03

This patch seems reasonable, but I'm a little dubious about the
existence of "is_added" in the first place.  As far as I can tell, the
only other buses with something similar are the MEN Chameleon bus and
the Intel Management Engine Interface.

The PCI uses of "is_added" don't seem *that* critical or unique to
PCI, so I'm not 100% convinced we need it at all.  But I haven't
looked into it enough to be able to propose an alternative.

> This fixes it by setting the flag first, which also has the
> advantage of matching the fact that we are clearing it *after*
> unbinding in the remove path, thus the flag is now symtetric
> and always set while the driver code is running.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  drivers/pci/bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 35b7fc87eac5..48ae63673aa8 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -321,16 +321,16 @@ void pci_bus_add_device(struct pci_dev *dev)
>  	pci_proc_attach_device(dev);
>  	pci_bridge_d3_update(dev);
>  
> +	dev->is_added = 1;
>  	dev->match_driver = true;
>  	retval = device_attach(&dev->dev);
>  	if (retval < 0 && retval != -EPROBE_DEFER) {
> +		dev->is_added = 0;
>  		pci_warn(dev, "device attach failed (%d)\n", retval);
>  		pci_proc_detach_device(dev);
>  		pci_remove_sysfs_dev_files(dev);
>  		return;
>  	}
> -
> -	dev->is_added = 1;
>  }
>  EXPORT_SYMBOL_GPL(pci_bus_add_device);
>  
> -- 
> 2.17.1
> 
