Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BC6C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 08:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0C2251F2
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 08:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PBImpQ9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0C2251F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbeGAINv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 04:13:51 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35618 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbeGAINq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 04:13:46 -0400
Received: by mail-pg0-f68.google.com with SMTP id i7-v6so5785687pgp.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 01:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nlFJffENQ7FOiQoDlG+ZYRTsq1kRTjx5ROqecPjEpFo=;
        b=PBImpQ9iCXrOXgaXSRQj1ckfKWjvtyBZTVUVY+ffLIydC6OuFFITIm7EM20iceQjFC
         TN4PaiZBoMQKvnLPQ2TBwS1V0BKa9Fn8cEbIWLDiyeSjluCniraCOf5Mmq5gwhAIYBs/
         6HsKWHwncYAjhuEte8zsNfyQ+cBYwK2hSZN+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nlFJffENQ7FOiQoDlG+ZYRTsq1kRTjx5ROqecPjEpFo=;
        b=eYhx/m3uQSRdDGcse3rrL2pRdc9U41qWuJOaNZ/87qkCp8x/30B0KrFRaLJZRr0eFm
         AIjn1tOPEVg7BTuXY47BbbPx7uJ3gzraFcGcrgcnMPLofpcKZcx74klvUcRlFqVAuaom
         8bDcuQOpcODh0VBLMNG+Yp8eHDQS7+sGa2HBQ3GpEp4lj6ZSCfDOKa9pXKS2UHQgoQ3+
         3XltXaK/GvFk3eozwuhu6/YOpdZAivzCZ3Eg0pjBV7j9SKYny4QK8PJcfZNpaF5TPvXu
         ziZ4DRJBi2JOEzTSGczsyP+XK+GeJI+wIjMSXFGoXFzdPtOPbSTHttgta5ywet+q+wvn
         T5uQ==
X-Gm-Message-State: APt69E1lHib72HbU7D4pMT4lZCulrSNgq5sYMPmWyLD2js9/TXL0/E4H
        XAKjy2H9gkezv09rlioTgsyS
X-Google-Smtp-Source: AAOMgpcdioHRefq2sQit6eX2ZIjSkN1LG6htpzoP2/hlx7QX2gNvSZ/5SnidcDGadBkjLfJHSpX1+g==
X-Received: by 2002:a63:5b0d:: with SMTP id p13-v6mr2341496pgb.202.1530432825392;
        Sun, 01 Jul 2018 01:13:45 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:73c0:9e12:2c06:3367:1893:796])
        by smtp.gmail.com with ESMTPSA id w3-v6sm27372009pfi.109.2018.07.01.01.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Jul 2018 01:13:44 -0700 (PDT)
Date:   Sun, 1 Jul 2018 13:43:33 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        =?utf-8?B?5YiY54Kc?= <liuwei@actions-semi.com>,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree <devicetree@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        amit.kucheria@linaro.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Mani Sadhasivam <manivannanece23@gmail.com>,
        Thomas Liau <thomas.liau@actions-semi.com>,
        jeff.chen@actions-semi.com
Subject: Re: [PATCH v3 5/6] i2c: Add Actions Semiconductor Owl family S900
 I2C driver
Message-ID: <20180701081333.GB28390@Mani-XPS-13-9360>
References: <20180630133330.23858-1-manivannan.sadhasivam@linaro.org>
 <20180630133330.23858-6-manivannan.sadhasivam@linaro.org>
 <CAHp75VcVNb51tJzKbCU3pqf0XYPCUZWpv38nfaV1711vyf2S0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcVNb51tJzKbCU3pqf0XYPCUZWpv38nfaV1711vyf2S0Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Sun, Jul 01, 2018 at 12:11:00AM +0300, Andy Shevchenko wrote:
> On Sat, Jun 30, 2018 at 4:33 PM, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> > Add Actions Semiconductor Owl family S900 I2C driver.
> 
> Thanks for an update. Few left comments and it would LGTM.
> 

Thanks :)

> > +static int owl_i2c_reset(struct owl_i2c_dev *i2c_dev)
> > +{
> 
> > +       mdelay(1);
> 
> But now, since it's not used in atomic context, we may switch to
> usleep_range() / msleep() instead.
> 

okay, will use msleep()

> > +       owl_i2c_update_reg(i2c_dev->base + OWL_I2C_REG_CTL,
> > +                               OWL_I2C_CTL_EN, true);
> > +
> 
> > +       /* Wait 50ms for FIFO reset complete */
> > +       do {
> 
> > +               mdelay(1);
> 
> Especially in this case it's very important.
> 

Okay.

> > +       } while (timeout++ < OWL_I2C_MAX_RETRIES);
> 
> > +}
> 
> > +       val = (i2c_dev->clk_rate + i2c_dev->bus_freq * 16 - 1) /
> > +                               (i2c_dev->bus_freq * 16);
> 
> This is effectively DIV_ROUND_UP(->clk_rate, ->bus_freq * 16).
> 

Ack.

> > +       /*
> > +        * By default, 0 will be returned if interrupt occurred but no
> > +        * read or write happened. Else if msg_ptr equals to message length,
> > +        * message count will be returned.
> > +        */
> 
> > +       if (i2c_dev->msg_ptr == msg->len)
> > +               ret = num;
> 
> I dunno if
> 
> ret = ->msg_ptr == len ? num : 0;
> 
> would be slightly more explicit (yes, I aware about ret == 0).
> 
> Up to you to choose.
> 

As per Peter's comment, returning 0 will get changed to an error value.
Will use this pattern once we settle with a proper error value.

> > +       /* We support only frequencies of 100k and 400k for now */
> > +       if (i2c_dev->bus_freq != OWL_I2C_DEF_SPEED_HZ &&
> > +                       i2c_dev->bus_freq > OWL_I2C_MAX_SPEED_HZ) {
> 
> I think it should be != in the second case as well.
> 

yeah, agree. We don't support any other frequencies now.

Thanks,
Mani

> > +               dev_err(dev, "invalid clock-frequency %d\n", i2c_dev->bus_freq);
> > +               return -EINVAL;
> > +       }
> 
> -- 
> With Best Regards,
> Andy Shevchenko
