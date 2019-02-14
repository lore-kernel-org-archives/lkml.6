Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF85C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51481222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="qnSikWf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404468AbfBNPAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:00:02 -0500
Received: from node.akkea.ca ([192.155.83.177]:54488 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387737AbfBNPAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:00:00 -0500
Received: by node.akkea.ca (Postfix, from userid 33)
        id A9E7E4E204B; Thu, 14 Feb 2019 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1550156398; bh=keTHT7Lsij3bOYI7jZY7FKJvzq/J/zmQECHnFMt8pV4=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=qnSikWf1BTo6ASUdEURVfQUaT5Jyro1L00PwMr/TN0KjM6119iw/MzKliDFZQEXVh
         W3VQp5Drbc88ZbYzbAQeh2wFahU5wgij+PNaxNCqlx5ElkYmYYJJLmOVFXMpZqPrLs
         eL2tNR9FnhwMsuxlVT/rSIJMxj4wJn83n/EE1VN8=
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v3 2/3] regulator: add  regulator_desc_list_voltage_linear_range
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 14 Feb 2019 06:59:58 -0800
From:   Angus Ainslie <angus@akkea.ca>
Cc:     mazzisaccount@gmail.com, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, Robin Gong <yibin.gong@nxp.com>,
        Elven Wang <elven.wang@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        linux-kernel-owner@vger.kernel.org
In-Reply-To: <82443305a32c1e4b8a1ae383f5291ff544bcaf45.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
 <82443305a32c1e4b8a1ae383f5291ff544bcaf45.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <5c0051887c28c07493a535593d452f11@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-14 01:38, Matti Vaittinen wrote:
> Add regulator_desc_list_voltage_linear_range which can be used
> by drivers for getting the voltages before regulator is registered.
> This may be useful for drivers which need to fetch the voltage
> selectors at device-tree parsing callback.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Acked-by: Mark Brown <broonie@kernel.org>

Tested-by: Angus Ainslie <angus@akkea.ca>
Reviewed-by: Angus Ainslie <angus@akkea.ca>

> ---
> 
> Mark, I converted your:
> "This seems fine." from RFC patch v1 into acked-by. This should
> be unchanged. Please let me know if that's not Ok.
> 
>  drivers/regulator/helpers.c      | 39 
> +++++++++++++++++++++++++++++----------
>  include/linux/regulator/driver.h |  6 ++++++
>  2 files changed, 35 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
> index 5686a1335bd3..68ac6017ef28 100644
> --- a/drivers/regulator/helpers.c
> +++ b/drivers/regulator/helpers.c
> @@ -594,28 +594,30 @@ int
> regulator_list_voltage_pickable_linear_range(struct regulator_dev
> *rdev,
>  EXPORT_SYMBOL_GPL(regulator_list_voltage_pickable_linear_range);
> 
>  /**
> - * regulator_list_voltage_linear_range - List voltages for linear 
> ranges
> + * regulator_desc_list_voltage_linear_range - List voltages for linear 
> ranges
>   *
> - * @rdev: Regulator device
> + * @desc: Regulator desc for regulator which volatges are to be listed
>   * @selector: Selector to convert into a voltage
>   *
>   * Regulators with a series of simple linear mappings between voltages
> - * and selectors can set linear_ranges in the regulator descriptor and
> - * then use this function as their list_voltage() operation,
> + * and selectors who have set linear_ranges in the regulator 
> descriptor
> + * can use this function prior regulator registration to list 
> voltages.
> + * This is useful when voltages need to be listed during device-tree
> + * parsing.
>   */
> -int regulator_list_voltage_linear_range(struct regulator_dev *rdev,
> -					unsigned int selector)
> +int regulator_desc_list_voltage_linear_range(const struct 
> regulator_desc *desc,
> +					     unsigned int selector)
>  {
>  	const struct regulator_linear_range *range;
>  	int i;
> 
> -	if (!rdev->desc->n_linear_ranges) {
> -		BUG_ON(!rdev->desc->n_linear_ranges);
> +	if (!desc->n_linear_ranges) {
> +		BUG_ON(!desc->n_linear_ranges);
>  		return -EINVAL;
>  	}
> 
> -	for (i = 0; i < rdev->desc->n_linear_ranges; i++) {
> -		range = &rdev->desc->linear_ranges[i];
> +	for (i = 0; i < desc->n_linear_ranges; i++) {
> +		range = &desc->linear_ranges[i];
> 
>  		if (!(selector >= range->min_sel &&
>  		      selector <= range->max_sel))
> @@ -628,6 +630,23 @@ int regulator_list_voltage_linear_range(struct
> regulator_dev *rdev,
> 
>  	return -EINVAL;
>  }
> +EXPORT_SYMBOL_GPL(regulator_desc_list_voltage_linear_range);
> +
> +/**
> + * regulator_list_voltage_linear_range - List voltages for linear 
> ranges
> + *
> + * @rdev: Regulator device
> + * @selector: Selector to convert into a voltage
> + *
> + * Regulators with a series of simple linear mappings between voltages
> + * and selectors can set linear_ranges in the regulator descriptor and
> + * then use this function as their list_voltage() operation,
> + */
> +int regulator_list_voltage_linear_range(struct regulator_dev *rdev,
> +					unsigned int selector)
> +{
> +	return regulator_desc_list_voltage_linear_range(rdev->desc, 
> selector);
> +}
>  EXPORT_SYMBOL_GPL(regulator_list_voltage_linear_range);
> 
>  /**
> diff --git a/include/linux/regulator/driver.h 
> b/include/linux/regulator/driver.h
> index 7f8345bff4e1..05efe2b057c1 100644
> --- a/include/linux/regulator/driver.h
> +++ b/include/linux/regulator/driver.h
> @@ -539,4 +539,10 @@ void *regulator_get_init_drvdata(struct
> regulator_init_data *reg_init_data);
>  void regulator_lock(struct regulator_dev *rdev);
>  void regulator_unlock(struct regulator_dev *rdev);
> 
> +/*
> + * Helper functions intended to be used by regulator drivers prior 
> registering
> + * their regulators.
> + */
> +int regulator_desc_list_voltage_linear_range(const struct 
> regulator_desc *desc,
> +					     unsigned int selector);
>  #endif
> --
> 2.14.3

