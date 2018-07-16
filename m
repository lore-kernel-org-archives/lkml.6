Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175CCECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 00:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678B8208E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 00:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678B8208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=electromag.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeGPBMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 21:12:37 -0400
Received: from anchovy3.45ru.net.au ([203.30.46.155]:46946 "EHLO
        anchovy3.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbeGPBMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 21:12:37 -0400
Received: (qmail 25178 invoked by uid 5089); 16 Jul 2018 00:47:46 -0000
Received: by simscan 1.2.0 ppid: 25093, pid: 25094, t: 0.0544s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.2?) (preid@electromag.com.au@58.7.184.227)
  by anchovy2.45ru.net.au with ESMTPA; 16 Jul 2018 00:47:45 -0000
Subject: Re: [PATCH/RFT 1/6] i2c: designware: use open drain for recovery GPIO
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, kernel@pengutronix.de,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
 <20180713210920.3648-2-wsa+renesas@sang-engineering.com>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <daaf702b-642f-e0fd-6a2e-7f0f817efba3@electromag.com.au>
Date:   Mon, 16 Jul 2018 08:47:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180713210920.3648-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2018 05:09, Wolfram Sang wrote:
> I2C is open drain, so set up the GPIO accordingly.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>   drivers/i2c/busses/i2c-designware-master.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
> index fc7c255c80af..a546db80f53e 100644
> --- a/drivers/i2c/busses/i2c-designware-master.c
> +++ b/drivers/i2c/busses/i2c-designware-master.c
> @@ -665,7 +665,7 @@ static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev)
>   	struct gpio_desc *gpio;
>   	int r;
>   
> -	gpio = devm_gpiod_get(dev->dev, "scl", GPIOD_OUT_HIGH);
> +	gpio = devm_gpiod_get(dev->dev, "scl", GPIOD_OUT_HIGH_OPEN_DRAIN);
>   	if (IS_ERR(gpio)) {
>   		r = PTR_ERR(gpio);
>   		if (r == -ENOENT || r == -ENOSYS)
> 
G'day Wolfram,

This was intentional. The gpio we use to drive the i2c line is implemented in an
FPGA and signals a buffer attached to the GPIO to drive scl OPEN drain. The GPIO is output
only.
The gpio setup can still specify the the GPIO be allocated OPEN drain if someone wishes
to use a "smarter" gpio.

So while the scl is open drain, there may be hardware in between that isn't.
What would the correct way be to deal with that now?


-- 
Regards
Phil
