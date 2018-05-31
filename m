Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755726AbeEaQ6G (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:58:06 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41934 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755556AbeEaQ6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:58:02 -0400
X-Google-Smtp-Source: ADUXVKIBML67v4eMwlMeQOOxmBNYD2iXw357ykGhMExK65FdTL6eCO1bwv6YnlRaWfQAHgs9rVyK9w==
Date: Thu, 31 May 2018 09:57:59 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Timur Tabi <timur@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.16 269/272] pinctrl: msm: Use dynamic GPIO numbering
Message-ID: <20180531165759.GJ14924@minitux>
References: <20180528100240.256525891@linuxfoundation.org>
 <20180528100302.722883806@linuxfoundation.org>
 <7c34ccef-2fa8-8b53-2677-29f6fbe71a04@dd-wrt.com>
 <20180531114553.GB11598@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180531114553.GB11598@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 31 May 04:45 PDT 2018, Greg Kroah-Hartman wrote:

> On Thu, May 31, 2018 at 01:21:56PM +0200, Sebastian Gottschall wrote:
> > Am 28.05.2018 um 12:05 schrieb Greg Kroah-Hartman:
> > > 4.16-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > 
> > > [ Upstream commit a7aa75a2a7dba32594291a71c3704000a2fd7089 ]
> > > 
> > > The base of the TLMM gpiochip should not be statically defined as 0, fix
> > > this to not artificially restrict the existence of multiple pinctrl-msm
> > > devices.
> > > 
> > > Fixes: f365be092572 ("pinctrl: Add Qualcomm TLMM driver")
> > > Reported-by: Timur Tabi <timur@codeaurora.org>
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >   drivers/pinctrl/qcom/pinctrl-msm.c |    2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> > > +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> > > @@ -818,7 +818,7 @@ static int msm_gpio_init(struct msm_pinc
> > >   		return -EINVAL;
> > >   	chip = &pctrl->chip;
> > > -	chip->base = 0;
> > > +	chip->base = -1;
> > >   	chip->ngpio = ngpio;
> > >   	chip->label = dev_name(pctrl->dev);
> > >   	chip->parent = pctrl->dev;
> > 
> > this patch creates a regression for me. on ipq8064 the systems gpios now
> > start somewhere in the sky
> > 
> > new layout
> > 
> > lrwxrwxrwx    1 root     root             0 Jan  1 00:00 gpiochip373 -> ../../devices/platform/soc/1b700000.pci/pci0001:00/0001:00:00.0/0001:01:00.0/gpio/gpiochip373
> > lrwxrwxrwx    1 root     root             0 Jan  1 00:00 gpiochip408 -> ../../devices/platform/soc/1b500000.pci/pci0000:00/0000:00:00.0/0000:01:00.0/gpio/gpiochip408
> > lrwxrwxrwx    1 root     root             0 Jan  1 00:00 gpiochip443 ->
> > ../../devices/platform/soc/800000.pinmux/gpio/gpiochip443
> > 
> > 
> > before the patch
> > 
> > lrwxrwxrwx    1 root     root             0 Jan  1  1970 gpiochip0 ->
> > ../../devices/platform/soc/800000.pinmux/gpio/gpiochip0
> > lrwxrwxrwx    1 root     root             0 May 31 13:13 gpiochip442 -> ../../devices/platform/soc/1b700000.pci/pci0001:00/0001:00:00.0/0001:01:00.0/gpio/gpiochip442
> > lrwxrwxrwx    1 root     root             0 May 31 13:13 gpiochip477 -> ../../devices/platform/soc/1b500000.pci/pci0000:00/0000:00:00.0/0000:01:00.0/gpio/gpiochip477
> > 
> > 
> > this broke my userspace gpio handling. i can override this, but still it
> > doesnt look correct since there is a hole at the beginng likelly reserved by
> > unused arm gpios
> 
> So does this mean that 4.17-rc is also broken for you?  If so, this
> needs to be reverted there as well.
> 
> Bjorn, any ideas?
> 

The Qualcomm TLMM (pinctrl) driver was introduced long after it was
decided that the kernel should not rely on global/static gpio numbering.

But due to a mistake on my part the dynamic gpio base for this gpiochip
was always 0, which the offending patch corrects.


So writing user space code relying on the gpio numbering for this chip
has always been incorrect, just as it is for the other two gpiochips
listed above.


The original objection for backporting this patch was a touchscreen
driver stopped working on 4.4, but the driver clearly doesn't depend on
global or static numbering of gpios. I don't think this was ever root
caused.


I guess the pragmatic approach would be to come up with something like
Timur's suggested fix that makes the first instance of this driver use
base = 0 and then use dynamic numbering for the rest, to maintain
support for this incorrect usage of the gpio sysfs interface. (Although
that would probably break if Timur's customers move their user space to
the new platform as "the first instance" isn't deterministic).

Regards,
Bjorn
