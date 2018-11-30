Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117A2C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5352146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5352146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbeK3VaZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:30:25 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48770 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbeK3VaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:30:25 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EC8A420CFB; Fri, 30 Nov 2018 11:21:34 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id 44860207A8;
        Fri, 30 Nov 2018 11:20:53 +0100 (CET)
Date:   Fri, 30 Nov 2018 11:20:52 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH 2/2] clk: core: link consumer with clock driver
Message-ID: <20181130112052.73d943ec@xps13>
In-Reply-To: <154356998033.88331.4426431020982838779@swboyd.mtv.corp.google.com>
References: <20181122212212.16039-3-miquel.raynal@bootlin.com>
        <201811231627.H7ojlKLL%fengguang.wu@intel.com>
        <20181123101132.6be3829c@xps13>
        <154356998033.88331.4426431020982838779@swboyd.mtv.corp.google.com>
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

Stephen Boyd <sboyd@kernel.org> wrote on Fri, 30 Nov 2018 01:26:20
-0800:

> Quoting Miquel Raynal (2018-11-23 01:11:32)
> > Would you agree with me adding dummy functions in the #else section
> > like:
> > 
> > static inline void __clk_device_link(struct device *consumer, struct clk *clk)
> > {
> >        return;
> > }
> > 
> > static inline void __clk_device_unlink(struct clk *clk)
> > {
> >        return;
> > }
> > 
> > Do you want me to also declare these functions in the #if section
> > (with the external keyword) to balance the above declarations?  
> 
> Why can't we do the linking in __clk_get() and __clk_put()?
> 

Because we need the caller's 'struct device' to make the link and
this is not available in __clk_get(). I tried to ad it as parameter but
I don't think it is possible to retrieve a 'struct device' from the
device name. The functions where this is problematic are:
* clk.c:__of_clk_get_from_provider()
* clkdev.c:clk_get_sys()

By the way in my new version I called the helpers:
* clk_{link,unlink}_hierarchy()
* clk_{link,unlink}_consumer()

I will send a new version with these helpers, but if you have anything
in mind to help me achieve the above request, I will welcome the idea.


Thanks,
Miquèl
