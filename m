Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754146AbeBZPGW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:06:22 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34478 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753387AbeBZPGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:06:18 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB24360FEA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tbaicar@codeaurora.org
Subject: Re: [PATCH 2/2] efi/esrt: mark ESRT memory region as nomap
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: linux-efi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Hugo <jhugo@codeaurora.org>, Sameer Goel <sgoel@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
References: <1519414953-5478-1-git-send-email-tbaicar@codeaurora.org>
 <1519414953-5478-3-git-send-email-tbaicar@codeaurora.org>
 <CAKv+Gu8bYzctzXKdYVDUDte=KoCPS1bzVoA6JYmidbc0ZrcZ+A@mail.gmail.com>
From: Tyler Baicar <tbaicar@codeaurora.org>
Message-ID: <9e3fa182-0635-108f-590b-6f1966bdabe0@codeaurora.org>
Date: Mon, 26 Feb 2018 10:06:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8bYzctzXKdYVDUDte=KoCPS1bzVoA6JYmidbc0ZrcZ+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ard,


On 2/24/2018 3:03 AM, Ard Biesheuvel wrote:
> Hi Tyler,
>
> On 23 February 2018 at 19:42, Tyler Baicar <tbaicar@codeaurora.org> wrote:
>> The ESRT memory region is being exposed as System RAM in /proc/iomem
>> which is wrong because it cannot be overwritten. This memory is needed
>> for kexec kernels in order to properly initialize ESRT, so if it is
>> overwritten it will cause ESRT failures in the kexec kernel. Mark this
>> region as nomap so that it is not overwritten.
>>
> This is not the right fix. We should only mark regions NOMAP if it is
> uncertain whether the firmware may have a mapping of the same region
> with mismatched attributes. NOMAP regions punch holes in the linear
> region, increasing its TLB footprint significantly, so we should avoid
> them if we can.
Thanks for the explanation, that makes sense.
> This same issue has come up in relation to mapping ACPI tables after
> kexec. This should simply be a matter of ensuring that all
> memblock_reserve()d region appear as such in /proc/iomem rather than
> as 'System RAM'
Do you know why this memory region would be coming up as System RAM rather than 
reserved if we're
calling memblock_reserve() on it in efi_mem_reserve()?

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
