Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D6FC71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA242064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pALukeXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA242064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeJOWBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:01:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38138 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJOWBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FHQCMdKVXPj1Cm8RtUxt6DOIpPE3Ck1Gjw9K8Usi/Q8=; b=pALukeXoea2/FL7MOXmuSAM1r
        8lirzAqofngMHKxKhkoeKU2gLKU7wnvU3BcrZ2p+yT+l/pmnWzel8evdXahfr5UV033OLQcuyHYS9
        gk2StgzPygkK6aXXG6oGwkvKuoIUKamvHc5DQ9lvlA3eVioKyTRcTvUCvI/tiifcoeUk2+b4S8R44
        YMi5E0McTN5+q9PjT8rkCfq4bgkFY5GiSIzC8tdnRSRDpYjO3CQJ7uH7rIg6dzDkfhga/R3qde0IK
        0HSt3AYbZMFg30boWwsSrBy5opgopQEem5FknrB7SOl3VO15dIX6DIbHDsoEVmdG3Y63Hr+L7BDIm
        ma096617Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gC3e7-0000Fh-QM; Mon, 15 Oct 2018 14:15:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2FFE020131A06; Mon, 15 Oct 2018 16:14:58 +0200 (CEST)
Date:   Mon, 15 Oct 2018 16:14:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        "riel@surriel.com" <riel@surriel.com>,
        Richard Henderson <rth@twiddle.net>,
        Mark Salter <msalter@redhat.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Greentime Hu <green.hu@gmail.com>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>, Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Max Filippov <jcmvbkbc@gmail.com>,
        arcml <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH 12/18] arch/tlb: Clean up simple architectures
Message-ID: <20181015141458.GQ9867@hirez.programming.kicks-ass.net>
References: <20180926113623.863696043@infradead.org>
 <20180926114801.146189550@infradead.org>
 <C2D7FE5348E1B147BCA15975FBA23075012B09A59E@us01wembx1.internal.synopsys.com>
 <20181011150406.GL9848@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075012B0ADA16@US01WEMBX2.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B0ADA16@US01WEMBX2.internal.synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 07:40:04PM +0000, Vineet Gupta wrote:
> Very nice. Thx for doing this.
> 
> Once you have redone this, please point me to a branch so I can give this a spin.
> I've always been interested in tracking down / optimizing the full TLB flushes -
> which ARC implements by simply moving the MMU/process to a new ASID (TLB entries
> tagged with an 8 bit value - unique per process). When I started looking into this
> , a simple ls (fork+execve) would increment the ASID by 13 which I'd optimized to
> a reasonable 4. Haven't checked that in recent times though so would be fun to
> revive that measurement.

I just pushed out the latest version to:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git mm/tlb

(mandatory caution: that tree is unstable / throw-away)

I'll wait a few days to see what, if anything, comes back from 0day
before posting again.
