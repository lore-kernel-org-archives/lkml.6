Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9C894C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6B6208B6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSiFLWxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6B6208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934585AbeFLQd1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:33:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933658AbeFLQdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:33:25 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC7A5208B4;
        Tue, 12 Jun 2018 16:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528821205;
        bh=tVaDVhSYqs7DOEmDEij/aBy8WfVFrQKWgRk1pH79KY8=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=LSiFLWxOZZJ0ANKv9Rr4Ndb6SOoaYfb6MMWAZ+LQup+6qG8d47OcDZ2qG/07BizGk
         NUsnxKsCxHmOAFVVkOm96K1OEOcg7JCLkP54dM23BNqYFDPYbhsFZA4z8NfHTzzqQZ
         nwhWDxasH7uo7W7P7NU5mwI87DZr9PtfbdpipBVQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        alexandre.belloni@bootlin.com, alsa-devel@alsa-project.org,
        boris.brezillon@bootlin.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        nicolas.ferre@microchip.com, robh+dt@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <d2558674-9aee-8b08-293f-34754fd2b185@microchip.com>
Cc:     Cristian.Birsan@microchip.com
References: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
 <1527251668-31396-3-git-send-email-codrin.ciubotariu@microchip.com>
 <152778039660.144038.4743783065942615925@swboyd.mtv.corp.google.com>
 <d2558674-9aee-8b08-293f-34754fd2b185@microchip.com>
Message-ID: <152882120419.16708.16947882037246176868@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 2/7] clk: at91: add I2S clock mux driver
Date:   Tue, 12 Jun 2018 09:33:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Codrin Ciubotariu (2018-06-04 01:20:29)
> On 31.05.2018 18:26, Stephen Boyd wrote:
> > Quoting Codrin Ciubotariu (2018-05-25 05:34:23)
> > =

> >> +       .get_parent =3D clk_i2s_mux_get_parent,
> >> +       .set_parent =3D clk_i2s_mux_set_parent,
> >> +       .determine_rate =3D __clk_mux_determine_rate,
> >> +};
> >> +
> >> +static struct clk_hw * __init
> >> +at91_clk_i2s_mux_register(struct regmap *regmap, const char *name,
> >> +                         const char * const *parent_names,
> >> +                         unsigned int num_parents, u32 bus_id)
> >> +{
> >> +       struct clk_init_data init =3D {};
> >> +       struct clk_i2s_mux *i2s_ck;
> >> +       int ret;
> >> +
> >> +       i2s_ck =3D kzalloc(sizeof(*i2s_ck), GFP_KERNEL);
> >> +       if (!i2s_ck)
> >> +               return ERR_PTR(-ENOMEM);
> >> +
> >> +       init.name =3D name;
> >> +       init.ops =3D &clk_i2s_mux_ops;
> >> +       init.parent_names =3D parent_names;
> >> +       init.num_parents =3D num_parents;
> >> +       init.flags =3D CLK_IGNORE_UNUSED;
> > =

> > Really? Why?
> =

> I am thinking that there is no need to gate this clock, since there is =

> no way to gate this clock in HW.

This flag is not necessary if the clk can't be gated via hardware
control registers. Please remove the flag.

