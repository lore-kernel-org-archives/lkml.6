Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753615AbeA3STi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:19:38 -0500
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:49686 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753585AbeA3STf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:19:35 -0500
Subject: Re: [PATCH v5 0/3] livepatch: introduce atomic replace
To: Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        jpoimboe@redhat.com, jeyu@kernel.org, jikos@kernel.org, mbenes@suse.cz,
        joe.lawrence@redhat.com
References: <cover.1515786085.git.jbaron@akamai.com>
 <c9064c38-9f04-f6d3-c28b-593a0bb74488@virtuozzo.com>
 <86cac2eb-0de4-bae7-f633-5ad03297880d@akamai.com>
 <20180126102326.u5jscbbgburrzatp@pathway.suse.cz>
 <adf9b91f-e9e9-9d9a-8b28-5754c16c0782@virtuozzo.com>
 <20180130140303.6xmjgnbdemovzif5@pathway.suse.cz>
 <54c06e8c-2749-7c53-5a44-575c0ba69551@virtuozzo.com>
From: Jason Baron <jbaron@akamai.com>
Message-ID: <af3f596d-c3cc-1096-8670-352ab66fc87f@akamai.com>
Date: Tue, 30 Jan 2018 13:19:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <54c06e8c-2749-7c53-5a44-575c0ba69551@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1801300223
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1801300223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/30/2018 10:06 AM, Evgenii Shatokhin wrote:
> On 30.01.2018 17:03, Petr Mladek wrote:
>> On Fri 2018-01-26 14:29:36, Evgenii Shatokhin wrote:
>>> On 26.01.2018 13:23, Petr Mladek wrote:
>>>> On Fri 2018-01-19 16:10:42, Jason Baron wrote:
>>>>>
>>>>>
>>>>> On 01/19/2018 02:20 PM, Evgenii Shatokhin wrote:
>>>>>> On 12.01.2018 22:55, Jason Baron wrote:
>>>>>> There is one more thing that might need attention here. In my
>>>>>> experiments with this patch series, I saw that unpatch callbacks
>>>>>> are not
>>>>>> called for the older binary patch (the one being replaced).
>>>>>
>>>>> So I think the pre_unpatch() can be called for any prior livepatch
>>>>> modules from __klp_enable_patch(). Perhaps in reverse order of loading
>>>>> (if there is more than one), and *before* the pre_patch() for the
>>>>> livepatch module being loaded. Then, if it sucessfully patches in
>>>>> klp_complete_transition() the post_unpatch() can be called for any
>>>>> prior
>>>>> livepatch modules as well. I think again it makes sense to call the
>>>>> post_unpatch() for prior modules *before* the post_patch() for the
>>>>> current livepatch modules.
>>>>
>>>> So, we are talking about a lot of rather non-trivial code.
>>>> IMHO, it might be easier to run just the callbacks from
>>>> the new patch. In reality, the author should always know
>>>> what it might be replacing and what needs to be done.
>>>>
>>>> By other words, it might be much easier to handle all
>>>> situations in a single script in the new patch. Alternative
>>>> would be doing crazy hacks to prevent the older scripts from
>>>> destroying what we would like to keep. We would need to
>>>> keep in mind interactions between the scripts and
>>>> the order in which they are called.
>>>>
>>>> Or do you plan to use cumulative patches to simply
>>>> get rid of any other "random" livepatches with something
>>>> completely different? In this case, it might be much more
>>>> safe to disable the older patches a normal way.
>>>
>>> In my experience, it was quite convenient sometimes to just "replace all
>>> binary patches the user currently has loaded with this single one". No
>>> matter what these original binary patches did and where they came from.
>>
>> To be honest, I would feel better if the livepatch framework is
>> more safe. It should prevent breaking the system by a patch
>> that atomically replaces other random patches that rely on callbacks.
>>
>> Well, combining random livepatches from random vendors is a call
>> for troubles. It might easily fail when two patches add
>> different changes to the same function.
>>
>> I wonder if we should introduce some tags, keys, vendors. I mean
>> to define an identification or dependencies that would say that some
>> patches are compatible or incompatible.
>>
>> We could allow to livepatch one function by two livepatches
>> only if they are from the same vendor. But then the order still
>> might be important. Also I am not sure if this condition is safe
>> enough.
>>
>> One the other hand, we could handle callbacks like the shadow
>> variables. Every shadow variable has an ID. We have an API to
>> add/read/update/remove them. We might allow to have more
>> callbacks with different IDs. Then we could run callbacks
>> only for IDs that are newly added or removed. Sigh, this would
>> be very complex implementation as well. But it might make
>> these features easier to use and maintain.
>>
>>
>> Alternatively, I thought about having two modes. One is
>> stack of "random" patches. Second is a cumulative mode.
>> IMHO, the combination of the two modes makes things very
>> complex. It might be much easier if we allow to load
>> patch with the replace flag enabled only on top of
>> another patch with this flag enabled.
>>
>>
>>> Another problematic situation is when you need to actually downgrade a
>>> cumulative patch. Should be rare, but...
>>
>> Good point. Well, especially the callbacks should be rare.
> 
> Yes, we will probably use them for the most important fixes only and
> only if there are no other suitable options. The patches with could be
> more difficult to maintain anyway.
> 
>>
>> I would like to hear from people that have some experience
>> or plans with using callbacks and cumulative patches.
>>
>> I wonder how they plan to technically reuse a feature
>> in the cummulative patches. IMHO, it should be very
>> rare to add/remove callbacks. Then it might be safe
>> to downgrade a cummulative patch if the callbacks
>> are exactly the same.
>>
>>> Well, I think we will disable the old patches explicitly in these cases,
>>> before loading of the new one. May be fragile but easier to maintain.
>>
>> I am afraid that we will not be able to support all use cases
>> and keep the code sane.
> 
> Thats is OK.
> 
> I agree with you that the current behaviour of the 'replace' operation
> w.r.t. patch callbacks should stay as is. Making kernel code more
> complex than it should be is definitely a bad thing.
> 
> I cannot say much about generic policies for cumulative/non-cumulative
> patches here. In our particular case (Virtuozzo ReadyKernel), the
> cumulative patches are easily recognizable by their names, they have
> 'cumulative' substring there. Patch version is also included in the name
> and is easily obtainable.
> 
> So I think, I'll update our userspace tools (based on kpatch) so that
> their 'replace' command worked as follows:
> 
> * Explicitly disable all loaded non-cumulative patches first.
> * If the new patch is non-cumulative, just disable all loaded patches
> explicitly and then load the new one.
> * If the new patch is cumulative, explicitly disable the loaded
> cumulative patches that have smaller version numbers than the new one
> (if any). Then run replace as usual.
> 
> This way, the in-kernel 'replace' functionality will only be used when
> upgrading cumulative patches - and we can design their callbacks (if the
> callbacks are needed at some point) according to the current behaviour.
> 
> Patch downgrade operations should be very rare and could only happen if
> something goes wrong at the users' side. I think, it is acceptable to
> disable the loaded patch first in that case. Its callbacks, if present,
> will do proper cleanup. Then the older, "good" patch can be loaded
> normally. If such things happen, we'll have to investigate the affected
> nodes anyway.
> 
> Same for the custom (non-cumulative) patches. We sometimes use them to
> "patch things up" quickly before the cumulative patch with the
> appropriate fixes is officially released. It should be reasonably safe
> to disable these patches explicitly when loading a new cumulative patch.
> 
> So, I think, the current situation with 'replace' & callbacks is
> acceptable for us.
>

Our main interest in 'atomic replace' is simply to make sure that
cumulative patches work as expected in that they 'replace' any prior
patches. We have an interest primarily in being able to apply patches
from the stable trees via livepatch. I think the current situation with
respect to 'replace' and callbacks is fine for us as well, but could
change based on more experience with livepatch.

As an aside I was just wondering how you are making use of the callbacks
using the tool you mentioned (that is based on kpatch)? I see in the
upstream kpatch that there are hooks such as: 'KPATCH_LOAD_HOOK(fn)' and
'KPATCH_UNLOAD_HOOK(fn)'. However, these are specific to 'kpatch' (as
opposed to livepatch), and I do not see these sort of macros for the
recently introduced livepatch callbacks. It seems it would be easy
enough to add similar hooks for the livepatch callbacks. I was thinking
of writing such a patch, but was wondering if there was an existing
solution?

Thanks,

-Jason
