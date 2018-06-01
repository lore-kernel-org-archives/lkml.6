Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750934AbeFAIqS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:46:18 -0400
Received: from smtps.newmedia-net.de ([185.84.6.167]:37697 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750724AbeFAIqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:46:14 -0400
Subject: Re: [PATCH 4.16 269/272] pinctrl: msm: Use dynamic GPIO numbering
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Timur Tabi <timur@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20180528100240.256525891@linuxfoundation.org>
 <20180528100302.722883806@linuxfoundation.org>
 <7c34ccef-2fa8-8b53-2677-29f6fbe71a04@dd-wrt.com>
 <20180531114553.GB11598@kroah.com> <20180531165759.GJ14924@minitux>
From: Sebastian Gottschall <s.gottschall@dd-wrt.com>
Message-ID: <8c5897d0-364f-b8e0-4608-9bdd294de657@dd-wrt.com>
Date: Fri, 1 Jun 2018 10:46:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180531165759.GJ14924@minitux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 31.05.2018 um 18:57 schrieb Bjorn Andersson:
> On Thu 31 May 04:45 PDT 2018, Greg Kroah-Hartman wrote:
>
>> On Thu, May 31, 2018 at 01:21:56PM +0200, Sebastian Gottschall wrote:
>>> Am 28.05.2018 um 12:05 schrieb Greg Kroah-Hartman:
>>>> 4.16-stable review patch.  If anyone has any objections, please let me know.
>>>>
>>>> ------------------
>>>>
>>>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>>
>>>> [ Upstream commit a7aa75a2a7dba32594291a71c3704000a2fd7089 ]
>>>>
>>>> The base of the TLMM gpiochip should not be statically defined as 0, fix
>>>> this to not artificially restrict the existence of multiple pinctrl-msm
>>>> devices.
>>>>
>>>> Fixes: f365be092572 ("pinctrl: Add Qualcomm TLMM driver")
>>>> Reported-by: Timur Tabi <timur@codeaurora.org>
>>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> ---
>>>>    drivers/pinctrl/qcom/pinctrl-msm.c |    2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
>>>> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
>>>> @@ -818,7 +818,7 @@ static int msm_gpio_init(struct msm_pinc
>>>>    		return -EINVAL;
>>>>    	chip = &pctrl->chip;
>>>> -	chip->base = 0;
>>>> +	chip->base = -1;
>>>>    	chip->ngpio = ngpio;
>>>>    	chip->label = dev_name(pctrl->dev);
>>>>    	chip->parent = pctrl->dev;
>>> this patch creates a regression for me. on ipq8064 the systems gpios now
>>> start somewhere in the sky
>>>
>>> new layout
>>>
>>> lrwxrwxrwx    1 root     root             0 Jan  1 00:00 gpiochip373 -> ../../devices/platform/soc/1b700000.pci/pci0001:00/0001:00:00.0/0001:01:00.0/gpio/gpiochip373
>>> lrwxrwxrwx    1 root     root             0 Jan  1 00:00 gpiochip408 -> ../../devices/platform/soc/1b500000.pci/pci0000:00/0000:00:00.0/0000:01:00.0/gpio/gpiochip408
>>> lrwxrwxrwx    1 root     root             0 Jan  1 00:00 gpiochip443 ->
>>> ../../devices/platform/soc/800000.pinmux/gpio/gpiochip443
>>>
>>>
>>> before the patch
>>>
>>> lrwxrwxrwx    1 root     root             0 Jan  1  1970 gpiochip0 ->
>>> ../../devices/platform/soc/800000.pinmux/gpio/gpiochip0
>>> lrwxrwxrwx    1 root     root             0 May 31 13:13 gpiochip442 -> ../../devices/platform/soc/1b700000.pci/pci0001:00/0001:00:00.0/0001:01:00.0/gpio/gpiochip442
>>> lrwxrwxrwx    1 root     root             0 May 31 13:13 gpiochip477 -> ../../devices/platform/soc/1b500000.pci/pci0000:00/0000:00:00.0/0000:01:00.0/gpio/gpiochip477
>>>
>>>
>>> this broke my userspace gpio handling. i can override this, but still it
>>> doesnt look correct since there is a hole at the beginng likelly reserved by
>>> unused arm gpios
>> So does this mean that 4.17-rc is also broken for you?  If so, this
>> needs to be reverted there as well.
>>
>> Bjorn, any ideas?
>>
> The Qualcomm TLMM (pinctrl) driver was introduced long after it was
> decided that the kernel should not rely on global/static gpio numbering.
>
> But due to a mistake on my part the dynamic gpio base for this gpiochip
> was always 0, which the offending patch corrects.
>
>
> So writing user space code relying on the gpio numbering for this chip
> has always been incorrect, just as it is for the other two gpiochips
> listed above.
>
>
> The original objection for backporting this patch was a touchscreen
> driver stopped working on 4.4, but the driver clearly doesn't depend on
> global or static numbering of gpios. I don't think this was ever root
> caused.
>
>
> I guess the pragmatic approach would be to come up with something like
> Timur's suggested fix that makes the first instance of this driver use
> base = 0 and then use dynamic numbering for the rest, to maintain
> support for this incorrect usage of the gpio sysfs interface. (Although
> that would probably break if Timur's customers move their user space to
> the new platform as "the first instance" isn't deterministic).
>
> Regards,
> Bjorn
that would at least guarantee backward compatiblity. i'm fine with that

Sebastian
>
