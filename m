Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44024C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3BC2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXUP6lLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3BC2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeLAGGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:06:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:46746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbeLAGGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:06:03 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51ABA20834;
        Fri, 30 Nov 2018 18:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543604149;
        bh=Yn3Kj8SjepGfVKMZ9qAYh+MpJuICHMTg+kf4tPrygn0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=tXUP6lLzV2XfLkWPdc1GUCk8AHHsFkyadFUNgvBla2I/YUDWPkuJxLT2jxXgdIbhb
         IHyP4xRLjFVqw5AoihNXw1sBAUH7PRMjnVHT5tCNPpqdOw+H6eXKD098bS5IeSGK3D
         KI+pB+R0onnWJQLoe4Mp5xGAJqPiGko/CoZLaxMo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Phil Edworthy <phil.edworthy@renesas.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181130110446.GE30658@n2100.armlinux.org.uk>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20181120141445.21378-1-phil.edworthy@renesas.com>
 <154356894146.88331.4169293505438588293@swboyd.mtv.corp.google.com>
 <TY1PR01MB1769161656941346A08F9F8AF5D30@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <20181130110446.GE30658@n2100.armlinux.org.uk>
Message-ID: <154360414857.88331.16753630865153792604@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v8] clk: Add (devm_)clk_get_optional() functions
Date:   Fri, 30 Nov 2018 10:55:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Russell King - ARM Linux (2018-11-30 03:04:46)
> On Fri, Nov 30, 2018 at 10:25:37AM +0000, Phil Edworthy wrote:
> > On 30 November 2018 09:09 Stephen Boyd wrote:
> > > Quoting Phil Edworthy (2018-11-20 06:14:45)
> > > > This adds clk_get_optional() and devm_clk_get_optional() functions =
to
> > > > get optional clocks.
> > > > They behave the same as (devm_)clk_get except where there is no clo=
ck
> > > > producer. In this case, instead of returning -ENOENT, the function
> > > > returns NULL. This makes error checking simpler and allows
> > > > clk_prepare_enable, etc to be called on the returned reference with=
out
> > > > additional checks.
> > > =

> > > Ok. I guess that works by virtue of how -ENOENT is returned by various
> > > functions that are called deeper in the clk_get() path? I'm cautiously
> > > optimistic. So cautious, we should probably add a comment to these op=
tional
> > > functions that indicate they rely on the functions they call to retur=
n -ENOENT
> > > under the various conditions that make a clk optional.
> > Yes, it does indeed rely on how clk_get() is implemented.
> > Specifically, that if __of_clk_get_by_name() returns -EINVAL, the error=
 is
> > superseded by clk_get_sys() returning -ENOENT.
> > As you say, a comment may help here.
> =

> Each time the question of the optional clk_get() stuff comes up, we go
> around the same discussions time and time again.  So far, each time
> has ended up flopping.
> =

> Yes, clk_get() can only ever return -ENOENT if it falls back to the
> non-DT methods, because it assumes that the clk tables are complete
> (it can do nothing else.)
> =

> I don't think it needs a comment because it's obvious from the code
> and also from the implementation point of view.

Ok. I would still suggest a comment on of_clk_get_by_name() that
indicates what types of return values happen in there. Otherwise it's
obvious from the code after reading 3 or 4 functions deep
(__of_clk_get_by_name -> __of_clk_get -> of_parse_phandle_with_args and
__of_clk_get_from_provider) that this is what happens.

> =

> > > > +static inline struct clk *clk_get_optional(struct device *dev, con=
st
> > > > +char *id)
> > > =

> > > Any kernel doc for this function?
> > I took my cue from the surrounding functions, let me know if I have to =
add it.
> =

> I don't see you need to - this is an internal function by way of the
> "static inline" you have before it.  It's not an API function.

It's static inline in a header file. That is an API function as far as I
can tell.

