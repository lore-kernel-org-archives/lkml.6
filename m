Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3062CC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1540206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tMUQfbR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1540206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbeGSJ4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:56:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36910 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeGSJ4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JeFK8tOezHXJTwWgDOi2sa3rSt1ZV2Xb/G0KT5OadUc=; b=tMUQfbR0eGMYYShpQIvBioLYX
        p3lKM5/17XfCyK8jEGxShgtApr2zFPOcKEqsYlWc/UmxSdIbzdnY8hrJ3dKsE2VX3NFx7Ci1ZMsVA
        8nmo6PVxbJZ65RDr54BvSuxThL8VnuCg2vdWri9D8GfmXFJIVHcOwNNE44o3nzNFvCtRwEwS/si9K
        5/TuaObCaK5Gj2v35yDl1HKIlqXYcGMlIbYzjxRFuNcZpfrT/OfPHdQU8g6tbHA0Mv+ar08Mx5N5/
        SqnmFdhIBcgpUdO40l7ZoyxjY09V8rUqrqIh/F7dJFSTGbCqc0syxwB99nP+DYDlnLt2CneH9lTvH
        opr0r2uWw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fg50R-0007Wf-IW; Thu, 19 Jul 2018 09:13:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 41B2020289330; Thu, 19 Jul 2018 11:13:49 +0200 (CEST)
Date:   Thu, 19 Jul 2018 11:13:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     songliubraving@fb.com, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, torvalds@linux-foundation.org,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/mm] x86/mm/tlb: Make lazy TLB mode lazier
Message-ID: <20180719091349.GY2494@hirez.programming.kicks-ass.net>
References: <20180716190337.26133-5-riel@surriel.com>
 <tip-ac0315896970d8589291e9d8a1569fc65967b7f1@git.kernel.org>
 <20180717113330.GU2476@hirez.programming.kicks-ass.net>
 <08AC2AF2-17DE-4416-BBBD-B6B950D20906@surriel.com>
 <20180718160007.GS2494@hirez.programming.kicks-ass.net>
 <081E558D-DB34-4A18-A35C-896BC47F6EBA@surriel.com>
 <20180718182359.GW2494@hirez.programming.kicks-ass.net>
 <477353D9-BA10-4AAB-ACC4-DDFDAE63895B@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <477353D9-BA10-4AAB-ACC4-DDFDAE63895B@surriel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 02:51:45PM -0400, Rik van Riel wrote:

> > Ah, ok. I wasn't entirely sure the new lazy was purely for the idle
> > case. But yes, the KVM paravirt thing should get the idle case right.
> > 
> Not just idle, but also running in kernel threads like ksoftirqd,
> kworker, kswapd, etc.

Right, that's what I thought.

> However, kvm_flush_tlb_other calls
> native_flush_tlb_other, so it should get that optimization automatically
> from my patch series.

Aah, seems I forgot that part, then yes indeed, it all works.
