Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EB3C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F400C214D9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5faTbEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F400C214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeLCTUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:20:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:43524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbeLCTUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:20:35 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B5D8208A3;
        Mon,  3 Dec 2018 19:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543864831;
        bh=H6S6MvFSSvsPpGH6+RWcgg9meLreOiqbH96RVPwsrgw=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=H5faTbEaDiuyorLuM7U+i/E6gKaz1LpKEldlqeqqL3PuBk4fHHKpgtCAZF86+zmrO
         HxZ/HEE6+cVO3F1emfUXw38UoD++Svm/+1DEEfyHXnUGM51q+1RcZ9Tb3IJ+FyN2EG
         QG91u70kQG2IA63iZOBApiBtRPK8oDsYMzpw502Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Miquel Raynal <miquel.raynal@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181130112052.73d943ec@xps13>
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
References: <20181122212212.16039-3-miquel.raynal@bootlin.com>
 <201811231627.H7ojlKLL%fengguang.wu@intel.com>
 <20181123101132.6be3829c@xps13>
 <154356998033.88331.4426431020982838779@swboyd.mtv.corp.google.com>
 <20181130112052.73d943ec@xps13>
Message-ID: <154386483105.88331.13970025193347328031@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: core: link consumer with clock driver
Date:   Mon, 03 Dec 2018 11:20:31 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miquel Raynal (2018-11-30 02:20:52)
> Hi Stephen,
> =

> Stephen Boyd <sboyd@kernel.org> wrote on Fri, 30 Nov 2018 01:26:20
> -0800:
> =

> > Quoting Miquel Raynal (2018-11-23 01:11:32)
> > > Would you agree with me adding dummy functions in the #else section
> > > like:
> > > =

> > > static inline void __clk_device_link(struct device *consumer, struct =
clk *clk)
> > > {
> > >        return;
> > > }
> > > =

> > > static inline void __clk_device_unlink(struct clk *clk)
> > > {
> > >        return;
> > > }
> > > =

> > > Do you want me to also declare these functions in the #if section
> > > (with the external keyword) to balance the above declarations?  =

> > =

> > Why can't we do the linking in __clk_get() and __clk_put()?
> > =

> =

> Because we need the caller's 'struct device' to make the link and
> this is not available in __clk_get(). I tried to ad it as parameter but
> I don't think it is possible to retrieve a 'struct device' from the
> device name. The functions where this is problematic are:
> * clk.c:__of_clk_get_from_provider()
> * clkdev.c:clk_get_sys()
> =

> By the way in my new version I called the helpers:
> * clk_{link,unlink}_hierarchy()
> * clk_{link,unlink}_consumer()
> =

> I will send a new version with these helpers, but if you have anything
> in mind to help me achieve the above request, I will welcome the idea.
> =


We can do the linking in __clk_get() and __clk_put() if we poke into the
struct clk -> struct clk_core and bury the struct device into each
clk_core structure.

