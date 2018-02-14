Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030792AbeBNUqi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 15:46:38 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46292 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030206AbeBNUqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 15:46:36 -0500
X-Google-Smtp-Source: AH8x22496AyuwS8gMrmOi5JVmc6An+oW/TYePpwoYr/OpMd/i+LBQ/8MrSA7mQ8PoRUPn11WnZnRK0Ext+GVJH01/w0=
MIME-Version: 1.0
In-Reply-To: <20180131202506.GI9418@n2100.armlinux.org.uk>
References: <20180129234900.11121-1-anders.roxell@linaro.org>
 <20180131201911.19253-1-anders.roxell@linaro.org> <20180131202506.GI9418@n2100.armlinux.org.uk>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 14 Feb 2018 21:46:35 +0100
Message-ID: <CADYN=9L2-yaOvxp8j23O9Sp15mgFZrPUsEZBOWi=UngYyXNJpQ@mail.gmail.com>
Subject: Re: [PATCHv2] arch/arm/Kconfig: default ARM_MODULE_PLTS to 'y'
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 January 2018 at 21:25, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Wed, Jan 31, 2018 at 09:19:11PM +0100, Anders Roxell wrote:
>> While testing multi_v7_defconfig with LOCKDEP enabled, the kernel
>> fails to load simple modules, as reported by kselftest:
>>
>> [   34.107620] test_printf: section 4 reloc 2 sym 'memset': relocation
>> 28 out of range (0xbf046044 -> 0xc109f720)
>> selftests: printf.sh [FAIL]
>>
>> The problem that is seen when LOCKDEP is enabled without
>> ARM_MODULE_PLTS, is that LOCKDEP eats so much memory that the top of the
>> kernel gets out of reach from the bottom of the module area.
>
> As I've said three times already (and clearly the message still hasn't
> sunk in), it does _not_ follow that "enable lockdep" means "lots more
> memory used".  We could say the same thing about several other kernel
> options as well.  Please remove this from your commit message.

Sorry, I meant to show this as an example in v2, but forgot to update this part
of the change log.

>
> <exasperation at seemingly being ignored on this point>
>
> Maybe you'd like to send your configuration file so we can see how much
> is enabled in your kernel.  At that point I'll make a decision, but
> until then, I'm not going to say that even what I suggested is an
> acceptable way forward.

Here's the config file[1] that is using.

I'm obviously ignorant here, but whats the disadvantages of enabling
this option by default?
My understanding is that the module size gets slightly larger by enabling
this option but nothing else?

Obviously, if the default is changed to yes, the last part of this option's help
message also need to change. To something like:
"Say n if you know that you wont get out of memory errors while loading modules"

Cheers,
Anders
[1] http://snapshots.linaro.org/openembedded/lkft/morty/am57xx-evm/rpb/linux-mainline/622/config

>
>>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>> ---
>>  arch/arm/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 51c8df561077..8014c8c322df 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1702,6 +1702,7 @@ config ARCH_WANT_GENERAL_HUGETLB
>>  config ARM_MODULE_PLTS
>>       bool "Use PLTs to allow module memory to spill over into vmalloc area"
>>       depends on MODULES
>> +     default y
>>       help
>>         Allocate PLTs when loading modules so that jumps and calls whose
>>         targets are too far away for their relative offsets to be encoded
>> --
>> 2.11.0
>>
>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> According to speedtest.net: 8.21Mbps down 510kbps up
