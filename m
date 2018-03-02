Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934900AbeCBXni (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 18:43:38 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52974 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934783AbeCBXnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 18:43:37 -0500
Date: Sat, 3 Mar 2018 00:43:11 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: David Daney <ddaney.cavm@gmail.com>
Cc: David Daney <david.daney@cavium.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6] rtc: isl12026: Add driver.
Message-ID: <20180302234311.GE1479@piout.net>
References: <20180222200432.22003-1-david.daney@cavium.com>
 <20180228151701.GM1479@piout.net>
 <CAKjEs9FbNDKNs5j-aZAmHCYO1YE5g70vLyuk1hGDNvvRWj977w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKjEs9FbNDKNs5j-aZAmHCYO1YE5g70vLyuk1hGDNvvRWj977w@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2018 at 08:22:22 -0800, David Daney wrote:
> I am no longer able to test this patch as I lost access to the hardware.
> 

Ah, too bad. I will take your patch as-is and then add a small patch to
fixup the nvmem registration.

> If someone else wants to take charge of the patch, that would be great.
> 
> Sorry I couldn't drive this to completion,
> David Daney
> 
> On Wed, Feb 28, 2018 at 7:17 AM, Alexandre Belloni <
> alexandre.belloni@free-electrons.com> wrote:
> 
> > Hi,
> >
> > That's mostly good
> >
> > On 22/02/2018 at 12:04:32 -0800, David Daney wrote:
> > > +     priv->rtc->ops = &isl12026_rtc_ops;
> > > +     priv->rtc->nvram_old_abi = false;
> >
> > This allocation is not necessary and I would refer not having t so when
> > the ABI goes away, it is not necessary to change this driver.
> >
> > > +     ret = rtc_register_device(priv->rtc);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     memset(&nvm_cfg, 0, sizeof(nvm_cfg));
> > > +     nvm_cfg.name = "eeprom";
> >
> > You probably need something more descriptive, usually the rtc model name
> > else, it is difficult (but not impossible) to find where this nvmem is
> > actually located when using /sys/bus/nvmem/devices
> > isl12026- would be a good choice.
> >
> > > +     nvm_cfg.read_only = false;
> > > +     nvm_cfg.root_only = true;
> >
> > any reason to have it root only?
> >
> > > +     nvm_cfg.base_dev = &client->dev;
> > > +     nvm_cfg.priv = priv;
> > > +     nvm_cfg.stride = 1;
> > > +     nvm_cfg.word_size = 1;
> > > +     nvm_cfg.size = 512;
> > > +     nvm_cfg.reg_read = isl12026_nvm_read;
> > > +     nvm_cfg.reg_write = isl12026_nvm_write;
> > > +
> > > +     return rtc_nvmem_register(priv->rtc, &nvm_cfg);
> >
> > The probe function must not fail after rtc_register_device has been
> > called so you must return 0 here.
> >
> > It is not currently possible to call rtc_nvmem_register before
> > rtc_register_device unless we move the nvmem to the parent device:
> >
> > diff --git a/drivers/rtc/nvmem.c b/drivers/rtc/nvmem.c
> > index 3a02357eb783..17ec4c8d0fad 100644
> > --- a/drivers/rtc/nvmem.c
> > +++ b/drivers/rtc/nvmem.c
> > @@ -91,7 +91,7 @@ int rtc_nvmem_register(struct rtc_device *rtc,
> >         if (!nvmem_config)
> >                 return -ENODEV;
> >
> > -       nvmem_config->dev = &rtc->dev;
> > +       nvmem_config->dev = rtc->dev.parent;
> >         nvmem_config->owner = rtc->owner;
> >         rtc->nvmem = nvmem_register(nvmem_config);
> >         if (IS_ERR_OR_NULL(rtc->nvmem))
> >
> > I'll submit this patch for this cycle before there are many users of the
> > interface (converted drivers are still exposing the old ABI).
> >
> > If you prefer, you can depend on it.
> >
> > --
> > Alexandre Belloni, Bootlin (formerly Free Electrons)
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
