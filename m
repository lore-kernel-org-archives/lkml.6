Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754277AbeBZPHP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:07:15 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:40796 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754127AbeBZPHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:07:12 -0500
X-Google-Smtp-Source: AG47ELtvMuldjWk6x5cpYMlcx2HOXpbQYmgYtPCFOKVZc+SjiAyryOcyumrC+3ISbsgJzLZ+9yAmbxVkncFx5agDxRs=
MIME-Version: 1.0
In-Reply-To: <9e3fa182-0635-108f-590b-6f1966bdabe0@codeaurora.org>
References: <1519414953-5478-1-git-send-email-tbaicar@codeaurora.org>
 <1519414953-5478-3-git-send-email-tbaicar@codeaurora.org> <CAKv+Gu8bYzctzXKdYVDUDte=KoCPS1bzVoA6JYmidbc0ZrcZ+A@mail.gmail.com>
 <9e3fa182-0635-108f-590b-6f1966bdabe0@codeaurora.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 26 Feb 2018 15:07:11 +0000
Message-ID: <CAKv+Gu9WUU6_YoOr1ZptxyoTi0pbKUUPVhFX9DOvDbTw3Bsz-A@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi/esrt: mark ESRT memory region as nomap
To: Tyler Baicar <tbaicar@codeaurora.org>
Cc: James Morse <james.morse@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Hugo <jhugo@codeaurora.org>, Sameer Goel <sgoel@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 February 2018 at 15:06, Tyler Baicar <tbaicar@codeaurora.org> wrote:
> Hello Ard,
>
>
> On 2/24/2018 3:03 AM, Ard Biesheuvel wrote:
>>
>> Hi Tyler,
>>
>> On 23 February 2018 at 19:42, Tyler Baicar <tbaicar@codeaurora.org> wrote:
>>>
>>> The ESRT memory region is being exposed as System RAM in /proc/iomem
>>> which is wrong because it cannot be overwritten. This memory is needed
>>> for kexec kernels in order to properly initialize ESRT, so if it is
>>> overwritten it will cause ESRT failures in the kexec kernel. Mark this
>>> region as nomap so that it is not overwritten.
>>>
>> This is not the right fix. We should only mark regions NOMAP if it is
>> uncertain whether the firmware may have a mapping of the same region
>> with mismatched attributes. NOMAP regions punch holes in the linear
>> region, increasing its TLB footprint significantly, so we should avoid
>> them if we can.
>
> Thanks for the explanation, that makes sense.
>>
>> This same issue has come up in relation to mapping ACPI tables after
>> kexec. This should simply be a matter of ensuring that all
>> memblock_reserve()d region appear as such in /proc/iomem rather than
>> as 'System RAM'
>
> Do you know why this memory region would be coming up as System RAM rather
> than reserved if we're
> calling memblock_reserve() on it in efi_mem_reserve()?
>

I don't think there is any special handling of memblock_reserve()'d
regions at all at the moment.
