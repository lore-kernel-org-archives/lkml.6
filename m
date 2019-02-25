Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C56C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A9320C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551115397;
	bh=jUVsctHUgvayoQ79L0I7WuO5SYorYv5zFy3yLJyycfU=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=AD62SDXIwHZwVhRRLLNXKJMD1ezcABG2nbgDPMPloUmdVUfc8RF8DorYNzZaAM1u0
	 Z6iK7wJW9OONyUY8xb1NyQ/le6CbjT2Tr/MSkUiUtQ5WVWQsq0h8nG9hqDv7a44nHh
	 B1DKNUcjIOfu06MK4utOwzbdzbGgps9slk6kZJxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfBYRXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:23:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbfBYRXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:23:16 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16BE720684;
        Mon, 25 Feb 2019 17:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551115395;
        bh=jUVsctHUgvayoQ79L0I7WuO5SYorYv5zFy3yLJyycfU=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=heTY1QR9436fC/F+vwS8v1uF4btWeGRDQJ8ad3d+CJFY1y5pVZdd72ZK9RHSaeJwS
         yXrm2bAgcP9j7LTe+s0g67xd1m8RCkdU3zgUu3RJTTcWOtKjj65aLsike7H2OAUmkf
         Ebqzf3gzMbsJUIxaotVLGkZaBv+aWjcLsHEDZYiI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] clk: imx: Refactor entire sccg pll clk
Message-ID: <155111539427.77512.17052467596124902632@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1550855235-31528-1-git-send-email-abel.vesa@nxp.com> <155085758346.77512.1117855723990616329@swboyd.mtv.corp.google.com> <20190223105813.aepvfxzbjcdjvkzy@fsr-ub1664-175>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190223105813.aepvfxzbjcdjvkzy@fsr-ub1664-175>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 25 Feb 2019 09:23:14 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2019-02-23 02:58:14)
> On 19-02-22 09:46:23, Stephen Boyd wrote:
> > Quoting Abel Vesa (2019-02-22 09:07:32)
> > > Make the entire combination of plls to be one single clock. The paren=
ts used
> > > for bypasses are specified each as an index in the parents list.
> > > The determine_rate does a lookup throughout all the possible combinat=
ions
> > > for all the divs and returns the best possible 'setup' which in turn =
is used
> > > by set_rate later to set up all the divs and bypasses.
> > >=20
> > > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > > Tested-by: Lucas Stach <l.stach@pengutronix.de>
> > > Acked-by: Lucas Stach <l.stach@pengutronix.de>
> >=20
> > I suspect these tested by and acked tags should have been dropped,
> > unless you discussed and tested off-list?
> >=20
>=20
> Oups, I forgot to drop them.

Ok. Can Lucas re-test?

