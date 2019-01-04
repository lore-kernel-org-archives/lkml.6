Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C523C43612
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7719421874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfADPyK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:54:10 -0500
Received: from mail.bootlin.com ([62.4.15.54]:53923 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfADPyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 10:54:10 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 68A8B2075E; Fri,  4 Jan 2019 16:54:07 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-29-148.w90-88.abo.wanadoo.fr [90.88.149.148])
        by mail.bootlin.com (Postfix) with ESMTPSA id 17ED4206A6;
        Fri,  4 Jan 2019 16:54:07 +0100 (CET)
Date:   Fri, 4 Jan 2019 16:54:06 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH v3 2/4] clk: core: link consumer with clock driver
Message-ID: <20190104165406.3b52399a@xps13>
In-Reply-To: <154454837597.17204.11648795524314926025@swboyd.mtv.corp.google.com>
References: <20181204192440.12125-1-miquel.raynal@bootlin.com>
        <20181204192440.12125-3-miquel.raynal@bootlin.com>
        <154454837597.17204.11648795524314926025@swboyd.mtv.corp.google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Stephen Boyd <sboyd@kernel.org> wrote on Tue, 11 Dec 2018 09:12:55
-0800:

> Sorry, I'm not reviewing the whole patch right now, just this one little
> bit because I'm also working in the same area.
> 
> Quoting Miquel Raynal (2018-12-04 11:24:38)
> > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > index 60c51871b04b..721d6b55b2fa 100644
> > --- a/include/linux/clk-provider.h
> > +++ b/include/linux/clk-provider.h
> > @@ -781,6 +781,8 @@ void devm_clk_hw_unregister(struct device *dev, struct clk_hw *hw);
> >  const char *__clk_get_name(const struct clk *clk);
> >  const char *clk_hw_get_name(const struct clk_hw *hw);
> >  struct clk_hw *__clk_get_hw(struct clk *clk);
> > +void clk_link_consumer(struct device *consumer, struct clk *clk);
> > +void clk_unlink_consumer(struct clk *clk);  
> 
> We shouldn't need to add these functions as far as I can tell. That's
> because __clk_get() has become an internal API between clkdev.c and
> clk.c that does nothing now on implementations that aren't the CCF. We
> can even change this API to take a clk_hw pointer instead of a clk
> pointer.
> 
> I'd rather see us plumb a struct device and clk_hw structure down into
> __clk_get() and fold it all into __clk_create_clk, possibly even
> renaming __clk_create_clk to clk_hw_create_clk(). That way we can get
> the calling device and clk_hw pointer in one call in the clk framework,
> along with the device name and connection name, and then generate the
> struct clk right there. This can simplify some code and make it easier
> to extend this to associate calling devices with the clk consumer
> somehow.
> 
> Here's the diff. With this, you should be able to add and remove device
> links in clk_hw_create_clk() when dev != NULL.

Thanks for the help; I updated my work on top of yours, it looks ok but
I need to run some more tests.

However I had to tweak a parameter in one of your recent changes, you
used '-1' as index in __of_clock_get() while it is not a valid value
(returning an error). As in the __of_clk_get_by_name() function you
removed index was just set to 0 at the top of the function, I think the
below fix is valid.


Thanks,
Miquèl


---

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index ba4d1e06732d..f2f4f2afd28c 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -163,7 +163,7 @@ struct clk *clk_get(struct device *dev, const char *con_id)
        struct clk_hw *hw;
 
        if (dev && dev->of_node) {
-               hw = of_clk_get_hw(dev->of_node, -1, con_id);
+               hw = of_clk_get_hw(dev->of_node, 0, con_id);
                if (!IS_ERR(hw) || PTR_ERR(hw) == -EPROBE_DEFER)
                        return clk_hw_create_clk(dev, hw, dev_id, con_id);
        }
