Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D310CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B6D20883
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547509842;
	bh=nxmDQmXyHlAZ/bAsuCjxJIvEnsJ76XdFCud2ws8Wim0=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=sM5kuq5Tf4h2vtX/WwpF42XNqlwzeCMg693mKFsOviKUakSclgc4QjeMyIoOyddZ3
	 WLWCukZcP5fscg6tdA4CdiifVZjp7Hdo+Fve8jtqZSLbaO4W0Y0InJtCVOvZ3Jru9R
	 PI18q3aH0gYO2TPm1/ptmbU3RYpbebuUk5yLNTgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfANXul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:50:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbfANXuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:50:39 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7961520989;
        Mon, 14 Jan 2019 23:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547509838;
        bh=nxmDQmXyHlAZ/bAsuCjxJIvEnsJ76XdFCud2ws8Wim0=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=lcyXY1ynz2TNoSfP7DQSAKIGIHnGL0ltbg6sWBzCDEFbxOjO36UFWj1Xyi2gzDyz4
         PzNcWB6Don58Z1s7NqtCPuAzX6efGUg3js1UgqVRHuOlK+ZHtA67effFhRyucbPAoR
         PiDc63/sFBT1hWsTff7KmP/rKRqqYrKAlsM8GJ6M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 06/14] spmi: pmic-arb: disassociate old virq if hwirq mapping already exists
User-Agent: alot/0.8
In-Reply-To: <20190113154716.5145-7-masneyb@onstation.org>
References: <20190113154716.5145-1-masneyb@onstation.org> <20190113154716.5145-7-masneyb@onstation.org>
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Brian Masney <masneyb@onstation.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org
Message-ID: <154750983758.169631.7250053254022211406@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Mon, 14 Jan 2019 15:50:37 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2019-01-13 07:47:08)
> Check to see if the hwirq is already associated with another virq on
> this IRQ domain. If so, then disassociate it before associating the
> hwirq with the new virq.
>=20
> This is a temporary hack that is needed in order to not break git
> bisect for existing boards. The next patch in this series converts
> spmi-gpio to be a hierarchical IRQ chip, then there are several patches
> to update all of the device tree files, and finally this patch will be
> reverted within the same patch series.
>=20
> IRQs for spmi-gpio are all initially setup without an IRQ hierarchy
> on pmic-arb when mfd/qcom-spmi-pmic.c is probed (via the
> devm_of_platform_populate call) due to the interrupts property in
> device tree. Once spmi-gpio is converted to be a hierarchical IRQ chip
> in the next patch, existing users of gpio[d]_to_irq() will call
> pmic_gpio_to_irq(), and that will use the new IRQ chip code in
> spmi-gpio that sets up the IRQ in an IRQ hierarchy. The hwirq is now
> associated with two Linux virqs and interrupts will not work as
> expected. This patch corrects that issue.
>=20
> Driver was tested using gpio-keys and iadc/vadc on the LG Nexus 5
> (hammerhead) phone.
>=20
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

