Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64590C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D01D224DC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D01D224DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752997AbeGDSYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 14:24:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:22338 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752622AbeGDSYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 14:24:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 11:24:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,308,1526367600"; 
   d="scan'208";a="54460399"
Received: from saamir-mobl.ger.corp.intel.com (HELO localhost) ([10.252.34.242])
  by orsmga008.jf.intel.com with ESMTP; 04 Jul 2018 11:24:20 -0700
Date:   Wed, 4 Jul 2018 21:24:19 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        linux-sgx@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 09/13] x86/sgx: EPC page allocation routines
Message-ID: <20180704182419.GO6724@linux.intel.com>
References: <20180703182118.15024-1-jarkko.sakkinen@linux.intel.com>
 <20180703182118.15024-10-jarkko.sakkinen@linux.intel.com>
 <alpine.DEB.2.21.1807032216390.1816@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807032216390.1816@nanos.tec.linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 10:41:14PM +0200, Thomas Gleixner wrote:
> On Tue, 3 Jul 2018, Jarkko Sakkinen wrote:
> >  
> > +#define SGX_NR_TO_SCAN	16
> > +#define SGX_NR_LOW_PAGES 32
> > +#define SGX_NR_HIGH_PAGES 64
> > +
> >  bool sgx_enabled __ro_after_init;
> >  EXPORT_SYMBOL(sgx_enabled);
> >  bool sgx_lc_enabled __ro_after_init;
> >  EXPORT_SYMBOL(sgx_lc_enabled);
> > +LIST_HEAD(sgx_active_page_list);
> > +EXPORT_SYMBOL(sgx_active_page_list);
> > +DEFINE_SPINLOCK(sgx_active_page_list_lock);
> > +EXPORT_SYMBOL(sgx_active_page_list_lock);
> 
> Why is all of this exported. If done right then no call site has to fiddle
> with the list and the lock at all.

We can fix this in a way that these exports are not needed. Thanks
for pointing this out.

> >  static atomic_t sgx_nr_free_pages = ATOMIC_INIT(0);
> >  static struct sgx_epc_bank sgx_epc_banks[SGX_MAX_EPC_BANKS];
> >  static int sgx_nr_epc_banks;
> > +static struct task_struct *ksgxswapd_tsk;
> > +static DECLARE_WAIT_QUEUE_HEAD(ksgxswapd_waitq);
> > +
> > +static void sgx_swap_cluster(void)
> > +{
> > +	struct sgx_epc_page *cluster[SGX_NR_TO_SCAN + 1];
> > +	struct sgx_epc_page *epc_page;
> > +	int i;
> > +	int j;
> 
>   	int i, j;

I've always preferred single declaration per line even for index
variables but not something that I'm going to argue about too
much.

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
> > +
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
> 
> Thanks a lot for commenting this piece of art thoughtfully. It's entirely
> clear how all of this works now.

Got your point.

> > +}
> > +
> > +static int ksgxswapd(void *p)
> > +{
> > +	set_freezable();
> > +
> > +	while (!kthread_should_stop()) {
> > +		if (try_to_freeze())
> > +			continue;
> > +
> > +		wait_event_freezable(ksgxswapd_waitq, kthread_should_stop() ||
> > +				     atomic_read(&sgx_nr_free_pages) <
> > +				     SGX_NR_HIGH_PAGES);
> > +
> > +		if (atomic_read(&sgx_nr_free_pages) < SGX_NR_HIGH_PAGES)
> > +			sgx_swap_cluster();
> > +	}
> > +
> > +	pr_info("%s: done\n", __func__);
> 
> Really useful. 

Forgotten cruft, will remove.

> > +	return 0;
> > +}
> > +
> > +static struct sgx_epc_page *sgx_try_alloc_page(struct sgx_epc_page_impl *impl)
> > +{
> > +	struct sgx_epc_bank *bank;
> > +	struct sgx_epc_page *page = NULL;
> > +	int i;
> > +
> > +	for (i = 0; i < sgx_nr_epc_banks; i++) {
> > +		bank = &sgx_epc_banks[i];
> > +
> > +		down_write(&bank->lock);
> > +
> > +		if (atomic_read(&bank->free_cnt))
> 
> And these atomics are required becasue bank->lock protection is not
> sufficient or what am I missing here?

This is also response to your comment below. It would be better idea
to just use a spinlock I guess. Seeing your and Daves point.

> > +			page = bank->pages[atomic_dec_return(&bank->free_cnt)];
> > +
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
> > +
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
> > +	}
> > +
> > +	if (atomic_read(&sgx_nr_free_pages) < SGX_NR_LOW_PAGES)
> > +		wake_up(&ksgxswapd_waitq);
> 
> What's the logic of SGX_NR_LOW_PAGES vs. SGX_NR_HIGH_PAGES? 

If the number of pages goes below SGX_NR_LOW_PAGES ksgxswapd swaps pages
up until SGX_NR_HIGH_PAGES is reached.

> 
> > +
> > +	return entry;
> > +}
> > +EXPORT_SYMBOL(sgx_alloc_page);
> > +
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
> 
> I have hard time to see the benefit of this reader/writer semaphore
> here. Both sides which fiddle with the bank pages are doing a simple
> de/increment of free_cnt and a store resp. load. So what justifies the
> overhead of a rwsem?



> 
> >  static __init int sgx_init_epc_bank(unsigned long addr, unsigned long size,
> >  				    unsigned long index,
> >  				    struct sgx_epc_bank *bank)
> > @@ -114,6 +318,11 @@ static __init void sgx_page_cache_teardown(void)
> >  		kfree(bank->pages);
> >  		kfree(bank->pages_data);
> >  	}
> > +
> > +	if (ksgxswapd_tsk) {
> > +		kthread_stop(ksgxswapd_tsk);
> > +		ksgxswapd_tsk = NULL;
> 
> This stops the thread _AFTER_ freeing all the bank memory. Is that actually
> correct?

Should not cause any actual regressions but is a flakky order anyway
so I will change it.

/Jarkko
