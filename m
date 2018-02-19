Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751433AbeBSGYo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 01:24:44 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:51812 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbeBSGYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 01:24:43 -0500
X-Google-Smtp-Source: AH8x227/S0Y3HZHzW6RsXxHPWjVAnTLmkbaTZTEZcVqSixf9rk1CmeKbPNOL0qjd/Stz87TfutfhMA==
Subject: Re: [PATCH] of: Kconfig: OF_OVERLAY, select OF_EARLY_FLATTREE
To: Rob Herring <robh+dt@kernel.org>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <1519000156-14319-1-git-send-email-frowand.list@gmail.com>
 <CAL_JsqLa83SKe5vbCkU8pwjPzBszsHrWQEA-ThMMciMwLO1XmA@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <300becd6-db35-59e6-1b81-6b1940070df0@gmail.com>
Date: Sun, 18 Feb 2018 22:24:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLa83SKe5vbCkU8pwjPzBszsHrWQEA-ThMMciMwLO1XmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18/18 17:46, Rob Herring wrote:
> On Sun, Feb 18, 2018 at 6:29 PM,  <frowand.list@gmail.com> wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> kbuild test robot reported a new warning for a recent patch:
>>>> drivers/of/overlay.c:832:2: error: implicit declaration of function 'of_fdt_unflatten_tree' [-Werror=implicit-function-declaration]
>>      of_fdt_unflatten_tree(new_fdt, NULL, &overlay_root);
>>
>> The cause is that the prototype for of_fdt_unflatten_tree() in
>> include/linux/of_fdt.c is guarded by OF_EARLY_FLATTREE.
>>
>> This was a pre-existing problem for any overlay related caller of
>> of_fdt_unflatten_device_tree(), who was then going to pass the
>> unflattened tree to of_overlay_apply().  After the patch that triggered
>> this warning, all other overlay callers of of_fdt_unflatten_device_tree()
>> no longer exist, so adding the select to OF_OVERLAY is a sufficient fix.
>>
>> To reproduce the warning:
>>   Use the .config attached to https://lkml.org/lkml/2018/2/17/268
>>   make ARCH=i386 olddefconfig
>>   make ARCH=i386 CC=gcc-7 drivers/of/overlay.o
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>  drivers/of/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
>> index 783e0870bd22..00a6abfaaec7 100644
>> --- a/drivers/of/Kconfig
>> +++ b/drivers/of/Kconfig
>> @@ -92,6 +92,7 @@ config OF_RESOLVE
>>  config OF_OVERLAY
>>         bool "Device Tree overlays"
>>         select OF_DYNAMIC
>> +       select OF_EARLY_FLATTREE
> 
> If we do this, we might as well kill OF_EARLY_FLATTREE. What platform
> really boots from not FDT, but uses DT without overlays?

Making sure I'm understanding...  So you want to remove OF_EARLY_FLATTREE
and convert the current users of it to OF_FLATTREE?

I don't see any way to directly configure OF_FLATTREE and I don't see any
Kconfig file selecting it, other than drivers/of/Kconfig which selects
OF_FLATTREE from OF_EARLY_FLATTREE.  So as far as I can tell, the two
config options are essentially a single config option.  Meaning that
either one could be replaced by the other.

Changing all to OF_FLATTREE will touch more files and thus will be a
bit more obtrusive.  It looks like it would take two releases to avoid
a flag day change.

Changing all to OF_EARLY_FLATTREE can be done in a single release.

I can create a patch set whichever way you prefer.

-Frank
