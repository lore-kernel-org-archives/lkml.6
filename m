Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE1EC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A952084E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rccc7BFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbfALPt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 10:49:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40298 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfALPtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 10:49:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=E5jeThNuXJiosx7Bk1oeBAmKTo11eywDu/ykXx4V/zo=; b=rccc7BFOuB4X/7wNfKDBViyyw
        tCIq00thjE8uBpRc2EMKCYg5Pjp4pL5OD8AkcjqW5KJKQYIqo0djjpzork/c108Trm/6QyapyO3DC
        hU7wELBi+gG1L1fDiiyok/NRypETF5628z9SQ0EAS7cNcGp3EUvUu864qCBeiplTY1rTPwtjPS0Fp
        2lhX45+RO4vzvcTo/lAzPKzmJ8xOYJe54ylsedrg2VIUSKglaC1737qr31qWSqgl8CW0YCdM5D9R1
        dzSpWXEq2u0NZuZtlrmd9FIUNx8PQQpuI6MgJo/7FEp0Vp67At7crqTQ9StU23rHHuNQEIaLpjgiM
        RcF5Bo9Ng==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giLXc-0000SR-TQ; Sat, 12 Jan 2019 15:49:44 +0000
Date:   Sat, 12 Jan 2019 07:49:44 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        mark.rutland@arm.com, mhocko@suse.com, linux-sh@vger.kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kvmarm@lists.cs.columbia.edu, linux@armlinux.org.uk,
        mingo@redhat.com, vbabka@suse.cz, rientjes@google.com,
        marc.zyngier@arm.com, rppt@linux.vnet.ibm.com, shakeelb@google.com,
        kirill@shutemov.name, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org,
        robin.murphy@arm.com, steve.capper@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] mm: Introduce GFP_PGTABLE
Message-ID: <20190112154944.GT6310@bombadil.infradead.org>
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
 <20190112121230.GQ6310@bombadil.infradead.org>
 <ddd59fdc-3d8f-4015-e851-e7f099193a1b@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddd59fdc-3d8f-4015-e851-e7f099193a1b@c-s.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 02:49:29PM +0100, Christophe Leroy wrote:
> As far as I can see,
> 
> #define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)
> 
> So what's the difference between:
> 
> (GFP_KERNEL_ACCOUNT | __GFP_ZERO) & ~__GFP_ACCOUNT
> 
> and
> 
> (GFP_KERNEL | __GFP_ZERO) & ~__GFP_ACCOUNT

Nothing.  But there's a huge difference in the other parts of that same
file where GFP_ACCOUNT is _not_ used.

I think this unification is too small to bother with.  Something I've
had on my todo list for some time and have not done anything about
is to actually unify all of the architecture pte/pmd/... allocations.
There are tricks some architectures use that others would benefit from.
