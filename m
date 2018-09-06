Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260DDC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C937B20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Bb9Ryl5a";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Itmqqe9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C937B20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbeIFWnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:43:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42198 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbeIFWnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:43:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A2BA060807; Thu,  6 Sep 2018 18:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536257185;
        bh=vRGsnx+5Dj+Q+CMzHudpgn2popksQdt1olO5Dpo7DQk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Bb9Ryl5aoWN05J/luCN5Fdj9jaJlxyh2cZQ/3ezsSkzzYNxV/uzEd6+9JwuUvNqC+
         rtze4Eu3fudmHabRXC0sMq8h5tcZWL+JzfTv1oPqR1RSIKyha8j+GItn5Ff+OwFth7
         UH9GZfu/cgJa23b3tJJJyOhpA+LJpHXg1YJCNK5o=
Received: from [192.168.1.102] (unknown [157.49.165.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 24DB86024C;
        Thu,  6 Sep 2018 18:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536257183;
        bh=vRGsnx+5Dj+Q+CMzHudpgn2popksQdt1olO5Dpo7DQk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Itmqqe9DPdQYudj3THow3vV6eY6fGQQqAhyJ/exxt1Pxh3k68Whu4mA2zht0zYJbE
         +tN3OxUmPeb1DzQWfle3qIZckw7uVmDS00LFh5n2O0KycebR9Twt9Vc9vHGvDHYda/
         Bkn4Eos6NteUDg/cipBm2Rp3mWH5MfEqEIeYYUxc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24DB86024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [RFC PATCH v2 3/3] dynamic_debug: Add support for dynamic
 register trace
To:     Will Deacon <will.deacon@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
References: <cover.1535119710.git.saiprakash.ranjan@codeaurora.org>
 <9015a7a4aafa9935be769c07918743df63d6f648.1535119711.git.saiprakash.ranjan@codeaurora.org>
 <20180906100523.GE3592@arm.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <0b96bfa0-f577-f72f-7c88-ac2e7ac3a189@codeaurora.org>
Date:   Thu, 6 Sep 2018 23:36:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906100523.GE3592@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/2018 3:35 PM, Will Deacon wrote:
> On Fri, Aug 24, 2018 at 08:15:27PM +0530, Sai Prakash Ranjan wrote:
>> Introduce dynamic debug filtering mechanism to register
>> tracing as dynamic_rtb() which will reduce a lot of
>> overhead otherwise of tracing all the register reads/writes
>> in all files.
>>
>> Now we can just specify the file name or any wildcard pattern
>> as any other dynamic debug facility in bootargs and dynamic rtb
>> will just trace them and the output can be seen in pstore.
>>
>> TODO: Now we use same 'p' flag but will add a separate flag for register trace
>> later.
>>
>> Also add asm-generic/io-instrumented.h file for instrumentation of IO
>> operations such as read/write{b,w,l,q} as per Will's suggestion to not touch
>> arch code and let core generate instrumentation.
>> This can be extended to arm as well later for tracing.
>>
>> Example for tracing all register reads/writes in drivers/soc/qcom/* below:
>>
>>    # dyndbg="file drivers/soc/qcom/* +p" in bootargs
>>    # reboot -f
>>    # mount -t pstore pstore /sys/fs/pstore
>>    # cat /sys/fs/pstore/rtb-ramoops-0
>>      [LOGK_WRITE] ts:1373030419  data:ffff00000d5065a4  <ffff00000867cb44>  qcom_smsm_probe+0x51c/0x668
>>      [LOGK_WRITE] ts:1373360576  data:ffff00000d506608  <ffff00000867cb44>  qcom_smsm_probe+0x51c/0x668
>>
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> ---
>>   arch/arm64/include/asm/io.h           | 26 +++++++++-------------
>>   include/asm-generic/io-instrumented.h | 32 +++++++++++++++++++++++++++
>>   include/linux/dynamic_debug.h         | 13 +++++++++++
>>   kernel/trace/Kconfig                  |  1 +
>>   4 files changed, 56 insertions(+), 16 deletions(-)
>>   create mode 100644 include/asm-generic/io-instrumented.h
>>
>> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
>> index 35b2e50f17fb..aafd4b0be9f0 100644
>> --- a/arch/arm64/include/asm/io.h
>> +++ b/arch/arm64/include/asm/io.h
> 
> The arm64 bits look fine to me, but please can you split them into a
> separate patch?
> 

Thanks for the review. Sure, I will split them into separate patch in 
next post. I have got the tracepoints working now as Steven suggested, 
will upload them soon.

>> diff --git a/include/asm-generic/io-instrumented.h b/include/asm-generic/io-instrumented.h
>> new file mode 100644
>> index 000000000000..ce273742b98c
>> --- /dev/null
>> +++ b/include/asm-generic/io-instrumented.h
>> @@ -0,0 +1,32 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef _ASM_GENERIC_IO_INSTRUMENTED_H
>> +#define _ASM_GENERIC_IO_INSTRUMENTED_H
>> +
>> +#include <linux/dynamic_debug.h>
>> +
>> +#define __raw_write(v, a, _t) ({			\
>> +	volatile void __iomem *_a = (a);		\
> 
> Does this actually need to be volatile?
> 

To avoid 100's of compilation warnings like below. Also wanted the 
parameters of functions like "iowrite32" to be passed to 
arch_raw_{read,write}() as is.

./include/asm-generic/io.h: In function ‘iowrite32’:
./include/asm-generic/io-instrumented.h:8:21: warning: initialization 
discards ‘volatile’ qualifier from pointer target type 
[-Wdiscarded-qualifiers]
   void __iomem *_a = (a);    \
                      ^
./include/asm-generic/io-instrumented.h:15:28: note: in expansion of 
macro ‘__raw_write’
  #define __raw_writel(v, a) __raw_write((v), a, l)
                             ^~~~~~~~~~~
./arch/arm64/include/asm/io.h:118:36: note: in expansion of macro 
‘__raw_writel’
  #define writel_relaxed(v,c) ((void)__raw_writel((__force 
u32)cpu_to_le32(v),(c)))
                                     ^~~~~~~~~~~~
./arch/arm64/include/asm/io.h:133:36: note: in expansion of macro 
‘writel_relaxed’
  #define writel(v,c)  ({ __iowmb(); writel_relaxed((v),(c)); })
                                     ^~~~~~~~~~~~~~
./include/asm-generic/io.h:745:2: note: in expansion of macro ‘writel’
   writel(value, addr);
   ^~~~~~

>> +	dynamic_rtb("LOGK_WRITE", (void __force *)(_a));\
>> +	arch_raw_write##_t((v), _a);			\
>> +	})
>> +
>> +#define __raw_writeb(v, a)	__raw_write((v), a, b)
>> +#define __raw_writew(v, a)	__raw_write((v), a, w)
>> +#define __raw_writel(v, a)	__raw_write((v), a, l)
>> +#define __raw_writeq(v, a)	__raw_write((v), a, q)
>> +
>> +#define __raw_read(a, _l, _t)    ({					\
>> +	_t __a;								\
>> +	const volatile void __iomem *_a = (const volatile void __iomem *)(a);\
> 
> Again, can't this just be void __iomem * ?
> 

Same as above.

>> +	dynamic_rtb("LOGK_READ", (void __force *)(_a));			\
>> +	__a = arch_raw_read##_l(_a);					\
>> +	__a;								\
>> +	})
>> +
>> +#define __raw_readb(a)	__raw_read((a), b, u8)
>> +#define __raw_readw(a)	__raw_read((a), w, u16)
>> +#define __raw_readl(a)	__raw_read((a), l, u32)
>> +#define __raw_readq(a)	__raw_read((a), q, u64)
> 
> I find the way you've defined the __raw_{read,write} macros quite confusing.
> They both have an _t parameter, but it's totally unrelated between the two!
> 
Sorry for the confusion, I will fix it and have _l for both 
_raw_{read,write}.

Thanks,
Sai Prakash
