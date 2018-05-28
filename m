Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166040AbeE1PPW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:15:22 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:32921 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033680AbeE1PPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:15:15 -0400
X-Google-Smtp-Source: ADUXVKJC4aeU1tUDFTJYel+2+54qoxylA8o5SchvSgHU42VTTcZSFQyXc1ZbrTgpGza/OvjmE2xFe+UZtvEe+1oUL4g=
MIME-Version: 1.0
In-Reply-To: <CAHp75VffA5Q2VxgkQqT6M_iLwZtv46Gy5Fz4Fx7PA9CvRnX0Ag@mail.gmail.com>
References: <20180525210752.1794502-1-arnd@arndb.de> <CAPDyKFoyBZ=k5UQyTmgkPd+30Htymw99Xeh3C+bDPo+VGyjrNw@mail.gmail.com>
 <CAK8P3a2AGu4Lec1pwi87gb4QYn9QTy7mG2i9kWtfAR=An+k-7g@mail.gmail.com> <CAHp75VffA5Q2VxgkQqT6M_iLwZtv46Gy5Fz4Fx7PA9CvRnX0Ag@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 28 May 2018 17:15:13 +0200
X-Google-Sender-Auth: Da54lkbbRcHgrmyHARvjCTsG3Sg
Message-ID: <CAK8P3a1z2AyUs536ujPm8dpYrktRoeFxcbNHQ_fgQK1idM5T+A@mail.gmail.com>
Subject: Re: [PATCH] mmc: sunxi: mark PM functions as __maybe_unused
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 2:12 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> +Cc: Jean
>
> On Mon, May 28, 2018 at 2:13 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Mon, May 28, 2018 at 1:04 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> On 25 May 2018 at 23:07, Arnd Bergmann <arnd@arndb.de> wrote:
>>>> The newly added runtime-pm functions cause a harmless warning
>>>> when CONFIG_PM is disabled:
>>>>
>>>> drivers/mmc/host/sunxi-mmc.c:1452:12: error: 'sunxi_mmc_runtime_suspend' defined but not used [-Werror=unused-function]
>>>>  static int sunxi_mmc_runtime_suspend(struct device *dev)
>>>>             ^~~~~~~~~~~~~~~~~~~~~~~~~
>>>> drivers/mmc/host/sunxi-mmc.c:1435:12: error: 'sunxi_mmc_runtime_resume' defined but not used [-Werror=unused-function]
>>>>  static int sunxi_mmc_runtime_resume(struct device *dev)
>>>>
>>>> This marks them as __maybe_unused to shut up the warning.
>>>
>>> Most mmc drivers uses #ifdef CONFIG_PM instead of the __maybe_unused() option.
>>>
>>> It's not a big deal, but consistency is always good. Would you mind changing?
>>
>> I'd prefer not to. Most uses of #ifdef CONFIG_PM that get introduced are wrong,
>> and cause additional randconfig warnings that I end up having to fix,
>> so I always
>> do it with __maybe_unused.
>
> Some of the maintainers have strong objection against such changes.
> http://lkml.iu.edu/hypermail/linux/kernel/1805.1/06100.html
>
> It seems we might have a split in the opinions, which is not good in
> this case (consistency for PM callbacks overall will be broken).

We actually talked about this at the kernel summit last year, and the conclusion
was that we should replace the SET_RUNTIME_PM_OPS(),
SIMPLE_DEV_PM_OPS(), SET_SYSTEM_SLEEP_PM_OPS()
etc macros with new ones that don't require the ugly #ifdef and just silently
drop the unused functions.

Unfortunately we can't extend the existing macros to work that way (it
breaks for drivers that have an #ifdef today), and nobody could come up
with a new name that is at least as readable as the current one.

Note that incorrect #ifdef usage here is the most common source of
newly introduced build warnings and errors in the kernel, everyone gets
those wrong since they are just very confusing.

       Arnd
