Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965600AbeEIQxD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:53:03 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:47400 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934971AbeEIQxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:53:01 -0400
Date: Wed, 9 May 2018 09:33:11 -0700
From: Paul Burton <paul.burton@mips.com>
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Colin King <colin.king@canonical.com>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-mips@linux-mips.org>,
        <linux-clk@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: boston: fix memory leak of 'onecell' on error
 return paths
Message-ID: <20180509163311.alvyibwwuwkumyxf@pburton-laptop>
References: <20180509134031.11611-1-colin.king@canonical.com>
 <20180509140135.4dndt3baomtxups5@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180509140135.4dndt3baomtxups5@mwanda>
User-Agent: NeoMutt/20180323
X-BESS-ID: 1525884637-853316-27024-312772-1
X-BESS-VER: 2018.5-r1804261738
X-BESS-Apparent-Source-IP: 12.201.5.31
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192850
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin & Dan,

On Wed, May 09, 2018 at 05:01:35PM +0300, Dan Carpenter wrote:
> On Wed, May 09, 2018 at 02:40:31PM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > There are several error return paths that don't free up onecell
> > and hence we have some memory leaks. Add an error exit path that
> > kfree's onecell to fix the leaks.
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/clk/imgtec/clk-boston.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/clk/imgtec/clk-boston.c b/drivers/clk/imgtec/clk-boston.c
> > index 15af423cc0c9..d6bc468ff551 100644
> > --- a/drivers/clk/imgtec/clk-boston.c
> > +++ b/drivers/clk/imgtec/clk-boston.c
> > @@ -73,27 +73,34 @@ static void __init clk_boston_setup(struct device_node *np)
> >  	hw = clk_hw_register_fixed_rate(NULL, "input", NULL, 0, in_freq);
> >  	if (IS_ERR(hw)) {
> >  		pr_err("failed to register input clock: %ld\n", PTR_ERR(hw));
> > -		return;
> > +		goto error;
> 
> I hate vague label names like "error" and "out"...
> 
> There are a bunch of other resources that we should free if we decide
> it's worth freeing things.

Agreed - for example unregistering the clocks that we'd be discarding
references to by freeing onecell.

> Can this even boot without the clk?

Nope. If this clock setup fails then whether you free this memory or not
you're going to be unable to do anything useful with it.

I imagine this patch is the result of some static analysis rather than a
problem being observed at runtime?

Thanks,
    Paul

> When
> the label names says what is freed, then you mentally only have to keep
> track of the most recently allocated resource.  So if
> 
> 	hw = clk_hw_register_fixed_rate(NULL, "input", NULL, 0, in_freq);
> 
> succeeds then the next goto is going to "goto free_clk_input;".
> 
> regards,
> dan carpenter
