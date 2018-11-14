Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66F3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCBA22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lC11sxMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BCBA22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733108AbeKOAUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 19:20:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeKOAUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 19:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Fuxfoi2tfpKf98DtsaD/2e9sR4uDwwobYWJu+hrrObM=; b=lC11sxMNqLP0GyNAqNKc7uGCD
        f2mNxsrIL4NhUfV8t9i16HnMzLtBKxss18n7jhcDv8aRVwKgqCakA7RIZLGhJ4eQB+i+nz+v0l6d0
        zUHLYIHD9MFG+uTMCfr5CTuNk6lV6UO8sGtxkhEnz3qeqXl09dtRuLO9iAhlWhsc8j3HxfDXsHlLq
        JkwsyWXEuGHf/oSg4JEAcok4AkDvFSi10f97jlEugH6PycxFyF45bfvtDnim3GFZwK1US4t3B5PyA
        gdeBphcmgbUtOn0jQUQAF4vcLPruDQ9D3woLBSskNUbd4aaWOp5v/0raYafdlqSUEnwMi8+MlzzNP
        MTEcm8aHw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMvyk-0008TF-2v; Wed, 14 Nov 2018 14:17:14 +0000
Date:   Wed, 14 Nov 2018 06:17:13 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
Subject: Re: [LKP] [page cache]  eb797a8ee0:  vm-scalability.throughput
 -16.5% regression
Message-ID: <20181114141713.GA25731@bombadil.infradead.org>
References: <20181114092242.GD18977@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114092242.GD18977@shao2-debian>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 05:22:42PM +0800, kernel test robot wrote:
> FYI, we noticed a -16.5% regression of vm-scalability.throughput due to commit:
> commit: eb797a8ee0ab4cd03df556980ce7bf167cadaa50 ("page cache: Rearrange address_space")
> 
> in testcase: vm-scalability
> on test machine: 80 threads Skylake with 64G memory
> with following parameters:
> 
> 	runtime: 300s
> 	test: small-allocs
> 	cpufreq_governor: performance

Thanks for the report.  I am surprised by it, because I can't see what
could have caused this.  On a 64-bit system (which your test is using),
here's the effect of that patch:

gfp_mask moves from being with private_lock up into a hole adjacent
to i_mmap_writable.
wb_err moves from the end of the array up to be with private_lock.
address_space shrinks by 8 bytes.

Hmm.  Might the shrinking be the problem?  Something in struct inode is
now split across two cachelines, or is no longer in the same cacheline
as something else?

I'm at Plumbers this week, so I don't have much time to investigate,
but this regression is very important to me and I shall dig into this
when I can.  It's OK to revert this commit in the meantime; nothing
depends on it yet.

> In addition to that, the commit also has significant impact on the following tests:
> 
> | testcase: change | unixbench: unixbench.score 20.9% improvement                         |

Huh.  If we had to choose, would a 20.9% improvement in unixbench be more
important than a 16.5% penalty to will-it-scale?

