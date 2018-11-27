Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EDEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AB52086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AB52086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbeK0S6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:58:52 -0500
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:32991 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbeK0S6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:58:52 -0500
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 7F1E65C1002; Tue, 27 Nov 2018 08:01:13 +0000 (UTC)
Date:   Tue, 27 Nov 2018 09:01:13 +0100
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Sean Wang <sean.wang@kernel.org>
Cc:     hofrat@osadl.org, Linus Walleij <linus.walleij@linaro.org>,
        sergio.paracuellos@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, bgolaszewski@baylibre.com,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] gpio: mt7621: pass mediatek_gpio_bank_probe()
 failure up the stack
Message-ID: <20181127080113.GA2426@osadl.at>
References: <1542823573-20228-1-git-send-email-hofrat@osadl.org>
 <1542823573-20228-2-git-send-email-hofrat@osadl.org>
 <CAGp9LzoT7ueXyyVSYQdWOU0JkQDWMVcwCuSE3gJnEn0fLLjCBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGp9LzoT7ueXyyVSYQdWOU0JkQDWMVcwCuSE3gJnEn0fLLjCBA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:49:26PM -0800, Sean Wang wrote:
> Nicholas Mc Guire <hofrat@osadl.org> ??? 2018???11???21??? ?????? ??????10:13?????????
> >
> > The error cases of mediatek_gpio_bank_probe() would go unnoticed (except
> > for the dev_err() messages). The probe function should return an error
> > if one of the banks failed to initialize properly.
> >
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
> > ---
> >
> > Patch was compile tested with: omega2p_defconfig, SOC_MT7621=y,
> > GPIOLIB=y, GPIO_MT7621=y
> >
> > Patch is against 4.20-rc3 (localversion-next is next-20181121)
> >
> >  drivers/gpio/gpio-mt7621.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
> > index 1ec95bc..68fca8b 100644
> > --- a/drivers/gpio/gpio-mt7621.c
> > +++ b/drivers/gpio/gpio-mt7621.c
> > @@ -297,6 +297,7 @@ mediatek_gpio_probe(struct platform_device *pdev)
> >         struct device_node *np = dev->of_node;
> >         struct mtk *mtk;
> >         int i;
> > +       int ret;
> >
> >         mtk = devm_kzalloc(dev, sizeof(*mtk), GFP_KERNEL);
> >         if (!mtk)
> > @@ -311,8 +312,11 @@ mediatek_gpio_probe(struct platform_device *pdev)
> >         platform_set_drvdata(pdev, mtk);
> >         mediatek_gpio_irq_chip.name = dev_name(dev);
> >
> > -       for (i = 0; i < MTK_BANK_CNT; i++)
> > -               mediatek_gpio_bank_probe(dev, np, i);
> > +       for (i = 0; i < MTK_BANK_CNT; i++) {
> > +               ret = mediatek_gpio_bank_probe(dev, np, i);
> > +               if (!ret)
> 
> it should be if (ret < 0) ?

I don´t think so mediatek_gpio_bank_probe() returns 0 on success
and all other returns are error paths - while the current code
only returns negative values I do thik that any non 0 would be
an error indication so !ret should be fine here.

thx!
hofrat

> 
> > +                       return ret;
> > +       }
> >
> >         return 0;
> >  }
> > --
> > 2.1.4
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
