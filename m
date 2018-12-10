Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E3FC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8C92081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8C92081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbeLJHm6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:42:58 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:25843 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLJHm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:42:58 -0500
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBp5hRw/qOxWRk4dCyh+3cT6eo6dYPn7/hui19zvYhTXI9T/Rws9qN1"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2001:16b8:264d:f100:746c:60ac:be83:9114]
        by smtp.strato.de (RZmta 44.6 AUTH)
        with ESMTPSA id k03348uBA7gkv4O
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 10 Dec 2018 08:42:46 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] [PATCH v2 4/5] gnss: sirf: add a separate supply for a lna
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20181209195150.5192-5-andreas@kemnade.info>
Date:   Mon, 10 Dec 2018 08:42:48 +0100
Cc:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <918A20A2-30F4-45C8-9883-038DE57716C3@goldelico.com>
References: <20181209195150.5192-1-andreas@kemnade.info> <20181209195150.5192-5-andreas@kemnade.info>
To:     Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Am 09.12.2018 um 20:51 schrieb Andreas Kemnade <andreas@kemnade.info>:
> 
> Devices might have a separate lna between antenna output of the gps

some nitpicking: the LNA (low noise amplifier) is between the antenna
and the GPS receiver. Therefore:

s/between antenna output of the gps/between antenna input of the gps/

Otherwise fine!

BR and thanks,
Nikolaus

> chip and the antenna which might have a separate supply.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v2:
> - handle lna also if there is no on-off gpio
> - rebase on changed 2/5
> 
> drivers/gnss/sirf.c | 26 ++++++++++++++++++++++----
> 1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
> index c64369494afb..d339e8ef2508 100644
> --- a/drivers/gnss/sirf.c
> +++ b/drivers/gnss/sirf.c
> @@ -36,6 +36,7 @@ struct sirf_data {
> 	struct serdev_device *serdev;
> 	speed_t	speed;
> 	struct regulator *vcc;
> +	struct regulator *lna;
> 	struct gpio_desc *on_off;
> 	struct gpio_desc *wakeup;
> 	int irq;
> @@ -282,21 +283,32 @@ static int sirf_set_active(struct sirf_data *data, bool active)
> static int sirf_runtime_suspend(struct device *dev)
> {
> 	struct sirf_data *data = dev_get_drvdata(dev);
> +	int ret = 0;
> 
> 	if (!data->on_off)
> -		return regulator_disable(data->vcc);
> +		ret = regulator_disable(data->vcc);
> +	else
> +		ret = sirf_set_active(data, false);
> 
> -	return sirf_set_active(data, false);
> +	if (ret)
> +		return ret;
> +
> +	return regulator_disable(data->lna);
> }
> 
> static int sirf_runtime_resume(struct device *dev)
> {
> 	struct sirf_data *data = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regulator_enable(data->lna);
> +	if (ret)
> +		return ret;
> 
> 	if (!data->on_off)
> 		return regulator_enable(data->vcc);
> -
> -	return sirf_set_active(data, true);
> +	else
> +		return sirf_set_active(data, true);
> }
> 
> static int __maybe_unused sirf_suspend(struct device *dev)
> @@ -384,6 +396,12 @@ static int sirf_probe(struct serdev_device *serdev)
> 		goto err_put_device;
> 	}
> 
> +	data->lna = devm_regulator_get(dev, "lna");
> +	if (IS_ERR(data->lna)) {
> +		ret = PTR_ERR(data->lna);
> +		goto err_put_device;
> +	}
> +
> 	data->on_off = devm_gpiod_get_optional(dev, "sirf,onoff",
> 			GPIOD_OUT_LOW);
> 	if (IS_ERR(data->on_off))
> -- 
> 2.11.0
> 
> _______________________________________________
> http://projects.goldelico.com/p/gta04-kernel/
> Letux-kernel mailing list
> Letux-kernel@openphoenux.org
> http://lists.goldelico.com/mailman/listinfo.cgi/letux-kernel

