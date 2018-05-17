Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751322AbeEQGQ0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:16:26 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:40949 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeEQGQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:16:24 -0400
X-Google-Smtp-Source: AB8JxZq9xe64eqmdsD+Wn9T0pG7VgIYuzVXBo8UGh4stkfDw4rdzP3a7nmaidEPDOO8Jz0o70C20mfC6AoYUFnmAgrs=
MIME-Version: 1.0
In-Reply-To: <316ca15c-86f2-f052-c307-ba12eea7b579@rock-chips.com>
References: <20180516192022.23541-1-malat@debian.org> <316ca15c-86f2-f052-c307-ba12eea7b579@rock-chips.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 17 May 2018 08:16:03 +0200
X-Google-Sender-Auth: fvgCWwcnSINDrBuftXqQAJjxWzA
Message-ID: <CA+7wUszzfp8u+PwRzOUj3MNNEdCpZYCUoFgGp3GwT8c9nyurpg@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: propagate correct returned value in mmc_rpmb_ioctl
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4H6GXmi016279

On Thu, May 17, 2018 at 4:45 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> On 2018/5/17 3:20, Mathieu Malaterre wrote:
>>
>> In commit 97548575bef3 ("mmc: block: Convert RPMB to a character device")
>> a
>> new function `mmc_rpmb_ioctl` was added. The final return is simply
>> returning a value of `0` instead of propagating the correct return code.
>>
>> Discovered during a compilation with W=1, silence the following gcc
>> warning
>>
>>    drivers/mmc/core/block.c:2470:6: warning: variable ‘ret’ set but not
>> used [-Wunused-but-set-variable]
>>
>
> Good catch! But hey, which gcc are you using now? Mine, gcc-linaro-
> 6.3.1-2017.05-x86_64_aarch64-linux-gnu, with W=1 doesn't warn about
> this.

$ powerpc-linux-gnu-gcc --version
powerpc-linux-gnu-gcc (Debian 6.3.0-18) 6.3.0 20170516
Copyright (C) 2016 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

This is the default powerpc cross compiler on Debian stable (no
change). Config is simply a ppc32 (with some minor customization).


> And it's worth backporting to stable.

I am not familiar with the process, do I need to submit a v2 to add the line:

Cc: <stable@vger.kernel.org> # v4.15+

?

> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
>
>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>>   drivers/mmc/core/block.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>> index 9e923cd1d80e..38a7586b00cc 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -2485,7 +2485,7 @@ static long mmc_rpmb_ioctl(struct file *filp,
>> unsigned int cmd,
>>                 break;
>>         }
>>   -     return 0;
>> +       return ret;
>>   }
>>     #ifdef CONFIG_COMPAT
>>
>
