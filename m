Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525851392; cv=none;
        d=google.com; s=arc-20160816;
        b=H6oiBsFMbvnjUtKT1HH4o7AXvrCWTfE8cYJw50wMvPA0aPmOEJjOU/tNnsjvfAcDir
         DA0IAlbekTFGwTiM136Cc6ycBNJeRnN3bhqoOSfA6UfKjEJcc5+hrX+BBx1Yb27rER1k
         g7ddwhz8qo8PGtz4xECM9xVtGE22m5Sgwlsubex5J3Hcc9/lyAlVqAwmjqf7CnO3WAuo
         WGTNJZBcMVIaZ2LshwGZhDktiPuTXjnpmkJgUbv+ZwNnX5IhQ8/cgrm1ZN08K6St0LB4
         dZTiMkvrbnoBKifdAIVSgBQKcrVqk7A8lXgeahDLAUKj1Gp/p2A/ZR7QUvJE6YTq81Rx
         1EYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :arc-authentication-results;
        bh=SCovB25dLQ2lz/kLr1tMXI4L7SBybbsWJiiQ+IySEX0=;
        b=HZMbrn7RrofBjdvHHGOvbgug3cF9MQfll4KLNeLWICyjkw/BiCTaKjmd+xFbFdvKmG
         af6JgSWmKoomgXRql1xJT4ZGRtVAU3fRrcccWHnkesog7gHVeA2JtoOm/dpqLJTr6A30
         LIbsqEc8uRRn9Mg48nnzn6aWU2nczPJc/l5CoW8SJyfV18KQ4nLY74VKAeZvPh7WLpuR
         gpWpRuijUpnMML3tGA34TK5fAXTqF1l8786O+XoCIaaZm36iLgCEPeR7i5QJwaIXDwrt
         /6pXfaOGvuw+djwzeQFv+a3uI5vpRE86AXZNUJDyxv/WNqLWIScmUBIfSSVuALqiAZuM
         wHVA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AB8JxZpmMYmS3JPxeh9XQil9Vy36mPmcgwwMdXn6Bb+c+bEf/Ij/GMzO5XZMT8z25xB2fBUt0kUiQw==
Subject: Re: Bug in vboxguest: After commit Merge tag 'char-misc-4.17-rc3'
To: gregkh@linuxfoundation.org, arnd@arndb.de, linux-kernel@vger.kernel.org
References: <20180502193735.GA2444@zrhn9910b>
 <20180502200615.GB16341@kroah.com> <20180502204612.GA2089@zrhn9910b>
 <c589f2f9-e8e3-7f54-e1ab-9ac3baf700bf@redhat.com>
 <20180508194135.GA27020@zrhn9910b>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <cbf215d0-b193-16fd-cfb7-b6cbf4dc6a74@redhat.com>
Date: Wed, 9 May 2018 09:36:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508194135.GA27020@zrhn9910b>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599382342256929089?=
X-GMAIL-MSGID: =?utf-8?q?1599971149647236584?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 08-05-18 21:41, damian wrote:
> On Tue, 08. May 13:42, Hans de Goede wrote:
>> Hi Damian,
>>
>> On 02-05-18 22:46, damian wrote:
>>> Hello Greg,
>>>
>>> it is PATCH 3 virt: vbox: Use __get_free_pages insteas of kmalloc for DMA32 memory.
>>
>> Thank you for the bug report, I've tried to reproduce this problem
>> but for me everything works fine.
>>
>> Does your virtual-machine have more then 4G of RAM configured for its
>> use?  If yes then what is likely happening is that you also have
>> the out-of-tree version of the vboxguest modules installed and prior
>> to the commit in question the out of tree version of the driver is
>> loading, because before that commit the vboxguest driver in the
>> mainline kernel fails to load on machines with more then 4G.
>>
>> Or alternatively before the commit in question you may not have
>> any version of the vboxguest driver loaded.
>>
>> Using the upstream version of the driver should not make a noticeable
>> difference, but before the vboxguest driver became a part of the
>> mainline kernel the virtualbox upstream developers have done a
>> cleanup / redesign of the userspace API of the vboxguest driver,
>> so the vboxguest driver will only work with recent virtualbox-guest-additions
>> and since you are using Ubuntu 16.04 chances are that you are
>> using that with Ubuntu's quite old bundled virtualbox-guest-additions
>> which will not work with the new driver and may be causing this
>> issue.
>>
>> Can you try upgrading your virtualbox-guest-additions to 5.2.10
>> please?
>>
>> Also if the above does not help, a couple of follow up
>> questions to help this pin down further:
>>
>> 1) Are you using vbox's 3d pass through functionality
>> 2) Which desktop-environment are you using?
>>
>> Regards,
>>
>> Hans
> 
> Hi Hans,
> 
> i will check my configutation and will come back
> At the moment i dont use use the virtualbox-guest-additions, i use the driver from the staging area.

Ah I see, you may still have the Ubuntu pkg for them installed though,
which may be an old version which actually starts to try and do stuff
now that there is a vboxguest driver in mainline too, but that old
version does not support the new, stable API as merged into the
mainline.

So if you don't care about the add-ons instead of upgrading yopu
can also remove the Ubuntu pkg for them.

Regards,

Hans
