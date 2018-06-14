Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 36CF3C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE07208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE07208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964830AbeFNMtQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:49:16 -0400
Received: from gloria.sntech.de ([95.129.55.99]:54690 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964777AbeFNMtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:49:15 -0400
Received: from wd0940.dip.tu-dresden.de ([141.76.111.172] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.1:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <heiko@sntech.de>)
        id 1fTRgc-0004dn-R7; Thu, 14 Jun 2018 14:49:10 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     dri-devel@lists.freedesktop.org
Cc:     Emil Velikov <emil.l.velikov@gmail.com>,
        Lin Huang <hl@rock-chips.com>, David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 1/3] drm/panel: refactor INNOLUX P079ZCA panel driver
Date:   Thu, 14 Jun 2018 14:49:05 +0200
Message-ID: <2358142.UaIIZZriA2@phil>
In-Reply-To: <CACvgo50UGi97RYQkYLMmVNKcfi39BSVVKkxHnLTvsEks737+-Q@mail.gmail.com>
References: <1521018736-20980-1-git-send-email-hl@rock-chips.com> <CACvgo50UGi97RYQkYLMmVNKcfi39BSVVKkxHnLTvsEks737+-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 14. März 2018, 13:02:13 CEST schrieb Emil Velikov:
> Hi Lin,
> 
> On 14 March 2018 at 09:12, Lin Huang <hl@rock-chips.com> wrote:
> > From: huang lin <hl@rock-chips.com>
> >
> > Refactor Innolux P079ZCA panel driver, let it support
> > multi panel.
> >
> > Change-Id: If89be5e56dba8cb498e2d50c1bbeb0e8016123a2
> > Signed-off-by: Lin Huang <hl@rock-chips.com>

[...]

> > @@ -207,19 +248,28 @@ static const struct drm_panel_funcs innolux_panel_funcs = {
> 
> >
> > -       innolux->supply = devm_regulator_get(dev, "power");
> > -       if (IS_ERR(innolux->supply))
> > -               return PTR_ERR(innolux->supply);
> > +       innolux = devm_kzalloc(dev, sizeof(*innolux), GFP_KERNEL);
> > +       if (!innolux)
> > +               return -ENOMEM;
> > +
> > +       innolux->desc = desc;
> > +       innolux->vddi = devm_regulator_get(dev, "power");
> > +       innolux->avdd = devm_regulator_get(dev, "avdd");
> > +       innolux->avee = devm_regulator_get(dev, "avee");
> >
> AFAICT devm_regulator_get returns a pointer which is unsuitable to be
> passed into regulator_{enable,disable}.
> Hence, the IS_ERR check should stay. If any of the regulators are
> optional, you want to call regulator_{enable,disable} only as
> applicable.

using the regulator_bulk APIs should help to make this far easier,
as you can just define the per-panel supplies in in the panel_desc
and then get + enable the correct ones per bound panel.


