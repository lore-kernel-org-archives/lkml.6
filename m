Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB922C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF022190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JZg0HPf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391785AbeLUTn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:43:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60006 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389698AbeLUTn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kA78ajiCCgzgrzC4KMHQxEt9vGXQoYC7epprdY+vrYM=; b=JZg0HPf49GS/MoBVH4WBbP0Un
        ozYQHGixHeOQk5SCk88BGtKHG+UC9TpSpbQTFt3tCGjl2mbOF1LEE730/2N8823qf1Q930D9JWPhA
        mQcWtcnzXn4ck8qPZflSWE2bY2koIptyiYMrQCM0soT5cglVnBVEMpTwayVyruB90XU4tKxpw5aly
        2LN4ACdIkFf14gfSm7QXavJ+R4xfdTOP4yLBcoJyUS5Ij2JwREzlRN+8/Xk35f9N9/2j7iyiBT6rA
        z0mh9q+kCaprNBc+N6OxD0+vA4leZ2FSaSkAGkqh738UswrHkv5rLYNaJ8T1LeBLPtctqXxQNTM1Z
        DUNUhgPgg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gaQi7-0000t6-Na; Fri, 21 Dec 2018 19:43:51 +0000
Date:   Fri, 21 Dec 2018 11:43:51 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] __wr_after_init: generic functionality
Message-ID: <20181221194351.GH10600@bombadil.infradead.org>
References: <20181221181423.20455-1-igor.stoppa@huawei.com>
 <20181221181423.20455-4-igor.stoppa@huawei.com>
 <20181221184120.GG10600@bombadil.infradead.org>
 <14487401-dec3-6a7d-a0b1-e369e93aa9c4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14487401-dec3-6a7d-a0b1-e369e93aa9c4@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 09:07:54PM +0200, Igor Stoppa wrote:
> On 21/12/2018 20:41, Matthew Wilcox wrote:
> > On Fri, Dec 21, 2018 at 08:14:14PM +0200, Igor Stoppa wrote:
> > > +static inline int memtst(void *p, int c, __kernel_size_t len)
> > 
> > I don't understand why you're verifying that writes actually happen
> > in production code.  Sure, write lib/test_wrmem.c or something, but
> > verifying every single rare write seems like a mistake to me.
> 
> This is actually something I wrote more as a stop-gap.
> I have the feeling there should be already something similar available.
> And probably I could not find it. Unless it's so trivial that it doesn't
> deserve to become a function?
> 
> But if there is really no existing alternative, I can put it in a separate
> file.

I'm not questioning the implementation, I'm questioning why it's ever
called.  If I type 'p = q', I don't then verify that p actually is equal
to q.  I just assume that the compiler did its job.

> > > +#ifndef CONFIG_PRMEM
> > 
> > So is this PRMEM or wr_mem?  It's not obvious that CONFIG_PRMEM controls
> > wrmem.
> 
> In my mind (maybe still clinging to the old implementation), PRMEM is the
> master toggle, for protected memory.
> 
> Then there are various types and the first one being now implemented is
> write rare after init (because ro after init already exists).
> 
> However, the same levels of protection should then follow for dynamically
> allocated memory (ye old pmalloc).
> 
> PRMEM would then become the moniker for the whole shebang.

To my mind, what we have in this patchset is support for statically
allocated protected (or write-rare) memory.  Later, we'll add dynamically
allocated protected memory.  So it's all protected memory, and we'll
use the same accessors for both ... right?

> > > +#define wr_rcu_assign_pointer(p, v)	rcu_assign_pointer(p, v)
> > > +#define wr_assign(var, val) ({			\
> > > +	typeof(var) tmp = (typeof(var))val;	\
> > > +						\
> > > +	wr_memcpy(&var, &tmp, sizeof(var));	\
> > > +	var;					\
> > > +})
> > 
> > Doesn't wr_memcpy return 'var' anyway?
> 
> It should return the destination, which is &var.
> 
> But I wanted to return the actual value of the assignment, val
> 
> Like if I do  (a = 7)  it evaluates to 7,
> 
> similarly wr_assign(a, 7) would also evaluate to 7
> 
> The reason why i returned var instead of val is that it would allow to
> detect any error.

Ah, good point; I missed the var vs &var distinction.

> > > +void *wr_memcpy(void *p, const void *q, __kernel_size_t size)
> > > +{
> > > +	wr_state_t wr_state;
> > > +	void *wr_poking_addr = __wr_addr(p);
> > > +
> > > +	if (WARN_ONCE(!wr_ready, "No writable mapping available") ||
> > 
> > Surely not.  If somebody's called wr_memcpy() before wr_ready is set,
> > that means we can just call memcpy().
> 
> What I was trying to catch is the case where, after a failed init, the
> writable mapping doesn't exist. In that case wr_ready is also not set.
> 
> The problem is that I just don't know what to do in a case where there has
> been such a major error which prevents he creation of hte alternate mapping.
> 
> I understand that we still want to continue, to provide as much debug info
> as possible, but I am at a loss about finding the saner course of actions.

I don't think there's anything to be done in that case.  Indeed,
I think the only thing to do is panic and stop the whole machine if
initialisation fails.  We'd be in a situation where nothing can update
protected memory, and the machine just won't work.

I suppose we could "fail insecure" and never protect the memory, but I
think that's asking for trouble.

Anyway, my concern was for a driver which can be built either as a
module or built-in.  Its init code will be called before write-protection
happens when it's built in, and after write-protection happens when it's
a module.  It should be able to use wr_assign() in either circumstance.
One might also have a utility function which is called from both init
and non-init code and want to use wr_assign() whether initialisation
has completed or not.
