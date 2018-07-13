Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC7BECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14DF20873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14DF20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbeGMNBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:01:15 -0400
Received: from muru.com ([72.249.23.125]:51316 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727999AbeGMNBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:01:15 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6D3A58081;
        Fri, 13 Jul 2018 12:49:50 +0000 (UTC)
Date:   Fri, 13 Jul 2018 05:46:41 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] pinctrl: mt7622: fix probe fail by misuse the selector
Message-ID: <20180713124641.GR99251@atomide.com>
References: <ddd18e427de47476722c945dc622571394192331.1531374468.git.sean.wang@mediatek.com>
 <CACRpkdYGPw0Vaaa1_0-vmFf0wdB6Wi+NLv4jDqDxCwJF9o6G=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYGPw0Vaaa1_0-vmFf0wdB6Wi+NLv4jDqDxCwJF9o6G=A@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [180713 08:14]:
> On Thu, Jul 12, 2018 at 7:50 AM <sean.wang@mediatek.com> wrote:
> 
> > From: Sean Wang <sean.wang@mediatek.com>
> >
> > After the commit acf137951367 ("pinctrl: core: Return selector to the
> > pinctrl driver") and the commit 47f1242d19c3 ("pinctrl: pinmux: Return
> > selector to the pinctrl driver"), it's necessary to add the fixes
> > needed for the pin controller drivers to use the appropriate returned
> > selector for a negative error number returned in case of the fail at
> > these functions. Otherwise, the driver would have a failed probe and
> > that causes boot message cannot correctly output and devices fail
> > to acquire their own pins.
> >
> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Fixes: acf137951367 ("pinctrl: core: Return selector to the pinctrl driver")
> > Fixes: 47f1242d19c3 ("pinctrl: pinmux: Return selector to the pinctrl driver")
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> 
> Applied on top of Tony's patches on the fixes branch.
> 
> Now there are fixes piling on top of fixes and I am starting to feel
> insecure of pushing this to v4.18 and I feel like letting these
> fixes go to v4.19 (it can be picked to stable from there).

Yes might be worth waiting as we're getting close to the merge window.

> Tony: do you think there could be more fallout like this?

Based on grep -A5 pinctrl_generic_add we have also:

drivers/pinctrl/pinctrl-ingenic.c

Looks like it should check for if (err < 0). Adding Paul Cercueil
to Cc as well, Paul can you please check and patch?

Then 12f953b382bf ("pinctrl: rza1: Fix selector use for groups and
functions") seems to have fixed a similar issue for
drivers/pinctrl/pinctrl-rza1.c

Regards,

Tony
