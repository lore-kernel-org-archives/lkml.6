Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbeCNTnE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:43:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751289AbeCNTnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:43:03 -0400
Subject: Re: [PATCH 1/2] livepatch: Initialize shadow variables by init
 function safely
To: Josh Poimboeuf <jpoimboe@redhat.com>, Petr Mladek <pmladek@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jessica Yu <jeyu@kernel.org>, Nicolai Stange <nstange@suse.de>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180313155448.1998-1-pmladek@suse.com>
 <20180313155448.1998-2-pmladek@suse.com>
 <20180314192857.yfdk2uwn4okuzlfh@treble>
From: Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <acd1592a-3f0d-c515-b90f-b1ed9694204b@redhat.com>
Date: Wed, 14 Mar 2018 15:43:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180314192857.yfdk2uwn4okuzlfh@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/14/2018 03:28 PM, Josh Poimboeuf wrote:
> On Tue, Mar 13, 2018 at 04:54:47PM +0100, Petr Mladek wrote:
> 
>> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
>> index 4754f01c1abb..fc7c64ce0992 100644
>> --- a/include/linux/livepatch.h
>> +++ b/include/linux/livepatch.h
>> @@ -186,11 +186,20 @@ static inline bool klp_have_reliable_stack(void)
>>  	       IS_ENABLED(CONFIG_HAVE_RELIABLE_STACKTRACE);
>>  }
>>  
>> +struct klp_shadow;
> 
> Why is this forward struct declaration needed?

Compiles ok w/o it, so shouldn't be needed.

>> @@ -150,6 +145,23 @@ static void *__klp_shadow_get_or_alloc(void *obj, unsigned long id, void *data,
>>  		goto exists;
>>  	}
>>  
>> +	new_shadow->obj = obj;
>> +	new_shadow->id = id;
>> +
>> +	if (init_func) {
>> +		int err;
>> +
>> +		err = init_func(obj, new_shadow->data, init_data);
> 
> Am I hallucinating, or will new_shadow->data always be NULL?  How did it
> even work before?
>
struct klp_shadow {
        struct hlist_node node;
        struct rcu_head rcu_head;
        void *obj;
        unsigned long id;
        char data[];            << not a pointer
};

In the past, this function would allocate the klp_shadow struct size
accordingly, then memcpy in its data contents.  This patch pushes the
responsibility of data initialization out to the init_func().

-- Joe
