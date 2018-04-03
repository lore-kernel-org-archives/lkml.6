Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932317AbeDCNVG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 09:21:06 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:17021 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932212AbeDCNVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 09:21:01 -0400
Subject: Re: Signal handling in a page fault handler
To: Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Wilcox <willy@infradead.org>, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org, Souptick Joarder <jrdr.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org
References: <20180402141058.GL13332@bombadil.infradead.org>
 <152275879566.32747.9293394837417347482@mail.alporthouse.com>
From: Thomas Hellstrom <thomas@shipmail.org>
Message-ID: <e10f5e18-299b-57fd-4ba7-800caa1a105d@shipmail.org>
Date: Tue, 3 Apr 2018 15:12:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152275879566.32747.9293394837417347482@mail.alporthouse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2018 02:33 PM, Chris Wilson wrote:
> Quoting Matthew Wilcox (2018-04-02 15:10:58)
>> Souptick and I have been auditing the various page fault handler routines
>> and we've noticed that graphics drivers assume that a signal should be
>> able to interrupt a page fault.  In contrast, the page cache takes great
>> care to allow only fatal signals to interrupt a page fault.
>>
>> I believe (but have not verified) that a non-fatal signal being delivered
>> to a task which is in the middle of a page fault may well end up in an
>> infinite loop, attempting to handle the page fault and failing forever.
>>
>> Here's one of the simpler ones:
>>
>>          ret = mutex_lock_interruptible(&etnaviv_obj->lock);
>>          if (ret)
>>                  return VM_FAULT_NOPAGE;
>>
>> (many other drivers do essentially the same thing including i915)
>>
>> On seeing NOPAGE, the fault handler believes the PTE is in the page
>> table, so does nothing before it returns to arch code at which point
>> I get lost in the magic assembler macros.  I believe it will end up
>> returning to userspace if the signal is non-fatal, at which point it'll
>> go right back into the page fault handler, and mutex_lock_interruptible()
>> will immediately fail.  So we've converted a sleeping lock into the most
>> expensive spinlock.
> I'll ask the obvious question: why isn't the signal handled on return to
> userspace?

+1

>
>> I don't think the graphics drivers really want to be interrupted by
>> any signal.
> Assume the worst case and we may block for 10s. Even a 10ms delay may be
> unacceptable to some signal handlers (one presumes). For the number one
> ^C usecase, yes that may be reduced to only bother if it's killable, but
> I wonder if there are not timing loops (e.g. sigitimer in Xorg < 1.19)
> that want to be able to interrupt random blockages.
> -Chris

I think the TTM page fault handler originally set the standard for this. 
First, IMO any critical section that waits for the GPU (like typically 
the page fault handler does), should be locked at least killable. The 
need for interruptible locks came from the X server's silken mouse 
relying on signals for smooth mouse operations: You didn't want the X 
server to be stuck in the kernel waiting for GPU completion when it 
should handle the cursor move request.. Now that doesn't seem to be the 
case anymore but to reiterate Chris' question, why would the signal 
persist once returned to user-space?

/Thomas







> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
