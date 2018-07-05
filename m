Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92946C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C22F24048
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lqf0zGvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C22F24048
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753814AbeGERlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:41:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33226 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753397AbeGERlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AFNjFo3Hj0Wiy+e8S6u7axeJjHEvLcdRMGS0CviExGk=; b=Lqf0zGvHTV0kHXVdDGK3cwx4O
        busto24yGb4js7mwBkfZ1qzzXuEb4EMfvcgfu5R4o1XtNnjEj5dCZJAUR7TKBBMUmcPqXsyhnOGps
        S+tic0tL8oTCmcPg6Yz+p6U8aQPQkCdD67A7Eo7Sbk99UAt+PL/ZUMcB4KPiR1wqISO7E6ZQS+E2+
        WGBYZFHw5Nx4OsdOIUf+cYaNlHRp3ttmnb6Jhlw8MYy2siChoBo/drY8nltwjskJP7SWHdXs8xWjo
        F/knHsfKguzeJUm2gcoKV/hHnk5+xOuT5oZedgTOI1REASpEl5Gj42tdHYly84IfHLUWBzQVeS5XQ
        7S1+2S0EA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fb8F0-0002wa-Lz; Thu, 05 Jul 2018 17:40:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2241A20289CF4; Thu,  5 Jul 2018 19:40:25 +0200 (CEST)
Date:   Thu, 5 Jul 2018 19:40:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2 06/19] csky: Cache and TLB routines
Message-ID: <20180705174025.GD2530@hirez.programming.kicks-ass.net>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <a2c153fa2e585e4ba54a339f13442881553ab6a4.1530465326.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2c153fa2e585e4ba54a339f13442881553ab6a4.1530465326.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 01:30:09AM +0800, Guo Ren wrote:
> diff --git a/arch/csky/include/asm/barrier.h b/arch/csky/include/asm/barrier.h
> new file mode 100644
> index 0000000..7254527
> --- /dev/null
> +++ b/arch/csky/include/asm/barrier.h
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +#ifndef __ASM_CSKY_BARRIER_H
> +#define __ASM_CSKY_BARRIER_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#define nop()	asm volatile ("nop")
> +
> +#ifdef CONFIG_SMP
> +#define mb()	asm volatile ("sync.is":::"memory")
> +#else
> +#define mb()	asm volatile ("sync":::"memory")
> +#endif

This is very suspect, please elaborate.

What I would've expected is:

#define mb() asm volatile ("sync" ::: "memory")

#ifdef CONFIG_SMP
#define __smp_mb() asm volatile ("sync.is" ::: "memory")
#endif

Is that in fact what you meant?

Do you have a reference to your architecture manual and memory model
description somewhere?


> +
> +#include <asm-generic/barrier.h>
> +
> +#endif /* __ASSEMBLY__ */
> +#endif /* __ASM_CSKY_BARRIER_H */
