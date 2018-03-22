Return-Path: <hch@lst.de>
X-Google-Smtp-Source: AG47ELuyCuDn3yhfsr/eQHW9D2iIG5a1/TEK5pOAXDAgurVFlqprXCx22Uqlly6W2nM6+z22OV2X
ARC-Seal: i=1; a=rsa-sha256; t=1521706531; cv=none;
        d=google.com; s=arc-20160816;
        b=IoR/fQ8/+sVWBxAtSB2eRRQIN22PIbrUSBMgGq1ot1egqr8yAaf1bIURMoDs219V4J
         ye0dNTt1q8qwoVkb12K4MFpKl4rhnpenYSpuN8UOkXxEbl/Et5eD2UaKuFLwJP8z/rvt
         4DciJEEFt/zjXZNsjnvy+1xhWQs4/t9gVF6FASBGJVyGrlmb7hMOYVHLe9NnKwluYdta
         DLFzSX0UQf6hkV6reVTUUN6dKbpwRuxWxf2liIs/u+Wo5nMXS81OAe+Fn2wUsq/HIzx2
         KXjNwW6UJGz9PIOzn/dFv4yMbq7W+KFpIWyf8cWr4/MbP9apZk8DDr7z7MUxhe0Ob7bL
         S52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=RVfeGvQhs0SthuXrfBw+pT+1Q4EmHFLcF+3FKvBtWgc=;
        b=TZX3gihDiFm1BrWdxU87eTzZI47E5x7XKbzarYyhTgI3bKeFa8kUi6OG1p1zx0lKKn
         RVFhhNKcBpMGJ18ignYkxO8GRbQWQaCf8HpekCm4zs3r9eCfaSMND/QMxCptbBiHlXyN
         tk97PzZ4nI7N8NLqGyjfZ/asATvlGpTRuS/kbfjDHpDtbrrnV/vORon/1+8nbJLaZnoK
         0LRQ9CBXZPPENL6Y5SCoLQr22FHpMiVNmH1yTUjbKFhGry5rLUdO9MarvgGbJwV1xQ0Q
         t8foOsR7l9gz9qlZxHFJ0ZIIb59oTvmAiAL/mgJMht6U324DhGr3A0qYaF1/Kc/i/lk5
         4MxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Date: Thu, 22 Mar 2018 09:15:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: robin.murphy@arm.com, hch@lst.de, linux@armlinux.org.uk,
	gregkh@linuxfoundation.org, m.szyprowski@samsung.com,
	bhelgaas@google.com, zajec5@gmail.com, andy.gross@linaro.org,
	david.brown@linaro.org, dan.j.williams@intel.com,
	vinod.koul@intel.com, thierry.reding@gmail.com, robh+dt@kernel.org,
	frowand.list@gmail.com, jarkko.sakkinen@linux.intel.com,
	rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com,
	johan@kernel.org, msuchanek@suse.de, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
	dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, bharat.bhushan@nxp.com,
	leoyang.li@nxp.com
Subject: Re: [PATCH v2 1/2] dma-mapping: move dma configuration to bus
	infrastructure
Message-ID: <20180322081530.GA29444@lst.de>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com> <1521615323-4752-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521615323-4752-1-git-send-email-nipun.gupta@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1595624947896122599?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> +static int amba_dma_configure(struct device *dev)
> +{
> +	return dma_common_configure(dev);
> +}

So it turns out we only end with two callers of dma_common_configure
after this series.  Based ont hat I'm tempted with the suggestion
from Robin to just have amba call platform_dma_configure, and move
the code from dma_common_configure to platform_dma_configure.

> +int dma_configure(struct device *dev)
> +{
> +	if (dev->bus->dma_configure)
> +		return dev->bus->dma_configure(dev);
> +
> +	return 0;
> +}
>  void dma_deconfigure(struct device *dev)

As grep pointed out this wants a blank line after the function, and while
in nitpicking mode I'd suggest to remove the blank line above the return
statement while at it.

> diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
> index 88a3558..fa9896d 100644
> --- a/drivers/gpu/host1x/bus.c
> +++ b/drivers/gpu/host1x/bus.c
> @@ -314,6 +314,14 @@ static int host1x_device_match(struct device *dev, struct device_driver *drv)
>  	return strcmp(dev_name(dev), drv->name) == 0;
>  }
>  
> +static int host1x_dma_configure(struct device *dev)
> +{
> +	if (dev->of_node)
> +		return of_dma_configure(dev, dev->of_node);
> +
> +	return 0;

Same here.

> + */
> +static int pci_dma_configure(struct device *dev)
> +{
> +	struct device *bridge;
> +	enum dev_dma_attr attr;
> +	int ret = 0;
> +
> +	bridge = pci_get_host_bridge_device(to_pci_dev(dev));
> +
> +	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
> +	    bridge->parent->of_node) {
> +		ret = of_dma_configure(dev, bridge->parent->of_node);
> +	} else if (has_acpi_companion(bridge)) {
> +		attr = acpi_get_dma_attr(to_acpi_device_node(bridge->fwnode));
> +		if (attr != DEV_DMA_NOT_SUPPORTED)
> +			ret = acpi_dma_configure(dev, attr);
> +	}

The attr declaration can be moved into the inner scope here.

> +	pci_put_host_bridge_device(bridge);
> +
> +	return ret;

Drop the blank line after the return, please.
