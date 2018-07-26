Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54748C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BC42089E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1BC42089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbeGZHAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 03:00:30 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:51531 "EHLO
        mail.osadl.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbeGZHAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 03:00:30 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 8C84D5C0A99; Thu, 26 Jul 2018 05:43:42 +0000 (UTC)
Date:   Thu, 26 Jul 2018 05:43:42 +0000
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Kees Cook <keescook@chromium.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drivers: clk: st: warn on iomap failure
Message-ID: <20180726054342.GA22040@osadl.at>
References: <1531649904-6072-1-git-send-email-hofrat@osadl.org>
 <153255129875.48062.4075642035553635128@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153255129875.48062.4075642035553635128@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 01:41:38PM -0700, Stephen Boyd wrote:
> Quoting Nicholas Mc Guire (2018-07-15 03:18:23)
> >  While the return value of clkgen_get_register_base() is being checked
> > at the call site, there is no indication of failure cause thus making
> > diagnosis of the issues hard. The WARN_ON() allows to determine the
> > cause of failure.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > ---
> > 
> > Problem found by an experimental coccinelle script
> > 
> > Patch was compile tested with: multi_v7_defconfig (implies
> > CONFIG_ARCH_STI=y)
> > 
> > Patch is against 4.18-rc4 (localversion-next is next-20180713)
> > 
> >  drivers/clk/st/clkgen-pll.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
> > index cbb5184..aeb30ab 100644
> > --- a/drivers/clk/st/clkgen-pll.c
> > +++ b/drivers/clk/st/clkgen-pll.c
> > @@ -647,6 +647,7 @@ static void __iomem * __init clkgen_get_register_base(
> >                 return NULL;
> >  
> >         reg = of_iomap(pnode, 0);
> > +       WARN_ON(!reg);
> >  
> >         of_node_put(pnode);
> >         return reg;
> 
> Shouldn't the caller blow up on NULL pointer access? This patch doesn't
> seem useful, sorry.
>
if you look at the call chain then there is a check for !NULL along
the way - but never any information - no pr_*/printk or the like so
ultimately you would get a failure but not know where that failure came
from - the intent of the WARN_ON() is to allow you to locate the trigger
event. Blowing up with a BUG_ON() is not necessary as the call chain
does check for !NULL along the way.

thx!
hofrat
