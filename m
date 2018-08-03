Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AB8C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 20:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B7F217AA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 20:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="boOuAqxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B7F217AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbeHCWxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 18:53:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729876AbeHCWxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 18:53:31 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DAFF217A2;
        Fri,  3 Aug 2018 20:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533329734;
        bh=1wInzgfFYXz03b+rlnjAPPvo8pMAOV/6XNdXzEq7awQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=boOuAqxRzH/KBhuRT8vgTvcOht7kmqtDN9y/n8G0mYIqa/mwVXR+psa+s9VZAH+7j
         YP23T7DMqnhHmDapYElTc30B++VuMo57vI9rvHUdvm+iCY02U03IoVaruHevwRi+HF
         572sehZQ5/uJCAKsfXKlqeq06AoDQraNtvr0WosE=
Date:   Fri, 3 Aug 2018 21:55:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Parthiban Nallathambi <pn@denx.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>, wd@denx.de,
        sbabic@denx.de, Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v4 2/3] iio: light: Add support for vishay vcnl4035
Message-ID: <20180803215529.2069df4f@archlinux>
In-Reply-To: <CAHp75VcR7aaUkNJdARMvnkuzxfODwVhHFH0Hm94hsENbShtO3A@mail.gmail.com>
References: <20180802182729.2061830-1-pn@denx.de>
        <20180802182729.2061830-2-pn@denx.de>
        <CAHp75VcR7aaUkNJdARMvnkuzxfODwVhHFH0Hm94hsENbShtO3A@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2018 22:34:14 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Aug 2, 2018 at 9:27 PM, Parthiban Nallathambi <pn@denx.de> wrote:
> > Add support for VCNL4035, which is capable of Ambient light
> > sensing (ALS) and proximity function. This patch adds support
> > only for ALS function  
> 
> > +#include <linux/module.h>
> > +#include <linux/i2c.h>
> > +#include <linux/bitops.h>
> > +#include <linux/regmap.h>
> > +#include <linux/pm_runtime.h>  
> 
> Sort?
> 
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/events.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>  
> 
> Ditto.
> 
> > +       if (reg & (VCNL4035_INT_ALS_IF_H_MASK | VCNL4035_INT_ALS_IF_L_MASK))
> > +               return true;
> > +       else
> > +               return false;  
> 
> return !!(reg & ...); ?
> 
> > +static irqreturn_t vcnl4035_drdy_irq_thread(int irq, void *private)
> > +{
> > +       struct iio_dev *indio_dev = private;
> > +       struct vcnl4035_data *data = iio_priv(indio_dev);
> > +  
> 
> > +       if (vcnl4035_is_triggered(data)) {  
> 
> Here is negative conditional suits.
> 
> > +#ifndef CONFIG_PM  
> 
> Why?
> 
> > +       ret = vcnl4035_set_als_power_state(data, VCNL4035_MODE_ALS_ENABLE);
> > +       if (ret < 0)
> > +               return ret;
> > +#endif  
> 
> > +               pr_err("regmap_write default THDH returned %d\n", ret);  
> 
> dev_err()
> 
> > +               pr_err("regmap_write default THDL returned %d\n", ret);  
> 
> Ditto.
> 
> 
> > +       ret = pm_runtime_set_active(&client->dev);
> > +       if (ret < 0)
> > +               goto fail_poweroff;
> > +
> > +       pm_runtime_enable(&client->dev);
> > +       pm_runtime_set_autosuspend_delay(&client->dev, VCNL4035_SLEEP_DELAY_MS);
> > +       pm_runtime_use_autosuspend(&client->dev);  
> 
> Usually we do this after we probed the device.
I'm not sure we should.  The docs are fairly clear on this:

"In order to use autosuspend, subsystems or drivers must call
pm_runtime_use_autosuspend() (preferably before registering the device), and
thereafter they should use the various *_autosuspend() helper functions instead
of the non-autosuspend counterparts:" (Documentation/runtime_pm.txt)

It also makes more logical sense to have removed the userspace interfaces before
unwinding this as then we don't have annoying races around the inevitable
set_suspended.

> 
> > +       if (client->irq) {  
> 
> First of all, it can be negative.
> Second, care to factor out this rather long branch to a separate function?
> 
> > +               if (ret < 0) {
> > +                       dev_err(&client->dev, "request irq %d for trigger0 failed\n",
> > +                               client->irq);
> > +                       goto fail_buffer_clean;
> > +                       }  
> 
> Indentation.
> 
> > +       }  
> 
> So, do I understand correctly that IRQ is optional for this device?
> 
> 
> 
> > +#ifdef CONFIG_PM
> > +static int vcnl4035_runtime_suspend(struct device *dev)  
> 
> Perhaps __maybe_unused
> 
> > +static int vcnl4035_runtime_resume(struct device *dev)  
> 
> Ditto.
> 
> > +{
> > +       struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> > +       struct vcnl4035_data *data = iio_priv(indio_dev);
> > +       int ret;
> > +
> > +       regcache_sync(data->regmap);
> > +       ret = vcnl4035_set_als_power_state(data, VCNL4035_MODE_ALS_ENABLE);
> > +       if (ret < 0)
> > +               return ret;  
> 
> + blank line
> 
> > +       /* wait for 1 ALS integration cycle */
> > +       msleep(data->als_it_val * 100);
> > +
> > +       return 0;
> > +}
> > +#endif  
> 
> > +static const struct of_device_id vcnl4035_of_match[] = {
> > +       { .compatible = "vishay,vcnl4035", },
> > +       { },  
> 
> Better w/o comma.
> 
> > +};
> > +MODULE_DEVICE_TABLE(of, vcnl4035_of_match);  
> 
> > +
> > +static const struct i2c_device_id vcnl4035_id[] = {
> > +       { "vcnl4035", 0 },
> > +       { }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, vcnl4035_id);  
> 
> Are you expecting legacy code to use this? I would rather switch to
> ->probe_new() and also remove this.  
> 

