Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B15C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DFA2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LwDBkBhU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DFA2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbeLCKhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:37:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40591 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeLCKhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:37:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id q26so5062950wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=up5LcSgEp00Z28NCqSzII18i1J7FDVHnKHI1LcaQ96Q=;
        b=LwDBkBhUzLzsiQyW8lPHWGQGrmJiUXwE83VXqUAXoDiQphRD14Eq1+67nHQv+UDsAg
         GOmrIccai+Vj9+3iAPibTN94keNWrOXUSPjj6UpPBouRxFrH52WgCfWcaqD6o7MUzHgv
         j2n2BMpFv8vJNbaeJTm2YTfMP9trEJBL6ZJN9ynSb1IqZkAbNd40U5PxPdN7pwILuoXE
         3IRxGPFPpYqjT+Zp31h3jTpx0fDyNlzrriIRKEi8gB812OqUO5JJVQG9NQxZaEIEsE4d
         a9AmMZcCk+wim8mIQde31fcW+pgno6Oxeo9UeB9ShuroHlP+LaQplnAOwzhLrTGlOjV7
         GG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=up5LcSgEp00Z28NCqSzII18i1J7FDVHnKHI1LcaQ96Q=;
        b=DuwKvSR8hF7bJ3S+n2A6UPY0r5z0FioMEC0eg8+EP3DSwAOiaH0Jmn4sbK33y4VEYQ
         2pgttAaS1akfh35z4JQr8yWb8+BlBhjjwORbZfvGjapdNbEqp4N1tHIiEZLveWePWF0s
         2CSu4J5k1LnAAcpoHBzfdOecMRBzkWXZYvGj9n+o3UKP1gYOq+P8hcuDVW1yuRbP3QuK
         oj/gXzOg8sIw/NSqGZ6u1Pxr+ZMPLJLKvwevafCfWseTg1XSSfC8I0NOR1wMNl2Dw6PR
         VJ+68DK/gI/MRJ1O4qJUGGblWsVQKRaMxt+Qae8IIRhivyTTFJbGpSawXPrMsxmdctXp
         NZzg==
X-Gm-Message-State: AA+aEWbbBQKNieVfkjCf0e7ve5rrvnv79cndESICURcJrZN2SlRamVFS
        BB0UVqzJmEFc5LweIOud3iLKIQ==
X-Google-Smtp-Source: AFSGD/X5ceD2PIej54vdDDlQaNJ8ZL3HBbzxz9hWOEcqHqqKvssWwQElEL1m32OD4ORNQRaqsLLtYA==
X-Received: by 2002:a1c:9513:: with SMTP id x19mr7527589wmd.112.1543833394984;
        Mon, 03 Dec 2018 02:36:34 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id k26sm3011479wmi.28.2018.12.03.02.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 02:36:34 -0800 (PST)
Message-ID: <f2ceff1edcb2c103d0128a838ff630bb3c147bf5.camel@baylibre.com>
Subject: Re: [PATCH] pinctrl: meson: fix G12A ao pull registers base address
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org
Cc:     khilman@baylibre.com, carlo@caione.org,
        martin.blumenstingl@googlemail.com, robh@kernel.org,
        jianxin.pan@amlogic.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 03 Dec 2018 11:36:32 +0100
In-Reply-To: <a240773f-7b05-d950-e5e9-23d7983c7f35@baylibre.com>
References: <20181203030533.10989-1-xingyu.chen@amlogic.com>
         <a240773f-7b05-d950-e5e9-23d7983c7f35@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-03 at 11:27 +0100, Neil Armstrong wrote:
