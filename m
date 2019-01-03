Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E7CC43612
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51292184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546558748;
	bh=JauEgPlDF4vNGUY660UwdmTygIBtTNyTT/Q6WvXLM7Y=;
	h=Subject:Cc:To:In-Reply-To:From:References:Date:List-ID:From;
	b=MKrHi7+T/0hrpow+7sMzRywXtU9tiAY7iw6Hk7b+jpzaTON8zPYA1B30AwLG7KzYC
	 ygqvrlir8LzrtDLfE35z6PLmoNBv9sWlPlWlutgmmXLsrQMarsNxygpXYkda+1JgvV
	 MPkFUvrTP/8I5qXLwKeyKJHWRXGWEfLx0eEpBzRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfACXjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 18:39:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:36236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728829AbfACXjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 18:39:07 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19F2C217F5;
        Thu,  3 Jan 2019 23:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546558746;
        bh=JauEgPlDF4vNGUY660UwdmTygIBtTNyTT/Q6WvXLM7Y=;
        h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
        b=E6NOFUl6N32Txx1BwuNo2MuSZibq2WW9zlAAzS0qd7FJHWp0y3Ozoy2DE7LTOCdUm
         McJuWEkRfWF0Y0sD98l8EB2NTg+DgfuYeluHAGMBeZEQ4aIvbwDwj7tULbxG+kk1D5
         nMLIcVTHnfT4sOECntwi7kqZpkWey/+NQ3z7itPc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle ops
Cc:     Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com,
        letux-kernel@openphoenux.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        mturquette@baylibre.com, paul@pwsan.com
To:     Andreas Kemnade <andreas@kemnade.info>,
        Tero Kristo <t-kristo@ti.com>
In-Reply-To: <20181231092944.014fc1c0@aktux>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com> <20181130153729.GG53235@atomide.com> <154362191595.88331.15503578806026771935@swboyd.mtv.corp.google.com> <20181203153910.GA6707@atomide.com> <20181203172246.0e767a16@kemnade.info> <20181204164556.GB6707@atomide.com> <20181227211222.5996c356@aktux> <20181228200229.GY6707@atomide.com> <76d9fc57-898b-53ba-1dca-78e5b5c9b2be@ti.com> <20181231092944.014fc1c0@aktux>
Message-ID: <154655874528.15366.10423050138946294754@swboyd.mtv.corp.google.com>
Date:   Thu, 03 Jan 2019 15:39:05 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andreas Kemnade (2018-12-31 00:30:21)
> On Mon, 31 Dec 2018 09:23:01 +0200
> Tero Kristo <t-kristo@ti.com> wrote:
>=20
> > On 28/12/2018 22:02, Tony Lindgren wrote:
> > > * Andreas Kemnade <andreas@kemnade.info> [181227 20:13]: =20
> > >> Hi,
> > >>
> > >> On Tue, 4 Dec 2018 08:45:57 -0800
> > >> Tony Lindgren <tony@atomide.com> wrote:
> > >> =20
> > >>> * Andreas Kemnade <andreas@kemnade.info> [181204 06:17]: =20
> > >>>> On Mon, 3 Dec 2018 07:39:10 -0800
> > >>>> Tony Lindgren <tony@atomide.com> wrote: =20
> > >>>>> The consumer device stays active just fine with PM runtime
> > >>>>> calls. So yes, the problem is keeping a clock controller forced
> > >>>>> active for the period of consumer device reset. Other than
> > >>>>> that typically autoidle can be just kept enabled.
> > >>>>>     =20
> > >>>> Are we still talking about the same problem? Maybe I am losing tra=
ck
> > >>>> here. Just to make sure.
> > >>>> The patch series was about disabling autoidle for devices which ca=
nnot
> > >>>> work with it during normal operation. Not during reset or something
> > >>>> like that.
> > >>>> Or is the keep-clock-active-during-reset just a requirement for bi=
gger
> > >>>> restructuring ideas? =20
> > >>>
> > >>> Yeah there are two issues: The fix needed for the issue you brought=
 up,
> > >>> and also how to let a reset driver to block autoidle for reset.
> > >>> =20
> > >> Hmm, is this set now waiting for the famous "somebody" fixing all
> > >> the stuff? =20
> > >=20
> > > Well I think we're still waiting on Tero to comment on this. =20
> >=20
> > The only item requiring immediate fixing is the point Stephen made out,=
=20
> > removing the usage of CLK_IS_BASIC from this patch.
> >=20
> > Afaics, the reset related concerns Tony has can be handled later.
> >=20
> hmm, and there we need Stephen's opinion about having the allow/deny
> autoidle functions in the main clk_ops struct.
>=20

I have unanswered questions on the list for this thread[1]. I'm not sure
what allow/deny autoidle functions mean to clk drivers. It looks like an
OMAP specific addition to the clk_ops struct, which sounds wrong to put
it plainly. Hopefully it can be done outside of the clk framework by
having the provider driver know more things about all the frameworks
it's hooking into.

[1] https://lkml.kernel.org/r/154385676593.88331.5239924154783168815@swboyd=
.mtv.corp.google.com

