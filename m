Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78335C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B54D2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfBSUnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:43:55 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33027 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbfBSUnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:43:55 -0500
Received: by mail-qt1-f195.google.com with SMTP id z39so24868219qtz.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 12:43:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G1HWNYsD3Z3OiVO9yKc0w6x7BZ/+lbWGySu9GnLUQ4U=;
        b=K9sQgUFKGaxVOA+2WEdrO6ao1KXk3U8ZHMWUpeYao0iUGCjxnKij/QibJXjVwqJaVs
         iJDYE5ryO+ZqXqJJQ8p8M8sWozdfbNqUoUgIj1cd2cuKpYwAvnXMhxQ7Hvq3SdXyZGTE
         xf0/ZnONy2VDvEhiaV8+SKzmafm3lbXDHW9qAVPXuCFm/18mOHeb9rweL9KXKQW2oqbt
         bMNEHC3+OS6/9y7mj6jIrg+Cszyik3MOAhHU2ksrCIvbV/cIJJXK0gWX4cGUwKxb7cZm
         SzoUKEenfPhjIb/CtRMrxYov9TovS7SsICkepfZAL2syzwEu/jNtMe0msHqag/qa3yAP
         S90w==
X-Gm-Message-State: AHQUAuYdERXE2XbgMMDiH/jZzWRqG1x0LPVKxTasNjN5ksJuElV3tfdT
        UBAyWmcYb7KCWY6uZYiXv1v0Hg==
X-Google-Smtp-Source: AHgI3IY8VuBjpwZcHg8hisQZ/dYCBRhpPFLrjN0IUBFMQjKxBhvLZBKdBaE5a5Y1NJGkrk0mt7wwDA==
X-Received: by 2002:ac8:28f1:: with SMTP id j46mr23641165qtj.133.1550609030569;
        Tue, 19 Feb 2019 12:43:50 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::112f? ([2601:602:9800:dae6::112f])
        by smtp.gmail.com with ESMTPSA id t20sm2387713qtb.58.2019.02.19.12.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 12:43:49 -0800 (PST)
Subject: Re: [PATCH v2] staging: android: ion: Allocate from heap ID directly
 without mask
To:     John Stultz <john.stultz@linaro.org>,
        Brian Starkey <Brian.Starkey@arm.com>
Cc:     "Andrew F. Davis" <afd@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Christoph Hellwig <hch@infradead.org>,
        Liam Mark <lmark@codeaurora.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>
References: <20190128214408.25442-1-afd@ti.com>
 <CALAqxLXb53nsBJtb958sMzpr-fnXxqFE0s2B6YJzoGcswv50wg@mail.gmail.com>
 <20190215105057.jujgm4k77rhkvmo7@DESKTOP-E1NTVVP.localdomain>
 <CALAqxLU=L3Y7KJEo9c-Nu1rS3EquofGf1UGWBWqAO+Qke72Ekw@mail.gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <17a3ed06-a46f-75c6-323c-3f486788a3b3@redhat.com>
Date:   Tue, 19 Feb 2019 12:43:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLU=L3Y7KJEo9c-Nu1rS3EquofGf1UGWBWqAO+Qke72Ekw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/19 11:01 AM, John Stultz wrote:
> On Fri, Feb 15, 2019 at 2:51 AM Brian Starkey <Brian.Starkey@arm.com> wrote:
>>
>> Hi John,
>>
>> On Thu, Feb 14, 2019 at 09:38:29AM -0800, John Stultz wrote:
>>>
>> [snip]
>>
>>> Some thoughts, as this ABI break has the potential to be pretty painful.
>>>
>>> 1) Unfortunately, this ABI is exposed *through* libion via
>>> ion_alloc/ion_alloc_fd out to gralloc implementations. Which means it
>>> will have a wider impact to vendor userland code.
>>
>> I figured libion could fairly easily loop through all the set bits in
>> heap_mask and call the ioctl for each until it succeeds. That
>> preserves the old behaviour from the libion clients' perspective.
> 
> Potentially, though that implicitly still caps the heaps to 32.  So
> I'm not sure what the net benefit would be.
> 
> 
>>> 2) For patches that cause ABI breaks, it might be good to make it
>>> clear in the commit what the userland impact looks like in userspace,
>>> possibly with an example, so the poor folks who bisect down the change
>>> as breaking their system in a year or so have a clear example as to
>>> what they need to change in their code.
>>>
>>> 3) Also, its not clear how a given userland should distinguish between
>>> the different ABIs.  We already have logic in libion to distinguish
>>> between pre-4.12 legacy and post-4.12 implementations (using implicit
>>> ion_free() behavior). I don't see any such check we can make with this
>>> code. Adding another ABI version may require we provide an actual
>>> interface version ioctl.
>>>
>>
>> A slightly fragile/ugly approach might be to attempt a small
>> allocation with a heap_mask of 0xffffffff. On an "old" implementation,
>> you'd expect that to succeed, whereas it would/could be made to fail
>> in the "new" one.
> 
> Yea I think having a proper ION_IOC_VERSION is going to be necessary.
> 
> I'm hoping to send out an ugly first stab at the kernel side for
> switching to per-heap devices (with a config for keeping /dev/ion for
> legacy compat), which I hope will address the core issue this patch
> does (moving away from heap masks to specifically requested heaps).
> 
> thanks
> -john
> 

Arnd/Greg said no to this last time I tried back in 2016

https://lore.kernel.org/lkml/1472769644-11039-4-git-send-email-labbott@redhat.com/T/#u
