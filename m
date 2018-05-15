Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbeEOAoK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 20:44:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45678 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752293AbeEOAoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 20:44:09 -0400
Date: Mon, 14 May 2018 17:44:06 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Boaz Harrosh <boazh@netapp.com>, Jeff Moyer <jmoyer@redhat.com>,
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
Message-ID: <20180515004406.GB5168@bombadil.infradead.org>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
 <20180514144901.0fe99d240ff8a53047dd512e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514144901.0fe99d240ff8a53047dd512e@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 02:49:01PM -0700, Andrew Morton wrote:
> On Mon, 14 May 2018 20:28:01 +0300 Boaz Harrosh <boazh@netapp.com> wrote:
> > In this project we utilize a per-core server thread so everything
> > is kept local. If we use the regular zap_ptes() API All CPU's
> > are scheduled for the unmap, though in our case we know that we
> > have only used a single core. The regular zap_ptes adds a very big
> > latency on every operation and mostly kills the concurrency of the
> > over all system. Because it imposes a serialization between all cores
> 
> I'd have thought that in this situation, only the local CPU's bit is
> set in the vma's mm_cpumask() and the remote invalidations are not
> performed.  Is that a misunderstanding, or is all that stuff not working
> correctly?

I think you misunderstand Boaz's architecture.  He has one thread per CPU,
so every bit will be set in the mm's (not vma's) mm_cpumask.
