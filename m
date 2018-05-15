Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753703AbeEOORr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 10:17:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54930 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753360AbeEOORp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 10:17:45 -0400
Date: Tue, 15 May 2018 16:17:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boaz Harrosh <boazh@netapp.com>
Cc: Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Moyer <jmoyer@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Amit Golander <Amit.Golander@netapp.com>
Subject: Re: [PATCH] mm: Add new vma flag VM_LOCAL_CPU
Message-ID: <20180515141721.GF12217@hirez.programming.kicks-ass.net>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
 <20180514144901.0fe99d240ff8a53047dd512e@linux-foundation.org>
 <20180515004406.GB5168@bombadil.infradead.org>
 <cff721c3-65e8-c1e8-9f6d-c37ce6e56416@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cff721c3-65e8-c1e8-9f6d-c37ce6e56416@netapp.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 02:54:29PM +0300, Boaz Harrosh wrote:
> At the beginning I was wishful thinking that the mm_cpumask(vma->vm_mm)
> should have a single bit set just as the affinity of the thread on
> creation of that thread. But then I saw that at %80 of the times some
> other random bits are also set.
> 
> Yes Random. Always the thread affinity (single) bit was set but
> then zero one or two more bits were set as well. Never seen more then
> two though, which baffles me a lot.
> 
> If it was like Matthew said .i.e the cpumask of the all process
> then I would expect all the bits to be set. Because I have a thread
> on each core. And also I would even expect that all vma->vm_mm
> or maybe mm_cpumask(vma->vm_mm) to point to the same global object.
> But it was not so. it was pointing to some thread unique object but
> still those phantom bits were set all over. (And I am almost sure
> same vma had those bits change over time)
> 
> So I would love some mm guy to explain where are those bits collected?

Depends on the architecture, some architectures only ever set bits,
some, like x86, clear bits again. You want to look at switch_mm().

Basically x86 clears the bit again when we switch away from the mm and
have/will invalidate TLBs for it in doing so.

> Which brings me to another question. How can I find from
> within a thread Say at the file_operations->mmap() call that the thread
> is indeed core-pinned. What mm_cpumask should I inspect?

is_percpu_thread().
