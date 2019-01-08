Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8E6C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7AF2217D9
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546968588;
	bh=463rTfsVfYKLfsiycL5S1KPF2PFNSXn/kblxkJt2nl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yiMRN82XXSZJFUwFMHeY5HwyewEpy/DLBgcVW7AWa3YTz+Z6LucXg6dfEzL3uGNcL
	 Z9U5NY/mu7CBxfpStPVYErfg69I+J7sk50/EfWqUMSOjVfCK9yZe+1IsYy7H6mhVwU
	 AuUhQENdmzvmJ/fwsScvle7RpH0E//FJjAUgzJJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfAHR3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:29:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:58100 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728402AbfAHR3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:29:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2BCDEAFCE;
        Tue,  8 Jan 2019 17:29:46 +0000 (UTC)
Date:   Tue, 8 Jan 2019 18:29:45 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.0-rc1 (test results)
Message-ID: <20190108172945.GG31793@dhcp22.suse.cz>
References: <CAHk-=wgKYnrL3LjhVkH2Fp+ecmWhLqezT9zmR6CzfcpwcJX0qA@mail.gmail.com>
 <20190107192648.GA10789@roeck-us.net>
 <CAHk-=wjt6oKtYuJ-EOGSO1m8vBdPa+g2_6WZ6MKCwfu4afoSrw@mail.gmail.com>
 <20190108095107.GA25409@guoren-Inspiron-7460>
 <20190108154031.GB343@dhcp22.suse.cz>
 <20190108161659.GA26358@guoren-Inspiron-7460>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108161659.GA26358@guoren-Inspiron-7460>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-01-19 00:16:59, Guo Ren wrote:
> Thx Michal,
> 
> On Tue, Jan 08, 2019 at 04:40:31PM +0100, Michal Hocko wrote:
> > On Tue 08-01-19 17:51:07, Guo Ren wrote:
> > [...]
> > > static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
> > > {
> > > 	pte_t *pte;
> > > 	unsigned long i;
> > > 
> > > 	pte = (pte_t *) __get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL);
> > > 						     ^^^^^^^^^^^^^^^^^^^
> > > 						     It's necessary ?
> > > 						     x86 & arm don't use
> > > 						     it.
> > > 	if (!pte)
> > > 		return NULL;
> > 
> > That depends on whether you want OOM killer to be triggered for these
> > allocations. If you add the flag then the allocation bails out with a
> > failure rather than kill an oom victim.
> 
> Yes, in page_alloc.c: 
> 	if (gfp_mask & __GFP_RETRY_MAYFAIL)
> 		goto out;
> 	...
> 	if (out_of_memory(&oc) || WARN_ON_ONCE(gfp_mask & __GFP_NOFAIL)) {
>             ^^^^^^^^^^^^^ OOM kill victim
> 	...
> 		if (gfp_mask & __GFP_NOFAIL)
> 			page = __alloc_pages_cpuset_fallback(gfp_mask, order,
> 					ALLOC_NO_WATERMARKS, ac);
> 	}

Btw. we have that nice documentation in gfp.h. I would encourage you to
read through that rather than try to imply the semantic from the
implementation.

> Seems it could affect the behavior of the system which is out of memory.
> OOM killer could help to get_page for current. So keep the same as x86 &
> arm here. I'll remove __GFP_RETRY_MAYFAIL in patch.

OK

-- 
Michal Hocko
SUSE Labs
