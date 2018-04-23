Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753903AbeDWCZ0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:25:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40650 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753726AbeDWCZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:25:24 -0400
Date: Sun, 22 Apr 2018 19:25:05 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Souptick Joarder <jrdr.linux@gmail.com>, viro@zeniv.linux.org.uk,
        mawilcox@microsoft.com, ross.zwisler@linux.intel.com,
        akpm@linux-foundation.org, dan.j.williams@intel.com, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fs: dax: Adding new return type vm_fault_t
Message-ID: <20180423022505.GA2308@bombadil.infradead.org>
References: <20180421210529.GA27238@jordon-HP-15-Notebook-PC>
 <20180422230948.2mvimlf3zspry4ji@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422230948.2mvimlf3zspry4ji@quack2.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 01:09:48AM +0200, Jan Kara wrote:
> > -int vm_insert_mixed_mkwrite(struct vm_area_struct *vma, unsigned long addr,
> > -			pfn_t pfn)
> > +vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
> > +		unsigned long addr, pfn_t pfn)
> >  {
> > -	return __vm_insert_mixed(vma, addr, pfn, true);
> > +	int err;
> > +
> > +	err =  __vm_insert_mixed(vma, addr, pfn, true);
> > +	if (err == -ENOMEM)
> > +		return VM_FAULT_OOM;
> > +	if (err < 0 && err != -EBUSY)
> > +		return VM_FAULT_SIGBUS;
> > +	return VM_FAULT_NOPAGE;
> >  }
> > -EXPORT_SYMBOL(vm_insert_mixed_mkwrite);
> > +EXPORT_SYMBOL(vmf_insert_mixed_mkwrite);
> 
> So are we sure that all the callers of this function (and also of
> vmf_insert_mixed()) are OK with EBUSY? Because especially in the
> vmf_insert_mixed() case other page than the caller provided is in page
> tables and thus possibly the caller needs to do some error recovery (such
> as drop page refcount) in such case...

I went through all the users and didn't find any that did anything
with -EBUSY other than turn it into VM_FAULT_NOPAGE.  I agree that it's
possible that there might have been someone who wanted to do that, but
we tend to rely on mapcount (through rmap) rather than refcount (ie we
use refcount to mean the number of kernel references to the page and then
use mapcount for the number of times it's mapped into a process' address
space).  All the drivers I audited would allocagte the page first, store
it in their own data structures, then try to insert it into the virtual
address space.  So an EBUSY always meant "the same page was inserted".

If we did want to support "This happened already" in the future, we
could define a VM_FAULT flag for that.
