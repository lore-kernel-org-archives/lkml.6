Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63719C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334AC21783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547246952;
	bh=COwkIeYXkL2LvqiszFfWYcnuafPpg1uJP7sxv5bcmXA=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=Nyvi57w3Z//X3FeX6bFd6oWruMdVmruBanlHXpW0FQSKLpTIldksM54axU/QdYCx7
	 qmxQVBYGGlvMJkeou2awJWB//T9hNxTBNC5vqXKKttC2HcvJxxzY/j24stVSIFYiKf
	 AHKgrpzTjlXjgvBAxBwEdDVyFlEuFk5ksiQXRWPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfAKWtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:49:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:51220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfAKWtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:49:11 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C58B20878;
        Fri, 11 Jan 2019 22:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547246949;
        bh=COwkIeYXkL2LvqiszFfWYcnuafPpg1uJP7sxv5bcmXA=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=S3qZQbqEfJnnN7AZxqcFsvJcglBHMNSE5vcIc0SX0zluDf5U8cvBUp7h5KWqAj4RX
         lgQQ8mKisMF0lkbseJzNB4a1+/gzEjUIU3SwRHmQLEVzi2EXfWFMRinUfEYEP/ub3r
         0IG7Stvy+ar4O5ONZ5h9HgUpsCZVSCwAt4HgK204=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle ops
User-Agent: alot/0.8
In-Reply-To: <33b3aecd-54dc-ae93-dabe-883275e1d7b0@ti.com>
References: <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com> <20181203153910.GA6707@atomide.com> <20181203172246.0e767a16@kemnade.info> <20181204164556.GB6707@atomide.com> <20181227211222.5996c356@aktux> <20181228200229.GY6707@atomide.com> <76d9fc57-898b-53ba-1dca-78e5b5c9b2be@ti.com> <20181231092944.014fc1c0@aktux> <154655874528.15366.10423050138946294754@swboyd.mtv.corp.google.com> <33b3aecd-54dc-ae93-dabe-883275e1d7b0@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com,
        letux-kernel@openphoenux.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        mturquette@baylibre.com, paul@pwsan.com
To:     Andreas Kemnade <andreas@kemnade.info>,
        Tero Kristo <t-kristo@ti.com>
Message-ID: <154724694850.169631.6179537075340016611@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 11 Jan 2019 14:49:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tero Kristo (2019-01-03 23:28:58)
> On 04/01/2019 01:39, Stephen Boyd wrote:
> > Quoting Andreas Kemnade (2018-12-31 00:30:21)
> >> On Mon, 31 Dec 2018 09:23:01 +0200
> >> Tero Kristo <t-kristo@ti.com> wrote:
> >>
> >>> On 28/12/2018 22:02, Tony Lindgren wrote:
> >>>> * Andreas Kemnade <andreas@kemnade.info> [181227 20:13]:
> >>>>> Hi,
> >>>>>
> >>>>> On Tue, 4 Dec 2018 08:45:57 -0800
> >>>>> Tony Lindgren <tony@atomide.com> wrote:
> >>>>>  =20
> >>>>>> * Andreas Kemnade <andreas@kemnade.info> [181204 06:17]:
> >>>>>>> On Mon, 3 Dec 2018 07:39:10 -0800
> >>>>>>> Tony Lindgren <tony@atomide.com> wrote:
> >>>>>>>> The consumer device stays active just fine with PM runtime
> >>>>>>>> calls. So yes, the problem is keeping a clock controller forced
> >>>>>>>> active for the period of consumer device reset. Other than
> >>>>>>>> that typically autoidle can be just kept enabled.
> >>>>>>>>      =20
> >>>>>>> Are we still talking about the same problem? Maybe I am losing tr=
ack
> >>>>>>> here. Just to make sure.
> >>>>>>> The patch series was about disabling autoidle for devices which c=
annot
> >>>>>>> work with it during normal operation. Not during reset or somethi=
ng
> >>>>>>> like that.
> >>>>>>> Or is the keep-clock-active-during-reset just a requirement for b=
igger
> >>>>>>> restructuring ideas?
> >>>>>>
> >>>>>> Yeah there are two issues: The fix needed for the issue you brough=
t up,
> >>>>>> and also how to let a reset driver to block autoidle for reset.
> >>>>>>  =20
> >>>>> Hmm, is this set now waiting for the famous "somebody" fixing all
> >>>>> the stuff?
> >>>>
> >>>> Well I think we're still waiting on Tero to comment on this.
> >>>
> >>> The only item requiring immediate fixing is the point Stephen made ou=
t,
> >>> removing the usage of CLK_IS_BASIC from this patch.
> >>>
> >>> Afaics, the reset related concerns Tony has can be handled later.
> >>>
> >> hmm, and there we need Stephen's opinion about having the allow/deny
> >> autoidle functions in the main clk_ops struct.
> >>
> >=20
> > I have unanswered questions on the list for this thread[1].
>=20
> The reset portion we can't answer with the current knowledge I fear, we=20
> need to prototype this a bit first and see which way to go.
>=20
> > I'm not sure
> > what allow/deny autoidle functions mean to clk drivers. It looks like an
> > OMAP specific addition to the clk_ops struct, which sounds wrong to put
> > it plainly.
>=20
> Yeah, I don't think other SoCs implement the same functionality, at=20
> least not in the same way. The autoidle bits are available in=20
> omap2/omap3 only, where they control the HW autoidle functionality of=20
> these clocks. If the bit is enabled, the HW can autonomously disable the =

> clock once it is not needed anymore by HW.

Some qcom chips have automatic clock gating (basically hw clk gating)
but they don't really need to involve that with the reset asserting or
deasserting anymore. It used to be that they had to turn off the
automatic mode, assert the reset, deassert the reset, and then reenable
the automatic mode. So there is some precedence for this. But again, I
think that the reset controller and the clk controller are the same
device in both vendor instances so in theory the driver can be one
driver for both clk and reset and do the proper things on the backend.
So just use reset controller framework and register that from the clk
controller driver?

>=20
> > Hopefully it can be done outside of the clk framework by
> > having the provider driver know more things about all the frameworks
> > it's hooking into.
>=20
> This is how it has been done so far, however Andreas wants to expand the =

> functionality a bit where it breaks... unless we can use the=20
> CLK_IS_BASIC flag to detect if we accessing an OMAP specific clock or=20
> not. If we are passing in a clk pointer from a consumer level API, I=20
> don't know if there is any other way to go with this if we can't modify=20
> the generic clk_ops struct.
>=20
> The same flag check is used across TI clock driver already btw.
>=20

Sure, it's not like this is a new problem. I'd just like to see if we
can solve it now and get rid of the CLK_IS_BASIC flag now. It would be
great if some extra effort could be put into it vs. punting the problem
until 2020 or something.

