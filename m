Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AH8x224dHDDanMHZsZcqSHs6zWsCoUln1rWE4KJOMhb2Kp5dSyQXLWhItNCZuYJtObuHS64q+cgW
ARC-Seal: i=1; a=rsa-sha256; t=1518475235; cv=none;
        d=google.com; s=arc-20160816;
        b=kdEM9CczcagkZ1c2y0LjE3tvta9j1+yq0a9dP2Y9qxNUy3LKrp4QY0W7/ZTfKI6Zk/
         07Hasktu7/1G6y4YiMWaRnSBvNq3VO5Yhkw+G/xVfKfk86IXgtYSKUBdzpd9zDvutHVK
         wKwa63vjnYVHqElbnqnBbLDum9gVeD4A9DzpgpBuXRPOYTBqkyqvEnYT76UaBhCU2rKZ
         nNTW/dAIoCQQFDzUATRqGu/c9C68NAIH81FcNTSMqJV7VrqupBq3/PteRVcApBzIW27+
         xxC2Hl0XC8YLJeVVjtc4EFZtWqp/giMSM2jzLlAONZZPK9GMS+j8JK/ouWbYyRkUy0JZ
         spLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=NqH1oW7TmuZxMkSMH+IpG5I2j7khv6dEHOpF1MtfK8c=;
        b=JlAeVUhCbZnd6ZO0OVyyeJTW7+pioIhp6zEbzTGsIWne+icgZ+dMBOfBD7x6SfnnWV
         Cx2WeoAEwA75HmyjLrD2vLcI+6CUKqZiSDbaLL+IFVCxrl2PYeV+FKzMXG294QnjSozd
         RWMESTdHKpZaIv5oP4JJneE9jgL8kwKotY530uxk7v4JT7jfVoHTArqM+MtDRZ1cPV32
         ayR4C6ofSIkld3+e/r5AxpUJooZS27TxWZfS/leOVujfQUGjnl6nxI8IdzWxQ5mOJy++
         Mduf/CI/0rDMWAk1luVKtxAJrmKe2lZ/VsKYO4omYhevH+zQkrQT31WrN8NmgmEViNpg
         4z7A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=ePcOmZk1;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=kBUi2bne;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=ePcOmZk1;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=kBUi2bne;
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
 linuxppc-dev@lists.ozlabs.org
References: <a4629db7-194d-3c7c-c8fd-24f61b220a70@infradead.org>
 <87zi4ev1d2.fsf@concordia.ellerman.id.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2b44ef68-126a-b20a-a50f-48c337fa6d0b@infradead.org>
Date: Mon, 12 Feb 2018 13:16:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87zi4ev1d2.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592178829884506725?=
X-GMAIL-MSGID: =?utf-8?q?1592236687942632305?=
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
> Full results trickling in here, not all the failures there are caused by
> this patch, ie. some configs are broken in mainline:
> 
>   http://kisskb.ellerman.id.au/kisskb/head/13396/

That's very useful, thanks.

I'll send a few patches for those.

-- 
~Randy
