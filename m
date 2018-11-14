Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE39DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 06:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D84220854
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 06:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D84220854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fpond.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbeKNQfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 11:35:17 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:18670 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeKNQfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 11:35:17 -0500
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzmt2bYDnKIKaws6YXTsc4="
X-RZG-CLASS-ID: mo00
Received: from oxapp05-01.back.ox.d0m.de
        by smtp-ox.front (RZmta 44.3 AUTH)
        with ESMTPSA id 20819cuAE6ULydX
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Wed, 14 Nov 2018 07:30:21 +0100 (CET)
Date:   Wed, 14 Nov 2018 07:30:21 +0100 (CET)
From:   Ulrich Hecht <uli@fpond.eu>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <1090034354.41357.1542177021922@webmail.strato.com>
In-Reply-To: <20181113124744.7769-1-geert+renesas@glider.be>
References: <20181113124744.7769-1-geert+renesas@glider.be>
Subject: Re: [PATCH] reset: Add reset_control_get_count()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev46
X-Originating-Client: open-xchange-appsuite
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your patch.

> On November 13, 2018 at 1:47 PM Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> 
> 
> Currently the reset core has internal support for counting the number of
> resets for a device described in DT.  Generalize this to devices using
> lookup resets, and export it for public use.
> 
> This will be used by generic drivers that need to be sure a device is
> controlled by a single, dedicated reset line (e.g. vfio-platform).
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> See https://lore.kernel.org/lkml/1539003437.11512.20.camel@pengutronix.de/
> for the rationale to ensure a single, dedicated reset line.
> 
>  drivers/reset/core.c  | 41 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/reset.h |  7 +++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 654e20ff2d5da9d4..c32b755ec373c338 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -859,3 +859,44 @@ devm_reset_control_array_get(struct device *dev, bool shared, bool optional)
>  	return rstc;
>  }
>  EXPORT_SYMBOL_GPL(devm_reset_control_array_get);
> +
> +static int reset_control_get_count_from_lookup(struct device *dev)
> +{
> +	const struct reset_control_lookup *lookup;
> +	const char *dev_id = dev_name(dev);
> +	int count = 0;
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	mutex_lock(&reset_lookup_mutex);
> +
> +	list_for_each_entry(lookup, &reset_lookup_list, list) {
> +		if (!strcmp(lookup->dev_id, dev_id))
> +			count++;
> +	}
> +
> +	mutex_unlock(&reset_lookup_mutex);
> +
> +	if (count == 0)
> +		count = -ENOENT;
> +
> +	return count;
> +}
> +
> +/**
> + * of_reset_control_get_count - Count number of resets available with a device

Should be "reset_control_get_count", without of_ prefix.

> + *
> + * @dev: device for which to return the number of resets
> + *
> + * Returns positive reset count on success, or error number on failure and
> + * on count being zero.
> + */
> +int reset_control_get_count(struct device *dev)
> +{
> +	if (dev->of_node)
> +		return of_reset_control_get_count(dev->of_node);
> +
> +	return reset_control_get_count_from_lookup(dev);
> +}
> +EXPORT_SYMBOL_GPL(reset_control_get_count);
> diff --git a/include/linux/reset.h b/include/linux/reset.h
> index f0b094130686bf32..2698b36bd1eb3e0c 100644
> --- a/include/linux/reset.h
> +++ b/include/linux/reset.h
> @@ -32,6 +32,8 @@ struct reset_control *devm_reset_control_array_get(struct device *dev,
>  struct reset_control *of_reset_control_array_get(struct device_node *np,
>  						 bool shared, bool optional);
>  
> +int reset_control_get_count(struct device *dev);
> +
>  #else
>  
>  static inline int reset_control_reset(struct reset_control *rstc)
> @@ -97,6 +99,11 @@ of_reset_control_array_get(struct device_node *np, bool shared, bool optional)
>  	return optional ? NULL : ERR_PTR(-ENOTSUPP);
>  }
>  
> +static inline int reset_control_get_count(struct device *dev)
> +{
> +	return -ENOENT;
> +}
> +
>  #endif /* CONFIG_RESET_CONTROLLER */
>  
>  static inline int __must_check device_reset(struct device *dev)
> -- 
> 2.17.1
>

CU
Uli
