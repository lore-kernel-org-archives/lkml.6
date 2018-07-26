Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE58EC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858F920673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858F920673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbeGZHHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 03:07:22 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:51538 "EHLO
        mail.osadl.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeGZHHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 03:07:22 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id B61475C0A99; Thu, 26 Jul 2018 05:50:33 +0000 (UTC)
Date:   Thu, 26 Jul 2018 05:50:33 +0000
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Kees Cook <keescook@chromium.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: clk: st: address sparse warnings
Message-ID: <20180726055033.GB22040@osadl.at>
References: <1531649904-6072-1-git-send-email-hofrat@osadl.org>
 <1531649904-6072-2-git-send-email-hofrat@osadl.org>
 <153255125317.48062.14342630708691039501@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <153255125317.48062.14342630708691039501@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 01:40:53PM -0700, Stephen Boyd wrote:
> Quoting Nicholas Mc Guire (2018-07-15 03:18:24)
> >  Refactoring of code to make it more readable and at the same time make
> > sparse happy again.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > ---
> > 
> > sparse complained about:
> > drivers/clk/st/clkgen-pll.c:225:12: warning: context imbalance in 'clkgen_pll_enable' - different lock contexts for basic block
> > drivers/clk/st/clkgen-pll.c:267:9: warning: context imbalance in 'clkgen_pll_disable' - different lock contexts for basic block
> > drivers/clk/st/clkgen-pll.c:413:9: warning: context imbalance in 'set_rate_stm_pll3200c32' - different lock contexts for basic block
> > drivers/clk/st/clkgen-pll.c:570:9: warning: context imbalance in 'set_rate_stm_pll4600c28' - different lock contexts for basic block
> > 
> > Which are technically false positives as the pll->lock which is being
> > checked is determined at configuration time, thus the locks are balanced.
> > Never the less the refactored code seems more readable and was 
> > commented to make it clear.
> 
> This stuff above should go into the commit text.

ok - then I´ll resend that with that moved into the commit message.

> 
> > 
> > Patch was compile tested with: multi_v7_defconfig (implies
> > CONFIG_ARCH_STI=y)
> > 
> > Patch is against 4.18-rc4 (localversion-next is next-20180713)
> > 
> >  drivers/clk/st/clkgen-pll.c | 51 +++++++++++++++++++++++++--------------------
> >  1 file changed, 28 insertions(+), 23 deletions(-)
> 
> I believe this driver is in stasis mode. Not sure anyone is testing this
> right now. Please Cc people who have worked on this driver, like Gabriel
> Fernandez.
>  
> > 
> > diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
> > index 7a7106dc..cbb5184 100644
> > --- a/drivers/clk/st/clkgen-pll.c
> > +++ b/drivers/clk/st/clkgen-pll.c
> > @@ -228,13 +228,13 @@ static int clkgen_pll_enable(struct clk_hw *hw)
> >         unsigned long flags = 0;
> >         int ret = 0;
> >  
> > -       if (pll->lock)
> > +       if (pll->lock) {
> > +               /* stih418 and stih407 */
> >                 spin_lock_irqsave(pll->lock, flags);
> > -
> > -       ret = __clkgen_pll_enable(hw);
> > -
> > -       if (pll->lock)
> > +               ret = __clkgen_pll_enable(hw);
> >                 spin_unlock_irqrestore(pll->lock, flags);
> > +       } else
> > +               ret = __clkgen_pll_enable(hw);
> >  
> >         return ret;
> >  }
> > @@ -259,13 +259,13 @@ static void clkgen_pll_disable(struct clk_hw *hw)
> >         struct clkgen_pll *pll = to_clkgen_pll(hw);
> >         unsigned long flags = 0;
> >  
> > -       if (pll->lock)
> > +       if (pll->lock) {
> > +               /* stih418 and stih407 */
> >                 spin_lock_irqsave(pll->lock, flags);
> > -
> > -       __clkgen_pll_disable(hw);
> > -
> > -       if (pll->lock)
> > +               __clkgen_pll_disable(hw);
> >                 spin_unlock_irqrestore(pll->lock, flags);
> > +       } else
> > +               __clkgen_pll_disable(hw);
> >  }
> >  
> >  static int clk_pll3200c32_get_params(unsigned long input, unsigned long output,
> > @@ -400,15 +400,18 @@ static int set_rate_stm_pll3200c32(struct clk_hw *hw, unsigned long rate,
> >  
> >         __clkgen_pll_disable(hw);
> >  
> > -       if (pll->lock)
> > +       if (pll->lock) {
> > +               /* stih407 and stih418 */
> >                 spin_lock_irqsave(pll->lock, flags);
> > -
> > -       CLKGEN_WRITE(pll, ndiv, pll->ndiv);
> > -       CLKGEN_WRITE(pll, idf, pll->idf);
> > -       CLKGEN_WRITE(pll, cp, pll->cp);
> > -
> > -       if (pll->lock)
> > +               CLKGEN_WRITE(pll, ndiv, pll->ndiv);
> > +               CLKGEN_WRITE(pll, idf, pll->idf);
> > +               CLKGEN_WRITE(pll, cp, pll->cp);
> >                 spin_unlock_irqrestore(pll->lock, flags);
> > +       } else {
> > +               CLKGEN_WRITE(pll, ndiv, pll->ndiv);
> > +               CLKGEN_WRITE(pll, idf, pll->idf);
> > +               CLKGEN_WRITE(pll, cp, pll->cp);
> > +       }
> 
> Please don't duplicate this code. The sparse warnings can be fixed by
> adding a fake lock acquire to the else of the if condition. We do this
> in drivers/clk/clk.c so you should be able to copy it from there.

the duplication is not a mater of the sparse warning only - the inetnt was
to improve readability - atleast for the one-line cases it seems more 
readable to have it this way than to have the two lock checks - notably
as you can then comment what the difference here really is.

I agree that for this case with the three lines in the body it is not
that reasonable - this was simply a matter of consistency as the other lock
checks were moved into a if-else construct for readability and commenting.

thx!
hofrat
