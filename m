Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDEFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A206204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A206204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966449AbeFSO6F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:58:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:4265 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937728AbeFSO6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:58:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 07:58:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,243,1526367600"; 
   d="scan'208";a="64507450"
Received: from aluisell-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.254.128])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jun 2018 07:57:54 -0700
Date:   Tue, 19 Jun 2018 17:57:53 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:INTEL SGX" <intel-sgx-kernel-dev@lists.01.org>
Subject: Re: [PATCH v11 09/13] x86, sgx: basic routines for enclave page cache
Message-ID: <20180619145753.GB8034@linux.intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-10-jarkko.sakkinen@linux.intel.com>
 <3c1b04d6-6e93-efaa-1890-101b7fd9784c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c1b04d6-6e93-efaa-1890-101b7fd9784c@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 11:24:12AM -0700, Dave Hansen wrote:
> On 06/08/2018 10:09 AM, Jarkko Sakkinen wrote:
> > SGX has a set of data structures to maintain information about the enclaves
> > and their security properties. BIOS reserves a fixed size region of
> > physical memory for these structures by setting Processor Reserved Memory
> > Range Registers (PRMRR). This memory area is called Enclave Page Cache
> > (EPC).
> > 
> > This commit implements the basic routines to allocate and free pages from
> > different EPC banks. There is also a swapper thread ksgxswapd for EPC pages
> > that gets woken up by sgx_alloc_page() when we run below the low watermark.
> > The swapper thread continues swapping pages up until it reaches the high
> > watermark.
> 
> Yay!  A new memory manager in arch-specific code.
> 
> > Each subsystem that uses SGX must provide a set of callbacks for EPC
> > pages that are used to reclaim, block and write an EPC page. Kernel
> > takes the responsibility of maintaining LRU cache for them.
> 
> What does a "subsystem that uses SGX" mean?  Do we have one of those
> already?

Driver and KVM.

> > +struct sgx_secs {
> > +	uint64_t size;
> > +	uint64_t base;
> > +	uint32_t ssaframesize;
> > +	uint32_t miscselect;
> > +	uint8_t reserved1[SGX_SECS_RESERVED1_SIZE];
> > +	uint64_t attributes;
> > +	uint64_t xfrm;
> > +	uint32_t mrenclave[8];
> > +	uint8_t reserved2[SGX_SECS_RESERVED2_SIZE];
> > +	uint32_t mrsigner[8];
> > +	uint8_t	reserved3[SGX_SECS_RESERVED3_SIZE];
> > +	uint16_t isvvprodid;
> > +	uint16_t isvsvn;
> > +	uint8_t reserved4[SGX_SECS_RESERVED4_SIZE];
> > +};
> 
> This is a hardware structure, right?  Doesn't it need to be packed?

Everything is aligned properly in this struct.

> > +enum sgx_tcs_flags {
> > +	SGX_TCS_DBGOPTIN	= 0x01, /* cleared on EADD */
> > +};
> > +
> > +#define SGX_TCS_RESERVED_MASK 0xFFFFFFFFFFFFFFFEL
> 
> Would it be possible to separate out the SGX software structures from
> SGX hardware?  It's hard to tell them apart.

How do you draw the line in the architectural structures?

> > +#define SGX_NR_TO_SCAN	16
> > +#define SGX_NR_LOW_PAGES 32
> > +#define SGX_NR_HIGH_PAGES 64
> > +
> >  bool sgx_enabled __ro_after_init = false;
> >  EXPORT_SYMBOL(sgx_enabled);
> > +bool sgx_lc_enabled __ro_after_init;
> > +EXPORT_SYMBOL(sgx_lc_enabled);
> > +atomic_t sgx_nr_free_pages = ATOMIC_INIT(0);
> 
> Hmmm, global atomic.  Doesn't sound very scalable.

We could potentially remove this completely as banks have 'free_cnt'
field and use the sum when needed as the value.

> > +struct sgx_epc_bank sgx_epc_banks[SGX_MAX_EPC_BANKS];
> > +EXPORT_SYMBOL(sgx_epc_banks);
> > +int sgx_nr_epc_banks;
> > +EXPORT_SYMBOL(sgx_nr_epc_banks);
> > +LIST_HEAD(sgx_active_page_list);
> > +EXPORT_SYMBOL(sgx_active_page_list);
> > +DEFINE_SPINLOCK(sgx_active_page_list_lock);
> > +EXPORT_SYMBOL(sgx_active_page_list_lock);
> 
> Hmmm, global spinlock protecting a page allocator linked list.  Sounds
> even worse than at atomic.
> 
> Why is this OK?

