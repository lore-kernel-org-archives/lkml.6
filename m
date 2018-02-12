Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AH8x226ySvqgwiX/FiNMexV8UuD0Mmf7NWM8Mg7POewEg24RbfvUFZhs/recQnOV2ptEqinLg/uk
ARC-Seal: i=1; a=rsa-sha256; t=1518464488; cv=none;
        d=google.com; s=arc-20160816;
        b=i504JxtLR1jt+WqHa1bGIqRnjgu/C5gl3Gb0AJwYl6qUQ/j6qe+AbMxdj05N80ftpl
         4n+z/Hg8WuBEW8aic/uK07WurLhaTlXzySoaBy3tsaqPJ62CpngjAgGT/uA2lz1RUw2L
         qYtiBYKGZ1EyyMQHbXFTb+5rzCgCBpquY9ApDzN6unEvDxEczcvwG0/V8PS4LNxheOdn
         O5v0AynhQbl5MU4WelVtbvxWkBKjb3pmEeNYlqGLgmWwgUJ3nw4p+oTmfxPZzGzgdgUF
         wLK0Gy0epzXwmg1/0PJGUxcyAS7tGAIDXuQb3jqwYMuTW5zA6IPFFTe+6TDpngqa53y0
         FfLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=8ddCeT2CaxziEhNbYFFiDVMA4IR8IJ//X0nIbXz3DHs=;
        b=PYDGcAD+edwp1qmJyFlVHaV3qhLHFNDrmNKKra89CcStrXVFvZRyJqbmrRN/w2Bs0a
         JYI8hbo2NZ/P7iwD55W68XEaJWzJTTikm7/akefp371x9LnNswIMyKPbV8b4my//Yje0
         vkTce0kBgDQCSlef+CnbJn6AQxvejDS1RbVgPU7xPhV5Ns1KLeKE8mCuEvyvMt6X0FfR
         Ky5vXeofP4uDNqAIhVwQ3b4/KM2veNCE9b7QIUt5xqSJANEFXZqMtfUzFVqYocgW2CQp
         nO0UD/+RfeB0g4zVOHzyG8Xcnaq9rW6oGFv9HqGNkw0Wbn732n9bCd6o1w/8P8xB0DIo
         Ggeg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=o5nFBx3B;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=o5nFBx3B;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH] headers: untangle kmemleak.h from mm.h
To: Michael Ellerman <mpe@ellerman.id.au>, LKML
 <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Fengguang Wu <fengguang.wu@intel.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>,
 John Johansen <john.johansen@canonical.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, X86 ML <x86@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Dmitry Kasatkin <dmitry.kasatkin@intel.com>
References: <a4629db7-194d-3c7c-c8fd-24f61b220a70@infradead.org>
 <87zi4ev1d2.fsf@concordia.ellerman.id.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f119a273-2e86-1b7f-346f-7627ad8b51ed@infradead.org>
Date: Mon, 12 Feb 2018 11:40:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87zi4ev1d2.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592178829884506725?=
X-GMAIL-MSGID: =?utf-8?q?1592225419562180222?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/12/2018 04:28 AM, Michael Ellerman wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Currently <linux/slab.h> #includes <linux/kmemleak.h> for no obvious
>> reason. It looks like it's only a convenience, so remove kmemleak.h
>> from slab.h and add <linux/kmemleak.h> to any users of kmemleak_*
>> that don't already #include it.
>> Also remove <linux/kmemleak.h> from source files that do not use it.
>>
>> This is tested on i386 allmodconfig and x86_64 allmodconfig. It
>> would be good to run it through the 0day bot for other $ARCHes.
>> I have neither the horsepower nor the storage space for the other
>> $ARCHes.
>>
>> [slab.h is the second most used header file after module.h; kernel.h
>> is right there with slab.h. There could be some minor error in the
>> counting due to some #includes having comments after them and I
>> didn't combine all of those.]
>>
>> This is Lingchi patch #1 (death by a thousand cuts, applied to kernel
>> header files).
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> I threw it at a random selection of configs and so far the only failures
> I'm seeing are:
> 
>   lib/test_firmware.c:134:2: error: implicit declaration of function 'vfree' [-Werror=implicit-function-declaration]                                                                                                          
>   lib/test_firmware.c:620:25: error: implicit declaration of function 'vzalloc' [-Werror=implicit-function-declaration]
>   lib/test_firmware.c:620:2: error: implicit declaration of function 'vzalloc' [-Werror=implicit-function-declaration]
>   security/integrity/digsig.c:146:2: error: implicit declaration of function 'vfree' [-Werror=implicit-function-declaration]
> 

Both of those source files need to #include <linux/vmalloc.h>.

> Full results trickling in here, not all the failures there are caused by
> this patch, ie. some configs are broken in mainline:
> 
>   http://kisskb.ellerman.id.au/kisskb/head/13396/
> 
> cheers

:)

-- 
~Randy
