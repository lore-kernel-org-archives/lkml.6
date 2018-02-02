Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbeBBNnC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:43:02 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45830 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbeBBNmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:42:54 -0500
X-Google-Smtp-Source: AH8x227qPxvhkcRaeehJnS22n5/rOiof50hKsFNikyNshum2Cn9BM/whNlK/6ItPyRzAxbsn23uZBQ==
Reply-To: minyard@acm.org
Subject: Re: [PATCH arm/aspeed/ast2500 v4 1/2] ipmi: add a KCS IPMI BMC driver
To: "Wang, Haiyue" <haiyue.wang@linux.intel.com>, minyard@acm.org,
        joel@jms.id.au, openbmc@lists.ozlabs.org,
        openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: andriy.shevchenko@intel.com
References: <1517531323-19427-1-git-send-email-haiyue.wang@linux.intel.com>
 <1ec1648a-020c-a6b5-3519-48eece098716@acm.org>
 <a84e8e19-dbd3-786e-b334-28b6202c0f1c@linux.intel.com>
From: Corey Minyard <tcminyard@gmail.com>
Message-ID: <ce0598e6-fcd6-1f53-3412-9cf23c267a58@gmail.com>
Date: Fri, 2 Feb 2018 07:42:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a84e8e19-dbd3-786e-b334-28b6202c0f1c@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2018 07:33 PM, Wang, Haiyue wrote:
>
>
> On 2018-02-02 09:10, Corey Minyard wrote:
>>
>> I loaded this in, tried a compile on x86_64, and got the following:
>>
>> In file included from ../drivers/char/ipmi/kcs_bmc.c:15:0:
>> ../drivers/char/ipmi/kcs_bmc.h: In function ‘kcs_bmc_priv’:
>> ../drivers/char/ipmi/kcs_bmc.h:100:9: warning: return discards 
>> ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
>>   return kcs_bmc->priv;
>>          ^
> -static inline void *kcs_bmc_priv(const struct kcs_bmc *kcs_bmc)
> +static inline void *kcs_bmc_priv(struct kcs_bmc *kcs_bmc)  <-- Can 
> this fix error on x86_64 ?
> {
>     return kcs_bmc->priv;
> }

That, or you can separately alloc the priv data and just make it a 
pointer.  That's more standard, but either way will work.

Where you not getting this warning on your compile?

>> In file included from ../include/linux/printk.h:7:0,
>>                  from ../include/linux/kernel.h:14,
>>                  from ../include/asm-generic/bug.h:18,
>>                  from ../arch/x86/include/asm/bug.h:82,
>>                  from ../include/linux/bug.h:5,
>>                  from ../include/linux/io.h:23,
>>                  from ../drivers/char/ipmi/kcs_bmc.c:7:
>> ../drivers/char/ipmi/kcs_bmc.c: In function ‘kcs_bmc_read’:
>> ../include/linux/kern_levels.h:5:18: warning: format ‘%u’ expects 
>> argument of type ‘unsigned int’, but argument 3 has type ‘size_t {aka 
>> long unsigned int}’ [-Wformat=]
>>  #define KERN_SOH "\001"  /* ASCII Start Of Header */
>>                   ^
>> ../include/linux/kern_levels.h:11:18: note: in expansion of macro 
>> ‘KERN_SOH’
>>  #define KERN_ERR KERN_SOH "3" /* error conditions */
>>                   ^
>> ../include/linux/printk.h:301:9: note: in expansion of macro ‘KERN_ERR’
>>   printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>>          ^
>> ../drivers/char/ipmi/kcs_bmc.c:307:3: note: in expansion of macro 
>> ‘pr_err’
>>    pr_err("channel=%u with too large data : %u\n",
>>    ^
> https://elinux.org/Debugging_by_printing
> However please*note*: always use/%zu/,/%zd/or/%zx/for 
> printing/size_t/and/ssize_t/values. ssize_t and size_t are quite 
> common values in the kernel, so please use the/%z/to avoid annoying 
> compile warnings.
> So I change it from "%u" to "%zu", it is passed on my arm-32 compile, 
> is it OK on your X64 ?

Should be good.

Thanks,

-corey

> pr_err("channel=%u with too large data : %zu\n",
>> In file included from ../drivers/char/ipmi/kcs_bmc_aspeed.c:20:0:
>> ../drivers/char/ipmi/kcs_bmc.h: In function ‘kcs_bmc_priv’:
>> ../drivers/char/ipmi/kcs_bmc.h:100:9: warning: return discards 
>> ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
>>   return kcs_bmc->priv;
>>          ^
>>
>> So that needs to be fixed before it goes in.
>>
>> Also, since you are respinning, can you make ASPEED_KCS_IPMI_BMC 
>> select IPMI_KCS_BMC, like:
>>
>> diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
>> index bc2568a..d34f40e 100644
>> --- a/drivers/char/ipmi/Kconfig
>> +++ b/drivers/char/ipmi/Kconfig
>> @@ -99,16 +99,11 @@ config IPMI_POWEROFF
>>  endif # IPMI_HANDLER
>>
>>  config IPMI_KCS_BMC
>> -       tristate 'IPMI KCS BMC Interface'
>> -       help
>> -         Provides a device driver for the KCS (Keyboard Controller 
>> Style)
>> -         IPMI interface which meets the requirement of the BMC 
>> (Baseboard
>> -         Management Controllers) side for handling the IPMI request 
>> from
>> -         host system software.
>> +       tristate
>>
>>  config ASPEED_KCS_IPMI_BMC
>>         depends on ARCH_ASPEED || COMPILE_TEST
>> -       depends on IPMI_KCS_BMC
>> +       select IPMI_KCS_BMC
>>         select REGMAP_MMIO
>>         tristate "Aspeed KCS IPMI BMC driver"
>>         help
>>
>> It doesn't make much sense to have IPMI_KCS_BMC on its own.  I was 
>> going to do this till I saw the compiler error.
>>
> Got it, will change it to 'select'
>> -corey 
>