Any suggestions what would be a better place in order to make a
fine grained granularity?

> > +static struct task_struct *ksgxswapd_tsk;
> > +static DECLARE_WAIT_QUEUE_HEAD(ksgxswapd_waitq);
> > +
> > +/*
> > + * Writing the LE hash MSRs is extraordinarily expensive, e.g.
> > + * 3-4x slower than normal MSRs, so we use a per-cpu cache to
> > + * track the last known value of the MSRs to avoid unnecessarily
> > + * writing the MSRs with the current value.  Because most Linux
> > + * kernels will use an LE that is signed with a non-Intel key,
> > + * i.e. the first EINIT will need to write the MSRs regardless
> > + * of the cache, the cache is intentionally left uninitialized
> > + * during boot as initializing the cache would be pure overhead
> > + * for the majority of systems.  Furthermore, the MSRs are per-cpu
> > + * and the boot-time values aren't guaranteed to be identical
> > + * across cpus, so we'd have to run code all all cpus to properly
> > + * init the cache.  All in all, the complexity and overhead of
> > + * initializing the cache is not justified.
> > + */
> > +static DEFINE_PER_CPU(u64 [4], sgx_le_pubkey_hash_cache);
> 
> Justifying the design decisions is great for changelogs, not so great
> for comments.  Also, looking at this, I have no idea what this has to do
> with the "enclave page cache".

We'll have to revisit comment, I see your point.

> > +static void sgx_swap_cluster(void)
> > +{
> > +	struct sgx_epc_page *cluster[SGX_NR_TO_SCAN + 1];
> > +	struct sgx_epc_page *epc_page;
> > +	int i;
> > +	int j;
> 
> This is rather free of comments or explanation of what this is doing,
> how it is related to swapping as everyone else knows it

I can document this function properly.

> > +	memset(cluster, 0, sizeof(cluster));
> > +
> > +	for (i = 0, j = 0; i < SGX_NR_TO_SCAN; i++) {
> > +		spin_lock(&sgx_active_page_list_lock);
> > +		if (list_empty(&sgx_active_page_list)) {
> > +			spin_unlock(&sgx_active_page_list_lock);
> > +			break;
> > +		}
> > +		epc_page = list_first_entry(&sgx_active_page_list,
> > +					    struct sgx_epc_page, list);
> > +		if (!epc_page->impl->ops->get(epc_page)) {
> > +			list_move_tail(&epc_page->list, &sgx_active_page_list);
> > +			spin_unlock(&sgx_active_page_list_lock);
> > +			continue;
> > +		}
> > +		list_del(&epc_page->list);
> > +		spin_unlock(&sgx_active_page_list_lock);
> >  
> > -static __init bool sgx_is_enabled(void)
> > +		if (epc_page->impl->ops->reclaim(epc_page)) {
> > +			cluster[j++] = epc_page;
> > +		} else {
> > +			spin_lock(&sgx_active_page_list_lock);
> > +			list_add_tail(&epc_page->list, &sgx_active_page_list);
> > +			spin_unlock(&sgx_active_page_list_lock);
> > +			epc_page->impl->ops->put(epc_page);
> > +		}
> > +	}
> > +
> > +	for (i = 0; cluster[i]; i++) {
> > +		epc_page = cluster[i];
> > +		epc_page->impl->ops->block(epc_page);
> > +	}
> > +
> > +	for (i = 0; cluster[i]; i++) {
> > +		epc_page = cluster[i];
> > +		epc_page->impl->ops->write(epc_page);
> > +		epc_page->impl->ops->put(epc_page);
> > +		sgx_free_page(epc_page);
> > +	}
> > +}
> 
> This is also gloriously free of any superfluous comments.  Could you fix
> that?

Yes.

