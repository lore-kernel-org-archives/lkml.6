Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FD2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0AE20645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="couwHrlL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0AE20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbeJLSCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:02:22 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7941 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbeJLSCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:02:22 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc077c20000>; Fri, 12 Oct 2018 03:30:26 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 12 Oct 2018 03:30:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 12 Oct 2018 03:30:37 -0700
Received: from [10.21.132.143] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 12 Oct
 2018 10:30:36 +0000
Subject: Re: [PATCH] gpio/regulator: Allow nonexclusive GPIO access
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20181011143531.7195-1-linus.walleij@linaro.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <0a8efd69-48da-5031-6488-c0d9fdc07a03@nvidia.com>
Date:   Fri, 12 Oct 2018 11:30:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011143531.7195-1-linus.walleij@linaro.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539340226; bh=XRCmLea9oZvqpmY6pAR4dEOL3q7EAllOgVZeNdbJHcM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=couwHrlLHR8PCQVlnmTOvBgQOiUZnfENDkFxcr1astME/Px9LxjZqob/k165Gaykt
         A4BUIUfaBeoknMT6rEjvpeEeHG4dcYdZNGRPO6TTqZomjjrK1mSBBSUsR3xYys/AUd
         GCNc7CwaDwLcSD38Y84eWjnSQvP8j2KV1ByfjVap0rQwu6Z6arwoZW7QuSWG8aHT3f
         liXeMRRtedznQCIWe9qpjeE4jj+wUaxmYhPtG+dlPyrZ0HWXr+/vnC1Aidb0Y5H1+8
         yDSR6dC7scfGE/6eUePsL16cI6NFA/qS3jMPkQzhB8QB0ZGgc08i7KNVgtlHHVWhms
         jFG8KHkCR2Fvg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 11/10/18 15:35, Linus Walleij wrote:
> This allows nonexclusive (simultaneous) access to a single
> GPIO line for the fixed regulator enable line. This happens
> when several regulators use the same GPIO for enabling and
> disabling a regulator, and all need a handle on their GPIO
> descriptor.
> 
> This solution with a special flag is not entirely elegant
> and should ideally be replaced by something more careful as
> this makes it possible for several consumers to
> enable/disable the same GPIO line to the left and right
> without any consistency. The current use inside the regulator
> core should however be fine as it takes special care to
> handle this.
> 
> For the state of the GPIO backend, this is still the
> lesser evil compared to going back to global GPIO
> numbers.
> 
> Fixes: efdfeb079cc3 ("regulator: fixed: Convert to use GPIO descriptor only")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

This also fixes a regression I was seeing on Tegra124 Jetson TK1. So ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

> ---
> Hi Marek, it would be great if you could try this on top
> of linux-next and report if it solves your problem on the
> Samsung Exynos.
> 
> If it does I hope it will apply cleanly on the regulator
> tree.
> ---
>  drivers/gpio/gpiolib.c        | 19 +++++++++++++++++--
>  drivers/regulator/fixed.c     | 13 +++++++++++++
>  include/linux/gpio/consumer.h |  1 +
>  3 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 7c222df8f834..f82a741ff428 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -4144,8 +4144,23 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
>  	 * the device name as label
>  	 */
>  	status = gpiod_request(desc, con_id ? con_id : devname);
> -	if (status < 0)
> -		return ERR_PTR(status);
> +	if (status < 0) {
> +		if (status == -EBUSY && flags & GPIOD_FLAGS_BIT_NONEXCLUSIVE) {
> +			/*
> +			 * This happens when there are several consumers for
> +			 * the same GPIO line: we just return here without
> +			 * further initialization. It is a bit if a hack.
> +			 * This is necessary to support fixed regulators.
> +			 *
> +			 * FIXME: Make this more sane and safe.
> +			 */
> +			dev_info(dev, "nonexclusive access to GPIO for %s\n",
> +				 con_id);

Nit-pick, for me the 'con_id' is NULL so should we use the same ternary
operator here as above to print devname instead in this case?

Cheers!
Jon

-- 
nvpublic
