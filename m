Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAA4C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB47245E7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB47245E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933713AbeGDHkf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:40:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46350 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933581AbeGDHkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:40:33 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1facOm-0000qd-VX; Wed, 04 Jul 2018 09:40:25 +0200
Date:   Wed, 4 Jul 2018 09:40:24 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Yang, Bin" <bin.yang@intel.com>
cc:     "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/mm: fix cpu stuck issue in
 __change_page_attr_set_clr
In-Reply-To: <0131cecd5d0456c2a109f4b8bdbfe558389671dd.camel@intel.com>
Message-ID: <alpine.DEB.2.21.1807040849520.1816@nanos.tec.linutronix.de>
References: <1530180340-18593-1-git-send-email-bin.yang@intel.com>  <alpine.DEB.2.21.1807031442030.1601@nanos.tec.linutronix.de> <0131cecd5d0456c2a109f4b8bdbfe558389671dd.camel@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.21.1807040907001.1816@nanos.tec.linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018, Yang, Bin wrote:
> thanks for reviewing my patch. I will update a new patch version based
> on your feedback soon

Take your time.

> On Tue, 2018-07-03 at 15:57 +0200, Thomas Gleixner wrote:
> Below is the new commit comment I will use in new patch version soon

> > Please do not use the output of git show for submitting a patch. Use
> > git format-patch(1).  >
>
> I use "git send-email -1" to submit patch for review. Should I run "git
> format-patch" first and send the patch as email?

git send-email is fine, but it should not result in the changelog being
indented by a bunch of spaces. That's why I assumed that you used git show
because that's exacty the format. I'm not using it, so I can't give you
advise there.

> ===========
> If cpu supports "pdpe1gb", kernel will try its best to use 1G big page.
> When changing a 4K page attr inside 1G page range, __change_page_attr()
> will either consume this 4K page into the 1G page, or it splits 1G page
> into 2M pages and tries again. The retry will either consume the 4K
> page into a 2MB page, or it splits 2MB page into 4K pages.
> try_preserve_large_page() is called by __change_page_attr() to decide

I know what calls try_preserve_large_page(), but you still fail to explain
the full call chain including parameters which I asked for.

> it by checking all 4K pages inside the big page one by one.

After your change this will still happen. You just shortcut the inner
workings, but you are still not explaining why the shortcut is necessary in
the first place.

The try_preserve_large_page() logic should not need any of this unless
there is a subtle implementation bug. If that's the case, then the bug
needs to be isolated and fixed and not papered over by magic short cuts.

> This issue is discovered during kernel boot time optimization.
> Sometimes, free_initmem() returns after about 600ms on my x86_64 board
> with 4GB memory.
> 
> Since it is a common issue of x86_64, it can be reproduced by qemu too.
> We can add some logs in try_preserve_large_page() function to measure
> the loop count and elapsed time. Please make sure the host CPU has
> "pdpe1gb" flag and run below qemu command to reproduce it:
> 
> qemu-system-x86_64 -enable-kvm -cpu host -serial mon:stdio -m 4G
> -nographic -kernel bzImage -initrd ramdisk.img -append "console=ttyS0"
> 
> Since default x86_64 kernel enables CONFIG_RANDOMIZE_BASE, it needs to

Huch? What as this to do with randomize base?

> try many times to let init memory be randomized in a 1G page range.

And no, I'm not interested in random qemu commands and adding logs into
something. You already did the investigation, but you fail to provide the
information. And I'm not asking for random timing logs, I ask about a
proper explanation why this happens even if it's supposed not to happen.

> This patch try to cache the last address which had been checked just

See Documentation/process/submitting-patches.rst and search for 'This
patch' ....

> now. If the next address is in same big page with same attr, the cache
> will be used without full range check.

> > > @@ -552,16 +552,20 @@ static int
> > >  try_preserve_large_page(pte_t *kpte, unsigned long address,
> > >  			struct cpa_data *cpa)
> > >  {
> > > +	static unsigned long address_cache;
> > > +	static unsigned long do_split_cache = 1;
> > 
> > What are the life time and protection rules of these static variables
> > and
> > why are they static in the first place.
> 
> they will be protected by pgd_lock. They only cache previous "do_split"
> result and will be refreshed every time.

So why is there no comment explaining this? And I'm still not convinced
about pgd_lock being the real protection. pgd_lock protects against
concurrent page table manipulations, but it does not protect against
concurrent calls of the change_page_attr logic at all. That's what cpa_lock
does.

> > >  	unsigned long nextpage_addr, numpages, pmask, psize, addr,
> > > pfn, old_pfn;
> > >  	pte_t new_pte, old_pte, *tmp;
> > >  	pgprot_t old_prot, new_prot, req_prot;
> > >  	int i, do_split = 1;
> > >  	enum pg_level level;
> > >  
> > > -	if (cpa->force_split)
> > > +	spin_lock(&pgd_lock);
> > > +	if (cpa->force_split) {
> > > +		do_split_cache = 1;
> > 
> > Returns with pgd_lock held which will immediately lockup the system
> > on the
> > next spin_lock(&pgd_lock) operation.
> I am so sorry to make such stupid mistake. force_split was not hit on
> my board :(
> > 
> > Also what's the point of storing the already available information of
> > cpa->force_split in yet another variable? This enforces taking the
> > lock on
> > every invocation for no reason.
> As you know, do_split is initialized as 1. If do_split_cache == 1, the
> cache value will not be used. If force_split == 1, cache value should
> be expired. Since do_split_cache is protected by this lock, it needs to
> task this lock here.

No. It can be done w/o the lock and without touching the cache
variable. cpa->force_split does not need any of it.

> > > +	/*
> > > +	 * If an address in same range had been checked just now,
> > > re-use the
> > > +	 * cache value without full range check. In the worst
> > > case, it needs to
> > > +	 * check every 4K page in 1G range, which causes cpu stuck
> > > for long
> > > +	 * time.
> > > +	 */
> > > +	if (!do_split_cache &&
> > > +	    address_cache >= addr && address_cache < nextpage_addr
> > > &&
> > 
> > On the first call, address_cache contains 0. On any subsequent call
>
> on the first call, do_split_cache is 1. if do_split_cache == 1,
> address_cache will not be used.

That's really not obvious and the whole code flow is obfuscated.

> > > @@ -670,6 +686,8 @@ try_preserve_large_page(pte_t *kpte, unsigned
> > > long address,
> > >  	}
> > >  
> > >  out_unlock:
> > > +	address_cache = address;
> > > +	do_split_cache = do_split;
> > >  	spin_unlock(&pgd_lock);
> > 
> > So here you store the 'cache' values and while this code suggests
> > that it
> > protects the 'cache' via pgd_lock (due to lack of comments), the
> > protection
> > is actually cpa_lock.
> > 
> > But, that cache information stays around when cpa_lock is dropped,
> > i.e. when the current (partial) operation has been done and this
> > information stays stale for the next user. That does not make sense.
> 
> __change_page_attr is the only function to change page attr and
> try_preserve_large_page will be called every time for big page check.
> If a big page had been splitted, it will not be merged again. So it is
> safe to cache previous result in try_preserve_large_page() function.

Come on. __change_page_attr() has a single call site:
__change_page_attr_set_clr() which itself is called from a ton of places.
And once cpa_lock is dropped in the loop, the 'cache' thing is not longer
protected and and stale.

Unless it's coherentely explained, this looks more like works by chance
than by design.

Thanks,

	tglx
