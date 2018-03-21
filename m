Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbeCUQIO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 12:08:14 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:38973 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbeCUQIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 12:08:06 -0400
X-Google-Smtp-Source: AIpwx49whjakTpJa/jSVc0T4DAkNE05R71oy/i1WuJFGOIa8m5CLUI1CYVVLCChR4KJ4KO1qcL06gZXnvxNFbTt/g3E=
MIME-Version: 1.0
In-Reply-To: <4b985ed2-0db0-b4ad-8a9f-b8804e6d4db4@lechnology.com>
References: <20180321120807.18032-1-brgl@bgdev.pl> <20180321120807.18032-5-brgl@bgdev.pl>
 <4b985ed2-0db0-b4ad-8a9f-b8804e6d4db4@lechnology.com>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Wed, 21 Mar 2018 17:08:04 +0100
Message-ID: <CAMpxmJUELxNGv5fL1gdNM4nRxdJ9t39G2Nc29yjZRnS0fRyHYg@mail.gmail.com>
Subject: Re: [PATCH 4/8] clk: davinci: add a reset lookup table for psc0
To: David Lechner <david@lechnology.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-clk@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-21 17:01 GMT+01:00 David Lechner <david@lechnology.com>:
> On 03/21/2018 07:08 AM, Bartosz Golaszewski wrote:
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> In order to be able to use the reset framework in legacy boot mode as
>> well, add the reset lookup table to the psc driver for da850 variant.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>   drivers/clk/davinci/psc-da850.c | 8 ++++++++
>>   drivers/clk/davinci/psc.c       | 1 +
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/drivers/clk/davinci/psc-da850.c
>> b/drivers/clk/davinci/psc-da850.c
>> index ccc7eb17bf3a..395db4b2c0ee 100644
>> --- a/drivers/clk/davinci/psc-da850.c
>> +++ b/drivers/clk/davinci/psc-da850.c
>> @@ -6,6 +6,7 @@
>>    */
>>     #include <linux/clk-provider.h>
>> +#include <linux/reset-controller.h>
>>   #include <linux/clk.h>
>>   #include <linux/clkdev.h>
>>   #include <linux/init.h>
>> @@ -66,8 +67,15 @@ LPSC_CLKDEV3(ecap_clkdev,    "fck",  "ecap.0",
>>                                 "fck",  "ecap.1",
>>                                 "fck",  "ecap.2");
>>   +static struct reset_control_lookup da850_psc0_reset_lookup_table[] = {
>> +       RESET_LOOKUP("davinci-rproc.0", NULL, 15),
>> +};
>> +
>>   static int da850_psc0_init(struct device *dev, void __iomem *base)
>>   {
>> +       reset_controller_add_lookup("da850-psc0",
>> +                                   da850_psc0_reset_lookup_table,
>> +
>> ARRAY_SIZE(da850_psc0_reset_lookup_table));
>
>
> Could there be a race condition here since you are adding the lookup
> *before*
> you are adding the actual provider? It seems like
> reset_controller_add_lookup()
> should be after davinci_psc_register_clocks().
>

I don't think so, because reset_controller_add_lookup() only adds the
lookup structure to the list in reset/core.c. The actual reset
controller struct is only located and used when reset_control_get_*()
is called, so after probing the user. And it's all protected with
mutexes.

This made me think though - maybe if we can't locate the controller,
we should return -EPROBE_DEFER from probe in davinci-rproc?

Bart
