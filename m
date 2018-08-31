Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4E7C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338C22083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aQnzGQV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338C22083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeHaP1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 11:27:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeHaP1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 11:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dedie2nIteA0IT5VPYXbCZm15uXWzZn8mziNRaCx0D4=; b=aQnzGQV7BZVlE7Fv67/q2+sWk
        dyrEo2fso+2sLBxUEWKQvxvHLoNeJouLps7wpPH4k920yW64pFlSCdu6WZb8origjS+kIWH36JhnE
        x4/O6KLnjBIqcCUp9TUyEXPhMgsHanbxDwwZ2/xTyjGsgbkJqlcBJwO9Tv6QDeB717koIBxirNS5P
        X5++hBwSNwdTKDdXIdQ/p8KOvyLce/UK9uD1XFOtc9FUlrtvK584wGJLAJHzJw5WBxg3/3FWsHsx6
        yjCQDoApP8pJyhz8aK1M4RVXCsKe3ryYxOsa2Lk8V5TiPET8Xn5cJLvJ0L0hB9XE6NPf/bHSd/mll
        kbrDYZ8wQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvhTb-0006Of-Ea; Fri, 31 Aug 2018 11:20:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C710B2024D73F; Fri, 31 Aug 2018 13:20:29 +0200 (CEST)
Date:   Fri, 31 Aug 2018 13:20:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/12] Avoid synchronous TLB invalidation for
 intermediate page-table entries on arm64
Message-ID: <20180831112029.GK24124@hirez.programming.kicks-ass.net>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
 <CA+55aFzMMU5RBhn52Lbzf-FXvx3inh5VPVZL613srY+dVU+Lxw@mail.gmail.com>
 <20180831110054.475a3534@roar.ozlabs.ibm.com>
 <CA+55aFyweLwdAeeLnPv1ceje2y9Qc2AkM+LdMzK_z29fFb96ug@mail.gmail.com>
 <20180831095417.GF13166@arm.com>
 <20180831101014.GG24124@hirez.programming.kicks-ass.net>
 <20180831203234.7b8f4d13@roar.ozlabs.ibm.com>
 <20180831104945.GI24124@hirez.programming.kicks-ass.net>
 <20180831111247.GB15258@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831111247.GB15258@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 12:12:48PM +0100, Will Deacon wrote:
> On Fri, Aug 31, 2018 at 12:49:45PM +0200, Peter Zijlstra wrote:
> > On Fri, Aug 31, 2018 at 08:32:34PM +1000, Nicholas Piggin wrote:
> > > Oh gee, I suppose. powerpc hash is kind of interesting because it's
> > > crazy, Aneesh knows that code a lot better than I do. radix modulo
> > > some minor details of exact instructions is fairly like x86 
> > 
> > The whole TLB broadcast vs explicit IPIs is a fairly big difference in
> > my book.
> > 
> > Anyway, have you guys tried the explicit IPI approach? Depending on how
> > IPIs are routed vs broadcasts it might save a little bus traffic. No
> > point in getting all CPUs to process the TLBI when there's only a hand
> > full that really need it.
> > 
> > OTOH, I suppose the broadcast thing has been optimized to death on the
> > hardware side, so who knows..
> 
> You also can't IPI an IOMMU or a GPU ;)

Oh, right you are. I suppose that is why x86-iommu is using those mmu_notifiers.
