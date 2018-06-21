Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBE4C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D97A22496
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iT9F2Afx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D97A22496
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933782AbeFUWNp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:13:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35588 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933559AbeFUWNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4/xV+ZRTQVeIss7uup/iktGy+zad9J77s5Uc5iOIQBM=; b=iT9F2Afx2XvS2zcFtgCaQz6KD
        Xpu2QuhFxYIkTKw6q5StaQaHFSw6KsAUZCTI/3DzrKKPqJTXPlBGzGEObqGtysoWjo+j/FNf5wwue
        dTuBN4+qx9QB5HBoO7GX7R6O3GjmO1u8StZxhedbzJBvKiqpxOLA3mbL9wAh5PbLaoBdigJ6RDqLp
        uvUDddKXMM+pAYR736VnYugeHDFIqNiW2T9yU2g194F2j4Kq2/YmMdCypseQRnh2ONE2/G6WWqSaC
        aUPlm5ee+E/G7FJKNCzcgEST2UeOFH06WcXxoz4HVhY6p+2MGo3XLzrvumdDGPYSBYy1tEQNnZWzr
        vvGGijc2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW7pi-00031b-So; Thu, 21 Jun 2018 22:13:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E5A02029F1D7; Fri, 22 Jun 2018 00:13:37 +0200 (CEST)
Date:   Fri, 22 Jun 2018 00:13:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 00/16] x86/split_lock: Enable #AC exception for split
 locked accesses
Message-ID: <20180621221337.GE2494@hirez.programming.kicks-ass.net>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <20180621193738.GA13636@worktop.programming.kicks-ass.net>
 <20180621201851.GC114883@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1806212223480.1591@nanos.tec.linutronix.de>
 <20180621220003.GD114883@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621220003.GD114883@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 03:00:03PM -0700, Fenghua Yu wrote:
> For example, on a consolidated real-time machine, some cores are running

> Another example, in a public cloud deployed in the field, a user process

In either case a single split-lock shouldn't be a real problem, if you
program the event with a count of 1 and have the NMI handler kill the
offending task, you should be good.

Not saying the #AC isn't nicer, just saying the PMU based thing can
still work.
