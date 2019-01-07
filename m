Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B47C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58C62147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VukaHJef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfAGTf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:35:58 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35858 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfAGTf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:35:57 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so661947pfc.3;
        Mon, 07 Jan 2019 11:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=edW9kvO7o8V+7WPFgx+paf1/9qQIOc7hSoeqZYm+4aY=;
        b=VukaHJef07iEZi5Zm+xxFQxb08PIp/9GvmqkhYy6216GCvgvTD51h9e9XyrzUDummd
         QqYlYRjiXcG3Sn46zEVVxa8gdhH9WuEx0Tdlw0keHaxvBdNDZoIZt6JWiFGFzb8pnd6t
         DvK2ZUMoUu3gnsga88sne7Bi8f0d0K424mf8jnBMYWxI623mtekWs3gUNwhVLw8LNupf
         5CtsxCGpcxWlAgVzXHPqGLAxY8x+JlLuTBb2pQeMSlvzSAuuGrktWVng4Ohjzzyw4IXm
         cuyhp9VbkNPxai+BFuubZQZn5q8GVKN03uQk4NhAmxmOyeNZDIJUSaOmXfOsd6deTlNZ
         XuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=edW9kvO7o8V+7WPFgx+paf1/9qQIOc7hSoeqZYm+4aY=;
        b=gujUAhgFd624lTC832yA58fWxDKq52FGqd7lRKc5iQh1ujdYcYPFtCxkAinmfusRbz
         Zz0jo383NdNCyDzJnm08Ywxf7xqZtgE2v8nJXn5N0In5g3P4LtDJLjQdcPMTcLsBc22j
         Qx335dpTt2uLpEWOoN5mqRWfC79Oku/N4FJw2zkQgsTpXCyFkuNtyeelUXW9Zc6c8pXA
         SbGhqMXj8CRV+ytHsae/qyPiaw93V1HsyDlr5B6QwlfPQVq0+NSBvKIIVeiJkywAG60U
         M50MI+NKW6FOiZw+zEsNTxJwKjqpb6TE91GwfbgMZYaxo5yQ2HCdpBM/1YV12ao6BJuY
         B1BA==
X-Gm-Message-State: AJcUukcDawtBgGIkgN5l2YkSOOpQu3CbrfT5sqi+mWLstDr+hevKy9jb
        g845eaWQ9mDSLLjJH+luP7k=
X-Google-Smtp-Source: ALg8bN67a/Eu19E0QBa5Nkq1aaq3Q/2GYvcHskeAS5bzj3VAf8GF1r2ZEVHQBmw0x+q0LatE1zfRPg==
X-Received: by 2002:a65:60c2:: with SMTP id r2mr12159706pgv.393.1546889756881;
        Mon, 07 Jan 2019 11:35:56 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 78sm121456194pft.184.2019.01.07.11.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 11:35:56 -0800 (PST)
Date:   Mon, 7 Jan 2019 11:35:55 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (ina3221) Implement ti,single-shot DT
 property
Message-ID: <20190107193555.GA13547@roeck-us.net>
References: <20190105030636.533-1-nicoleotsuka@gmail.com>
 <20190105030636.533-3-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190105030636.533-3-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 07:06:36PM -0800, Nicolin Chen wrote:
> By default, ina3221, as a hardware monitor, continuously measures
> the inputs and generates corresponding data. However, for battery
> powered devices, this mode might be power consuming.
> 
> The DT binding doc is updated with a new boolean type property to
> allow changing the default operating mode from consuming mode to
> single-shot mode, which will measure input on demand and then shut
> down to save power.
> 
> So this patch implements the DT property accordingly.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> Changelog
> v1->v2:
>  * Replaced the useless mode defines with a boolean variable.
> 
>  drivers/hwmon/ina3221.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index e90ccac8bebb..4258a6ebe195 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -111,6 +111,7 @@ struct ina3221_input {
>   * @inputs: Array of channel input source specific structures
>   * @lock: mutex lock to serialize sysfs attribute accesses
>   * @reg_config: Register value of INA3221_CONFIG
> + * @single_shot: running in single-shot operating mode
>   */
>  struct ina3221_data {
>  	struct device *pm_dev;
> @@ -119,6 +120,8 @@ struct ina3221_data {
>  	struct ina3221_input inputs[INA3221_NUM_CHANNELS];
>  	struct mutex lock;
>  	u32 reg_config;
> +
> +	bool single_shot;
>  };
>  
>  static inline bool ina3221_is_enabled(struct ina3221_data *ina, int channel)
> @@ -188,6 +191,11 @@ static int ina3221_read_in(struct device *dev, u32 attr, int channel, long *val)
>  		if (!ina3221_is_enabled(ina, channel))
>  			return -ENODATA;
>  
> +		/* Write CONFIG register to trigger a single-shot measurement */
> +		if (ina->single_shot)
> +			regmap_write(ina->regmap, INA3221_CONFIG,
> +				     ina->reg_config);
> +
>  		ret = ina3221_wait_for_data(ina);
>  		if (ret)
>  			return ret;
> @@ -232,6 +240,11 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
>  		if (!ina3221_is_enabled(ina, channel))
>  			return -ENODATA;
>  
> +		/* Write CONFIG register to trigger a single-shot measurement */
> +		if (ina->single_shot)
> +			regmap_write(ina->regmap, INA3221_CONFIG,
> +				     ina->reg_config);
> +
>  		ret = ina3221_wait_for_data(ina);
>  		if (ret)
>  			return ret;
> @@ -617,6 +630,9 @@ static int ina3221_probe_from_dt(struct device *dev, struct ina3221_data *ina)
>  	if (!np)
>  		return 0;
>  
> +	if (of_property_read_bool(np, "ti,single-shot"))
> +		ina->single_shot = true;
> +
	ina->single_shot = of_property_read_bool(np, "ti,single-shot");

No need to resend right now; let's wait for feedback from Rob.

Guenter

>  	for_each_child_of_node(np, child) {
>  		ret = ina3221_probe_child_from_dt(dev, child, ina);
>  		if (ret)
> @@ -666,6 +682,10 @@ static int ina3221_probe(struct i2c_client *client,
>  	/* The driver will be reset, so use reset value */
>  	ina->reg_config = INA3221_CONFIG_DEFAULT;
>  
> +	/* Clear continuous bit to use single-shot mode */
> +	if (ina->single_shot)
> +		ina->reg_config &= ~INA3221_CONFIG_MODE_CONTINUOUS;
> +
>  	/* Disable channels if their inputs are disconnected */
>  	for (i = 0; i < INA3221_NUM_CHANNELS; i++) {
>  		if (ina->inputs[i].disconnected)
