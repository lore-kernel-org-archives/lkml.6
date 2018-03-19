Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932978AbeCSNJx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 09:09:53 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38327 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932415AbeCSNJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 09:09:52 -0400
X-Google-Smtp-Source: AG47ELu/uMVX4qbD8vE+++zWPbnrsFd9pZYfqA+KgV4W82wHRtbmqJAXEPUNreunP78xHYsGuL8sh0Y0/uK23hmIWmo=
MIME-Version: 1.0
In-Reply-To: <e750ef11-0a56-07c4-af91-fee0be6e1019@rock-chips.com>
References: <1521018736-20980-1-git-send-email-hl@rock-chips.com>
 <CACvgo50UGi97RYQkYLMmVNKcfi39BSVVKkxHnLTvsEks737+-Q@mail.gmail.com> <e750ef11-0a56-07c4-af91-fee0be6e1019@rock-chips.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Mon, 19 Mar 2018 13:09:49 +0000
Message-ID: <CACvgo52G=-QRtseOFLWeh+RT6pEUAgVVJd-i6LPQJTEOnU+CrA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] drm/panel: refactor INNOLUX P079ZCA panel driver
To: hl <hl@rock-chips.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 March 2018 at 02:35, hl <hl@rock-chips.com> wrote:
> Hi Emil,
>
>
>
> On Wednesday, March 14, 2018 08:02 PM, Emil Velikov wrote:
>>
>> Hi Lin,
>>
>> On 14 March 2018 at 09:12, Lin Huang <hl@rock-chips.com> wrote:
>>>
>>> From: huang lin <hl@rock-chips.com>
>>>
>>> Refactor Innolux P079ZCA panel driver, let it support
>>> multi panel.
>>>
>>> Change-Id: If89be5e56dba8cb498e2d50c1bbeb0e8016123a2
>>> Signed-off-by: Lin Huang <hl@rock-chips.com>
>>> ---
>>> Changes in v2:
>>> - Change regulator property name to meet the panel datasheet
>>> Changes in v3:
>>> - this patch only refactor P079ZCA panel to support multi panel, support
>>> P097PFG panel in another patch
>>> Changes in v4:
>>> - Modify the patch which suggest by Thierry
>>>
>> Thanks for splitting this up. I think there's another piece that fell
>> through the cracks.
>> I'm not deeply familiar with the driver, so just sharing some quick notes.
>>
>>
>>>   struct innolux_panel {
>>>          struct drm_panel base;
>>>          struct mipi_dsi_device *link;
>>> +       const struct panel_desc *desc;
>>>
>>>          struct backlight_device *backlight;
>>> -       struct regulator *supply;
>>> +       struct regulator *vddi;
>>> +       struct regulator *avdd;
>>> +       struct regulator *avee;
>>
>> These two seem are new addition, as opposed to a dummy refactor.
>> Are they optional, does one need them for the existing panel (separate
>> patch?) or only for the new one (squash with the new panel code)?
>>
>>
>>>          struct gpio_desc *enable_gpio;
>>>
>>>          bool prepared;
>>> @@ -77,9 +93,9 @@ static int innolux_panel_unprepare(struct drm_panel
>>> *panel)
>>>          /* T8: 80ms - 1000ms */
>>>          msleep(80);
>>>
>>> -       err = regulator_disable(innolux->supply);
>>> -       if (err < 0)
>>> -               return err;
>>
>> Good call on dropping the early return here.
>>
>>
>>> @@ -207,19 +248,28 @@ static const struct drm_panel_funcs
>>> innolux_panel_funcs = {
>>> -       innolux->supply = devm_regulator_get(dev, "power");
>>> -       if (IS_ERR(innolux->supply))
>>> -               return PTR_ERR(innolux->supply);
>>> +       innolux = devm_kzalloc(dev, sizeof(*innolux), GFP_KERNEL);
>>> +       if (!innolux)
>>> +               return -ENOMEM;
>>> +
>>> +       innolux->desc = desc;
>>> +       innolux->vddi = devm_regulator_get(dev, "power");
>>> +       innolux->avdd = devm_regulator_get(dev, "avdd");
>>> +       innolux->avee = devm_regulator_get(dev, "avee");
>>>
>> AFAICT devm_regulator_get returns a pointer which is unsuitable to be
>> passed into regulator_{enable,disable}.
>> Hence, the IS_ERR check should stay. If any of the regulators are
>> optional, you want to call regulator_{enable,disable} only as
>> applicable.
>
>
> devm_regulator_get() will use dummy_regulator if there not regulator pass to
> driver, so it not affect regulator_{enable, disable}.

One of us is getting confused here:
devm_regulator_get does not _use_ a regulator, it returns a pointer to
a regulator, right?

According to the 4.16-rc6 codebase - one error devm_regulator_get
returns a ERR_PTR [1].
With the pointer dereferenced in regulator_enable [2], without a
IS_ERR check, hence thing will go boom(?)

> These three regulator are
> optional,
> the p079zca will use "power" and ,
> so i think it better not to check ERR here.
>
What should happen if p079zca is missing "power" or p097pgf - "avdd" and "avee"?
Obviously the latter two should be introduced with the p097pgf support.

HTH
Emil

[1] https://elixir.bootlin.com/linux/v4.16-rc6/source/drivers/regulator/devres.c#L27
[2] https://elixir.bootlin.com/linux/v4.16-rc6/source/drivers/regulator/core.c#L2189
