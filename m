Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeDFWBC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 18:01:02 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:38634 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbeDFWBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 18:01:01 -0400
X-Google-Smtp-Source: AIpwx4/MzY11aASQGFP1wtqqnOp9zG/Xw3ks7sXY+hXpuLCXqNZ3O4RzmYlflFPCYGmBDN7tWouehA==
Subject: Re: AMD graphics performance regression in 4.15 and later
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        airlied@linux.ie, alexander.deucher@amd.com, Felix.Kuehling@amd.com,
        labbott@redhat.com, akpm@linux-foundation.org, michel.daenzer@amd.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <c743b220-0395-eef3-4405-a21cdbe8eee1@mozilla.com>
 <9ca940f1-7f21-c420-de45-13d72e783ab6@amd.com>
 <a96df0b8-fc22-4438-646d-2f0096dfcc84@mozilla.com>
 <6cebabff-908f-5ebe-4252-760773c4cd6f@amd.com>
 <312ed341-7052-a61e-331f-d1e8fd5b477e@mozilla.com>
 <d136f940-d807-d2f7-30a7-8617f130912d@amd.com>
From: Jean-Marc Valin <jmvalin@mozilla.com>
Message-ID: <77866d66-2728-8295-d7ee-9975dbf64b99@mozilla.com>
Date: Fri, 6 Apr 2018 18:00:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <d136f940-d807-d2f7-30a7-8617f130912d@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

Thanks for the info. FYI, I've also opened a Firefox bug for that at:
https://bugzilla.mozilla.org/show_bug.cgi?id=1448778
Feel free to comment since you have a better understanding of what's
going on.

One last question: right now I'm running 4.15.0 with the "offending"
patch reverted. Is that safe to run or are there possible bad
interactions with other changes.

Cheers,

	Jean-Marc

On 04/06/2018 01:20 PM, Christian König wrote:
> Am 06.04.2018 um 18:42 schrieb Jean-Marc Valin:
>> Hi Christian,
>>
>> On 04/09/2018 07:48 AM, Christian König wrote:
>>> Am 06.04.2018 um 17:30 schrieb Jean-Marc Valin:
>>>> Hi Christian,
>>>>
>>>> Is there a way to turn off these huge pages at boot-time/run-time?
>>> Only at compile time by not setting CONFIG_TRANSPARENT_HUGEPAGE.
>> Any reason why
>> echo never > /sys/kernel/mm/transparent_hugepage/enabled
>> doesn't solve the problem?
> 
> Because we unfortunately try to allocate huge pages anyway, we
> unfortunately just fail in 100% of all cases.
> 
> That basically gives you both, the extra allocation overhead and the
> still bad throughput.
> 
>> Also, I assume that disabling CONFIG_TRANSPARENT_HUGEPAGE will disable
>> them for everything and not just what your patch added, right?
> 
> Correct, that's why I wrote that disabling SWIOTLBs might be better.
> 
>>>> I'm not sure what you mean by "We mitigated the problem by avoiding the
>>>> slow coherent DMA code path on almost all platforms on newer
>>>> kernels". I
>>>> tested up to 4.16 and the performance regression is just as bad as
>>>> it is
>>>> for 4.15.
>>> Indeed 4.16 still doesn't have that. You could use the
>>> amd-staging-drm-next branch or wait for 4.17.
>> Is there a way to pull just that change or is there too much
>> interactions with other changes?
> 
> It adds a new detection if memory allocation needs to be coherent or
> not, that is not something you can easily pull into older versions.
> 
>>> That isn't related to the GFX hardware, but to your CPU/motherboard and
>>> whatever else you have in the system.
>> Well, I have an nvidia GPU in the same system (normally only used for
>> CUDA) and if I use it instead of my RX 560 then I'm not seeing any
>> performance issue with 4.15.
> 
> That's because you are probably using the Nvidia binary driver which has
> a completely separate code base.
> 
>>> Some part of your system needs SWIOTLB and that makes allocating memory
>>> much slower.
>> What would that part be? FTR, I have a complete description of my system
>> at https://jmvalin.dreamwidth.org/15583.html
>>
>> I don't know if it's related, but I can maybe see one thing in common
>> between my machine and the Core 2 Quad from the other bug report and
>> that's the "NUMA part". I have a dual-socket Xeon and (AFAIK) the Core 2
>> Quad is made of two two-core CPUs glued together with little
>> communication between them.
> 
> Yeah, that is probably the reason.
> 
>>> Intel doesn't use TTM because they don't have dedicated VRAM, but the
>>> open source nvidia driver should be affected as well.
>> I'm using the proprietary nvidia driver (because CUDA). Is that supposed
>> to be affected as well?
> 
> No.
> 
>>> We already mitigated that problem and I don't see any solution which
>>> will arrive faster than 4.17.
>> Is that supposed to make the slowdown unnoticeable or just slightly
>> better?
> 
> It completely goes away. The issue with the coherent path is that it
> tries to always allocate the lowest possible memory to make sure that it
> fits into the DMA constrains of all devices in the system.
> 
> But since AMD GPU can handle 40bits of addresses you would need at least
> 1TB of memory in the system to trigger that (or a NUMA where some system
> is low and some in a high area).
> 
> Christian.
> 
>>> The only quick workaround I can see is to avoid firefox, chrome for
>>> example is reported to work perfectly fine.
>> Or use an unaffected GPU/driver ;-)
>>
>> Cheers,
>>
>>     Jean-Marc
>>
> 
