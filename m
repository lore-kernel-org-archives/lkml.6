Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbeC0JGI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:06:08 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41406 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbeC0JGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:06:05 -0400
X-Google-Smtp-Source: AIpwx4/Qc5VYq3uZXm2P/9HAkqUbHO53DczOj1SD9bPT+j4l1GPj91eQtHOSXeEJF7ISUNKwcAOfCoJjWrAzShAFoTA=
MIME-Version: 1.0
In-Reply-To: <8115587a-4925-5602-43db-4285a3de7b0e@samsung.com>
References: <1521213399-31947-1-git-send-email-jacopo+renesas@jmondi.org>
 <1521213399-31947-3-git-send-email-jacopo+renesas@jmondi.org>
 <CGME20180327062437epcas5p3389cb070d15669febeb6f504cff2cf6f@epcas5p3.samsung.com>
 <30381869-9bc8-b6aa-a37a-598d9c8f280d@mentor.com> <df124c8f-7c71-7941-9969-977dd19c7d1b@samsung.com>
 <CAMuHMdVWJhmxXS+mvuwjrCOzurArFurqKwQ2PJD-eRCqbLRAng@mail.gmail.com> <8115587a-4925-5602-43db-4285a3de7b0e@samsung.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Mar 2018 11:06:03 +0200
X-Google-Sender-Auth: xCtGOAlD_UqPWzLpRaTkT2cf1VQ
Message-ID: <CAMuHMdVEF-6icsLXd3RU56mzGp6TZYpD1E5ViZvaOa=kWGYPvw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] drm: bridge: Add thc63lvd1024 LVDS decoder driver
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrezj,

On Tue, Mar 27, 2018 at 10:36 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:
> On 27.03.2018 09:36, Geert Uytterhoeven wrote:
>> On Tue, Mar 27, 2018 at 9:28 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:
>>>>> --- /dev/null
>>>>> +++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
>>>>> +static void thc63_enable(struct drm_bridge *bridge)
>>>>> +{
>>>>> +    struct thc63_dev *thc63 = to_thc63(bridge);
>>>>> +    struct regulator *vcc;
>>>>> +    int i;
>>>> unsigned int i;
>>> Why? You are introducing silly bug this way, see few lines below.
>>>
>>>>> +
>>>>> +    for (i = 0; i < ARRAY_SIZE(thc63->vccs); i++) {
>>>>> +            vcc = thc63->vccs[i];
>>>>> +            if (!vcc)
>>>>> +                    continue;
>>>>> +
>>>>> +            if (regulator_enable(vcc))
>>>>> +                    goto error_vcc_enable;
>>>>> +    }
>>>>> +
>>>>> +    if (thc63->pdwn)
>>>>> +            gpiod_set_value(thc63->pdwn, 0);
>>>>> +
>>>>> +    if (thc63->oe)
>>>>> +            gpiod_set_value(thc63->oe, 1);
>>>>> +
>>>>> +    return;
>>>>> +
>>>>> +error_vcc_enable:
>>>>> +    dev_err(thc63->dev, "Failed to enable regulator %s\n",
>>>>> +            thc63_reg_names[i]);
>>>>> +
>>>>> +    for (i = i - 1; i >= 0; i--) {
>>> Here, the loop will not end if you define i unsigned.
>> True.
>>
>>> I know one can change the loop, to make it working with unsigned. But
>>> this clearly shows that using unsigned is more risky.
>>> What are advantages of unsigned vs int in this case. Are there some
>>> guidelines/discussions about it?
>> Some people consider signed integers harmful, as they may be converted
>> silently by the compiler to the "larger" unsigned type when needed.
>
> Wow, it sounds crazy, shall we expect gigantic patchsets, converting all
> occurrences of int to "unsigned int" ? :)

No we shall not.

> I know both types have their pros and cons and can behave unexpectedly
> in corner cases, but I do not see why unsigned should be preferred over
> signed in general, or in this particular case.

When looping over array indices, and comparing with ARRAY_SIZE (which
is unsigned), using "unsigned int" is preferred.

However, in this case the error code relies on the index becoming negative,
so a signed integer should be used.

> I guess there were somewhere discussion about it, could you point me to
> it if possible, to avoid unnecessary noise in this thread.

Not here, but Google pointed me to
http://blog.robertelder.org/signed-or-unsigned/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
