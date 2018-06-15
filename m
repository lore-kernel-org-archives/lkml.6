Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEFBC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E640720891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E640720891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966070AbeFOT1j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:27:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56055 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964930AbeFOT1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:27:38 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 766B12079D; Fri, 15 Jun 2018 21:27:36 +0200 (CEST)
Received: from windsurf (LFbn-TOU-1-88-197.w86-201.abo.wanadoo.fr [86.201.177.197])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3C2AB206A0;
        Fri, 15 Jun 2018 21:27:26 +0200 (CEST)
Date:   Fri, 15 Jun 2018 21:27:26 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/sh: use slow path for get_user_pages_fast() on SMP
Message-ID: <20180615212726.17d8ffe5@windsurf>
In-Reply-To: <474bbdcc-d78f-faa0-b2c3-3650cc870b36@cogentembedded.com>
References: <20180615155237.8166-1-thomas.petazzoni@bootlin.com>
        <474bbdcc-d78f-faa0-b2c3-3650cc870b36@cogentembedded.com>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 15 Jun 2018 19:04:45 +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 06/15/2018 06:52 PM, Thomas Petazzoni wrote:
> 
> > The fast path of get_user_pages_fast() disables IRQs and then does:
> > 
> >  - gup_pud_range()
> >    - gup_pmd_range()
> >      - gup_pte_range()
> >        - flush_dcache_page()
> > 
> > However, flush_dcache_page() makes a smp_call_function(), and using
> > smp_call_function() when IRQs are disabled is not allowed.
> > 
> > In order to work around this problem, this commit prevents the fast
> > path from get_user_pages_fast() from being used on SMP, and directly  
>        ^^^^ of?
>    Else it sounds a bit tautological...

I re-read again my sentence, and I believe it's correct and it has the
meaning I intended to give. Of course, I'm not a native english
speaker, so I might be wrong on this :-)

I'm actually more interested in hearing whether there is a better
solution to this problem. This patch submission is really a very
proposal, and I'm hoping to get some better suggestions on how to
approach the problem.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
