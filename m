Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF3CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 04:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A6220844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 04:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h3CPpgSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A6220844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733005AbeHAGkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 02:40:33 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42580 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731956AbeHAGkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 02:40:32 -0400
Received: by mail-pl0-f68.google.com with SMTP id z7-v6so8175548plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 21:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HBwdBo+Gyx2IJsZUc4mXb2ZQzl38pBoyHl4bENHU868=;
        b=h3CPpgSMo1/BmoK+i7jilqomoyxuPErMj0SH9hoAaqd7dCWZTR8F1bRoWy8iMFg59f
         /JUciOiMe+X09Ie3WiShL080AZVj4Q6pG7AC+sH7n/Zsl4a9Le+Cczb2/Zlr0ANLSIqV
         wMSD3ecsr3AyZxdj3zc1HUee7ltoIt2JvgqXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HBwdBo+Gyx2IJsZUc4mXb2ZQzl38pBoyHl4bENHU868=;
        b=mIO91O/0qa4pxYk1FacGO11EqLDmuEgL3Rq2CIPDIt0h3Bc6pX2I4TB2dDwB5nte7I
         Vfd6hKxOJJSoi9pcZ3o+zpi5L1o8RZf7hxzpYE7dt0Jw0f31ziXIPWc1CDcjfLvtcb7W
         e7e7cGsSqzo6X1wbHzkznC5OWOLQstJaGIP7eayFzw44qfQfmdcT7oOz/4cg2wZcdwGG
         oVm3OglNRXPkBCEyN8j0p/hIdWnTlL7jEqANdFihY2AGjTtU0u3kZXbtXeIPMom36GzP
         El1YtC/O1EDbjXcKm2EHUcriEIcBKlSFrxLVV8J293dMCHcAgXHRDHSqj+s7+26xrIGj
         +zIQ==
X-Gm-Message-State: AOUpUlFanKhsn3mbWAPZEvww752aU+a0TpuJF/BokeUgaKBJP+7sH+6t
        tov2e/07hmJgEzokrpZekR2n
X-Google-Smtp-Source: AAOMgpeyYasaR7+txttJvKdNtefsdGESrSDDOsI8RCk2MAM+784mQnty9k95s9BsZ+aJlmqTLbAnJQ==
X-Received: by 2002:a17:902:9a06:: with SMTP id v6-v6mr10428845plp.316.1533099412214;
        Tue, 31 Jul 2018 21:56:52 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:730e:f0ae:ac4e:9cdd:28a2:4bf9])
        by smtp.gmail.com with ESMTPSA id b62-v6sm33872141pfm.97.2018.07.31.21.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 21:56:51 -0700 (PDT)
Date:   Wed, 1 Aug 2018 10:26:39 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     robh+dt@kernel.org, afaerber@suse.de, linus.walleij@linaro.org,
        linux-i2c@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com
Subject: Re: [PATCH v7 5/6] i2c: Add Actions Semiconductor Owl family S900
 I2C driver
Message-ID: <20180801045639.GB15529@Mani-XPS-13-9360>
References: <20180726154603.5089-1-manivannan.sadhasivam@linaro.org>
 <20180726154603.5089-6-manivannan.sadhasivam@linaro.org>
 <20180731200932.n7djds2rmqhclit5@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731200932.n7djds2rmqhclit5@ninjato>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Tue, Jul 31, 2018 at 10:09:32PM +0200, Wolfram Sang wrote:
> Hi Manivannan,
> 
> On Thu, Jul 26, 2018 at 09:16:02PM +0530, Manivannan Sadhasivam wrote:
> > Add Actions Semiconductor Owl family S900 I2C driver.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Acked-by: Peter Rosin <peda@axentia.se>
> 
> Looks mostly good already. Thanks Peter for the initial review!
> 

Thanks to Andy also :)

> > +static irqreturn_t owl_i2c_interrupt(int irq, void *_dev)
> > +{
> > +	struct owl_i2c_dev *i2c_dev = _dev;
> > +	struct i2c_msg *msg = i2c_dev->msg;
> > +	unsigned long flags;
> > +	unsigned int stat, fifostat;
> > +
> > +	spin_lock_irqsave(&i2c_dev->lock, flags);
> > +
> > +	fifostat = readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT);
> > +	if (fifostat & OWL_I2C_FIFOSTAT_RNB) {
> > +		dev_dbg(&i2c_dev->adap.dev, "received NACK from device\n");
> > +		goto stop;
> > +	}
> > +
> > +	stat = readl(i2c_dev->base + OWL_I2C_REG_STAT);
> > +	if (stat & OWL_I2C_STAT_BEB) {
> > +		dev_dbg(&i2c_dev->adap.dev, "bus error\n");
> > +		goto stop;
> > +	}
> 
> I wonder if you can't pass back the different errors to the upper
> layers? Like -ENXIO for NACK and -EIO for bus error? We have a
> convention for that and it seems your HW can support it. The different
> error codes would then maybe also make the debug outputs obsolete.
> 
> 

Sure, will catch the errors using an i2c_dev member and pass it to upper
layers in owl_i2c_master_xfer.

> > +	/*
> > +	 * Here, -ENXIO will be returned if interrupt occurred but no
> > +	 * read or write happened. Else if msg_ptr equals to message length,
> > +	 * message count will be returned.
> > +	 */
> > +	ret = i2c_dev->msg_ptr == msg->len ? num : -ENXIO;
> 
> I'd think this kinda unusual construct could go then as well by just
> returning the error code derived from the interrupt handler above.
> 

Makes sense! It will become:

ret = i2c_dev->err < 0 ? i2c_dev->err : num;

Thanks,
Mani

> > +static const struct i2c_adapter_quirks owl_i2c_quirks = {
> > +	.flags		= I2C_AQ_COMB | I2C_AQ_COMB_WRITE_FIRST,
> > +	.max_read_len   = 240,
> > +	.max_write_len  = 240,
> > +	.max_comb_1st_msg_len = 6,
> > +	.max_comb_2nd_msg_len = 240,
> > +};
> 
> Yay! Good use of the i2c_adapter_quirks struct :)
> 
> Regards,
> 
>    Wolfram
> 


