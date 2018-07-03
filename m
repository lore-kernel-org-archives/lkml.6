Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8486DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3471920834
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3471920834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934293AbeGCRbp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:31:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47219 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933569AbeGCRbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:31:43 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 73F9A20737; Tue,  3 Jul 2018 19:31:41 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 41A852069C;
        Tue,  3 Jul 2018 19:31:41 +0200 (CEST)
Date:   Tue, 3 Jul 2018 19:31:41 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: Defer on non-DT find_chip_by_name() failure
Message-ID: <20180703193141.747fa950@bbrezillon>
In-Reply-To: <20180703172635.32508-1-jmkrzyszt@gmail.com>
References: <20180703172635.32508-1-jmkrzyszt@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

On Tue,  3 Jul 2018 19:26:35 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Avoid replication of error code conversion in non-DT GPIO consumers'
> code by returning -EPROBE_DEFER from gpiod_find() in case a chip
> identified by its label in a registered lookup table is not ready.
> 
> See https://lkml.org/lkml/2018/5/30/176 for example case.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
> If accepted, please add
> 	Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> if Boris doesn't mind.
> 
> Thanks,
> Janusz
> 
>  drivers/gpio/gpiolib.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index e11a3bb03820..15dc77c80328 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -3639,9 +3639,16 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
>  		chip = find_chip_by_name(p->chip_label);
>  
>  		if (!chip) {
> -			dev_err(dev, "cannot find GPIO chip %s\n",
> -				p->chip_label);
> -			return ERR_PTR(-ENODEV);
> +			/*
> +			 * As the lookup table indicates a chip with
> +			 * p->chip_label should exist, assume it may
> +			 * still appear latar and let the interested

					^ later

> +			 * consumer be probed again or let the Deferred
> +			 * Probe infrastructure handle the error.
> +			 */
> +			dev_warn(dev, "cannot find GPIO chip %s, deferring\n",
> +				 p->chip_label);
> +			return ERR_PTR(-EPROBE_DEFER);
>  		}
>  
>  		if (chip->ngpio <= p->chip_hwnum) {

Looks good otherwise. Let's hope we're not breaking implementations
testing for -ENODEV...

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

Regards,

Boris
