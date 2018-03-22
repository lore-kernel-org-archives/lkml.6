Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751793AbeCVWrS convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 18:47:18 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17395 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeCVWrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 18:47:17 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 22 Mar 2018 15:47:12 -0700
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
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <cbc9dcba-0707-e487-d360-f6f7c8d5cb23@nvidia.com>
Date: Thu, 22 Mar 2018 15:47:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321234110.GK3214@redhat.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/21/2018 04:41 PM, Jerome Glisse wrote:
> On Wed, Mar 21, 2018 at 04:22:49PM -0700, John Hubbard wrote:
>> On 03/21/2018 11:16 AM, jglisse@redhat.com wrote:
>>> From: Jérôme Glisse <jglisse@redhat.com>
>>>
>>> This code was lost in translation at one point. This properly call
>>> mmu_notifier_unregister_no_release() once last user is gone. This
>>> fix the zombie mm_struct as without this patch we do not drop the
>>> refcount we have on it.
>>>
>>> Changed since v1:
>>>   - close race window between a last mirror unregistering and a new
>>>     mirror registering, which could have lead to use after free()
>>>     kind of bug
>>>
>>> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
>>> Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
>>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>>> Cc: Mark Hairgrove <mhairgrove@nvidia.com>
>>> Cc: John Hubbard <jhubbard@nvidia.com>
>>> ---
>>>  mm/hmm.c | 35 +++++++++++++++++++++++++++++++++--
>>>  1 file changed, 33 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/mm/hmm.c b/mm/hmm.c
>>> index 6088fa6ed137..f75aa8df6e97 100644
>>> --- a/mm/hmm.c
>>> +++ b/mm/hmm.c
>>> @@ -222,13 +222,24 @@ int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)
>>>  	if (!mm || !mirror || !mirror->ops)
>>>  		return -EINVAL;
>>>  
>>> +again:
>>>  	mirror->hmm = hmm_register(mm);
>>>  	if (!mirror->hmm)
>>>  		return -ENOMEM;
>>>  
>>>  	down_write(&mirror->hmm->mirrors_sem);
>>> -	list_add(&mirror->list, &mirror->hmm->mirrors);
>>> -	up_write(&mirror->hmm->mirrors_sem);
>>> +	if (mirror->hmm->mm == NULL) {
>>> +		/*
>>> +		 * A racing hmm_mirror_unregister() is about to destroy the hmm
>>> +		 * struct. Try again to allocate a new one.
>>> +		 */
>>> +		up_write(&mirror->hmm->mirrors_sem);
>>> +		mirror->hmm = NULL;
>>
>> This is being set outside of locks, so now there is another race with
>> another hmm_mirror_register...
>>
>> I'll take a moment and draft up what I have in mind here, which is a more
>> symmetrical locking scheme for these routines.
>>
> 
> No this code is correct. hmm->mm is set after hmm struct is allocated
> and before it is public so no one can race with that. It is clear in
> hmm_mirror_unregister() under the write lock hence checking it here
> under that same lock is correct.

Are you implying that code that calls hmm_mirror_register() should do 
it's own locking, to prevent simultaneous calls to that function? Because
as things are right now, multiple threads can arrive at this point. The
fact that mirror->hmm is not "public" is irrelevant; what matters is that
>1 thread can change it simultaneously.

thanks,
-- 
John Hubbard
NVIDIA
