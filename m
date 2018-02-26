Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752680AbeBZU4h (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 15:56:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:45832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752156AbeBZU4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 15:56:34 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6436C2168C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Mon, 26 Feb 2018 14:56:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?=
        <ckoenig.leichtzumerken@gmail.com>
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: stop crashing in pci_release_resource v2
Message-ID: <20180226205632.GB63171@bhelgaas-glaptop.roam.corp.google.com>
References: <20180221090715.2853-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180221090715.2853-1-christian.koenig@amd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 10:07:15AM +0100, Christian König wrote:
> Is it entirely possible that the BIOS wasn't able to assign resources to
> a device. In this case don't crash in pci_release_resource() when we try
> to resize the resource.
> 
> v2: keep printing the info that we try to release the BAR
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> CC: stable@vger.kernel.org

I think we probably want this in v4.16, since it seems to be a fix for
8bb705e3e79d ("PCI: Add pci_resize_resource() for resizing BARs"),
which appeared in v4.15.

What does the crash look like?  I might include a few lines in the
changelog to help people find the fix.

I added a Fixes: tag and Andy's Reviewed-by already.

> ---
>  drivers/pci/setup-res.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index e815111f3f81..c0f091614805 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -402,6 +402,10 @@ void pci_release_resource(struct pci_dev *dev, int resno)
>  	struct resource *res = dev->resource + resno;
>  
>  	dev_info(&dev->dev, "BAR %d: releasing %pR\n", resno, res);
> +
> +	if (!res->parent)
> +		return;
> +
>  	release_resource(res);
>  	res->end = resource_size(res) - 1;
>  	res->start = 0;
> -- 
> 2.14.1
> 
