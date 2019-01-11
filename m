Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64550C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A3A2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547244352;
	bh=ud1Yie9k2C3EIYIWAmP3UjxK8Tm7sc4U7aRKQxqj91o=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=PbEKTCy4MBUyUcP6bYsmuXFG5BMoMMoVg61rWeJ+HtPmSsLFmHUuBWZx3/EtfEtkF
	 upfVL+hHwMyVVxDA6o7uTcUb3Bjj9VALNNbmOGy5tvZZF4dL2We3v4MH4aePxODh6E
	 lC3t9UNhUFQghN8yNn9zDeu4bj05TQ6gGwlBzENI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfAKWFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:05:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:59640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbfAKWFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:05:51 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BC8C20878;
        Fri, 11 Jan 2019 22:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547244350;
        bh=ud1Yie9k2C3EIYIWAmP3UjxK8Tm7sc4U7aRKQxqj91o=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=ilG10Ty6DY58y1IBrOcrvwiFVK45oRpQHmKTMAG7QKhZqAY/jJGGsYI2yMbfb9MZf
         uSKHHosITQosxI/25JWebRfPPsgsDVvxMK6NFKxLTR7uvWMuoM1pc+4IRVshNUBTLE
         s37UQoFFRB4Elm13CB6rEQ6yN8Dp4P8j7rbb/B+w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 3/6] gpio: add irq domain activate/deactivate functions
User-Agent: alot/0.8
In-Reply-To: <20190110011258.17227-4-masneyb@onstation.org>
References: <20190110011258.17227-1-masneyb@onstation.org> <20190110011258.17227-4-masneyb@onstation.org>
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Brian Masney <masneyb@onstation.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org
Message-ID: <154724434941.169631.6671178005596601495@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 11 Jan 2019 14:05:49 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2019-01-09 17:12:55)
> This adds the two new functions gpiochip_irq_domain_activate and
> gpiochip_irq_domain_deactivate that can be used as the activate and
> deactivate functions in the struct irq_domain_ops. This is for
> situations where only gpiochip_{lock,unlock}_as_irq needs to be called.
> SPMI and SSBI GPIO are two users that will initially use these
> functions.
>=20
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> Stephen: Reply if you want a Suggested-by tag for this.

Sure. Add it please.

Suggested-by: Stephen Boyd <sboyd@kernel.org>

Minor question but otherwise

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

> +/**
> + * gpiochip_irq_domain_deactivate() - Unlock a GPIO used as an IRQ
> + * @domain: The IRQ domain used by this IRQ chip
> + * @data: Outermost irq_data associated with the IRQ
> + *
> + * This function is a wrapper that will call &gpiochip_unlock_as_irq and=
 is to

Is this kernel-doc notation to refer to functions and structures with
ampersand only? According to the docs[1] we should put () after
functions and '&struct' before structures.

> + * be used as the deactivate function for the struct &irq_domain_ops. The
> + * host_data for the IRQ domain must be the struct &gpiochip.
> + */
> +void gpiochip_irq_domain_deactivate(struct irq_domain *domain,
> +                                   struct irq_data *data)
> +{
> +       struct gpio_chip *chip =3D domain->host_data;
> +

[1] https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html?highli=
ght=3Dcross%20references#highlights-and-cross-references
