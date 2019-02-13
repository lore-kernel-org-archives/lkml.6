Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2637DC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CD12190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550080097;
	bh=LoGu4ZFpYnInUrsS0hVTMhsGX33lNGrwKZApfVSsGoQ=;
	h=To:In-Reply-To:Subject:References:Cc:From:Date:List-ID:From;
	b=zApA+8278/6ocrYQTr0GiYzA0qCmJLfPYTJzgf3sSs//OdqI0Swgddbx7CBCTppoK
	 4yMVuIwUShKJ+kahBZ6T1lNROIgwqn7w4rQ6bnLC54U/q4XKkVUy7EsU46sXK1yric
	 fbbCOp3kWaqaXyUq/ZlyntQC7Nb0b/2c15wBjupM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404518AbfBMRsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:48:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:39872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729082AbfBMRsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:48:13 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0DD82086C;
        Wed, 13 Feb 2019 17:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550080093;
        bh=LoGu4ZFpYnInUrsS0hVTMhsGX33lNGrwKZApfVSsGoQ=;
        h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
        b=OZtVXEWthhNHNzk3YJ4HfieZLR7ZZmoreYaYOlnQx/uUCofvgJPajcFKISoAMcv7S
         w5BWbL8clOEhf8ZmfCbNMAVgF989LF70mDAnjpLCw9cae+Oa1lxOJOhM0BDa734+Rx
         rzjBTv5rI7vP2V1Wf3geijEcxn5TgA2jx8D/Ol1M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        gabriel.fernandez@st.com
In-Reply-To: <20190212135154.2733-4-gabriel.fernandez@st.com>
User-Agent: alot/0.8
Subject: Re: [PATCH 3/7] clk: stm32mp1: set ck_csi as critical clock
Message-ID: <155008009213.115909.12905657780692674136@swboyd.mtv.corp.google.com>
References: <20190212135154.2733-1-gabriel.fernandez@st.com> <20190212135154.2733-4-gabriel.fernandez@st.com>
Cc:     linux-clk@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gabriel Fernandez <gabriel.fernandez@st.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 13 Feb 2019 09:48:12 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@st.com (2019-02-12 05:51:50)
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>=20
> ck_csi is used for IO compensation so it should be
> considered as "always-on" and kept on.
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  drivers/clk/clk-stm32mp1.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
> index e72079de83f4..5b30e4eeca2c 100644
> --- a/drivers/clk/clk-stm32mp1.c
> +++ b/drivers/clk/clk-stm32mp1.c
> @@ -1661,7 +1661,8 @@ static const struct clock_config stm32mp1_clock_cfg=
[] =3D {
> =20
>         /*  External / Internal Oscillators */
>         GATE_MP1(CK_HSE, "ck_hse", "clk-hse", 0, RCC_OCENSETR, 8, 0),
> -       GATE_MP1(CK_CSI, "ck_csi", "clk-csi", 0, RCC_OCENSETR, 4, 0),
> +       GATE_MP1(CK_CSI, "ck_csi", "clk-csi", CLK_IS_CRITICAL,

Please add a comment to the code indicating this so we know why critical
is here without reading git history.

