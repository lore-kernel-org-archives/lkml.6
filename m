Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247F3C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DAA208DA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s0qxdmJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DAA208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeH0LjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:39:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeH0LjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2iwai4mP+Qjak9gKjRqDjd/ma83sd80Ld7ymivudl6I=; b=s0qxdmJyCVLQMdTLlgAV5F9ep
        Y91khaZ6IXhWVTZYUWoWEIfV4u2Kf0KkKF8czlThqv8YXOCsY1NrU0vwmN2ojzcbU9J87X5PK78AY
        IyztcRNJo+MIuP9L2gn3CwGPgB3CWmP6WXqT9ZD8UAUfeYYY7TrBmcTgRkODnJCncNzuPVPzqRAKm
        prCscZ3W+/Nc89+w37jYpji7YPDd07SMwi37DDJkCMyXeEWUddektCa6q8vs8rooSfozhvOIta6iL
        r1k0KI1i9+QdWoViq3ptTLpO9jQTo3ejnCMOJYBDHCFCbwZYNLcjUj4eXzhuD2WpJxuqMBcDBRv0y
        5kQZGEtxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuCLH-0005cs-6v; Mon, 27 Aug 2018 07:53:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8A942024EFCD; Mon, 27 Aug 2018 09:53:41 +0200 (CEST)
Date:   Mon, 27 Aug 2018 09:53:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, benh@au1.ibm.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 09/11] asm-generic/tlb: Track which levels of the
 page tables have been cleared
Message-ID: <20180827075341.GY24124@hirez.programming.kicks-ass.net>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
 <1535125966-7666-10-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535125966-7666-10-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 04:52:44PM +0100, Will Deacon wrote:
> +static inline unsigned long tlb_get_unmap_granule(struct mmu_gather *tlb)
> +{
> +	if (tlb->cleared_ptes)
> +		return PAGE_SIZE;
> +	if (tlb->cleared_pmds)
> +		return PMD_SIZE;
> +	if (tlb->cleared_puds)
> +		return PUD_SIZE;
> +	if (tlb->cleared_p4ds)
> +		return P4D_SIZE;
> +
> +	return PAGE_SIZE;
> +}

When doing the x86 patch; I found _SHIFT more useful than _SIZE.
