Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbeENTP6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 15:15:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33228 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbeENTP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 15:15:56 -0400
Date: Mon, 14 May 2018 12:15:51 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Boaz Harrosh <boazh@netapp.com>
Cc: Jeff Moyer <jmoyer@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Amit Golander <Amit.Golander@netapp.com>
Subject: Re: [PATCH] mm: Add new vma flag VM_LOCAL_CPU
Message-ID: <20180514191551.GA27939@bombadil.infradead.org>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 08:28:01PM +0300, Boaz Harrosh wrote:
> On a call to mmap an mmap provider (like an FS) can put
> this flag on vma->vm_flags.
> 
> The VM_LOCAL_CPU flag tells the Kernel that the vma will be used
> from a single-core only, and therefore invalidation (flush_tlb) of
> PTE(s) need not be a wide CPU scheduling.

I still don't get this.  You're opening the kernel up to being exploited
by any application which can persuade it to set this flag on a VMA.

> NOTE: This vma (VM_LOCAL_CPU) is never used during a page_fault. It is
> always used in a synchronous way from a thread pinned to a single core.

It's not a question of how your app is going to use this flag.  It's a
question about how another app can abuse this flag (or how your app is
going to be exploited to abuse this flag) to break into the kernel.
