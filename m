Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AFBC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797C52089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NUrEnZ8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797C52089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbeJBO00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:26:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbeJBO00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=j4Ats4K9dWy+DD+Gwu7xecr0QwVgLAkNdBsAuWTbH9g=; b=NUrEnZ8hxi6lUfCxChnO32Xy4
        4MRUP+RDJ/L/K5fLSxXEtp6Z7uHxtwzH52tatU9WTuOVc9iyO9AyeoNelEB2Qsgt4yjKe2TG4vGXX
        shBo6M+G6YSGoqNkL3Kr2KrpAQltORgZ2l5ksAz8eRBeV/TP+m3kK1nJcW9ePsH1iIZ8U4Td5mYnc
        fsxAEFG2H+QYs1I9Rp9U2h84zbAsGpsv4yXtoImGPKwzrvF18wBy5dd9UhhoOUh/ltWWXpifNklvB
        cZiS+NlDxcnZfEk7EYA/1GRQZvvnMJD40NZmADVnwtBvdVPahFtaBm+iFd4WsHbqyC3bf0XDXHE8w
        lomQymkHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7FM1-000803-6u; Tue, 02 Oct 2018 07:44:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E89262025A358; Tue,  2 Oct 2018 09:44:21 +0200 (CEST)
Date:   Tue, 2 Oct 2018 09:44:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        will.deacon@arm.com, songliubraving@fb.com, mingo@kernel.org,
        luto@kernel.org, hpa@zytor.com, npiggin@gmail.com,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2 0/7] x86/mm/tlb: make lazy TLB mode even lazier
Message-ID: <20181002074421.GQ3439@hirez.programming.kicks-ass.net>
References: <20180926035844.1420-1-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926035844.1420-1-riel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:58:37PM -0400, Rik van Riel wrote:

> This v2 is "identical" to the version I posted yesterday,
> except this one is actually against current -tip (not sure
> what went wrong before), with a number of relevant patches
> on top:
> - tip x86/core
> 	012e77a903d ("x86/nmi: Fix NMI uaccess race against CR3 switching")
> - arm64 tlb/asm-generic (entire branch)
> - peterz queue mm/tlb
> 	12b2b80ec6f4 ("x86/mm: Page size aware flush_tlb_mm_range()")

If you could please double check:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=x86/mm

If 0day comes up green on that, I'll attempt to push it to tip.
