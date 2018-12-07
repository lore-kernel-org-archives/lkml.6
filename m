Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449E8C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E994220892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Im3jq4HD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E994220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbeLGUo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:44:56 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46326 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGUoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:44:55 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so2192812pgp.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 12:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0awEbaTTVfdjBXjKjzM8xYoCMSL025eTLYSG25fBPFc=;
        b=Im3jq4HDG0DE4Avxb9rowZcQgJg3GH7MLOdx0f8WuqfE9IRFOlmbCOM5vPCQbnBcFC
         PI1+ycsZ+/8yRZoXp/6dwt2MzASo+hpw5p9Ll/hy2MjO2jU788WSRF6X7f2Dq7V9i0wy
         Tnt1i20nKVQJI7XIZpm+jETf3KIKLvONQwrWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0awEbaTTVfdjBXjKjzM8xYoCMSL025eTLYSG25fBPFc=;
        b=TMYx2TstrBAsDlSoXMkbJVI1fHZBcMDjxANy/TuO8ninp6CpNwmKUwrIQSbphW0ErB
         ErUIjRy+yzMAAHfCNZ0rTSOHQho6sDDqboC4qYvpHO2pFT35aHsjLygpMr596DZatNBH
         pR/Kx+IgEB3K5JufghRUhS4JpeP1SeJ7hQDpr5uotkFyiyEu2chSUciObWnnVfp3UDYQ
         fF7PnnwYNc6wjt8kEc1U4BEaKlgDdq6gNOG+q3fVzmOIENSAiaVm9h5LYEAHr36kPPm/
         ka3LFAnGJcKZQx7Gp6zSp62MOGN9MJGIGAu58siFEun3uZgluTvgnEQo/sApEPvc388N
         6bEQ==
X-Gm-Message-State: AA+aEWaW43WXzWIyIO+PHwEDnE6EsBVkFr+HJHS5VVQQaF2Ul7YORhy4
        ifqe+5v/aof4ttZr2GF4ZuL5Enevsaw=
X-Google-Smtp-Source: AFSGD/UsQfEtyNRkDh2Xi/hDIlosqLEv6HM5XXi2SV4L4bYaXSzub1GIPgX0l8ga2Mk41pSBTT4rXA==
X-Received: by 2002:a63:c64f:: with SMTP id x15mr3163030pgg.16.1544215494628;
        Fri, 07 Dec 2018 12:44:54 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id g185sm5926163pfc.174.2018.12.07.12.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 12:44:53 -0800 (PST)
Date:   Fri, 7 Dec 2018 13:44:52 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux@armlinux.org.uk, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com
Subject: Re: [PATCH v3 1/2] drivers: amba: Updates to component
 identification for driver matching.
Message-ID: <20181207204452.GA10788@xps15>
References: <20181206000226.2507-1-mike.leach@linaro.org>
 <20181206000226.2507-2-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206000226.2507-2-mike.leach@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day Mike,

On Thu, Dec 06, 2018 at 12:02:25AM +0000, Mike Leach wrote:
> The CoreSight specification (ARM IHI 0029E), updates the ID register
> requirements for components on an AMBA bus, to cover both traditional
> ARM Primecell type devices, and newer CoreSight and other components.
> 
> The Peripheral ID (PID) / Component ID (CID) pair is extended in certain
> cases to uniquely identify components. CoreSight components related to
> a single function can share Peripheral ID values, and must be further
> identified using a Unique Component Identifier (UCI). e.g. the ETM, CTI,
> PMU and Debug hardware of the A35 all share the same PID.
> 
> Bits 15:12 of the CID are defined to be the device class.
> Class 0xF remains for PrimeCell and legacy components.
> Class 0x9 defines the component as CoreSight (CORESIGHT_CID above)
> Class 0x0, 0x1, 0xB, 0xE define components that do not have driver support
> at present.
> Class 0x2-0x8,0xA and 0xD-0xD are presently reserved.
> 
> The specification futher defines which classes of device use the standard
> CID/PID pair, and when additional ID registers are required.
> 
> The patches provide an update of amba_device and matching code to handle
> the additional registers required for the Class 0x9 (CoreSight) UCI.
> The *data pointer in the amba_id is used by the driver to provide extended
> ID register values for matching.
> 
> CoreSight components where PID/CID pair is currently sufficient for
> unique identification need not provide this additional information.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>

I am good with this patch but can't take it until Russell gives me the thumbs
up.  He may also decide to take it in his tree, in which case:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Russell, let me know that is the easiest for you.

Thanks,
Mathieu

