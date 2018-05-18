Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeEROOZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:14:25 -0400
Received: from a9-112.smtp-out.amazonses.com ([54.240.9.112]:47012 "EHLO
        a9-112.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751197AbeEROOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:14:21 -0400
Date: Fri, 18 May 2018 14:14:20 +0000
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Boaz Harrosh <boazh@netapp.com>
cc: Matthew Wilcox <willy@infradead.org>, Jeff Moyer <jmoyer@redhat.com>,
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
In-Reply-To: <f3a66d8b-b9dc-b110-08aa-a63f0c309fb2@netapp.com>
Message-ID: <010001637399f796-3ffe3ed2-2fb1-4d43-84f0-6a65b6320d66-000000@email.amazonses.com>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com> <20180514191551.GA27939@bombadil.infradead.org> <7ec6fa37-8529-183d-d467-df3642bcbfd2@netapp.com> <20180515004137.GA5168@bombadil.infradead.org> <f3a66d8b-b9dc-b110-08aa-a63f0c309fb2@netapp.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.05.18-54.240.9.112
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2018, Boaz Harrosh wrote:

> > I don't think page tables work the way you think they work.
> >
> > +               err = vm_insert_pfn_prot(zt->vma, zt_addr, pfn, prot);
> >
> > That doesn't just insert it into the local CPU's page table.  Any CPU
> > which directly accesses or even prefetches that address will also get
> > the translation into its cache.
> >
>
> Yes I know, but that is exactly the point of this flag. I know that this
> address is only ever accessed from a single core. Because it is an mmap (vma)
> of an O_TMPFILE-exclusive file created in a core-pinned thread and I allow
> only that thread any kind of access to this vma. Both the filehandle and the
> mmaped pointer are kept on the thread stack and have no access from outside.
>
> So the all point of this flag is the kernel driver telling mm that this
> address is enforced to only be accessed from one core-pinned thread.

But there are no provisions for probhiting accesses from other cores?

This means that a casual accidental write from a thread executing on
another core can lead to arbitrary memory corruption because the cache
flushing has been bypassed.
