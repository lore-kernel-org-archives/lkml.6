Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753279AbeDRIjh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:39:37 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:33380 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752864AbeDRIjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:39:35 -0400
Subject: Re: [PATCH v6 3/4] MIPS: vmlinuz: Use generic ashldi3
To: James Hogan <jhogan@kernel.org>
CC: Palmer Dabbelt <palmer@sifive.com>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, <linux-kbuild@vger.kernel.org>
References: <1523433019-17419-1-git-send-email-matt.redfearn@mips.com>
 <1523433019-17419-3-git-send-email-matt.redfearn@mips.com>
 <20180417230921.GA29046@saruman>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <500897d9-f800-e953-fc36-fba7b32eb028@mips.com>
Date: Wed, 18 Apr 2018 09:39:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180417230921.GA29046@saruman>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1524040742-298554-25649-18454-1
X-BESS-VER: 2018.4-r1804121647
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.60
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192116
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.60 MARKETING_SUBJECT      HEADER: Subject contains
        popular marketing words
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.60 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=MARKETING_SUBJECT, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 18/04/18 00:09, James Hogan wrote:
> On Wed, Apr 11, 2018 at 08:50:18AM +0100, Matt Redfearn wrote:
>> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
>> index adce180f3ee4..e03f522c33ac 100644
>> --- a/arch/mips/boot/compressed/Makefile
>> +++ b/arch/mips/boot/compressed/Makefile
>> @@ -46,9 +46,12 @@ $(obj)/uart-ath79.c: $(srctree)/arch/mips/ath79/early_printk.c
>>   
>>   vmlinuzobjs-$(CONFIG_KERNEL_XZ) += $(obj)/ashldi3.o $(obj)/bswapsi.o
>>   
>> -extra-y += ashldi3.c bswapsi.c
>> -$(obj)/ashldi3.o $(obj)/bswapsi.o: KBUILD_CFLAGS += -I$(srctree)/arch/mips/lib
>> -$(obj)/ashldi3.c $(obj)/bswapsi.c: $(obj)/%.c: $(srctree)/arch/mips/lib/%.c
>> +extra-y += ashldi3.c
>> +$(obj)/ashldi3.c: $(obj)/%.c: $(srctree)/lib/%.c
>> +	$(call cmd,shipped)
>> +
>> +extra-y += bswapsi.c
>> +$(obj)/bswapsi.c: $(obj)/%.c: $(srctree)/arch/mips/lib/%.c
>>   	$(call cmd,shipped)
> 
> ci20_defconfig:
> 
> arch/mips/boot/compressed/ashldi3.c:4:10: fatal error: libgcc.h: No such file or directory
>   #include "libgcc.h"
>             ^~~~~~~~~~
> 
> It looks like it had already copied ashldi3.c from arch/mips/lib/ when
> building an older commit, and it hasn't been regenerated from lib/ since
> the Makefile changed, so its still using the old version.
> 
> I think it should be using FORCE and if_changed like this:
> 
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index e03f522c33ac..abe77add8789 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -47,12 +47,12 @@ $(obj)/uart-ath79.c: $(srctree)/arch/mips/ath79/early_printk.c
>   vmlinuzobjs-$(CONFIG_KERNEL_XZ) += $(obj)/ashldi3.o $(obj)/bswapsi.o
>   
>   extra-y += ashldi3.c
> -$(obj)/ashldi3.c: $(obj)/%.c: $(srctree)/lib/%.c
> -	$(call cmd,shipped)
> +$(obj)/ashldi3.c: $(obj)/%.c: $(srctree)/lib/%.c FORCE
> +	$(call if_changed,shipped)
>   
>   extra-y += bswapsi.c
> -$(obj)/bswapsi.c: $(obj)/%.c: $(srctree)/arch/mips/lib/%.c
> -	$(call cmd,shipped)
> +$(obj)/bswapsi.c: $(obj)/%.c: $(srctree)/arch/mips/lib/%.c FORCE
> +	$(call if_changed,shipped)
>   
>   targets := $(notdir $(vmlinuzobjs-y))
>   
> That resolves the build failures when checking out old -> new without
> cleaning, since the .ashldi3.c.cmd is missing so it gets rebuilt.
> 
> It should also resolve issues if the path it copies from is updated in
> future since the .ashldi3.c.cmd will get updated.
> 
> If you checkout new -> old without cleaning, the now removed
> arch/mips/lib/ashldi3.c will get added which will trigger regeneration,
> so it won't error.
> 
> However if you do new -> old -> new then the .ashldi3.cmd file isn't
> updated while at old, so you get the same error as above. I'm not sure
> there's much we can practically do about that, aside perhaps avoiding
> the issue in future by somehow auto-deleting stale .*.cmd files.
> 
> Cc'ing kbuild folk in case they have any bright ideas.
> 
> At least the straightforward old->new upgrade will work with the above
> fixup though. If you're okay with it I'm happy to apply as a fixup.

Unbelievable how fragile this change is proving to be :-/
Yeah fixup looks good to me.

Thanks,
Matt

> 
> Cheers
> James
> 
