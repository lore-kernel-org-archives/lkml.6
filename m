Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936763AbeE2OwR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:52:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936730AbeE2Ovw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:51:52 -0400
Date: Tue, 29 May 2018 07:50:55 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: viro@zeniv.linux.org.uk, hughd@google.com, akpm@linux-foundation.org,
        mhocko@suse.com, ross.zwisler@linux.intel.com, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, mark.rutland@arm.com, riel@redhat.com,
        pasha.tatashin@oracle.com, jschoenh@amazon.de,
        kstewart@linuxfoundation.org, rientjes@google.com, tglx@linutronix.de,
        peterz@infradead.org, mgorman@suse.de, yang.s@alibaba-inc.com,
        minchan@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: Change return type to vm_fault_t
Message-ID: <20180529145055.GA15148@bombadil.infradead.org>
References: <20180529143126.GA19698@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529143126.GA19698@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 08:01:26PM +0530, Souptick Joarder wrote:
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.

I don't believe you've checked this with sparse.

> @@ -802,7 +802,8 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
>  		     bool *unlocked)
>  {
>  	struct vm_area_struct *vma;
> -	int ret, major = 0;
> +	int major = 0;
> +	vm_fault_t ret;
>  
>  	if (unlocked)
>  		fault_flags |= FAULT_FLAG_ALLOW_RETRY;

...
        major |= ret & VM_FAULT_MAJOR;

That should be throwing a warning.
