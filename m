Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753182AbeAaWJ0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 17:09:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751980AbeAaWJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 17:09:24 -0500
Subject: Re: [PATCH v5 0/3] livepatch: introduce atomic replace
To: Petr Mladek <pmladek@suse.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>
Cc: Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, jpoimboe@redhat.com, jeyu@kernel.org,
        jikos@kernel.org, mbenes@suse.cz
References: <cover.1515786085.git.jbaron@akamai.com>
 <c9064c38-9f04-f6d3-c28b-593a0bb74488@virtuozzo.com>
 <86cac2eb-0de4-bae7-f633-5ad03297880d@akamai.com>
 <20180126102326.u5jscbbgburrzatp@pathway.suse.cz>
 <adf9b91f-e9e9-9d9a-8b28-5754c16c0782@virtuozzo.com>
 <20180130140303.6xmjgnbdemovzif5@pathway.suse.cz>
From: Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <d7ea0dc8-bfde-c6f4-0e05-6c97184018c4@redhat.com>
Date: Wed, 31 Jan 2018 17:09:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180130140303.6xmjgnbdemovzif5@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/2018 09:03 AM, Petr Mladek wrote:
> On Fri 2018-01-26 14:29:36, Evgenii Shatokhin wrote:
>>
>> In my experience, it was quite convenient sometimes to just "replace all
>> binary patches the user currently has loaded with this single one". No
>> matter what these original binary patches did and where they came from.
> 
> To be honest, I would feel better if the livepatch framework is
> more safe. It should prevent breaking the system by a patch
> that atomically replaces other random patches that rely on callbacks.
> 
> Well, combining random livepatches from random vendors is a call
> for troubles. It might easily fail when two patches add
> different changes to the same function.
> 
> I wonder if we should introduce some tags, keys, vendors. I mean
> to define an identification or dependencies that would say that some
> patches are compatible or incompatible.
> 
> We could allow to livepatch one function by two livepatches
> only if they are from the same vendor. But then the order still
> might be important. Also I am not sure if this condition is safe
> enough.
> 
> One the other hand, we could handle callbacks like the shadow
> variables. Every shadow variable has an ID. We have an API to
> add/read/update/remove them. We might allow to have more
> callbacks with different IDs. Then we could run callbacks
> only for IDs that are newly added or removed. Sigh, this would
> be very complex implementation as well. But it might make
> these features easier to use and maintain.

Interesting ideas, but I wonder if this could be accomplished at the
livepatch module level?  ie, leave it to kpatch-build (or a livepatch
equivalent) to produce a module that does this automatically.  I guess
it would then be completely opt-in checking, but transfers the
complexity out of the kernel livepatching core.

I don't see a simple way to provide flexibility of when/if calling
redundant callbacks without making the code even more complicated.  I
don't have any use-cases off hand that would require such features, but
I guess if I did absolutely needed them, I might be inclined to say
prepare ahead of time and write callbacks so that they may be disabled
externally -- either by a new livepatch module's init() or some other
means.  Then whatever crazy policy I need is contained to my modules,
not provided or enforced by the kernel.

-- Joe
