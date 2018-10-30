Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997C6ECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BB12081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WDaqQ8Ib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62BB12081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeJaAxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:53:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39918 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeJaAxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RFzKLO3kQlJcnRgjOw2V4E4qiSf0NluBsPpJ9q2ybN4=; b=WDaqQ8IbZ7+pbVWSE7/FSxJDS
        yQlcYp773w/gAuZ0E2/nPCuTmGt3GCfxTPfypnNAZAsB0S9zArrdwNsZlowxYqZi7jZ7zAdNNsKrP
        diVY7gHHlDOMX6I4cS8E3xdpXDNvmjBE9gHtXYK4yPUx7tcOs+iss7vDBmsB9mvw6ePJiMhIYo2jj
        9D0pT8t3Bh+cSH0in4oJfyd75A8+C70DGQQ+caSSLKu9wmUuMc3q82S/fBXcw+pwjkeDAus1WhoLz
        XM15gffa++j07ir+bvoB6F6OcMbQEvS7dfqOFAaGqZgHPuTtIcxwAAwmmrhkRi+A/43QBXCMZItmK
        6tHA/iSzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHWPj-0004WZ-Ci; Tue, 30 Oct 2018 15:58:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8D8042029FA14; Tue, 30 Oct 2018 16:58:41 +0100 (CET)
Date:   Tue, 30 Oct 2018 16:58:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, igor.stoppa@huawei.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/17] prmem: pratomic-long
Message-ID: <20181030155841.GF8177@hirez.programming.kicks-ass.net>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-17-igor.stoppa@huawei.com>
 <20181025001312.GA3159@worktop.c.hoisthospitality.com>
 <806bfff0-8d62-9918-480d-ec791b93841e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <806bfff0-8d62-9918-480d-ec791b93841e@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 11:17:14PM +0200, Igor Stoppa wrote:
> 
> 
> On 25/10/2018 01:13, Peter Zijlstra wrote:
> > On Wed, Oct 24, 2018 at 12:35:03AM +0300, Igor Stoppa wrote:
> > > +static __always_inline
> > > +bool __pratomic_long_op(bool inc, struct pratomic_long_t *l)
> > > +{
> > > +	struct page *page;
> > > +	uintptr_t base;
> > > +	uintptr_t offset;
> > > +	unsigned long flags;
> > > +	size_t size = sizeof(*l);
> > > +	bool is_virt = __is_wr_after_init(l, size);
> > > +
> > > +	if (WARN(!(is_virt || likely(__is_wr_pool(l, size))),
> > > +		 WR_ERR_RANGE_MSG))
> > > +		return false;
> > > +	local_irq_save(flags);
> > > +	if (is_virt)
> > > +		page = virt_to_page(l);
> > > +	else
> > > +		vmalloc_to_page(l);
> > > +	offset = (~PAGE_MASK) & (uintptr_t)l;
> > > +	base = (uintptr_t)vmap(&page, 1, VM_MAP, PAGE_KERNEL);
> > > +	if (WARN(!base, WR_ERR_PAGE_MSG)) {
> > > +		local_irq_restore(flags);
> > > +		return false;
> > > +	}
> > > +	if (inc)
> > > +		atomic_long_inc((atomic_long_t *)(base + offset));
> > > +	else
> > > +		atomic_long_dec((atomic_long_t *)(base + offset));
> > > +	vunmap((void *)base);
> > > +	local_irq_restore(flags);
> > > +	return true;
> > > +
> > > +}
> > 
> > That's just hideously nasty.. and horribly broken.
> > 
> > We're not going to duplicate all these kernel interfaces wrapped in gunk
> > like that.
> 
> one possibility would be to have macros which use typeof() on the parameter
> being passed, to decide what implementation to use: regular or write-rare
> 
> This means that type punning would still be needed, to select the
> implementation.
> 
> Would this be enough? Is there some better way?

Like mentioned elsewhere; if you do write_enable() + write_disable()
thingies, it all becomes:

	write_enable();
	atomic_foo(&bar);
	write_disable();

No magic gunk infested duplication at all. Of course, ideally you'd then
teach objtool about this (or a GCC plugin I suppose) to ensure any
enable reached a disable.

The alternative is something like:

#define ALLOW_WRITE(stmt) do { write_enable(); do { stmt; } while (0); write_disable(); } while (0)

which then allows you to write:

	ALLOW_WRITE(atomic_foo(&bar));

No duplication.

> > Also, you _cannot_ call vunmap() with IRQs disabled. Clearly
> > you've never tested this with debug bits enabled.
> 
> I thought I had them. And I _did_ have them enabled, at some point.
> But I must have messed up with the configuration and I failed to notice
> this.
> 
> I can think of a way it might work, albeit it's not going to be very pretty:
> 
> * for the vmap(): if I understand correctly, it might sleep while obtaining
> memory for creating the mapping. This part could be executed before
> disabling interrupts. The rest of the function, instead, would be executed
> after interrupts are disabled.
> 
> * for vunmap(): after the writing is done, change also the alternate mapping
> to read only, then enable interrupts and destroy the alternate mapping.
> Making also the secondary mapping read only makes it equally secure as the
> primary, which means that it can be visible also with interrupts enabled.

That doesn't work if you wanted to do this write while you already have
IRQs disabled for example.


