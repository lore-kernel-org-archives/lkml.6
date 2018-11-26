Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31958C04EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6F820989
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dUdUjZ1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6F820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeKZV0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:26:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50458 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbeKZV0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9X0NPtRA2mZHhq5+nlCgto6J/8C/LZqji/77rk+JepE=; b=dUdUjZ1DKg80MbHGMBXp7o6Lg
        zXup2CddZs3UyistsdelIdd8ublfS6AUj1on3bI2MzHlJJcUfuxMihFAzzfztf8sR99BTBuCuVRce
        NjjlJJ2QMHMIJH9+B7Rnx8FHFcBzBPgAds5J2oDrFmDh5vys0vTJdogAlISXZNtLPnPixpJKRWUNR
        xw5A/6ZaRMHJ0qjHHdUMvRmBbhMQI7uh/Nk4t/36Xer34IPqDVXgErmywInBnydMikPPvTChdW60a
        FMduXXpC1IPJEdv9OHs0yds03sJB+oQPuGJAc87H3p8FGstu+r3Uooo6Tal5NUez//Tuau5AluTeq
        DUAqJfpPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRECF-0004xY-4y; Mon, 26 Nov 2018 10:32:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AC5522029FD58; Mon, 26 Nov 2018 11:32:52 +0100 (CET)
Date:   Mon, 26 Nov 2018 11:32:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v6 00/10] x86/alternative: text_poke() fixes
Message-ID: <20181126103252.GN2113@hirez.programming.kicks-ass.net>
References: <20181120203545.34928-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120203545.34928-1-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 12:35:35PM -0800, Nadav Amit wrote:

> Nadav Amit (9):
>   Fix "x86/alternatives: Lockdep-enforce text_mutex in text_poke*()"
>   x86/jump_label: Use text_poke_early() during early init
>   fork: provide a function for copying init_mm
>   x86/alternative: initializing temporary mm for patching
>   x86/alternative: use temporary mm for text poking
>   x86/kgdb: avoid redundant comparison of patched code
>   x86: avoid W^X being broken during modules loading
>   x86/jump-label: remove support for custom poker
>   x86/alternative: remove the return value of text_poke_*()
> 
>  arch/x86/include/asm/fixmap.h        |   2 -
>  arch/x86/include/asm/mmu_context.h   |  32 +++++
>  arch/x86/include/asm/pgtable.h       |   3 +
>  arch/x86/include/asm/text-patching.h |   7 +-
>  arch/x86/kernel/alternative.c        | 197 ++++++++++++++++++++-------
>  arch/x86/kernel/jump_label.c         |  19 ++-
>  arch/x86/kernel/kgdb.c               |  25 +---
>  arch/x86/kernel/module.c             |   2 +-
>  arch/x86/mm/init_64.c                |  35 +++++
>  arch/x86/xen/mmu_pv.c                |   2 -
>  include/linux/filter.h               |   6 +
>  include/linux/sched/task.h           |   1 +
>  init/main.c                          |   3 +
>  kernel/fork.c                        |  24 +++-
>  kernel/module.c                      |  10 ++
>  15 files changed, 279 insertions(+), 89 deletions(-)

Thanks Nadav!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
