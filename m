Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753689AbeCFP3N (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 10:29:13 -0500
Received: from bert.emutex.com ([91.103.1.109]:48185 "EHLO bert.emutex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750817AbeCFP3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 10:29:11 -0500
Subject: Re: [PATCH] pinctrl: intel: Implement intel_gpio_get_direction
 callback
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180306134213.16898-1-javier@emutex.com>
 <3585081b-70af-5c31-08c0-84e96b6055bc@emutex.com>
 <1520348165.10722.438.camel@linux.intel.com>
 <1520348368.10722.440.camel@linux.intel.com>
From: Javier Arteaga <javier@emutex.com>
Message-ID: <44e5cabd-c772-9fb6-52a4-887ba3c98fcc@emutex.com>
Date: Tue, 6 Mar 2018 15:29:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1520348368.10722.440.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Report: Spam detection software, running on the system "statler.emutex.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On 06/03/2018 14:59, Andy Shevchenko wrote: > On Tue, 2018-03-06
    at 16:56 +0200, Andy Shevchenko wrote: >> On Tue, 2018-03-06 at 14:31 +0000,
    Javier Arteaga wrote: > >>>> +static int intel_gpio_get_direction(struct
   gpio_chip *chip, >>>> unsigned int offset) >>>> +{ > >>>> + if (padcfg0 &
   PADCFG0_PMODE_MASK) >>>> + return -EINVAL; >> >> Actually we might return
   direction of GPIO function while pin is in >> some >> other mode, though it
    would probably make not much sense in practice. > > One more though, this
    is a call back for GPIO function anyway, so, above > condition should never
    happen. I think it's safe to remove it > completely. [...]
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2018 14:59, Andy Shevchenko wrote:
> On Tue, 2018-03-06 at 16:56 +0200, Andy Shevchenko wrote:
>> On Tue, 2018-03-06 at 14:31 +0000, Javier Arteaga wrote:
> 
>>>> +static int intel_gpio_get_direction(struct gpio_chip *chip,
>>>> unsigned int offset)
>>>> +{
> 
>>>> +	if (padcfg0 & PADCFG0_PMODE_MASK)
>>>> +		return -EINVAL;
>>
>> Actually we might return direction of GPIO function while pin is in
>> some
>> other mode, though it would probably make not much sense in practice.
> 
> One more though, this is a call back for GPIO function anyway, so, above
> condition should never happen. I think it's safe to remove it
> completely.

The story behind that check is likely *not* a valid usecase: the current
iteration of the UP board drivers use gpiod_get_direction() *while*
requesting GPIOs to mirror SoC GPIO config on the on-board FPGA. So the
direction doesn't make sense for pins set to function mode.

As per your other feedback that driver should be reworked anyway -
that's not a reason to keep the check. I just thought it's a bit more
defensive, and saw there's some precedent of doing this:

    f002d07c56c7 ("gpio: tegra: Implement gpio_get_direction callback")

That being said I don't have a strong argument either way :)
I'll resend if you still feel it's unnecessary.

Thanks for reviewing!
