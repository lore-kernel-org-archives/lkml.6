Return-Path: <hch@lst.de>
X-Google-Smtp-Source: AG47ELt4RVVblunyT5zhrOJLXc32RkKlzkQCrMpDKNrmLRL5R/e/GJ0yFrjZHoWqwo9U7D361eWt
ARC-Seal: i=1; a=rsa-sha256; t=1520926489; cv=none;
        d=google.com; s=arc-20160816;
        b=fkipg17PWSkflERgXXKlSMZuAGO6mTFGxJB4wi++utzXYO7oygq9PKGkesmpCbn0MG
         Z0uwITQgXkNgTjXqu/LIkY4aPpSoO/jkYBLTbxpubkgwPxdgosv8o+HPbYe3DjXJHjOw
         sWDsrPkyUv5630xHuAKfICdi11qB6IJaUUvFh9MY+2Av+qoE4IwfAbtX+dj5WAygLPRh
         PX/i0idfv04r7e+EC6A7cLyx+lX9P7f4eTJ/VB09MW1NGm2cJfmvVdQvP/ez0KLur/Ut
         1hjGUU2rJbuPKOknEAVB1A7KKkJI8p8xz+MUpGyCK/0IabYDyWa4B09DuS03w0qUva9G
         KnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=HCGwdnBFaELwnEUBO5m7hQBsMvhYTO4ysonGfWa7jZs=;
        b=u/5cHWfpSXooqOfkqsHNQns+Bf/YYnrVhELe51IvpqH8NMbLPc/3ngC3/rh6W6hWDh
         eOeF/kUAPWCYi5aU9L43v7/g2hhmO5e1i/1FkQaNacq/OSfFymZHUqArDyJOXKmXWAqm
         Y3psXDXJQ2R+GM4xF5z0AtlpcjcZx414Za5nihWZZUNc5V83MO0HqtZq32/hdzoL02Pq
         02B5SeR/TbOynbikQsTCFyZPQnhm/esOV0cRVAv7Qo20HsHrmd09y6mzU8WQiFmXKHAM
         q0nLKpbqD9EbekfOIFhNeuFQt0KGy+wCNxbpt2gves/6mlLspqysF/A7vLybPlwcEHyC
         t2uQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Date: Tue, 13 Mar 2018 08:34:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: hch@lst.de, robin.murphy@arm.com, linux@armlinux.org.uk,
	gregkh@linuxfoundation.org, m.szyprowski@samsung.com,
	bhelgaas@google.com, dmitry.torokhov@gmail.com,
	rafael.j.wysocki@intel.com, jarkko.sakkinen@linux.intel.com,
	linus.walleij@linaro.org, johan@kernel.org, msuchanek@suse.de,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: move dma configuration to bus
	infrastructure
Message-ID: <20180313073448.GA32269@lst.de>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1594807014604677532?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> +int amba_dma_configure(struct device *dev)
> +{
> +	enum dev_dma_attr attr;
> +	int ret = 0;
> +
> +	if (dev->of_node) {
> +		ret = of_dma_configure(dev, dev->of_node);
> +	} else if (has_acpi_companion(dev)) {
> +		attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
> +		if (attr != DEV_DMA_NOT_SUPPORTED)
> +			ret = acpi_dma_configure(dev, attr);
> +	}
> +
> +	return ret;

This code sniplet is duplicated so many times that I think we should
just have some sort of dma_common_configure() for it that the various
busses can use.

> +void amba_dma_deconfigure(struct device *dev)
> +{
> +	of_dma_deconfigure(dev);
> +	acpi_dma_deconfigure(dev);
> +}

As mention in my previous reply I think we don't even need a deconfigure
callback at this point - just remove the ACPI and OF wrappers and
clear the dma ops.

Also in this series we should replace the force_dma flag by use of the
proper method, e.g. give a force parameter to of_dma_configure and the
new dma_common_configure helper that the busses that want it can set.
