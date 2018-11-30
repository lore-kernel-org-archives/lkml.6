Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A93CC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E309A2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HydGg5va"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E309A2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeK3TFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:05:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:35860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbeK3TFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:05:40 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 918C72082F;
        Fri, 30 Nov 2018 07:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543564633;
        bh=45XbyJDAV+rjS6BURMjquRfCzLZ7P2sZjr9xmYBgirw=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=HydGg5valyBGLSi2BK5BMf6tt6P6RM7pAp+QXfLeqsezvo3DpddeF/zbrzovCHof6
         bYasXbs6SspbsxfwfE9lEoWlqK1nriWKzrbfpOiCPHbav3I7agiIUIccUovg7XPJJH
         kcK1ylDd47XlAzNVVySGLi+8G2OGI0VMLtjCRlOI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andreas Kemnade <andreas@kemnade.info>,
        Tero Kristo <t-kristo@ti.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <9eb7b090-4803-d389-4112-3bf058385b2e@ti.com>
Cc:     bcousson@baylibre.com, letux-kernel@openphoenux.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, mturquette@baylibre.com,
        paul@pwsan.com, tony@atomide.com
References: <20181110203115.13335-1-andreas@kemnade.info>
 <20181110203115.13335-3-andreas@kemnade.info>
 <154353750560.88331.11814738542436183126@swboyd.mtv.corp.google.com>
 <20181130071534.0a6cd455@kemnade.info>
 <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com>
 <9eb7b090-4803-d389-4112-3bf058385b2e@ti.com>
Message-ID: <154356463284.88331.13323307899580657085@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle ops
Date:   Thu, 29 Nov 2018 23:57:12 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tero Kristo (2018-11-29 23:35:35)
> On 30/11/2018 09:20, Stephen Boyd wrote:
> > Quoting Andreas Kemnade (2018-11-29 22:15:34)
> >> Hi Stephen,
> >>
> >> On Thu, 29 Nov 2018 16:25:05 -0800
> >> Stephen Boyd <sboyd@kernel.org> wrote:
> >>
> >>> Quoting Andreas Kemnade (2018-11-10 12:31:14)
> >>>> Code might use autoidle api with clocks not being omap2 clocks,
> >>>> so check if clock type is not basic
> >>>>
> >>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> >>>> ---
> >>>> New in v2
> >>>> ---
> >>>>   drivers/clk/ti/autoidle.c | 12 ++++++++++--
> >>>>   1 file changed, 10 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
> >>>> index 161f67850393..5bdae5552d38 100644
> >>>> --- a/drivers/clk/ti/autoidle.c
> >>>> +++ b/drivers/clk/ti/autoidle.c
> >>>> @@ -54,8 +54,12 @@ static DEFINE_SPINLOCK(autoidle_spinlock);
> >>>>   int omap2_clk_deny_idle(struct clk *clk)
> >>>>   {
> >>>>          struct clk_hw_omap *c;
> >>>> +       struct clk_hw *hw =3D __clk_get_hw(clk);
> >>>>   =

> >>>> -       c =3D to_clk_hw_omap(__clk_get_hw(clk));
> >>>> +       if (clk_hw_get_flags(hw) & CLK_IS_BASIC)
> >>>
> >>> Please try to avoid using CLK_IS_BASIC if at all possible. Can you?
> >>> Maybe add some flag in clk_hw_omap() instead?
> >>>
> >> hmm, Tero suggested that.
> >> But to check flags in clk_hw_omap I first need to know that there is a
> >> clk_hw_omap behind clk_hw. And for that I either need to check flags in
> >> clk_hw or do more changes in the omap_hwmod code.
> > =

> > Can you do it? The omap code is the only user of CLK_IS_BASIC. All the
> > other users are marking clks with this but there is no reason to do so.
> > I'll go make another pass over the tree and nuke those ones from orbit.
> =

> The reason for using this flag is because OMAP uses two clock types =

> around, the basic clocks like fixed-factor-clock/fixed-clock, and then =

> all the omap derivatives, which can be cast to clk_hw_omap. If we want =

> to avoid usage of CLK_IS_BASIC, we need to copy paste the remaining =

> basic code under drivers/clk/ti/ and convert them to use clk_hw_omap as =

> internal datatype. Is this preferred?
> =


No that is not preferred. Can the omap2_clk_deny_idle() function be
integrated closer into the clk framework in some way that allows it to
be part of the clk_ops structure? And then have that take a clk_hw
structure instead of a struct clk? I haven't looked at this in any
detail whatsoever so I may be way off right now.

