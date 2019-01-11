Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8B0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79D821783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547244514;
	bh=VSF2IiNDEjZXbDAFNccaf5sT5CpLNlBmN+NeWKwih4c=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=DX/8/LCrr3L7Z8hamFY/qvV9GG4/eiGoRfP6sGMOAI5LqvICsSOfA4M/JzXD1GZZD
	 Z6vfQ30WoJm/2ErOloGKul3DtHkgJqi+o6812ZA1qcRzdR+K2BfGgVYIl3szBxgVWR
	 uhjeW6Mp2A8SGgH5xEx2qlVkerVVdV6sZxSJ7Vmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfAKWIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:08:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfAKWId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:08:33 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC99C20878;
        Fri, 11 Jan 2019 22:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547244512;
        bh=VSF2IiNDEjZXbDAFNccaf5sT5CpLNlBmN+NeWKwih4c=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=Y0FLVD90vlL+P5wHmxLvDcX69mhs5L6OsMq5p/S4DtAZbyB6Nuu2jBVTKmhF8B6ww
         WfMegfmWrr5U+hlmC55SpBAvz1ATYQf90wGoHCArstQO5xTufePVW/VIQX3rzt6T9V
         UK1vqZo/GbbY7onrt2NhD6BtJzrA+Nr5OpaxwGZU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 4/6] qcom: spmi-gpio: add support for hierarchical IRQ chip
User-Agent: alot/0.8
In-Reply-To: <20190110011258.17227-5-masneyb@onstation.org>
References: <20190110011258.17227-1-masneyb@onstation.org> <20190110011258.17227-5-masneyb@onstation.org>
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Brian Masney <masneyb@onstation.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org
Message-ID: <154724451211.169631.16582455779809137159@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 11 Jan 2019 14:08:32 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2019-01-09 17:12:56)
> spmi-gpio did not have any irqchip support so consumers of this in
> device tree would need to call gpio[d]_to_irq() in order to get the
> proper IRQ on the underlying PMIC. IRQ chips in device tree should
> be usable from the start without the consumer having to make an
> additional call to get the proper IRQ on the parent. This patch adds
> hierarchical IRQ chip support to the spmi-gpio code to correct this
> issue.
>=20
> Driver was tested using the volume buttons (via gpio-keys) on the LG
> Nexus 5 (hammerhead) phone with the following two configurations.
>=20
> volume-up {
>         interrupts-extended =3D <&pm8941_gpios 2 IRQ_TYPE_EDGE_BOTH>;
>         ...
> };
>=20
> volume-up {
>         gpios =3D <&pm8941_gpios 2 GPIO_ACTIVE_LOW>;
>         ...
> };
>=20
> Both configurations now show that spmi-gpio is the IRQ domain and that
> the IRQ is setup in a hierarchy.
>=20
> $ grep volume_up /proc/interrupts
>  72:          6          0  spmi-gpio   1 Edge      volume_up
>=20
> $ cat /sys/kernel/debug/irq/irqs/72
> handler:  handle_edge_irq
> device:   (null)
> status:   0x00000403
>             _IRQ_NOPROBE
> istate:   0x00000000
> ddepth:   0
> wdepth:   0
> dstate:   0x02400203
>             IRQ_TYPE_EDGE_RISING
>             IRQ_TYPE_EDGE_FALLING
>             IRQD_ACTIVATED
>             IRQD_IRQ_STARTED
> node:     0
> affinity: 0-3
> effectiv:=20
> domain:  :soc:spmi@fc4cf000:pm8941@0:gpios@c000
>  hwirq:   0x1
>  chip:    spmi-gpio
>   flags:   0x4
>              IRQCHIP_MASK_ON_SUSPEND
>  parent:
>     domain:  :soc:spmi@fc4cf000
>      hwirq:   0xc100057
>      chip:    pmic_arb
>       flags:   0x4
>                  IRQCHIP_MASK_ON_SUSPEND
>=20
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

