Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AH8x2251KY2UZ+VuyeuxxoAVe9sbviuTBBrluTJoF1QXVtQ6Ym3r7bAGKvFbFOiRfKP8tKcQ5+j7
ARC-Seal: i=1; a=rsa-sha256; t=1518544275; cv=none;
        d=google.com; s=arc-20160816;
        b=IBFP3y4JVvHVxHCFDVYytXDQ7VnI1eLWDnzpI9zBuyhdzCL45wYhnGi4YqAzGPsTUj
         6o/kbwsv7pZb6b0CERnsbBRfBzoNcSyqCC8fR/rVncLqhT/FkSWjjKzFti3OFWVOP2/5
         KbvptCDK/zuH3C1aBENgxWZFSrm5ePAG7aIGNn1Q4nq+sc9x4UfEEYlGO84Zv1euZndY
         8gY0UNwbWvJ9Zj5+lLJ1LEiEDAwnFo2frMyg+284f/encTfKWjm5L4kA2qLHMMxXu8xH
         96nRMhZFqwwl7IrJTgZf+DKHiV+rX2Jq5wg/SEoJAZlqAfiIDGnXWrdL3ytcu0Ti5LXd
         HNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=6MujbapIlRQXb+EumgLtwiIRBFr/0fFBeM6vXo5F4A0=;
        b=tpIBmCWwpR+SFOfQxhP7YHahzqIXWqGgnJXU0jUrWeLbxYqh/HdDef4/sJLGG3wvbN
         JGxeWdFdP1Eqf8u8dpVjEPtGtoG8x1BhkbD7Uq8NF797uWW5N/yaw2DbYG37s5HVRmyY
         NBpqLwr2OlPHQ7glXp1mmVrdJaU0JwKSq0zX9bPXDGzSGC5eVEeT8elx2czVbPNmWZHH
         kaLbWqLgmYv6qCsi7DMJNkvoDlZCMSOBDhf6Hnyw2OV4jGk3W+hU6iQbD5krJDpUtElj
         Vt8Fqn93PD0s5ZUttSGBY2UCu5ddCe3FY5f0AfsnNtNP8q9P2N2pX5AIFq9T/sG/c+Xb
         hsXw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=jebXVubQ;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=jebXVubQ;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
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
 <f119a273-2e86-1b7f-346f-7627ad8b51ed@infradead.org>
 <87fu652oce.fsf@concordia.ellerman.id.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1f96a3c7-0bb3-6c06-0b44-ca47e5a5d127@infradead.org>
Date: Tue, 13 Feb 2018 09:51:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87fu652oce.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592178829884506725?=
X-GMAIL-MSGID: =?utf-8?q?1592309082644394739?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/13/2018 02:09 AM, Michael Ellerman wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> On 02/12/2018 04:28 AM, Michael Ellerman wrote:
>>> Randy Dunlap <rdunlap@infradead.org> writes:
>>>
>>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>>
>>>> Currently <linux/slab.h> #includes <linux/kmemleak.h> for no obvious
>>>> reason. It looks like it's only a convenience, so remove kmemleak.h
>>>> from slab.h and add <linux/kmemleak.h> to any users of kmemleak_*
>>>> that don't already #include it.
>>>> Also remove <linux/kmemleak.h> from source files that do not use it.
>>>>
>>>> This is tested on i386 allmodconfig and x86_64 allmodconfig. It
>>>> would be good to run it through the 0day bot for other $ARCHes.
>>>> I have neither the horsepower nor the storage space for the other
>>>> $ARCHes.
>>>>
>>>> [slab.h is the second most used header file after module.h; kernel.h
>>>> is right there with slab.h. There could be some minor error in the
>>>> counting due to some #includes having comments after them and I
>>>> didn't combine all of those.]
>>>>
>>>> This is Lingchi patch #1 (death by a thousand cuts, applied to kernel
>>>> header files).
>>>>
>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>
>>> I threw it at a random selection of configs and so far the only failures
>>> I'm seeing are:
>>>
>>>   lib/test_firmware.c:134:2: error: implicit declaration of function 'vfree' [-Werror=implicit-function-declaration]                                                                                                          
>>>   lib/test_firmware.c:620:25: error: implicit declaration of function 'vzalloc' [-Werror=implicit-function-declaration]
>>>   lib/test_firmware.c:620:2: error: implicit declaration of function 'vzalloc' [-Werror=implicit-function-declaration]
>>>   security/integrity/digsig.c:146:2: error: implicit declaration of function 'vfree' [-Werror=implicit-function-declaration]
>>
>> Both of those source files need to #include <linux/vmalloc.h>.
> 
> Yep, I added those and rebuilt. I don't see any more failures that look
> related to your patch.

Great, thanks.

I also sent patches for both of those.

>   http://kisskb.ellerman.id.au/kisskb/head/13399/
> 
> 
> I haven't gone through the defconfigs I have enabled for a while, so
> it's possible I have some missing but it's still a reasonable cross
> section.


-- 
~Randy
