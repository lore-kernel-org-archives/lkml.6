Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbeBBMvP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 07:51:15 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:55862 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbeBBMub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 07:50:31 -0500
X-Google-Smtp-Source: AH8x226SymePX/qU7D1RcMn7hLYc8ggdFmMVU9xb6yWv8ovmxff4J9lTv/EPVT8eVXm1XH7VQ/EIHw==
Message-ID: <1517575828.3153.23.camel@baylibre.com>
Subject: Re: [PATCH v5 00/10] clk: implement clock rate protection mechanism
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Fri, 02 Feb 2018 13:50:28 +0100
In-Reply-To: <20180201174307.GC23162@codeaurora.org>
References: <20171201215200.23523-1-jbrunet@baylibre.com>
         <151373031022.33554.13905466641279532222@resonance>
         <20171222021520.GO7997@codeaurora.org>
         <1517217778.3153.1.camel@baylibre.com>
         <20180201174307.GC23162@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-01 at 09:43 -0800, Stephen Boyd wrote:
> > > > Applied to clk-protect-rate, with the exception that I did not apply
> > > > "clk: fix CLK_SET_RATE_GATE with clock rate protection" as it breaks
> > > > qcom clk code.
> > > > 
> > > > Stephen, do you plan to fix up the qcom clock code so that the
> > > > SET_RATE_GATE improvement can go in?
> > > > 
> > > 
> > > I started working on it a while back. Let's see if I can finish
> > > it off this weekend.
> > > 
> > 
> > Hi Stephen,
> > 
> > Have you been able find something to fix the qcom code regarding this issue ?
> > 
> 
> This is what I have. I'm unhappy with a few things. First, I made
> a spinlock for each clk, which is overkill. Most likely, just a
> single spinlock is needed per clk-controller device. Second, I
> haven't finished off the branch/gate part, so gating/ungating of
> branches needs to be locked as well to prevent branches from
> turning on while rates change. And finally, the 'branches' list is
> duplicating a bunch of information about the child clks of an
> RCG, so it feels like we need a core framework API to enable and
> disable clks forcibly while remembering what is enabled/disabled
> or at least to walk the clk tree and call some function.

Looks similar to Mike's CCR idea ;)

> 
> The spinlock per clk-controller is duplicating the regmap lock we
> already have, so we may want a regmap API to grab the lock, and
> then another regmap API to do reads/writes without grabbing the
> lock, and then finally release the lock with a regmap unlock API.

There is 'regsequence' for multiple write in a burst, but that's only if you do
write only ... I suppose you are more in read/update/writeback mode, so it
probably does not help much.

Maybe we could extend regmap's regsequence, to do a sequence of
regmap_update_bits() ?

Another possibility could be to provide your own lock/unlock ops when
registering the regmap. With this, you might be able to supply your own spinlock
to regmap. This is already supported by regmap, would it help ?

> This part is mostly an optimization, but it would be nice to have
> so that multiple writes could be done in sequence. This way, the
> RCG code could do the special locking sequence and the branch
> code could do the fire and forget single bit update.
