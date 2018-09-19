Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AE5C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716752150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kNVjz3wX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716752150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbeISRIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:08:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39472 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730892AbeISRIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iuLY8C0AU8OH5Kb725mmws1jmUxW+uCZnUhLDTEQU98=; b=kNVjz3wX9O8m4VKwDjlGwuuzO
        1VlEfc0Zkazv7Q3GvG8l5J+OE0VebPQYdPQyYlR+J2muvJilk5cHLmbJtmWcWcmij06jY6800EjRw
        RGZ9y+dTpsiUokS61b35XxmHDHXJE7o8VBSvGOFxTKCGkIV1ubkLdHIGI5jaKJSyQQAf/v3H9LTPV
        jYjCCZJ3dLJWY8rm+flYSwEcsty0t4KNdr8Mv1JAS3tvVMAndLZAzrB3e6Qa57JJj7lLk05v0G/92
        +ewE8ZuGa6fHIqmwEpu8dvbMW7pgWg3+MeED76VwWMRd/E2cbl07cBlDr8CMCwLkcCYkG/Ov2w2iG
        FPhQA/O5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2agl-0001qO-Uk; Wed, 19 Sep 2018 11:30:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3FF5A2024E43D; Wed, 19 Sep 2018 13:30:33 +0200 (CEST)
Date:   Wed, 19 Sep 2018 13:30:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com
Subject: Re: [RFC][PATCH 07/11] arm/tlb: Convert to generic mmu_gather
Message-ID: <20180919113033.GB24124@hirez.programming.kicks-ass.net>
References: <20180913092110.817204997@infradead.org>
 <20180913092812.247989787@infradead.org>
 <20180918141034.GF16498@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918141034.GF16498@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 03:10:34PM +0100, Will Deacon wrote:
> > +	addr = (addr & PMD_MASK) + SZ_1M;
> > +	__tlb_adjust_range(tlb, addr - PAGE_SIZE, addr + PAGE_SIZE);
> 
> Hmm, I don't think you've got the range correct here. Don't we want
> something like:
> 
> 	__tlb_adjust_range(tlb, addr - PAGE_SIZE, 2 * PAGE_SIZE)
> 
> to ensure that we flush on both sides of the 1M boundary?

Argh indeed. I confused {start,size} with {start,end}. Thanks!
