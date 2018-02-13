Return-Path: <mpe@ellerman.id.au>
X-Google-Smtp-Source: AH8x227QVxClo7AhKQ5tR4T55AcUG7qMsGm60PPFy2ra/tZGlbUW7J1hdc4kwTBNLfFRsDK/9RWb
ARC-Seal: i=1; a=rsa-sha256; t=1518516551; cv=none;
        d=google.com; s=arc-20160816;
        b=iEqXWck5nNhEJ52Yg+SgN/AeNhP708nI/MX7usimVvbjcFQz7OJU7adtN6iQn/y/sz
         rtVsnMDexsHRbRoMlVvYiQRkakzD5ZijTKZqVmxPvxOfqwotYLlxXgKou1oRSrXsrA0Y
         PnygIfJtHKpDsPFA5k0qEhuJEMLeQHDuhc9rHxmyxMruNyk3RU2kxAkBgaXSoJK0z9lE
         zFpvB6QsSMIIAQJg7cBZNLHx9Mj2xANL1x8/vfWzqBByN+ryclh2afw28tiI+06KAy6K
         9k+NJ5k6zg5hZPzF69AtHjabaqCIJ4Zs/nmlFkf/Hdmgp+xuWEDoHjFRNDo9FTTP825h
         Aikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:arc-authentication-results;
        bh=k2ar0ptWv3hj+e/C7OuzfRDVrVTzlPSX66b0SBAp868=;
        b=V2ubwctYx6vQy38K4KD+akrPK1TOgnTDZFYDkSLnA1B+jYxmWSJAsljyKXhz7NPkiZ
         ZjN7dRRufXdhtx+jzVOOJxwCbuQvXGbOeZ7HhsZFmvQTxts0Nxe3lB+NDCiiaFZBZAZH
         RYjH+cOAR7jB4aeemhMtNFHtLVCuUudI+W6op6kDFI1i8lc1HYn/YL7N7OQ7niH2lU+f
         b9A6PnzTGTjewksQRPfJ2Ew1WLkN/GZkBUPK68dMmr6AsQXCrbnOFaSxwDove2qLTn+q
         x3f6m+8yhO176c0/xXhsbrlp9tfKJRvPy4YfAy/ErTor0SVKsy5OXhETFeLGnEXAkt8q
         /YTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2401:3900:2:1::2 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2401:3900:2:1::2 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Fengguang Wu <fengguang.wu@intel.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, John Johansen <john.johansen@canonical.com>, "netdev\@vger.kernel.org" <netdev@vger.kernel.org>, X86 ML <x86@kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Dmitry Kasatkin <dmitry.kasatkin@intel.com>
Subject: Re: [PATCH] headers: untangle kmemleak.h from mm.h
In-Reply-To: <f119a273-2e86-1b7f-346f-7627ad8b51ed@infradead.org>
References: <a4629db7-194d-3c7c-c8fd-24f61b220a70@infradead.org> <87zi4ev1d2.fsf@concordia.ellerman.id.au> <f119a273-2e86-1b7f-346f-7627ad8b51ed@infradead.org>
Date: Tue, 13 Feb 2018 21:09:05 +1100
Message-ID: <87fu652oce.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592178829884506725?=
X-GMAIL-MSGID: =?utf-8?q?1592280011929838081?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Randy Dunlap <rdunlap@infradead.org> writes:

> On 02/12/2018 04:28 AM, Michael Ellerman wrote:
>> Randy Dunlap <rdunlap@infradead.org> writes:
>> 
>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>
>>> Currently <linux/slab.h> #includes <linux/kmemleak.h> for no obvious
>>> reason. It looks like it's only a convenience, so remove kmemleak.h
>>> from slab.h and add <linux/kmemleak.h> to any users of kmemleak_*
>>> that don't already #include it.
>>> Also remove <linux/kmemleak.h> from source files that do not use it.
>>>
>>> This is tested on i386 allmodconfig and x86_64 allmodconfig. It
>>> would be good to run it through the 0day bot for other $ARCHes.
>>> I have neither the horsepower nor the storage space for the other
>>> $ARCHes.
>>>
>>> [slab.h is the second most used header file after module.h; kernel.h
>>> is right there with slab.h. There could be some minor error in the
>>> counting due to some #includes having comments after them and I
>>> didn't combine all of those.]
>>>
>>> This is Lingchi patch #1 (death by a thousand cuts, applied to kernel
>>> header files).
>>>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> 
>> I threw it at a random selection of configs and so far the only failures
>> I'm seeing are:
>> 
>>   lib/test_firmware.c:134:2: error: implicit declaration of function 'vfree' [-Werror=implicit-function-declaration]                                                                                                          
>>   lib/test_firmware.c:620:25: error: implicit declaration of function 'vzalloc' [-Werror=implicit-function-declaration]
>>   lib/test_firmware.c:620:2: error: implicit declaration of function 'vzalloc' [-Werror=implicit-function-declaration]
>>   security/integrity/digsig.c:146:2: error: implicit declaration of function 'vfree' [-Werror=implicit-function-declaration]
>
> Both of those source files need to #include <linux/vmalloc.h>.

Yep, I added those and rebuilt. I don't see any more failures that look
related to your patch.

  http://kisskb.ellerman.id.au/kisskb/head/13399/


I haven't gone through the defconfigs I have enabled for a while, so
it's possible I have some missing but it's still a reasonable cross
section.

cheers
