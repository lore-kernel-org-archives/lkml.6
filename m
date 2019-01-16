Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E93CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694812082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SoTUyiVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbfAPMep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:34:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38602 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732893AbfAPMep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kdLgW2R9CJvQxIJIOAnAx5HXf5S0hb4dQove9xHN/r8=; b=SoTUyiVrNcTQA6U6c7sP5Vun8
        NwFfkQcvDm19s+uGH+1Ungv2ayWinjciCJAvNaRtxRFWO8KHbdqpzPW4v9EFGE52DycDoCkO8eS+d
        MLNzT9KvItxbpLhzKdmmbxL1TKynQtohxPnAgsTzzYuX9P9BXAEwgUifnBneZyqVv7KU4alrjzF3x
        It6QmbByG6Mb3nSuTwgtx9eVK9uuj5lJg3/YqL1Uh6lRQXpnRvn4N/n/Mi8P78Y3yjj0i2lPdJ42+
        GOUbI8kGZNteaLq22CnzmKIN0cU0iYZDhiDPqM9nMxi8YYXqXlIkjokAEmBII6BBXOcNMMBfA7sjW
        fAeP4B3IQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjkOr-0004dF-9T; Wed, 16 Jan 2019 12:34:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A441B2029D919; Wed, 16 Jan 2019 13:34:27 +0100 (CET)
Date:   Wed, 16 Jan 2019 13:34:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-riscv@lists.infradead.org,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, mpe@ellerman.id.au, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com,
        christoffer.dall@arm.com, marc.zyngier@arm.com,
        kirill@shutemov.name, rppt@linux.vnet.ibm.com,
        ard.biesheuvel@linaro.org, mark.rutland@arm.com,
        steve.capper@arm.com, james.morse@arm.com, robin.murphy@arm.com,
        aneesh.kumar@linux.ibm.com, vbabka@suse.cz, shakeelb@google.com,
        rientjes@google.com, palmer@sifive.com, greentime@andestech.com
Subject: Re: [PATCH V2] mm: Introduce GFP_PGTABLE
Message-ID: <20190116123427.GE10803@hirez.programming.kicks-ass.net>
References: <1547619692-7946-1-git-send-email-anshuman.khandual@arm.com>
 <20190116065703.GE24149@dhcp22.suse.cz>
 <20190116123018.GF6310@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116123018.GF6310@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 04:30:18AM -0800, Matthew Wilcox wrote:
> On Wed, Jan 16, 2019 at 07:57:03AM +0100, Michal Hocko wrote:
> > On Wed 16-01-19 11:51:32, Anshuman Khandual wrote:
> > > All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
> > > __GFP_ZERO) and using it for allocating page table pages. This causes some
> > > code duplication which can be easily avoided. GFP_KERNEL allocated and
> > > cleared out pages (__GFP_ZERO) are required for page tables on any given
> > > architecture. This creates a new generic GFP flag flag which can be used
> > > for any page table page allocation. Does not cause any functional change.
> > > 
> > > GFP_PGTABLE is being added into include/asm-generic/pgtable.h which is the
> > > generic page tabe header just to prevent it's potential misuse as a general
> > > allocation flag if included in include/linux/gfp.h.
> > 
> > I haven't reviewed the patch yet but I am wondering whether this is
> > really worth it without going all the way down to unify the common code
> > and remove much more code duplication. Or is this not possible for some
> > reason?
> 
> Exactly what I suggested doing in response to v1.
> 
> Also, the approach taken here is crazy.  x86 has a feature that no other
> architecture has bothered to implement yet -- accounting page tables
> to the process.  Yet instead of spreading that goodness to all other
> architectures, Anshuman has gone to more effort to avoid doing that.

Also, s390 (of course, who else) has a fun custom page-table allocator
for reasons that don't apply to many other archs.
