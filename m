Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8E9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912ED21902
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qZiFOjmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfBTPDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:03:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54700 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfBTPC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oZBfBU4jWxNSshmOOtCHrGGSxVl/3qP/1xb30w4GIow=; b=qZiFOjmGGXLVTNULdyIQOXN6j
        qkQrNwxu5hyCOtMVdQ3zUyEW8qoQaD05FL0B+v8rv8OS5B5Inv+lLU0GITzVKL3d8/w5GQxV2lrdL
        HIdeMo1PpxLAtqhg+CmHpPmiULTPbmeJXR0/ydG3/rxopoY7aA9SwOP4wElpS1FRulpa26wYdKbLs
        g2pTzTNz1zwloHDjfcWLkjauRC7zQlFHyVJjibJPIJaKzifpuy95SOmRHPXloeWUTZ1zlP9kOiC7Q
        hhFYP7riOX85dKjb75YnVopzw7RBdtOtIXyqTZ1k3lxOcOtKDVHXVw71d6Bwbg/vzC6ULoPGhsIBs
        RCeOIDBBQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwTOf-0005pU-N1; Wed, 20 Feb 2019 15:02:53 +0000
Date:   Wed, 20 Feb 2019 07:02:53 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com, riel@surriel.com, tony.luck@intel.com
Subject: Re: [PATCH v6 06/18] asm-generic/tlb: Conditionally provide
 tlb_migrate_finish()
Message-ID: <20190220150253.GH12668@bombadil.infradead.org>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.207580251@infradead.org>
 <20190219124738.GD8501@fuggles.cambridge.arm.com>
 <20190219134147.GZ32494@hirez.programming.kicks-ass.net>
 <20190220144705.GH7523@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220144705.GH7523@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 02:47:05PM +0000, Will Deacon wrote:
> On Tue, Feb 19, 2019 at 02:41:47PM +0100, Peter Zijlstra wrote:
> > On Tue, Feb 19, 2019 at 12:47:38PM +0000, Will Deacon wrote:
> > > Fine for now, but I agree that we should drop the hook altogether. AFAICT,
> > > this only exists to help an ia64 optimisation which looks suspicious to
> > > me since it uses:
> > > 
> > >     mm == current->active_mm && atomic_read(&mm->mm_users) == 1
> > > 
> > > to identify a "single-threaded fork()" and therefore perform only local TLB
> > > invalidation. Even if this was the right thing to do, it's not clear to me
> > > that tlb_migrate_finish() is called on the right CPU anyway.
> > > 
> > > So I'd be keen to remove this hook before it spreads, but in the meantime:
> > 
> > Agreed :-)
> > 
> > The obvious slash and kill patch ... untested
> 
> I'm also unable to test this, unfortunately. Can we get it into next after
> the merge window and see if anybody reports issues?

While I do have a pair of Itanium systems in my basement, neither are
sn2 machines, which was the only sub-architecture that implemented
tlb_migrate_finish().  I see NASA decomissioned Columbia in 2013, and
I imagine most sn2 machines have been similarly scrapped.
