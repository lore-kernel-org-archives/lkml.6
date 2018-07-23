Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977A9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F5A20899
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F5A20899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388424AbeGWOsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:48:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54256 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388129AbeGWOsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:48:30 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F15A12093A; Mon, 23 Jul 2018 15:47:07 +0200 (CEST)
Received: from windsurf (176.199.29.109.rev.sfr.net [109.29.199.176])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8D9FC20717;
        Mon, 23 Jul 2018 15:46:57 +0200 (CEST)
Date:   Mon, 23 Jul 2018 15:46:57 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/sh: use slow path for get_user_pages_fast() on SMP
Message-ID: <20180723154657.3872fa70@windsurf>
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

Yes, agreed.

I can fix that up for a v2, or perhaps such a small typo can be fixed
while applying the patches.

Could someone review and/or merge those patches ?

I sent four patches, which are still pending:

  [PATCH] arch/sh: kernel: use KERN_CONT in print_sh_insn()
  [PATCH] arch/sh: kernel: use KERN_CONT in dump_mem()
  [PATCH] arch/sh: fix SH4 flush_dcache_all() for SMP
  [PATCH] arch/sh: use slow path for get_user_pages_fast() on SMP

Note that this last one is more a workaround than a proper fix. It does
the job, but there is very likely a better solution, and I was hoping
to get some insights/suggestions.

Thanks a lot,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
