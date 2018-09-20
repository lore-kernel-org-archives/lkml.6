Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947DCECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECD12152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fzKSXl6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECD12152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732912AbeITTze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:55:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730955AbeITTze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5rSLycSn6q+AmZdUyYIJwI8/b0usWYe7U5HT7bSfRHE=; b=fzKSXl6hETLE71iI7vOdW2Iug
        SoXkfiUHrkOFMc0rXnO9AgXLp4Ae6Nys+eAFwmPsSDYgWrvOlES+fxOdSz2+2HEc/ddupILgMOSzC
        Lz1bnlYA9YVeGNVxx+BjFYmorr4iwfLCdW9RqDBIes9582qm1iuUeFbDyN3HN9k9K4HlicfwBSkdI
        jx1VB1mflQtjY3FsW9GffodeJW8FfXVE429kUqBdwK9SWES0YzwtL6nUgijbEN4H2fD2AvfWO54D5
        lsrdG24916S2yY2LRAEQYrSkiY6TwRwYCyPaT4SGJ3fMxN/Gypy4NoEKg2J7B+4fDYUkCVoahZnpv
        THU+nEURA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2zgO-0001tT-B4; Thu, 20 Sep 2018 14:11:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D91BD2024E448; Thu, 20 Sep 2018 16:11:50 +0200 (CEST)
Date:   Thu, 20 Sep 2018 16:11:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        mingo@redhat.com, acme@kernel.org, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 0/6] perf and x86/intel_rdt: Fix lack of coordination
 with perf
Message-ID: <20180920141150.GY24124@hirez.programming.kicks-ass.net>
References: <cover.1537377064.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1537377064.git.reinette.chatre@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 10:29:05AM -0700, Reinette Chatre wrote:
> Reinette Chatre (6):
>   perf/core: Add sanity check to deal with pinned event failure
>   perf/x86: Add helper to obtain performance counter index
>   x86/intel_rdt: Remove local register variables
>   x86/intel_rdt: Create required perf event attributes
>   x86/intel_rdt: Use perf infrastructure for measurements
>   x86/intel_rdt: Re-enable pseudo-lock measurements
> 
>  Documentation/x86/intel_rdt_ui.txt          |  22 +-
>  arch/x86/events/core.c                      |  21 ++
>  arch/x86/include/asm/perf_event.h           |   1 +
>  arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 372 ++++++++++++--------
>  kernel/events/core.c                        |   6 +
>  5 files changed, 261 insertions(+), 161 deletions(-)

Yeah, these look good, thanks!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