> > +/**
> > + * sgx_try_alloc_page - try to allocate an EPC page
> > + * @impl:	implementation for the struct sgx_epc_page
> > + *
> > + * Try to grab a page from the free EPC page list. If there is a free page
> > + * available, it is returned to the caller.
> > + *
> > + * Return:
> > + *   a &struct sgx_epc_page instace,
> > + *   NULL otherwise
> > + */
> > +struct sgx_epc_page *sgx_try_alloc_page(struct sgx_epc_page_impl *impl)
> > +{
> > +	struct sgx_epc_bank *bank;
> > +	struct sgx_epc_page *page = NULL;
> > +	int i;
> > +
> > +	for (i = 0; i < sgx_nr_epc_banks; i++) {
> > +		bank = &sgx_epc_banks[i];
> 
> What's a bank?  How many banks does a system have?

AFAIK, UMA systems have one bank. NUMA have multiple. It is a physical
memory region reserved for enclave pages.

> > +		down_write(&bank->lock);
> > +
> > +		if (atomic_read(&bank->free_cnt))
> > +			page = bank->pages[atomic_dec_return(&bank->free_cnt)];
> 
> Why is a semaphore getting used here?  I don't see any sleeping or
> anything happening under this lock.

Should be changed to reader-writer spinlock, thanks.

> > +		up_write(&bank->lock);
> > +
> > +		if (page)
> > +			break;
> > +	}
> > +
> > +	if (page) {
> > +		atomic_dec(&sgx_nr_free_pages);
> > +		page->impl = impl;
> > +	}
> > +
> > +	return page;
> > +}
> > +EXPORT_SYMBOL(sgx_try_alloc_page);
> > +
> > +/**
> > + * sgx_alloc_page - allocate an EPC page
> > + * @flags:	allocation flags
> > + * @impl:	implementation for the struct sgx_epc_page
> > + *
> > + * Try to grab a page from the free EPC page list. If there is a free page
> > + * available, it is returned to the caller. If called with SGX_ALLOC_ATOMIC,
> > + * the function will return immediately if the list is empty. Otherwise, it
> > + * will swap pages up until there is a free page available. Upon returning the
> > + * low watermark is checked and ksgxswapd is waken up if we are below it.
> > + *
> > + * Return:
> > + *   a &struct sgx_epc_page instace,
> > + *   -ENOMEM if all pages are unreclaimable,
> > + *   -EBUSY when called with SGX_ALLOC_ATOMIC and out of free pages
> > + */
> > +struct sgx_epc_page *sgx_alloc_page(struct sgx_epc_page_impl *impl,
> > +				    unsigned int flags)
> > +{
> > +	struct sgx_epc_page *entry;
> > +
> > +	for ( ; ; ) {
> > +		entry = sgx_try_alloc_page(impl);
> > +		if (entry)
> > +			break;
> > +
> > +		if (list_empty(&sgx_active_page_list))
> > +			return ERR_PTR(-ENOMEM);
> 
> "active" pages in the VM are allocated/in-use pages.  This doesn't look
> to be using the same terminology.
> 
> > +		if (flags & SGX_ALLOC_ATOMIC) {
> > +			entry = ERR_PTR(-EBUSY);
> > +			break;
> > +		}
> > +
> > +		if (signal_pending(current)) {
> > +			entry = ERR_PTR(-ERESTARTSYS);
> > +			break;
> > +		}
> > +
> > +		sgx_swap_cluster();
> > +		schedule();
> 
> What's the schedule trying to do?  Is this the equivalent of "direct
> reclaim"?  Why do we need this in addition to the ksgxswapd?

It tries to direct reclaim. Ugh, that schedule() call does not make
much sense though...

> > +	}
> > +
> > +	if (atomic_read(&sgx_nr_free_pages) < SGX_NR_LOW_PAGES)
> > +		wake_up(&ksgxswapd_waitq);
> > +
> > +	return entry;
> > +}
> > +EXPORT_SYMBOL(sgx_alloc_page);
> 
> Why aren't these _GPL exports?

Source files a dual licensed.

