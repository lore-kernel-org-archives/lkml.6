Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeCOCfY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 22:35:24 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:45799 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751495AbeCOCfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 22:35:23 -0400
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
X-RL-SENDER: hl@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: hl@rock-chips.com
X-UNIQUE-TAG: <04fa7ad733cd2f6662ed8b8a0872eacc>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v4 1/3] drm/panel: refactor INNOLUX P079ZCA panel driver
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
References: <1521018736-20980-1-git-send-email-hl@rock-chips.com>
 <CACvgo50UGi97RYQkYLMmVNKcfi39BSVVKkxHnLTvsEks737+-Q@mail.gmail.com>
From: hl <hl@rock-chips.com>
Message-ID: <e750ef11-0a56-07c4-af91-fee0be6e1019@rock-chips.com>
Date: Thu, 15 Mar 2018 10:35:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACvgo50UGi97RYQkYLMmVNKcfi39BSVVKkxHnLTvsEks737+-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emil,


On Wednesday, March 14, 2018 08:02 PM, Emil Velikov wrote:
> Hi Lin,
>
> On 14 March 2018 at 09:12, Lin Huang <hl@rock-chips.com> wrote:
>> From: huang lin <hl@rock-chips.com>
>>
>> Refactor Innolux P079ZCA panel driver, let it support
>> multi panel.
>>
>> Change-Id: If89be5e56dba8cb498e2d50c1bbeb0e8016123a2
>> Signed-off-by: Lin Huang <hl@rock-chips.com>
>> ---
>> Changes in v2:
>> - Change regulator property name to meet the panel datasheet
>> Changes in v3:
>> - this patch only refactor P079ZCA panel to support multi panel, support P097PFG panel in another patch
>> Changes in v4:
>> - Modify the patch which suggest by Thierry
>>
> Thanks for splitting this up. I think there's another piece that fell
> through the cracks.
> I'm not deeply familiar with the driver, so just sharing some quick notes.
>
>
>>   struct innolux_panel {
>>          struct drm_panel base;
>>          struct mipi_dsi_device *link;
>> +       const struct panel_desc *desc;
>>
>>          struct backlight_device *backlight;
>> -       struct regulator *supply;
>> +       struct regulator *vddi;
>> +       struct regulator *avdd;
>> +       struct regulator *avee;
> These two seem are new addition, as opposed to a dummy refactor.
> Are they optional, does one need them for the existing panel (separate
> patch?) or only for the new one (squash with the new panel code)?
>
>
>>          struct gpio_desc *enable_gpio;
>>
>>          bool prepared;
>> @@ -77,9 +93,9 @@ static int innolux_panel_unprepare(struct drm_panel *panel)
>>          /* T8: 80ms - 1000ms */
>>          msleep(80);
>>
>> -       err = regulator_disable(innolux->supply);
>> -       if (err < 0)
>> -               return err;
> Good call on dropping the early return here.
>
>
>> @@ -207,19 +248,28 @@ static const struct drm_panel_funcs innolux_panel_funcs = {
>> -       innolux->supply = devm_regulator_get(dev, "power");
>> -       if (IS_ERR(innolux->supply))
>> -               return PTR_ERR(innolux->supply);
>> +       innolux = devm_kzalloc(dev, sizeof(*innolux), GFP_KERNEL);
>> +       if (!innolux)
>> +               return -ENOMEM;
>> +
>> +       innolux->desc = desc;
>> +       innolux->vddi = devm_regulator_get(dev, "power");
>> +       innolux->avdd = devm_regulator_get(dev, "avdd");
>> +       innolux->avee = devm_regulator_get(dev, "avee");
>>
> AFAICT devm_regulator_get returns a pointer which is unsuitable to be
> passed into regulator_{enable,disable}.
> Hence, the IS_ERR check should stay. If any of the regulators are
> optional, you want to call regulator_{enable,disable} only as
> applicable.

devm_regulator_get() will use dummy_regulator if there not regulator pass to driver,
so it not affect regulator_{enable, disable}. These three regulator are optional,
the p079zca will use "power" and p097pgf will use "avdd" and "avee",
so i think it better not to check ERR here.

>
>> @@ -318,5 +377,6 @@ static struct mipi_dsi_driver innolux_panel_driver = {
>>   module_mipi_dsi_driver(innolux_panel_driver);
>>
>>   MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
>> +MODULE_AUTHOR("Lin Huang <hl@rock-chips.com>");
> I don't think refactoring existing code classify as being the module author.
> Then again, I could be wrong.
>
> HTH
> Emil
>
>
>
