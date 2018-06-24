Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B65C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117A624EFB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzXrh1UK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117A624EFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbeFXNMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 09:12:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751637AbeFXNMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 09:12:18 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4665F24EF7;
        Sun, 24 Jun 2018 13:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529845937;
        bh=loK+mp8Z/1OSQUdaeS/Ho2CtjRMbpOAsTE6BVRL3hwM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OzXrh1UKQL05ho92rf05AJifTGYHegVNN5t2pWq91GsdKQXZMjDnWY7x7VWlisPYO
         EJNM0FKVXvMD43teKXKiwT/TFsSJpI1hdPui0GSSpnAB9tgB7igv6cZMIaMi2xpknT
         LfJYXpyKKhoEvmB0iu5slQuXgfNWOZJNL+oq4ans=
Date:   Sun, 24 Jun 2018 14:12:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, mchehab@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        rdunlap@infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: hx711: add delay until DOUT is ready
Message-ID: <20180624141211.3765219d@archlinux>
In-Reply-To: <20180623185447.GA17853@arbeit>
References: <20180623185447.GA17853@arbeit>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jun 2018 20:54:47 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> On a system with parasitic capacities it turned out that DOUT is not ready
> after 100 ns after PD_SCK has raised. A measurement showed almost 1000 ns
> until DOUT has reached its correct value.
> 
> With this patch its now possible to wait until data is ready.
> 
> The wait time should not be higher than the maximum PD_SCK high time which
> is corresponding to the datasheet 50000 ns.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

This looks fine to me.  Will pick up once we have a DT review for the binding.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/hx711.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index 9430b54121e0..41e26ef324ee 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c
> @@ -97,6 +97,13 @@ struct hx711_data {
>  	 * 2x32-bit channel + 64-bit timestamp
>  	 */
>  	u32			buffer[4];
> +	/*
> +	 * delay after a rising edge on SCK until the data is ready DOUT
> +	 * this is dependent on the hx711 where the datasheet tells a
> +	 * maximum value of 100 ns
> +	 * but also on potential parasitic capacities on the wiring
> +	 */
> +	u32			data_ready_delay_ns;
>  };
>  
>  static int hx711_cycle(struct hx711_data *hx711_data)
> @@ -110,6 +117,14 @@ static int hx711_cycle(struct hx711_data *hx711_data)
>  	 */
>  	preempt_disable();
>  	gpiod_set_value(hx711_data->gpiod_pd_sck, 1);
> +
> +	/*
> +	 * wait until DOUT is ready
> +	 * it turned out that parasitic capacities are extending the time
> +	 * until DOUT has reached it's value
> +	 */
> +	ndelay(hx711_data->data_ready_delay_ns);
> +
>  	val = gpiod_get_value(hx711_data->gpiod_dout);
>  	/*
>  	 * here we are not waiting for 0.2 us as suggested by the datasheet,
> @@ -458,6 +473,7 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
>  static int hx711_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
>  	struct hx711_data *hx711_data;
>  	struct iio_dev *indio_dev;
>  	int ret;
> @@ -530,6 +546,13 @@ static int hx711_probe(struct platform_device *pdev)
>  	hx711_data->gain_set = 128;
>  	hx711_data->gain_chan_a = 128;
>  
> +	ret = of_property_read_u32(np, "data-ready-delay-ns",
> +					&hx711_data->data_ready_delay_ns);
> +	if (ret < 0) {
> +		dev_warn(dev, "data-ready-delay-ns not set - assuming 0 ns\n");
> +		hx711_data->data_ready_delay_ns = 0;
> +	}
> +
>  	platform_set_drvdata(pdev, indio_dev);
>  
>  	indio_dev->name = "hx711";

