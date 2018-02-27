Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754068AbeB0O6q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 09:58:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754055AbeB0O6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 09:58:42 -0500
From: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v0 2/3] livepatch: update documentation/samples for
 callbacks
To: Miroslav Benes <mbenes@suse.cz>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>
References: <1519421630-12025-1-git-send-email-joe.lawrence@redhat.com>
 <1519421630-12025-3-git-send-email-joe.lawrence@redhat.com>
 <alpine.LSU.2.21.1802271324370.19255@pobox.suse.cz>
Organization: Red Hat
Message-ID: <f87dbd4e-7262-5c90-0a5f-a54e4d0af20d@redhat.com>
Date: Tue, 27 Feb 2018 09:58:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1802271324370.19255@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/2018 07:36 AM, Miroslav Benes wrote:
> On Fri, 23 Feb 2018, Joe Lawrence wrote:
> 
>> [ ... snip ... ]
>>  
>> +If a livepatch is replaced by a cumulative patch, then only the
>> +callbacks belonging to the cumulative patch will be executed.  This
>> +simplifies the livepatching core for it is the responsibility of the
>> +cumulative patch to safely revert whatever needs to be reverted.  See
>> +Documentation/livepatch/cumulative.txt for more information on such
>> +patches.
> 
> s/cumulative/atomic replace/ almost everywhere?
> 
> 'Documentation/livepatch/cumulative.txt' should be 
> 'Documentation/livepatch/cumulative-patches.txt' and we may rename it 
> atomic-replace-patches.txt. I don't know. Cumulative patches forms a 
> subset of atomic replace patches in my understanding. The feature itself 
> is more general. Even if practically used for cumulative patches only. But 
> it is for you and Petr to decide.

Hi Miroslav,

Thanks for reviewing!

I guess I'm a little confused about the distinction here.

I understood a "cumulative-patch" to mean that it would contain the sum
of all changes.  So instead of this:

  patch 1 = A
+ patch 2 =     B
+ patch 3 =         C
-----------------------
  net     = A + B + C

We can group all of the changes together into a single cumulative-patch
for the same net effect:

  patch 1 = A               -replaced by-
  patch 2 = A + B             -replaced by-
  patch 3 = A + B + C

I assumed this would also mean to include any reverted changes as well.
So in the example above, if change C needed to be reverted, then:

  patch 4 = A + B

and that would still be considered a "cumulative-patch".

In my mind, atomic replace is the mechanism that forces patching to be
cumulative.  Perhaps this is too strict?  Are there other use-cases for
atomic-replace?

>>  Example Use-cases
>>  =================
>>
>> [ ... snip ... ]
>>
>> +Test 11
>> +-------
>> +
>> +A similar test as the previous one, except this time load the second
>> +callback demo module as a cumulative (ie, replacement) patch.  The
>> +livepatching core will only execute klp_object callbacks for the latest
>> +cumulative patch on the patch stack.
>> +
>> +- load livepatch
>> +- load second livepatch (atomic replace)
>> +- disable livepatch
> 
> Not needed.

Good catch.

-- Joe
