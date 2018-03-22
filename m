Return-Path: <hch@lst.de>
X-Google-Smtp-Source: AG47ELtPgSlu/xIiAfsO0s2NJYoTcdGNurZykY7xswY4381j9v4NeIGmzBYPKHV5NLPAFXNxlLJh
ARC-Seal: i=1; a=rsa-sha256; t=1521706767; cv=none;
        d=google.com; s=arc-20160816;
        b=hfq1lAnrSfO+AOWero+4jSgTgkTqP21nf4A5iHVewZmYxyOMS5QIU7IHTXxO45c+dF
         e7SM6ouWex0vkv+vU8qT6/UE9z+Lv5xbEzbIvyHlpfU7tbksrpxff7aHllVYSpVz67jl
         Zy/Wna9uebQO8ndAXjHre8mBdw2joPJ+yKwJeFJ2XCo3FxmpMmaAtzIlMObeNXQTV1hB
         VidXjhGix5rDaMntlFKNhlSmIpGJD2nLK/wHszHOFj8hOy6p1J41xpkslWpxt1i98q/2
         C0+HxvE3jNAF6jouE5HEXBB2A8+DUlNT3Jn6xVLcdxHe9gT/uZfLZp47w2N5Zef6wAiX
         9HYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=aeDUYMgDuG2naCvDiR5Kqu80JnfR1ay51o3y0dRdd80=;
        b=0AljEQdXKRsrbiE6wmLRQTqyS+busrfmyQA16FeR/S1UcoCV1Cu26DMsUmFT7CXv0U
         TCxyjADVd2LQ2hXgk10oCl+gDVLZ16f6KI/vB1qux7pKTkAE4I7+D4NuTuR6V3iNEyBe
         iwt8SKXZKk4rVdvZBlRBXxqb9UtOz7dlQ5ePflo84chZnjTxaWD8OJewt3cJ1Pn5OiWj
         WmleviarIxsBX84D1a0MUTOrRb9jIHrPckpvQ5TUeTk7+giPueJyl0d4AzBEECDTQsK/
         wJ70xGujd1z2FxRd5f4y42RumpvLr6hpO8frDCqGxpBIJwm8qDiCSq/+D3Wk05ltJnW+
         NBxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Date: Thu, 22 Mar 2018 09:19:26 +0100
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
Subject: Re: [PATCH v2 2/2] drivers: remove force dma flag from buses
Message-ID: <20180322081926.GC29444@lst.de>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com> <1521615323-4752-1-git-send-email-nipun.gupta@nxp.com> <1521615323-4752-2-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521615323-4752-2-git-send-email-nipun.gupta@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595529373186786387?=
X-GMAIL-MSGID: =?utf-8?q?1595625194851956503?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> --- a/drivers/dma/qcom/hidma_mgmt.c
> +++ b/drivers/dma/qcom/hidma_mgmt.c
> @@ -398,7 +398,7 @@ static int __init hidma_mgmt_of_populate_channels(struct device_node *np)
>  		}
>  		of_node_get(child);
>  		new_pdev->dev.of_node = child;
> -		of_dma_configure(&new_pdev->dev, child);
> +		of_dma_configure(&new_pdev->dev, child, true);
>  		/*
>  		 * It is assumed that calling of_msi_configure is safe on
>  		 * platforms with or without MSI support.

Where did we mark this bus as force_dma before?

> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 9a4f4246..895c83e 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -353,7 +353,7 @@ int of_reserved_mem_device_init_by_idx(struct device *dev,
>  		/* ensure that dma_ops is set for virtual devices
>  		 * using reserved memory
>  		 */
> -		of_dma_configure(dev, np);
> +		of_dma_configure(dev, np, true);

Did all the callers of this one really force dma?  I have a hard time
untangling the call stacks unfortunately.
