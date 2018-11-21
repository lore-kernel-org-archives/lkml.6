Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222BAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FA32147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tT4ebkHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FA32147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeKUSgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:36:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:59532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728078AbeKUSgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:36:54 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32A452145D;
        Wed, 21 Nov 2018 08:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542787405;
        bh=zP8OWt1hsbB4NImJqQ15GVcek7o+lkF2496OvMYzo48=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=tT4ebkHJ5BVjZ7kdc2dQhJkeGn+EAPfFN4+tDd2RaCW++aZ+GqINjc9V5tMEMmyid
         XPsvzVRFCFQOItuXjancY+TZzITHb3pT/RO1aSkCajmHCwjAfCPReLiGCJv9+zLW0R
         WA0F1TSHfxk6wORio0vTJp979DwD8EJc0FoxtGbM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542685880.5132.11.camel@mtksdaap41>
Cc:     Rob Herring <robh@kernel.org>, srv_heupstream@mediatek.com,
        jamesjj.liao@mediatek.com, sboyd@codeaurora.org,
        lkml <linux-kernel@vger.kernel.org>, fan.chen@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        owen.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20181106064206.17535-1-weiyi.lu@mediatek.com>
 <20181106064206.17535-4-weiyi.lu@mediatek.com>
 <CANMq1KBjtyQFyJ-mZBndPDSfSDnD0K8izy39jp9zKE4xfiCiog@mail.gmail.com>
 <1542685880.5132.11.camel@mtksdaap41>
Message-ID: <154278740462.88331.17720342357503268022@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 02/11] clk: mediatek: add new member to mtk_pll_data
Date:   Wed, 21 Nov 2018 00:03:24 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2018-11-19 19:51:20)
> On Tue, 2018-11-13 at 08:18 -0800, Nicolas Boichat wrote:
> > On Mon, Nov 5, 2018 at 10:43 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
> > > @@ -138,9 +140,10 @@ static void mtk_pll_set_rate_regs(struct mtk_clk=
_pll *pll, u32 pcw,
> > >  static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u=
32 *postdiv,
> > >                 u32 freq, u32 fin)
> > >  {
> > > -       unsigned long fmin =3D 1000 * MHZ;
> > > +       unsigned long fmin =3D pll->data->fmin ? pll->data->fmin : 10=
00 * MHZ;
> > =

> > I'd put parentheses around (1000 * MHZ), to avoid the need to think
> > about precedence...
> > =

> =

> OK, thanks for the suggestion. will add in next version

Better style would be to not use a ternary statement for anything like
this and have an if condition instead.

