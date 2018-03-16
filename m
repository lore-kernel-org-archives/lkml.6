Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932767AbeCPBR1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 21:17:27 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18401 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932341AbeCPBRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 21:17:25 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 15 Mar 2018 18:17:22 -0700
Subject: Re: [PATCH 3/4] mm/hmm: HMM should have a callback before MM is
 destroyed
To: Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Evgeny Baskakov <ebaskakov@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
References: <20180315183700.3843-1-jglisse@redhat.com>
 <20180315183700.3843-4-jglisse@redhat.com>
 <20180315154829.89054bfd579d03097b0f6457@linux-foundation.org>
 <20180316005433.GA11470@redhat.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <fc1b6957-d2de-6cb6-73e6-e79d9a9373aa@nvidia.com>
Date: Thu, 15 Mar 2018 18:17:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316005433.GA11470@redhat.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/2018 05:54 PM, Jerome Glisse wrote:
> On Thu, Mar 15, 2018 at 03:48:29PM -0700, Andrew Morton wrote:
>> On Thu, 15 Mar 2018 14:36:59 -0400 jglisse@redhat.com wrote:
>>
>>> From: Ralph Campbell <rcampbell@nvidia.com>
>>>
>>> The hmm_mirror_register() function registers a callback for when
>>> the CPU pagetable is modified. Normally, the device driver will
>>> call hmm_mirror_unregister() when the process using the device is
>>> finished. However, if the process exits uncleanly, the struct_mm
>>> can be destroyed with no warning to the device driver.
>>
>> The changelog doesn't tell us what the runtime effects of the bug are. 
>> This makes it hard for me to answer the "did Jerome consider doing
>> cc:stable" question.
> 
> The impact is low, they might be issue only if application is kill,
> and we don't have any upstream user yet hence why i did not cc
> stable.
> 

Hi Jerome and Andrew,

I'd claim that it is not possible to make a safe and correct device
driver, without this patch. That's because, without the .release callback
that you're adding here, the driver could end up doing operations on a 
stale struct_mm, leading to crashes and other disasters.

Even if people think that maybe that window is "small", it's not really
any smaller than lots of race condition problems that we've seen. And
it is definitely not that hard to hit it: just a good directed stress
test involving multiple threads that are doing early process termination
while also doing lots of migrations and page faults, should suffice.

It is probably best to add this patch to stable, for that reason. 

thanks,
-- 
John Hubbard
NVIDIA
