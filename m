Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbeEOMJr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 08:09:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34682 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753121AbeEOMJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 08:09:46 -0400
Date: Tue, 15 May 2018 14:09:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boaz Harrosh <boazh@netapp.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jeff Moyer <jmoyer@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20180515120939.GA12217@hirez.programming.kicks-ass.net>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
 <20180514191551.GA27939@bombadil.infradead.org>
 <7ec6fa37-8529-183d-d467-df3642bcbfd2@netapp.com>
 <20180515004137.GA5168@bombadil.infradead.org>
 <f3a66d8b-b9dc-b110-08aa-a63f0c309fb2@netapp.com>
 <20180515111159.GA31599@bombadil.infradead.org>
 <6999e635-e804-99d0-12fc-c13ff3e9ca58@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6999e635-e804-99d0-12fc-c13ff3e9ca58@netapp.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 02:41:41PM +0300, Boaz Harrosh wrote:
> On 15/05/18 14:11, Matthew Wilcox wrote:

> > You're still thinking about this from the wrong perspective.  If you
> > were writing a program to attack this facility, how would you do it?
> > It's not exactly hard to leak one pointer's worth of information.
> > 
> 
> That would be very hard. Because that program would:
> - need to be root
> - need to start and pretend it is zus Server with the all mount
>   thread thing, register new filesystem, grab some pmem devices.
> - Mount the said filesystem on said pmem. Create core-pinned ZT threads
>   for all CPUs, start accepting IO.
> - And only then it can start leaking the pointer and do bad things.
>   The bad things it can do to the application, not to the Kernel.

No I think you can do bad things to the kernel at that point. Consider
it populating the TLBs on the 'wrong' CPU by 'inadvertenly' touching
'random' memory.

Then cause an invalidation and get the page re-used for kernel bits.

Then access that page through the 'stale' TLB entry we still have on the
'wrong' CPU and corrupt kernel data.