> Hi Xingyu,
> 
> 
> On 03/12/2018 04:05, Xingyu Chen wrote:
> > Since Meson G12A SoC, Introduce new ao registers AO_RTI_PULL_UP_EN_REG
> > and AO_GPIO_O.
> > 
> > These bits of controlling output level are remapped to the new register
> > AO_GPIO_O, and the AO_GPIO_O_EN_N support only controlling output enable.
> > 
> > These bits of controlling pull enable are remapped to the new register
> > AO_RTI_PULL_UP_EN_REG, and the AO_RTI_PULL_UP_REG support only controlling
> > pull type(up/down).
> > 
> > The new layout of ao gpio/pull registers is as follows:
> > - AO_GPIO_O_EN_N        [offset: 0x9 << 2]
> > - AO_GPIO_I             [offset: 0xa << 2]
> > - AO_RTI_PULL_UP_REG    [offset: 0xb << 2]
> > - AO_RTI_PULL_UP_EN_REG [offset: 0xc << 2]
> > - AO_GPIO_O             [offset: 0xd << 2]
> > 
> > From above, we can see ao GPIO registers region has been separated by the
> > ao pull registers. In order to ensure the continuity of the region on
> > software, the ao GPIO and ao pull registers use the same base address, but
> > can be identified by the offset.
> > 
> > Fixes: 29ae0952e85f ("pinctrl: meson-g12a: add pinctrl driver support")
> > Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> > Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> > ---
> >  drivers/pinctrl/meson/pinctrl-meson.c | 22 ++++++++++++----------
> >  1 file changed, 12 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/pinctrl/meson/pinctrl-meson.c
> > b/drivers/pinctrl/meson/pinctrl-meson.c
> > index 53d449076dee..7ff40cd7a0cb 100644
> > --- a/drivers/pinctrl/meson/pinctrl-meson.c
> > +++ b/drivers/pinctrl/meson/pinctrl-meson.c
> > @@ -31,6 +31,9 @@
> >   * In some cases the register ranges for pull enable and pull
> >   * direction are the same and thus there are only 3 register ranges.
> >   *
> > + * Since Meson G12A SoC, the ao register ranges for gpio, pull enable
> > + * and pull direction are the same, so there are only 2 register ranges.
> > + *
> >   * For the pull and GPIO configuration every bank uses a contiguous
> >   * set of bits in the register sets described above; the same register
> >   * can be shared by more banks with different offsets.
> > @@ -487,23 +490,22 @@ static int meson_pinctrl_parse_dt(struct
> > meson_pinctrl *pc,
> >  		return PTR_ERR(pc->reg_mux);
> >  	}
> >  
> > -	pc->reg_pull = meson_map_resource(pc, gpio_np, "pull");
> > -	if (IS_ERR(pc->reg_pull)) {
> > -		dev_err(pc->dev, "pull registers not found\n");
> > -		return PTR_ERR(pc->reg_pull);
> > +	pc->reg_gpio = meson_map_resource(pc, gpio_np, "gpio");
> > +	if (IS_ERR(pc->reg_gpio)) {
> > +		dev_err(pc->dev, "gpio registers not found\n");
> > +		return PTR_ERR(pc->reg_gpio);
> >  	}
> >  
> > +	pc->reg_pull = meson_map_resource(pc, gpio_np, "pull");
> > +	/* Use gpio region if pull one is not present */
> > +	if (IS_ERR(pc->reg_pull))
> > +		pc->reg_pull = pc->reg_gpio;
> > +
> >  	pc->reg_pullen = meson_map_resource(pc, gpio_np, "pull-enable");
> >  	/* Use pull region if pull-enable one is not present */
> >  	if (IS_ERR(pc->reg_pullen))
> >  		pc->reg_pullen = pc->reg_pull;
> >  
> > -	pc->reg_gpio = meson_map_resource(pc, gpio_np, "gpio");
> > -	if (IS_ERR(pc->reg_gpio)) {
> > -		dev_err(pc->dev, "gpio registers not found\n");
> > -		return PTR_ERR(pc->reg_gpio);
> > -	}
> > -
> >  	return 0;
> >  }
> >  
> > 
> Doesn't it need an update of the bindings ?

Going even further, shouldn't we stop trying make multiple regions out of
this, and have just one ? 

On all the Amlogic SoC we have seen so far, all the regions a very (VERY)
close to each other. It seems very unlikely that there something unrelated to
GPIO in between.

It looks like everything is mostly there in the driver to deal with offset, so
change would be minimal.

Of course, for  DT stability we will need to carry the legacy, but for newer
SoC, such as the g12, does it really makes sense to have multiple regions ?

> 
> Neil
> 


