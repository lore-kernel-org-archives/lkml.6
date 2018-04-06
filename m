Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753928AbeDFPaI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:30:08 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:37206 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753685AbeDFPaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:30:06 -0400
X-Google-Smtp-Source: AIpwx48kuQerftvVAOLRcx1KjD0fJYNXqgaj27YQ5ryXSxxIoIRZ6fGQua6hX93cwdn3Wvbd33eiBg==
Subject: Re: AMD graphics performance regression in 4.15 and later
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        airlied@linux.ie, alexander.deucher@amd.com, Felix.Kuehling@amd.com,
        labbott@redhat.com, akpm@linux-foundation.org, michel.daenzer@amd.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <c743b220-0395-eef3-4405-a21cdbe8eee1@mozilla.com>
 <9ca940f1-7f21-c420-de45-13d72e783ab6@amd.com>
From: Jean-Marc Valin <jmvalin@mozilla.com>
Message-ID: <a96df0b8-fc22-4438-646d-2f0096dfcc84@mozilla.com>
Date: Fri, 6 Apr 2018 11:30:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <9ca940f1-7f21-c420-de45-13d72e783ab6@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

Is there a way to turn off these huge pages at boot-time/run-time? Right
now the recent kernels are making Firefox pretty much unusable for me.
I've been able to revert the patch from 4.15 but it's not really a
long-term solution.

You mention that the purpose of the patch is to improve performance, but
I haven't actually noticed anything running faster on my system. Is
there any particular test where I'm supposed to see an improvement
compared to 4.14?

I'm not sure what you mean by "We mitigated the problem by avoiding the
slow coherent DMA code path on almost all platforms on newer kernels". I
tested up to 4.16 and the performance regression is just as bad as it is
for 4.15.

Unlike the older hardware reported on kernel bug 198511, the hardware I
have is quite recent (RX 560) and still being sold. I've also confirmed
that neither nvidia (on the same machine) nor intel GPUs (on a less
powerful machine) are affected, so it seems like there's a way to avoid
that slow performance. I'm not saying that what Firefox is doing is
ideal (I don't know what it does and why), but it still seems like
something that should still be avoided in the kernel.

Cheers,

	Jean-Marc

On 04/06/2018 04:03 AM, Christian König wrote:
> Hi Jean,
> 
> yeah, that is a known problem. Using huge pages improves the performance
> because of better TLB usage, but for the cost of higher allocation
> overhead.
> 
> What we found is that firefox is doing something rather strange by
> allocating large textures and then just trowing them away again
> immediately.
> 
> We mitigated the problem by avoiding the slow coherent DMA code path on
> almost all platforms on newer kernels, but essentially somebody needs to
> figure out why firefox and/or the user space stack is doing this
> constant allocation/freeing of memory.
> 
> There is also a bug tracker on bugs.kernel.org about this, but I can't
> find it any more of hand.
> 
> Regards,
> Christian.
> 
> Am 06.04.2018 um 02:30 schrieb Jean-Marc Valin:
>> Hi,
>>
>> I noticed a serious graphics performance regression between 4.14 and
>> 4.15. It is most noticeable with Firefox (tried FF57 through FF60) and
>> causes scrolling to be really choppy/sluggish. I've confirmed that the
>> problem is also there on 4.16, while 4.13 works fine.
>>
>> After a bisection, I've narrowed the regression down to this commit:
>>
>> commit 648bc3574716400acc06f99915815f80d9563783
>> Author: Christian König <christian.koenig@amd.com>
>> Date:   Thu Jul 6 09:59:43 2017 +0200
>>
>>      drm/ttm: add transparent huge page support for DMA allocations v2
>>
>>
>> Some details about my system:
>> Distro: Fedora 27 (up-to-date)
>> Video: MSI Radeon RX 560 AERO
>> CPU: Dual-socket Xeon E5-2640 v4 (20 cores total)
>> RAM: 128 GB ECC
>>
>>
>> As a comparison, when running Firefox with 4.15 on a Lenovo W540 laptop
>> (with Intel graphics only) the responsiveness is much better then what
>> I'm getting on the Xeon machine above with the Radeon card, so this
>> really seems to be an AMD-only issue.
>>
>> Any way to fix the issue?
>>
>> Thanks,
>>
>>     Jean-Marc
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
