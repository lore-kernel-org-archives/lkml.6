Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeCWQVx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:21:53 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41953 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbeCWQVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:21:51 -0400
X-Google-Smtp-Source: AG47ELsa63dbZV0j0/UuDFgn85KzHhdh8rB6i3M6o8byRlz8v++CTRYujpz3ESub+NlWKBbyrK06wg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Timur Tabi <timur@codeaurora.org>
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <1521804964.23017.96.camel@linux.intel.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>, linux-gpio@vger.kernel.org
References: <20180321165848.89751-1-swboyd@chromium.org>
 <20180321165848.89751-4-swboyd@chromium.org>
 <97380342-c3aa-5d34-7b22-f6ebbab4bafe@codeaurora.org>
 <1521804964.23017.96.camel@linux.intel.com>
Message-ID: <152182210780.178046.13284917877743312593@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 3/3] pinctrl: qcom: Don't allow protected pins to be requested
Date: Fri, 23 Mar 2018 09:21:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2NGLxCf005611

Quoting Andy Shevchenko (2018-03-23 04:36:04)
> On Thu, 2018-03-22 at 19:16 -0500, Timur Tabi wrote:
> > On 03/21/2018 11:58 AM, Stephen Boyd wrote:
> > > +static int msm_gpio_init_valid_mask(struct gpio_chip *chip,
> > > +                               struct msm_pinctrl *pctrl)
> > > +{
> > > +   int ret;
> > > +   unsigned int len, i;
> > > +   unsigned int max_gpios = pctrl->soc->ngpios;
> > > +
> > > +   /* The number of GPIOs in the ACPI tables */
> > > +   ret = device_property_read_u16_array(pctrl->dev, "gpios",
> > > NULL, 0);
> > > +   if (ret > 0 && ret < max_gpios) {
> > 
> > This needs to be ret <= max_gpios, otherwise it will fail if every
> > GPIO 
> > is available.
> > 
> > And it should print an error message and return an error code if ret
> > > 
> > max_gpios.
> 
> Perhaps makes sense to do the opposite condition
> 
> if (ret < 0 || ret > max_gpios) {
>  ... error handling ...
> }
> 

Indeed. I already rewrote it like this two days ago:

static int msm_gpio_init_valid_mask(struct gpio_chip *chip,
                                   struct msm_pinctrl *pctrl)
{
       int ret;
       unsigned int len, i;
       unsigned int max_gpios = pctrl->soc->ngpios;
       u16 *tmp;

       /* The number of GPIOs in the ACPI tables */
       len = ret = device_property_read_u16_array(pctrl->dev, "gpios",
ULL, 0);
       if (ret < 0)
               return 0;

       if (ret > max_gpios)
               return -EINVAL;

       tmp = kmalloc_array(len, sizeof(*tmp), GFP_KERNEL);
       if (!tmp)
               return -ENOMEM;

       ret = device_property_read_u16_array(pctrl->dev, "gpios", tmp,
en);
       if (ret < 0) {
               dev_err(pctrl->dev, "could not read list of GPIOs\n");
               goto out;
       }

       bitmap_zero(chip->valid_mask, max_gpios);
       for (i = 0; i < len; i++)
               set_bit(tmp[i], chip->valid_mask);

out:
       kfree(tmp);
       return ret;
}

I'll send the updated patches now.
