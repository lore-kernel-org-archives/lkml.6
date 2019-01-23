Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C733C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C9321872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfAWS2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:28:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfAWS2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:28:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0003623E6C1;
        Wed, 23 Jan 2019 18:28:00 +0000 (UTC)
Received: from [10.18.17.208] (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 16606608F3;
        Wed, 23 Jan 2019 18:28:00 +0000 (UTC)
Subject: Re: [PATCH 4/4] livepatch: Remove the redundant enabled flag in
 struct klp_patch
To:     Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190116161720.796-1-pmladek@suse.com>
 <20190116161720.796-5-pmladek@suse.com>
 <alpine.LSU.2.21.1901221100020.16809@pobox.suse.cz>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <d0f53387-1b6f-3d9a-2336-89485b0680ac@redhat.com>
Date:   Wed, 23 Jan 2019 13:27:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1901221100020.16809@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 23 Jan 2019 18:28:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/19 5:06 AM, Miroslav Benes wrote:
> On Wed, 16 Jan 2019, Petr Mladek wrote:
> 
>> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
>> index 684766d306ad..8e644837e668 100644
>> --- a/kernel/livepatch/core.c
>> +++ b/kernel/livepatch/core.c
>> @@ -59,6 +59,17 @@ static bool klp_is_module(struct klp_object *obj)
>>   	return obj->name;
>>   }
>>   
>> +static bool klp_patch_enabled(struct klp_patch *patch)
>> +{
>> +	if (patch == klp_transition_patch) {
>> +		WARN_ON_ONCE(klp_target_state == KLP_UNDEFINED);
> 
> I think we'd have a race in the code then. enabled_show() does not take
> klp_mutex() when calling klp_patch_enabled().
 >
> A patch sysfs attributes are added quite early during its enablement.
> klp_init_transition() first sets klp_transition_patch, then
> klp_target_state. It means one can call enabled_show() with patch ==
> klp_transition_patch and klp_target_state == KLP_UNDEFINED. No?
> 
> The similar applies the disablement. klp_complete_transition() first
> clears klp_target_state (sets it to KLP_UNDEFINED), then it clears
> klp_transition_patch.
> 
> We could add locking to enabled_show() or swap the assignments with some
> barriers on top.
>

Taking the mutex as enabled_store() does would be simplest, no?

> Or we could remove WARN_ON_ONCE() and live with false results in
> enabled_show(). It does not matter much, I think. All the other call sites
> of klp_patch_enabled() should be fine.
> 

Hmm, the self-tests and the kpatch tool inspect the sysfs files, but as 
long as the false result is a stale value, I think they would be okay. 
Those tools poll sysfs and don't depend on a one-shot-read value to make 
an enabled/disabled determination.

>> +		return klp_target_state == KLP_PATCHED;
>> +	}
>> +
>> +	return !list_empty(&patch->list);
>> +}
> 
> Shouldn't we also change list_del(&patch->list) in klp_free_patch_start()
> to list_del_init(&patch->list)?
> 

Right, we should do that if klp_patch_enabled() is going to subsequently 
check that list.

>> @@ -955,7 +964,7 @@ static int __klp_enable_patch(struct klp_patch *patch)
>>   	if (klp_transition_patch)
>>   		return -EBUSY;
>>   
>> -	if (WARN_ON(patch->enabled))
>> +	if (list_empty(&patch->list))
>>   		return -EINVAL;
> 
> I wanted to ask why there is list_empty() and not klp_patch_enabled(), so
> just to be sure... the patch was added to klp_patches list, so patch->list
> is not empty (should not be). We could achieve the same by calling
> !klp_patch_enabled() given its implementation, but it would look
> counter-intuitive here.
> 
> The rest looks fine.
> 
> However, I am not sure if the outcome is better than what we have. Yes,
> patch->enabled is not technically necessary and we can live with that (as
> the patch proves). On the other hand, it gives the reader clear guidance
> about the patch's state. klp_patch_enabled() is not a complete
> replacement. We have to call list_empty() in __klp_enable_patch() or check
> the original klp_target_state in klp_try_complete_transition().
> 
> I am not against the change, I am glad to see it is achievable, but I am
> not sure if the code is better with it. Joe acked it. What do the others
> think?

Let me qualify my ack -- I think minimizing the number of state 
variables like patch->enabled can help readability... on the other hand, 
deducing the same information from other properties like list-empty can 
be confusing, ie, klp_patch_enabled() is generally a lot clearer than 
list_empty(&patch->list)).

So I like this idea and would be interested to hear what folks think 
about the exception cases you pointed out.

-- Joe