> > +/**
> > + * sgx_free_page - free an EPC page
> > + *
> > + * @page:	any EPC page
> > + *
> > + * Remove an EPC page and insert it back to the list of free pages.
> > + *
> > + * Return: SGX error code
> > + */
> > +int sgx_free_page(struct sgx_epc_page *page)
> > +{
> > +	struct sgx_epc_bank *bank = SGX_EPC_BANK(page);
> > +	int ret;
> > +
> > +	ret = sgx_eremove(page);
> > +	if (ret) {
> > +		pr_debug("EREMOVE returned %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	down_read(&bank->lock);
> > +	bank->pages[atomic_inc_return(&bank->free_cnt) - 1] = page;
> > +	atomic_inc(&sgx_nr_free_pages);
> > +	up_read(&bank->lock);
> > +
> > +	return 0;
> > +}
> 
> bank->lock confuses me.  This seems to be writing to a bank, but only
> needs a read lock.  Why?

It could be either way around:

1. Allow multiple threads that free a page to access the array.
2. Allow multiple threads that alloc a page to access the array.

> > +/**
> > + * sgx_get_page - pin an EPC page
> > + * @page:	an EPC page
> > + *
> > + * Return: a pointer to the pinned EPC page
> > + */
> > +void *sgx_get_page(struct sgx_epc_page *page)
> > +{
> > +	struct sgx_epc_bank *bank = SGX_EPC_BANK(page);
> > +
> > +	if (IS_ENABLED(CONFIG_X86_64))
> > +		return (void *)(bank->va + SGX_EPC_ADDR(page) - bank->pa);
> > +
> > +	return kmap_atomic_pfn(SGX_EPC_PFN(page));
> > +}
> > +EXPORT_SYMBOL(sgx_get_page);
> 
> This is odd.  Do you really want to detect 64-bit, or CONFIG_HIGHMEM?

For 32-bit (albeit not supported at this point) it makes sense to always
use kmap_atomic_pfn() as the virtua address area is very limited.

> > +struct page *sgx_get_backing(struct file *file, pgoff_t index)
> > +{
> > +	struct inode *inode = file->f_path.dentry->d_inode;
> > +	struct address_space *mapping = inode->i_mapping;
> > +	gfp_t gfpmask = mapping_gfp_mask(mapping);
> > +
> > +	return shmem_read_mapping_page_gfp(mapping, index, gfpmask);
> > +}
> > +EXPORT_SYMBOL(sgx_get_backing);
> 
> What does shmem have to do with all this?

Backing storage is an shmem file similarly is in drm.

> > +void sgx_put_backing(struct page *backing_page, bool write)
> > +{
> > +	if (write)
> > +		set_page_dirty(backing_page);
> > +
> > +	put_page(backing_page);
> > +}
> > +EXPORT_SYMBOL(sgx_put_backing);
> 
> I'm not a big fan of stuff getting added with no apparent user and no
> explaination of what it is doing.  There's no way for me to assess
> whether this is sane or not.

I'll add the documetation.

> > +static __init int sgx_page_cache_init(void)
> > +{
> > +	struct task_struct *tsk;
> > +	unsigned long size;
> > +	unsigned int eax;
> > +	unsigned int ebx;
> > +	unsigned int ecx;
> > +	unsigned int edx;
> > +	unsigned long pa;
> > +	int i;
> > +	int ret;
> > +
> > +	for (i = 0; i < SGX_MAX_EPC_BANKS; i++) {
> > +		cpuid_count(SGX_CPUID, i + SGX_CPUID_EPC_BANKS, &eax, &ebx,
> > +			    &ecx, &edx);
> > +		if (!(eax & 0xf))
> > +			break;
> > +
> > +		pa   = ((u64)(ebx & 0xfffff) << 32) + (u64)(eax & 0xfffff000);
> > +		size = ((u64)(edx & 0xfffff) << 32) + (u64)(ecx & 0xfffff000);
> 
> Please align these like I did ^
> 
> > +		pr_info("EPC bank 0x%lx-0x%lx\n", pa, pa + size);
> > +
> > +		ret = sgx_init_epc_bank(pa, size, i, &sgx_epc_banks[i]);
> > +		if (ret) {
> > +			sgx_page_cache_teardown();
> > +			return ret;
> > +		}
> > +
> > +		sgx_nr_epc_banks++;
> > +	}
> 
> This is also rather sparsely commented.
> 
> > +static __init bool sgx_is_enabled(bool *lc_enabled)
> >  {
> >  	unsigned long fc;
> >  
> > @@ -41,12 +466,26 @@ static __init bool sgx_is_enabled(void)
> >  	if (!(fc & FEATURE_CONTROL_SGX_ENABLE))
> >  		return false;
> >  
> > +	*lc_enabled = !!(fc & FEATURE_CONTROL_SGX_LE_WR);
> > +
> >  	return true;
> >  }
> 
> I'm baffled why lc_enabled is connected to the enclave page cache.

KVM works only with writable MSRs. Driver works both with writable
and read-only MSRs.

Thanks, I'll try my best to deal with all this :-)

/Jarkko
