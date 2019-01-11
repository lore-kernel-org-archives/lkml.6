Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7819BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1DD2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="NTuVH6pT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfAKXAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:00:06 -0500
Received: from onstation.org ([52.200.56.107]:40464 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfAKXAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:00:05 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id CEED314C;
        Fri, 11 Jan 2019 23:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1547247605;
        bh=7YWGdwV1u1D/JPO9mD9mDUeoAKEuKut4w3G3r8+xiA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NTuVH6pTorsZyBuqEnb89A4XbnZSTgE2qkVBK9smN/KtqO5KP7gOp928ggzpKBm6A
         xlHfq2ww9sKsA8580nVEpiHYwZ+X9lvEvBvVxx6vn1bm/wC859N5JRIdWZbhXSRvFy
         /+exHZsPYUw4ykm8hjW0SlmuCGBPmCwRe9Ppngpo=
Date:   Fri, 11 Jan 2019 18:00:04 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, marc.zyngier@arm.com,
        shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/6] spmi: pmic-arb: convert to v2 irq interfaces to
 support hierarchical IRQ chips
Message-ID: <20190111230004.GA5805@basecamp>
References: <20190110011258.17227-1-masneyb@onstation.org>
 <20190110011258.17227-3-masneyb@onstation.org>
 <154724442941.169631.5308212449003169927@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154724442941.169631.5308212449003169927@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 02:07:09PM -0800, Stephen Boyd wrote:
> Quoting Brian Masney (2019-01-09 17:12:54)
> > Convert the spmi-pmic-arb IRQ code to use the version 2 IRQ interface
> > in order to support hierarchical IRQ chips. This is necessary so that
> > spmi-gpio can be setup as a hierarchical IRQ chip with pmic-arb as the
> > parent. IRQ chips in device tree should be usable from the start without
> > the consumer having to make an additional call to gpio[d]_to_irq() to
> > get the proper IRQ on the parent. Driver was tested on a LG Nexus 5
> > (hammerhead) phone.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > ---
> > Changes since v2:
> > - None
> > 
> > Changes since v1:
> > - Add intspec variable to qpnpint_irq_domain_translate to reduce the
> >   overall diff.
> > - Remove irq_domain_disassociate hack.
> 
> I thought we would need to keep that around? And then dispose of the
> hack later on. Won't this just wreck the world almost immediately
> because the MFD is counting irqs from DT?

We won't run into the issue with the MFD counting the IRQs since the
interrupts property was removed and the interrupt-controller property
was added to device tree in the same patch. The interrupts property that
we ultimately don't need was the issue that I ran into with the MFD
subsystem.

However to be certain, I retested and we need the temporary hack since
pmic_gpio_to_irq in this series uses the new SPMI IRQ controller. It
breaks as soon as patch 4 in this series (qcom: spmi-gpio: add support
for hierarchical IRQ chip) is applied but starts working again at patch
5 (ARM: dts: qcom: pm8941: add interrupt controller).

I'll respin this series this weekend with the temporary hack and drop it
later in the series. Sorry about the noise and thanks for the
reviewed-bys.

Brian
