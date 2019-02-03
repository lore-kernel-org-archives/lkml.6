Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FCDC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 17:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF1320815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 17:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfBCRgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 12:36:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40780 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfBCRgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 12:36:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so5242326pgp.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 09:36:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oDDoP3/YaRry/62dV8w87GaZ3zFpZATjApIPdffE4vg=;
        b=C6A3nniFqLcz8vV3qjYHb23PAZdO6SrQmTy66Ks2KbA0F/wghYxYsPJMaKbDR9EhOx
         Xd4EsU0lQreX8yz0E8RVD+cZ9xegkp08QAISEEzuaZEj3wEepSkWdVgCeF8IfVT6B10n
         7pyfiL6hMA26UP6z2esnjlBqsLXk2TViX+5JgDm14kFPCFguwx0Ck8DATV/iNP8rYSjV
         eqVb7QwqQeQN3tpg1Apa3sGjvKk4ErV+P+8cwDshEdJAV5WSAP6/prN+DIAvTKyNMTs0
         kRFz9sNlJGPR2F9dtIwNQOtdsiVx9RwLjaK5HpQIyNDXfgk4g+WusJ8FWIIFeXKJorNg
         KZ2w==
X-Gm-Message-State: AHQUAuZ49/+wivtKq3Ua/6tPURTcIvqQ0ccVXb0HqAxzs8aarY6TPbE0
        3O4S77FQ5j/flfTPgNNxs0w=
X-Google-Smtp-Source: AHgI3IaHF0OFlw1yhKxQzNu4JqsO3LjC5n/0X7OT08UhSlE+8eWBs9zO4twb9yUPixpJ6083R6M6zA==
X-Received: by 2002:a65:6683:: with SMTP id b3mr844042pgw.423.1549215401169;
        Sun, 03 Feb 2019 09:36:41 -0800 (PST)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id x186sm18451793pfb.59.2019.02.03.09.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 09:36:39 -0800 (PST)
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
 <1250147c-27bc-92e1-3ff5-211f3ba56891@acm.org>
 <20190201121510.GC31516@hirez.programming.kicks-ass.net>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <3c533b0e-b079-79ad-4935-cd61af000ce6@acm.org>
Date:   Sun, 3 Feb 2019 09:36:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201121510.GC31516@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/19 4:15 AM, Peter Zijlstra wrote:
> On Fri, Jan 18, 2019 at 06:34:20PM -0800, Bart Van Assche wrote:
>> I agree with what you wrote. The only code I know of that accesses list
>> entries using RCU is the __bfs() function. In that function I found the
>> following loop:
>>
>> 	list_for_each_entry_rcu(entry, head, entry) { [ ... ] }
> 
> Thing is; I can't seem to find any __bfs() usage outside of graph_lock.
> 
>    count_{fwd,bwd}_deps() - takes graph lock
> 
>    check_{noncircular,redudant}() - called from check_prev_add() <-
>    check_prevs_add() <- validate_chain() which takes graph lock
> 
>    find_usage{,_fwd,_bwd}
>      <- check_usage() <- check_irq_usage() <- check_prev_add_irq() <-
>      check_prev_add <- check_prevs_add() <- validate_chain() which takes
>      graph lock
> 
>      <- check_usage_{fwd,bdw}() <- mark_lock_irq() <- mark_lock() which
>      takes graph lock
> 
> Or did I miss something? If there are no __bfs() users outside of graph
> lock, then we can simply remove that _rcu from the iteration, and
> simplify all that.

Every time I make a single change to the lockdep code I have to rerun my 
test case for a week to make sure that no regressions have been 
introduced. In other words, I can make further changes but that could 
take some time. Do you want me to look into this simplification now or 
after this patch series went upstream?

>> Since zap_class() calls list_del_rcu(&entry->entry), since a grace period
>> occurs between the call_rcu() invocation and the RCU callback function,
>> since at least an RCU reader lock must be held around RCU loops and since
>> sleeping is not allowed while holding an RCU read lock I think there is
>> no risk that __bfs() will examine a list entry after it has been freed.
> 
> So you agree that list_entry_being_freed() should only check the current
> pf?

Sorry if I wasn't clear enough. In a previous e-mail I tried to explain 
that both pf's have to be checked. Another way to explain that is as 
follows:
- Each list entry has one of the following states: free, in use or being
   freed.
- "Free" means that the corresponding bit in the list_entries_in_use
   bitmap has not been set.
- "In use" means that the corresponding bit in the list_entries_in_use
   bitmap has been set and that none of the corresponding bits in the
   list_entries_being_freed bitmaps have been set.
- "Being freed" means that the corresponding bit in one of the
   list_entries_being_freed bitmaps has been set.

Since it can happen that multiple elements of the pending_free[] array 
are in the state where call_rcu() has been called but the RCU callback 
function has not yet been called, I think that zap_class() must check 
the list_entries_being_freed bitmaps in all pending_free[] array elements.

Thanks,

Bart.
