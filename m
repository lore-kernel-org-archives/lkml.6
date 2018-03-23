Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbeCWA4W convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 20:56:22 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11975 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751821AbeCWA4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 20:56:18 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 22 Mar 2018 17:56:13 -0700
Subject: Re: [PATCH 04/15] mm/hmm: unregister mmu_notifier when last HMM
 client quit v2
To: Jerome Glisse <jglisse@redhat.com>
CC: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
References: <20180320020038.3360-5-jglisse@redhat.com>
 <20180321181614.9968-1-jglisse@redhat.com>
 <a9ba54c5-a2d9-49f6-16ad-46b79525b93c@nvidia.com>
 <20180321234110.GK3214@redhat.com>
 <cbc9dcba-0707-e487-d360-f6f7c8d5cb23@nvidia.com>
 <20180322233715.GA5011@redhat.com>
 <b858d92a-3a38-bfff-fe66-697c64ea2053@nvidia.com>
 <20180323005017.GB5011@redhat.com>
From: John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <45076a33-1dab-d4c0-d0b3-ea8e9782975f@nvidia.com>
Date: Thu, 22 Mar 2018 17:56:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323005017.GB5011@redhat.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/22/2018 05:50 PM, Jerome Glisse wrote:
> On Thu, Mar 22, 2018 at 05:13:14PM -0700, John Hubbard wrote:
>> On 03/22/2018 04:37 PM, Jerome Glisse wrote:
>>> On Thu, Mar 22, 2018 at 03:47:16PM -0700, John Hubbard wrote:
>>>> On 03/21/2018 04:41 PM, Jerome Glisse wrote:
>>>>> On Wed, Mar 21, 2018 at 04:22:49PM -0700, John Hubbard wrote:
>>>>>> On 03/21/2018 11:16 AM, jglisse@redhat.com wrote:
>>>>>>> From: Jérôme Glisse <jglisse@redhat.com>
>>
>> <snip>
>>
>>>>>
>>>>> No this code is correct. hmm->mm is set after hmm struct is allocated
>>>>> and before it is public so no one can race with that. It is clear in
>>>>> hmm_mirror_unregister() under the write lock hence checking it here
>>>>> under that same lock is correct.
>>>>
>>>> Are you implying that code that calls hmm_mirror_register() should do 
>>>> it's own locking, to prevent simultaneous calls to that function? Because
>>>> as things are right now, multiple threads can arrive at this point. The
>>>> fact that mirror->hmm is not "public" is irrelevant; what matters is that
>>>>> 1 thread can change it simultaneously.
>>>
>>> The content of struct hmm_mirror should not be modified by code outside
>>> HMM after hmm_mirror_register() and before hmm_mirror_unregister(). This
>>> is a private structure to HMM and the driver should not touch it, ie it
>>> should be considered as read only/const from driver code point of view.
>>
>> Yes, that point is clear and obvious.
>>
>>>
>>> It is also expected (which was obvious to me) that driver only call once
>>> and only once hmm_mirror_register(), and only once hmm_mirror_unregister()
>>> for any given hmm_mirror struct. Note that driver can register multiple
>>> _different_ mirror struct to same mm or differents mm.
>>>
>>> There is no need of locking on the driver side whatsoever as long as the
>>> above rules are respected. I am puzzle if they were not obvious :)
>>
>> Those rules were not obvious. It's unusual to claim that register and unregister
>> can run concurrently, but regiser and register cannot. Let's please document
>> the rules a bit in the comments.
> 
> I am really surprise this was not obvious. All existing _register API
> in the kernel follow this. You register something once only and doing
> it twice for same structure (ie unique struct hmm_mirror *mirror pointer
> value) leads to serious bugs (doing so concurently or not).
> 
> For instance if you call mmu_notifier_register() twice (concurrently
> or not) with same pointer value for struct mmu_notifier *mn then bad
> thing will happen. Same for driver_register() but this one actualy
> have sanity check and complain loudly if that happens. I doubt there
> is any single *_register/unregister() in the kernel that does not
> follow this.

OK, then I guess no need to document it. In any case we know what to
expect here, so no problem there.

thanks,
-- 
John Hubbard
NVIDIA

> 
> Note that doing register/unregister concurrently for the same unique
> hmm_mirror struct is also illegal. However concurrent register and
> unregister of different hmm_mirror struct is legal and this is the
> reasons for races we were discussing.
> 
> Cheers,
> Jérôme
> 
