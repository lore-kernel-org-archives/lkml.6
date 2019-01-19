Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B7BC5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 02:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D38620850
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 02:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbfASCeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 21:34:25 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46470 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730318AbfASCeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 21:34:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so7454636pfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 18:34:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f5ShMU+OI+BMDR0BViO1qokihDuIgyWlUk+lpG6RtQc=;
        b=rUrGRlGNfKUZE7dMiYYIs6l2nGeghFnsUhcRtNCqJcPYwKHCGN2WHlPlRN0EeajtqF
         QN9DFhRi2xdlLfbdkjVSbZWGCQStqFPqGOWf796wUsH9dF6YasVn/GXYa9xK5uEhLQ6o
         ymwqqHsUToFHLuYeT7L6+nACDD8N34hSOyMQ+CVhanC8Hhi+Io3uWlrRIXIXggBelW3I
         SL5O9iQdJJ9ouuRLd+xMirVJhMv41ca+O3k2+bU5riXiIDeW3CZ1smzwNwiBNU9BIxW4
         6EIvGsF0/s3IPUW7+UQED5n1vbRuV/xs79KfOo0ttdPc1jJ4FuRTB1cX9my0Tpl/VvA8
         ZcTA==
X-Gm-Message-State: AJcUukdnRhEi9OButWM/yqFOQXqEZJH0kLxyGqoR1h2QJxzvJmHcqrmz
        6ONh9jZ3z7eXbnHKhRnFmn0=
X-Google-Smtp-Source: ALg8bN6l2WZzmvgZYhYT8jF3RHCV0Ns2QBKACF5bz30fo7onXcfIsxLutqqJksnED+Jd0VWSgwU7JA==
X-Received: by 2002:a62:c42:: with SMTP id u63mr21326900pfi.73.1547865263496;
        Fri, 18 Jan 2019 18:34:23 -0800 (PST)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id t5sm11620653pfb.60.2019.01.18.18.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 18:34:22 -0800 (PST)
Subject: Re: [PATCH v6 00/16] locking/lockdep: Add support for dynamic keys
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
References: <20190109210204.192109-1-bvanassche@acm.org>
 <20190111124835.GP1900@hirez.programming.kicks-ass.net>
 <1547222103.83374.72.camel@acm.org>
 <20190111165529.GA14054@worktop.programming.kicks-ass.net>
 <1547226101.83374.80.camel@acm.org>
 <20190114125235.GB20726@hirez.programming.kicks-ass.net>
 <1547484753.83374.109.camel@acm.org>
 <20190118094808.GA27931@hirez.programming.kicks-ass.net>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <1250147c-27bc-92e1-3ff5-211f3ba56891@acm.org>
Date:   Fri, 18 Jan 2019 18:34:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190118094808.GA27931@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 1:48 AM, Peter Zijlstra wrote:
> On Mon, Jan 14, 2019 at 08:52:33AM -0800, Bart Van Assche wrote:
>> On Mon, 2019-01-14 at 13:52 +0100, Peter Zijlstra wrote:
>>> On Fri, Jan 11, 2019 at 09:01:41AM -0800, Bart Van Assche wrote:
>>>> The list_del_rcu() call must only happen once.
>>>
>>> Yes; obviously. But if we need to check all @pf's, that means the entry
>>> is still reachable after a single reset_lock()/free_key_range(), which
>>> is a bug.
>>>
>>>> I ran into complaints reporting that
>>>> the list_del_rcu() call triggered list corruption. This change made these complaints
>>>> disappear.
>>>
>>> I'm saying this solution buggy, because that means the entry is still
>>> reachable after we do call_rcu() (which is a straight up UAF).
>>>
>>> Also put it differently, what guarantees checking those two @pf's is
>>> sufficient. Suppose your earlier @pf already did the RCU callback and
>>> freed stuff while the second is in progress. Then you're poking into
>>> dead space.
>>
>> zap_class() only examines elements of the list_entries[] array for which the
>> corresponding bit in list_entries_in_use has been set. The RCU callback clears
>> the bits in the list_entries_in_use that correspond to elements that have been
>> freed. The graph lock serializes zap_class() calls and the code inside the
>> RCU callback. So it's not clear to me why you are claiming that zap_class()
>> would trigger a use-after-free?
> 
> The scenario is like:
> 
> 
> CPU0					CPU1					CPU2
> 
> lockdep_reset_lock_reg()
>    pf = get_pending_free_lock() // pf[0]
>    __lockdep_reset_lock(pf)
>      zap_class()
>    schedule_free_zapped_classes(pf)
>      call_rcu()
> 
> 
>    // here is wbere the objects 'freed' in zap_class()
>    // can still be used through references obtained
>    // __before__ we did call_rcu().
> 
> 
> 					lockdep_reset_lock_reg()
> 					  pf = get_pending_free_lock() // pf[1]
> 					  __lockdep_reset_lock(pf)
> 					    zap_class()
> 					      list_entry_being_freed()
> 						// checks: pf[0]
> 
> 						// this is a problem, it
> 						// should _NEVER_ match
> 						// anything from pf[0]
> 
> 						// those entries should
> 						// be unreachable,
> 						// otherwise:
> 
> 
> 										rcu_read_lock()
> 										entry = rcu_dereference()
> 
> <rcu-callback>
>    free_zapped_classes()
> 
> 										entry->class // UAF, just freed by rcu-callback
> 
> 										rcu_read_unlock()
> 
> 
> 
> 
> Now, arguably, I'm having a really hard time actually finding the RCU user of
> lock_list::entry, the comment in add_lock_to_list() seems to mention
> look_up_lock_class(), but the only RCU usage there is the
> lock_class::hash_entry, not lock_list::entry.
> 
> If lock_class is not indeed RCU used, that would simplify things. Please
> double check.
> 
> But in any case, the normal RCU pattern is:
> 
> lock()
> add-to-data-structure()
> unlock()
> 
> 				rcu_read_lock()
> 				obj = obtain-from-data-structure();
> 
> lock()
> remove-from-data-structure()
>    call_rcu()
> unlock();
> 
> 				use(obj);
> 				rcu_read_unlock();
> 
> 
> <rcu-callback>
>    actually-free-obj()
> 
> 
> 
> Fundamentally RCU delays the callback to the point where the last observer
> that started before call_rcu() has finished and no later (in practise it often
> is much later, but no guarantees there). So being able to reach an object
> after you did call_rcu() on it is a fundamental fail.

Hi Peter,

I agree with what you wrote. The only code I know of that accesses list
entries using RCU is the __bfs() function. In that function I found the
following loop:

	list_for_each_entry_rcu(entry, head, entry) { [ ... ] }

Since zap_class() calls list_del_rcu(&entry->entry), since a grace period
occurs between the call_rcu() invocation and the RCU callback function,
since at least an RCU reader lock must be held around RCU loops and since
sleeping is not allowed while holding an RCU read lock I think there is
no risk that __bfs() will examine a list entry after it has been freed.

Bart.
