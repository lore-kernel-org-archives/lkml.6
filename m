Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36514C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C1C217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551115313;
	bh=B11qdtzD4kvPekptQ8/DwF7Tpovpen1qO75lHMRYb58=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=cABQhl2pUWkI6Nd80iGXHZ4LpN2TIddYFOmLba0pX6Sx7AfJqoad9WfbEZisgoRvq
	 ZZZ+sx8TrDtNt+rKKUN4YGkqROHG+ShMwtlDe4RaB+h/LM+hLnQLu809NQvnLiCohx
	 sl0OYDO1te1sImXR63jrYOOlGhBYxx475u4Y5iOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfBYRVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:21:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:35810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbfBYRVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:21:50 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C57420684;
        Mon, 25 Feb 2019 17:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551115309;
        bh=B11qdtzD4kvPekptQ8/DwF7Tpovpen1qO75lHMRYb58=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=JevmI0d3htbubzraz3yIWbu8XD/A1b8k7lwL/g/JM0fU8SK6vry+byfb64hfM1+1j
         b7PpFKMm363LJ8m+mudNHYa3Nkn7Zv/OzhNxDnrBfYdz+3Yo1I6qj1F81FuQ9OR3gH
         x5MtJcpodyrqsw365DHsiso1R2a9W6c5bUkgUAEs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH RESEND V6 2/2] clk: imx: scu: add cpu frequency scaling support
Message-ID: <155111530880.77512.16435986555733393398@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1550802436-13007-1-git-send-email-Anson.Huang@nxp.com> <1550802436-13007-2-git-send-email-Anson.Huang@nxp.com> <155086249004.77512.8709011386763447047@swboyd.mtv.corp.google.com> <DB3PR0402MB3916BA142113B84C0199C93EF5780@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <DB3PR0402MB3916BA142113B84C0199C93EF5780@DB3PR0402MB3916.eurprd04.prod.outlook.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
Date:   Mon, 25 Feb 2019 09:21:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2019-02-22 18:32:28)
> > > +               cluster_id =3D 0;
> >=20
> > Do we still need to check this anymore? Why not just always use cluster=
_id 0?
>=20
> The i.MX8QXP ONLY has 1 cluster named A35, while on i.MX8QM there will be
> 2 clusters, A53 and A72, so we need to use the resource ID to initialize =
the cluster_id.
>=20
> >=20
> > > +
> > > +       /* CPU frequency scaling can ONLY be done by ARM-Trusted-Firm=
ware
> > */
> > > +       arm_smccc_smc(IMX_SIP_CPUFREQ, IMX_SIP_SET_CPUFREQ,
> > > +                     cluster_id, rate, 0, 0, 0, 0, &res);
> >=20
> > Because not checking would make this work, vs. checking causes this cod=
e to
> > sometimes use an uninitialized value from the stack.
>=20
>  89 +       if (rsrc_id =3D=3D IMX_SC_R_A35)
>  90 +               init.ops =3D &clk_scu_cpu_ops;
>  91 +       else
>  92 +               init.ops =3D &clk_scu_ops;
>=20
> I think it should be good. Only when plan to support cpu-freq scaling, th=
en the
> CPU clock will be switched to use clk_scu_cpu_ops and the clutser_id init=
ialization
> will be done according to CPU resource. For example, when we plan to supp=
ort i.MX8QM
> cpu-freq scaling, we will add A53 and A72 check here and switch the clock=
 ops to clk_scu_cpu_ops,
> also we will add the cluster_id initialization in the SMC clock set rate.
>=20

Ok. So then please make the set_rate function fail if the rsrc_id
doesn't match something expected. As the code is written right now, the
compiler can't figure out that cluster_id will always be assigned, so it
complains that it may be using uninitialized data.

