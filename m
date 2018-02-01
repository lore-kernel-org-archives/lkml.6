Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751699AbeBAXew (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 18:34:52 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:35164 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbeBAXeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 18:34:44 -0500
X-Google-Smtp-Source: AH8x22418Gg8iK+kXSSxk19mHbPdk6tkCHjVTztNIsOu1bBlYJWRWRZSwFP+fro7sg6AmtrxDdAR/Q==
Subject: Re: [RFC PATCH] rootfs: force mounting rootfs as tmpfs
To: Taras Kondratiuk <takondra@cisco.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: initramfs <initramfs@vger.kernel.org>,
        Victor Kamensky <kamensky@cisco.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1517348777.3469.5.camel@linux.vnet.ibm.com>
 <1814af5c-170d-39c0-58fd-02eb7216e008@landley.net>
 <1517436423.3469.237.camel@linux.vnet.ibm.com>
 <a538e55c-81ca-6d59-20cf-21b47387c3e2@landley.net>
 <20180201020331.GA3774@rani.riverdale>
 <1517458921.3329.2.camel@linux.vnet.ibm.com>
 <f9112881-772c-2568-ebfa-d2ca807124e9@landley.net>
 <1517500500.3974.45.camel@linux.vnet.ibm.com>
 <875e5d2d-9ffe-14ab-090a-4a9632af0f35@landley.net>
 <1517521912.3619.0.camel@linux.vnet.ibm.com>
 <151752488608.10051.146219644323454814@takondra-t460s>
From: Rob Landley <rob@landley.net>
Message-ID: <8d6b1fcc-1a21-1707-dd8e-43529e1d644c@landley.net>
Date: Thu, 1 Feb 2018 17:34:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <151752488608.10051.146219644323454814@takondra-t460s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/01/2018 04:41 PM, Taras Kondratiuk wrote:
> Quoting Mimi Zohar (2018-02-01 13:51:52)
>> On Thu, 2018-02-01 at 11:09 -0600, Rob Landley wrote:
>>> On 02/01/2018 09:55 AM, Mimi Zohar wrote:
>>>> On Thu, 2018-02-01 at 09:20 -0600, Rob Landley wrote:
>>>>
>>>>>> With your patch and specifying "root=tmpfs", dracut is complaining:
>>>>>>
>>>>>> dracut: FATAL: Don't know how to handle 'root=tmpfs'
>>>>>> dracut: refusing to continue
>>>>>
>>>>> [googles]... I do not understand why this package exists.
>>>>>
>>>>> If you're switching to another root filesystem, using a tool that
>>>>> wikipedia[citation needed] says has no purpose but to switch to another
>>>>> root filesystem, (so let's reproduce the kernel infrastructure in
>>>>> userspace while leaving it the kernel too)... why do you need initramfs
>>>>> to be tmpfs? You're using it for half a second, then discarding it,
>>>>> what's the point of it being tmpfs?
>>>>
>>>> Unlike the kernel image which is signed by the distros, the initramfs
>>>> doesn't come signed, because it is built on the target system.  Even
>>>> if the initramfs did come signed, it is beneficial to measure and
>>>> appraise the individual files in the initramfs.
>>>
>>> You can still shoot yourself in the foot with tmpfs. People mount a /run
>>> and a /tmp and then as a normal user you can go
>>> https://twitter.com/landley/status/959103235305951233 and maybe the
>>> default should be a little more clever there...
>>>
>>> I'll throw it on the todo heap. :)
>>>
>>>>> Sigh. If people are ok with having rootfs just be tmpfs whenever tmpfs
>>>>> is configured in, even when you're then going to overmount it with
>>>>> something else like you're doing, let's just _remove_ the test. If it
>>>>> can be tmpfs, have it be tmpfs.
>>>>
>>>> Very much appreciated!
>>>
>>> Not yet tested, but something like the attached? (Sorry for the
>>> half-finished doc changes in there, I'm at work and have a 5 minute
>>> break. I can test properly this evening if you don't get to it...)
>>
>> Yes, rootfs is being mounted as tmpfs.
> 
> I don't think you can unconditionally replace ramfs with initramfs by
> default. Their behavior is different in some cases (e.g. pivot_root vs
> switch_root)

Both are switch_root, you can't pivot_root off of either one. (Yes, I
hit that bug and reported it, and they fixed it, back in the day...
http://lists.busybox.net/pipermail/busybox/2006-March/053529.html )

> and it can break many systems that expect ramfs by default.

The use case I told Mimi about off-list (since they stopped cc:ing the
list in one of their replies but the conversation continued) was the guy
who was extracting an initramfs bigger than 50% of system memory, which
worked with initramfs but failed with initmpfs. A quick google didn't
find the original message but it resulted in this blog entry from the
affected party:

http://www.lightofdawn.org/blog/?viewDetailed=00128

I.E. yeah, I know, I need to redo these patches tonight.

Rob
