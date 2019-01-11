Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB745C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843812183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547249970;
	bh=a765YprzwGgYLsk0t0Bp69JT/jPnS6sQo4mjbgrGvnY=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=WfmRqqwmYcHoYi6gapvdj2ySjR0X0AGCOxN7CPlxFwhjSxk10GYegffzkOy+2Nw56
	 QnqEfYULDlatyAx5Eg0cLczH9fuScd7+JJjN4N4FfLpA+dU+UftY6IsYozSabnmJa4
	 OW9XAz/PpJqcg+t0MDkvPkbNSbhaZn2cLreLLggI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfAKXj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:39:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:58316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfAKXj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:39:29 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A448920878;
        Fri, 11 Jan 2019 23:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547249968;
        bh=a765YprzwGgYLsk0t0Bp69JT/jPnS6sQo4mjbgrGvnY=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=fLf+iD57tupRC0x/W+K1aW+QyJM0G6xQ2mNQOHKyZdxK4jCuhMTeio0JRv912XE+w
         eEBH8fFDIMpMOv/fAkgWre2on20az07ehOc0iZysUr2tfpb2sH7y4gFJcu1roj1IRW
         rJ1Ky4hBXza+nEY42PnTrQUNVK8DuThApjvtneVM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/6] spmi: pmic-arb: convert to v2 irq interfaces to support hierarchical IRQ chips
User-Agent: alot/0.8
In-Reply-To: <20190111230004.GA5805@basecamp>
References: <20190110011258.17227-1-masneyb@onstation.org> <20190110011258.17227-3-masneyb@onstation.org> <154724442941.169631.5308212449003169927@swboyd.mtv.corp.google.com> <20190111230004.GA5805@basecamp>
Cc:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, marc.zyngier@arm.com,
        shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Brian Masney <masneyb@onstation.org>
Message-ID: <154724996786.169631.3834576842560322500@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 11 Jan 2019 15:39:27 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2019-01-11 15:00:04)
> On Fri, Jan 11, 2019 at 02:07:09PM -0800, Stephen Boyd wrote:
> > Quoting Brian Masney (2019-01-09 17:12:54)
> > > Convert the spmi-pmic-arb IRQ code to use the version 2 IRQ interface
> > > in order to support hierarchical IRQ chips. This is necessary so that
> > > spmi-gpio can be setup as a hierarchical IRQ chip with pmic-arb as the
> > > parent. IRQ chips in device tree should be usable from the start with=
out
> > > the consumer having to make an additional call to gpio[d]_to_irq() to
> > > get the proper IRQ on the parent. Driver was tested on a LG Nexus 5
> > > (hammerhead) phone.
> > >=20
> > > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > > ---
> > > Changes since v2:
> > > - None
> > >=20
> > > Changes since v1:
> > > - Add intspec variable to qpnpint_irq_domain_translate to reduce the
> > >   overall diff.
> > > - Remove irq_domain_disassociate hack.
> >=20
> > I thought we would need to keep that around? And then dispose of the
> > hack later on. Won't this just wreck the world almost immediately
> > because the MFD is counting irqs from DT?
>=20
> We won't run into the issue with the MFD counting the IRQs since the
> interrupts property was removed and the interrupt-controller property
> was added to device tree in the same patch. The interrupts property that
> we ultimately don't need was the issue that I ran into with the MFD
> subsystem.
>=20
> However to be certain, I retested and we need the temporary hack since
> pmic_gpio_to_irq in this series uses the new SPMI IRQ controller. It
> breaks as soon as patch 4 in this series (qcom: spmi-gpio: add support
> for hierarchical IRQ chip) is applied but starts working again at patch
> 5 (ARM: dts: qcom: pm8941: add interrupt controller).
>=20
> I'll respin this series this weekend with the temporary hack and drop it
> later in the series. Sorry about the noise and thanks for the
> reviewed-bys.
>=20

Ok sounds good. Can you also fix all the spmi-gpio specifying dts files?
There are more than just two PMIC dts files that need changes (per my
grep results sent to the list earlier).

