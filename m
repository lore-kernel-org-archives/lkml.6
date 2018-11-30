Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858C6C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7CD20867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5ugkbqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7CD20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbeLALC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:02:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:35952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbeLALC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:02:58 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABE1D20863;
        Fri, 30 Nov 2018 23:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543621916;
        bh=28KxK7jmdJhv3ezopzF8QLNa4Cm04iaHphql+3h5q/M=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=D5ugkbqiQaI6Osdqb1R09pUl0ei920geNir6aNU9Ap3TtD8Va13j37nNGL7ZdM2Pf
         RgDIsqbWNuZOci3TP4oLhD9FUp1Iu3KsmSR6SyD2j7nAkRNN3y1buQMYnGuhZnGTNM
         LJaX+bZJUCigLoBFmmsTNYPavwaBNrddm86uC+5c=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181130153729.GG53235@atomide.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>, bcousson@baylibre.com,
        letux-kernel@openphoenux.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        mturquette@baylibre.com, paul@pwsan.com
References: <20181110203115.13335-1-andreas@kemnade.info>
 <20181110203115.13335-3-andreas@kemnade.info>
 <154353750560.88331.11814738542436183126@swboyd.mtv.corp.google.com>
 <20181130071534.0a6cd455@kemnade.info>
 <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com>
 <9eb7b090-4803-d389-4112-3bf058385b2e@ti.com>
 <154356463284.88331.13323307899580657085@swboyd.mtv.corp.google.com>
 <eca27a46-2ca3-1a02-c0c8-c1c00b3b2f46@ti.com>
 <20181130153729.GG53235@atomide.com>
Message-ID: <154362191595.88331.15503578806026771935@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle ops
Date:   Fri, 30 Nov 2018 15:51:55 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tony Lindgren (2018-11-30 07:37:29)
> Hi,
> =

> * Tero Kristo <t-kristo@ti.com> [181130 09:21]:
> > On 30/11/2018 09:57, Stephen Boyd wrote:
> > > No that is not preferred. Can the omap2_clk_deny_idle() function be
> > > integrated closer into the clk framework in some way that allows it to
> > > be part of the clk_ops structure? And then have that take a clk_hw
> > > structure instead of a struct clk? I haven't looked at this in any
> > > detail whatsoever so I may be way off right now.
> > =

> > It could be added under the main clk_ops struct, however this would
> > introduce two new func pointers to it which are not used by anything el=
se
> > but OMAP. Are you aware of any other platforms requiring similar featur=
e?
> =

> From consumer usage point of view, I'm still wondering about
> the relationship of clk_deny_idle() and clkdm_deny_idle().
> =

> It seems that we need to allow reset control drivers call
> clk_deny_idle() for the duration of reset. And it seems the
> clk_deny_idle() should propagate to also up to the related
> clock domain driver to do clkdm_deny_idle().
> =

> So maybe clk_deny_idle() is could just be something like:
> =

> dev =3D clk_get_device(clk);
> ...
> error =3D pm_runtime_get(dev);
> ...
> pm_runtime_put(dev);
> ...
> =

> And that way it would just propagate to the parent clock
> domain driver and the clock framework does not need to know
> about clockdomains. A clockdomain could be just a genpd
> domain.
> =

> Or do you guys have better ideas?
> =


Wouldn't the device link in clk framework patches do this for you if we
had the RUNTIME_PM flag passed in. If this is about keeping the clock
controller active when a consumer device is using it then I think it may
work.