> ---
>  drivers/amba/bus.c       | 45 +++++++++++++++++++++++++++++++++-------
>  include/linux/amba/bus.h | 32 ++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 41b706403ef7..524296a0eba0 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -26,19 +26,36 @@
>  
>  #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
>  
> -static const struct amba_id *
> -amba_lookup(const struct amba_id *table, struct amba_device *dev)
> +/* called on periphid match and class 0x9 coresight device. */
> +static int
> +amba_cs_uci_id_match(const struct amba_id *table, struct amba_device *dev)
>  {
>  	int ret = 0;
> +	struct amba_cs_uci_id *uci;
> +
> +	uci = table->data;
>  
> +	/* no table data - return match on periphid */
> +	if (!uci)
> +		return 1;
> +
> +	/* test against read devtype and masked devarch value */
> +	ret = (dev->uci.devtype == uci->devtype) &&
> +		((dev->uci.devarch & uci->devarch_mask) == uci->devarch);
> +	return ret;
> +}
> +
> +static const struct amba_id *
> +amba_lookup(const struct amba_id *table, struct amba_device *dev)
> +{
>  	while (table->mask) {
> -		ret = (dev->periphid & table->mask) == table->id;
> -		if (ret)
> -			break;
> +		if (((dev->periphid & table->mask) == table->id) &&
> +			((dev->cid != CORESIGHT_CID) ||
> +			 (amba_cs_uci_id_match(table, dev))))
> +			return table;
>  		table++;
>  	}
> -
> -	return ret ? table : NULL;
> +	return NULL;
>  }
>  
>  static int amba_match(struct device *dev, struct device_driver *drv)
> @@ -399,10 +416,22 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
>  			cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) <<
>  				(i * 8);
>  
> +		if (cid == CORESIGHT_CID) {
> +			/* set the base to the start of the last 4k block */
> +			void __iomem *csbase = tmp + size - 4096;
> +
> +			dev->uci.devarch =
> +				readl(csbase + UCI_REG_DEVARCH_OFFSET);
> +			dev->uci.devtype =
> +				readl(csbase + UCI_REG_DEVTYPE_OFFSET) & 0xff;
> +		}
> +
>  		amba_put_disable_pclk(dev);
>  
> -		if (cid == AMBA_CID || cid == CORESIGHT_CID)
> +		if (cid == AMBA_CID || cid == CORESIGHT_CID) {
>  			dev->periphid = pid;
> +			dev->cid = cid;
> +		}
>  
>  		if (!dev->periphid)
>  			ret = -ENODEV;
> diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
> index d143c13bed26..8c0f392e4da2 100644
> --- a/include/linux/amba/bus.h
> +++ b/include/linux/amba/bus.h
> @@ -25,6 +25,36 @@
>  #define AMBA_CID	0xb105f00d
>  #define CORESIGHT_CID	0xb105900d
>  
> +/*
> + * CoreSight Architecture specification updates the ID specification
> + * for components on the AMBA bus. (ARM IHI 0029E)
> + *
> + * Bits 15:12 of the CID are the device class.
> + *
> + * Class 0xF remains for PrimeCell and legacy components. (AMBA_CID above)
> + * Class 0x9 defines the component as CoreSight (CORESIGHT_CID above)
> + * Class 0x0, 0x1, 0xB, 0xE define components that do not have driver support
> + * at present.
> + * Class 0x2-0x8,0xA and 0xD-0xD are presently reserved.
> + *
> + * Remaining CID bits stay as 0xb105-00d
> + */
> +
> +/*
> + * Class 0x9 components use additional values to form a Unique Component
> + * Identifier (UCI), where peripheral ID values are identical for different
> + * components. Passed to the amba bus code from the component driver via
> + * the amba_id->data pointer.
> + */
> +struct amba_cs_uci_id {
> +	unsigned int devarch;
> +	unsigned int devarch_mask;
> +	unsigned int devtype;
> +};
> +
> +#define UCI_REG_DEVTYPE_OFFSET	0xFCC
> +#define UCI_REG_DEVARCH_OFFSET	0xFBC
> +
>  struct clk;
>  
>  struct amba_device {
> @@ -32,6 +62,8 @@ struct amba_device {
>  	struct resource		res;
>  	struct clk		*pclk;
>  	unsigned int		periphid;
> +	unsigned int		cid;
> +	struct amba_cs_uci_id	uci;
>  	unsigned int		irq[AMBA_NR_IRQS];
>  	char			*driver_override;
>  };
> -- 
> 2.19.1
> 
