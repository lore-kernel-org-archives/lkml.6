Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B157C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF2321B1C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550209889;
	bh=2HYpZ8C2rw8QFkLaNwrUiibUBIe7rwEP7b8zXCMdSLY=;
	h=To:In-Reply-To:Subject:References:Cc:From:Date:List-ID:From;
	b=RF0DXTNAosfqei8RjfjWJ3mbYanVPWZUpCGasuKp2Ir+rkv8XRWlUtJkzz7NWg0Pj
	 sTugRLFMuxAwYRXWH/2jYaDPEPTdSFVUnK3jCMRcrgk/CIpNB65+K7GvMF3aRwcP4S
	 rncq13vFvygmL6R1mcdSf4WakLgn2ytF6/csnqLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732130AbfBOFv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 00:51:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:54610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbfBOFv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 00:51:28 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35E71206DD;
        Fri, 15 Feb 2019 05:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550209887;
        bh=2HYpZ8C2rw8QFkLaNwrUiibUBIe7rwEP7b8zXCMdSLY=;
        h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
        b=pcLjU2SkNIqChRCRpstLH+lfiyP5X+NvW6cxx7ZODAXrAMcnk54IEymfuYyd2Xbm1
         wrFeUxsBb0jl938lOynwrvB+G6RgZxjKGFMRT3c1HlOUZSERzVmNpEpJqKrPTqCVd4
         bHC6pOd1eSVquVZMpZpm/v3W4LoE/0/LkV4NR+7g=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Brian Masney <masneyb@onstation.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, lee.jones@linaro.org,
        linus.walleij@linaro.org, marc.zyngier@arm.com
In-Reply-To: <20190208021631.30252-6-masneyb@onstation.org>
User-Agent: alot/0.8
Subject: Re: [PATCH v2 05/11] mfd: pm8xxx: disassociate old virq if hwirq mapping already exists
Message-ID: <155020988635.115909.8353948296231202388@swboyd.mtv.corp.google.com>
References: <20190208021631.30252-1-masneyb@onstation.org> <20190208021631.30252-6-masneyb@onstation.org>
Cc:     tglx@linutronix.de, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Thu, 14 Feb 2019 21:51:26 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2019-02-07 18:16:25)
> Check to see if the hwirq is already associated with another virq on
> this IRQ domain. If so, then disassociate it before associating the
> hwirq with the new virq.
>=20
> This is a temporary hack that is needed in order to not break git
> bisect for existing boards. The next patch in this series converts
> ssbi-gpio to be a hierarchical IRQ chip, then there are several patches
> to update all of the device tree files, and finally this patch will be
> reverted within the same patch series.
>=20
> IRQs for ssbi-gpio are all initially setup without an IRQ hierarchy
> this driver is probed due to the interrupts property in device tree.
> Once ssbi-gpio is converted to be a hierarchical IRQ chip in the next
> patch, existing users of gpio[d]_to_irq() will call pmic_gpio_to_irq(),
> and that will use the new IRQ chip code in ssbi-gpio that sets up the
> IRQ in an IRQ hierarchy. The hwirq is now associated with two Linux
> virqs and interrupts will not work as expected. This patch corrects
> that issue.
>=20
> This change was tested on an APQ8060 DragonBoard.
>=20
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes since v1:
> - None
>=20
>  drivers/mfd/qcom-pm8xxx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
> index 8eb2528793f9..2f99a98ccee5 100644
> --- a/drivers/mfd/qcom-pm8xxx.c
> +++ b/drivers/mfd/qcom-pm8xxx.c
> @@ -380,6 +380,12 @@ static void pm8xxx_irq_domain_map(struct pm_irq_chip=
 *chip,
>                                   struct irq_domain *domain, unsigned int=
 irq,
>                                   irq_hw_number_t hwirq, unsigned int typ=
e)
>  {
> +       unsigned int old_virq;
> +
> +       old_virq =3D irq_find_mapping(domain, hwirq);
> +       if (old_virq)
> +               irq_domain_disassociate(domain, old_virq);

Is it possible to pass 'true' for the 'realloc' argument to
__irq_domain_alloc_irqs() and then this disassociate change isn't
needed?

> +
>         irq_domain_set_info(domain, irq, hwirq, chip->pm_irq_data->irq_ch=
ip,
>                             chip, handle_level_irq, NULL, NULL);
>         irq_set_noprobe(irq);
