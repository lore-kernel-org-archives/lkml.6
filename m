Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA1BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A929B20658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A929B20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeHaPTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 11:19:34 -0400
Received: from foss.arm.com ([217.140.101.70]:56522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727363AbeHaPTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 11:19:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9EF618A;
        Fri, 31 Aug 2018 04:12:35 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AA7243F721;
        Fri, 31 Aug 2018 04:12:35 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 466AE1AE3614; Fri, 31 Aug 2018 12:12:48 +0100 (BST)
Date:   Fri, 31 Aug 2018 12:12:48 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/12] Avoid synchronous TLB invalidation for
 intermediate page-table entries on arm64
Message-ID: <20180831111247.GB15258@arm.com>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
 <CA+55aFzMMU5RBhn52Lbzf-FXvx3inh5VPVZL613srY+dVU+Lxw@mail.gmail.com>
 <20180831110054.475a3534@roar.ozlabs.ibm.com>
 <CA+55aFyweLwdAeeLnPv1ceje2y9Qc2AkM+LdMzK_z29fFb96ug@mail.gmail.com>
 <20180831095417.GF13166@arm.com>
 <20180831101014.GG24124@hirez.programming.kicks-ass.net>
 <20180831203234.7b8f4d13@roar.ozlabs.ibm.com>
 <20180831104945.GI24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831104945.GI24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 12:49:45PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 31, 2018 at 08:32:34PM +1000, Nicholas Piggin wrote:
> > Oh gee, I suppose. powerpc hash is kind of interesting because it's
> > crazy, Aneesh knows that code a lot better than I do. radix modulo
> > some minor details of exact instructions is fairly like x86 
> 
> The whole TLB broadcast vs explicit IPIs is a fairly big difference in
> my book.
> 
> Anyway, have you guys tried the explicit IPI approach? Depending on how
> IPIs are routed vs broadcasts it might save a little bus traffic. No
> point in getting all CPUs to process the TLBI when there's only a hand
> full that really need it.
> 
> OTOH, I suppose the broadcast thing has been optimized to death on the
> hardware side, so who knows..

You also can't IPI an IOMMU or a GPU ;)

Will
