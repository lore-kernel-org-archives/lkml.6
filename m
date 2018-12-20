Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB343C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D30218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545339904;
	bh=k9ZOs6Z9ayUZn++BZJFEEV81SU6Z4YhaSf6YMjfDQWw=;
	h=To:References:Cc:From:In-Reply-To:Subject:Date:List-ID:From;
	b=OEZQmEIaKfyEt6D+6gDGYUt5CXWmg9eNLF0EvGLVomfLn4/Y3ritT0Yl+fcqcbQkJ
	 yLD4KKF2H0WE2CkxDiFK2yuljdW2WfCe1m4YB2UYqAp8RQ2EhEhkZXR5Hrh5pxMOft
	 DTV5GO6Wu3DI1HXY0KAH2Krjh+uwFYwBMP8VMmfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389822AbeLTVFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:05:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:50982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389807AbeLTVE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:04:57 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70CD7218FE;
        Thu, 20 Dec 2018 21:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545339896;
        bh=k9ZOs6Z9ayUZn++BZJFEEV81SU6Z4YhaSf6YMjfDQWw=;
        h=To:References:Cc:From:In-Reply-To:Subject:Date:From;
        b=h2J/gJ40bayPTQXguMuIzA3jeIf2irBuLgVRqrfxPu41CywXUBPQ2fZAgxeal3rGs
         Wy72AlLLAlNefiFVCIRlp+CdO3/f1jqh5UUSbdijVjl2UWutrjzPi0ip0XLbmueFAT
         MdtCq0Ofs5+LeNnLbE8cQlLtw993jSNPCU6s6GKU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
User-Agent: alot/0.8
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
References: <1545306385-31240-1-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1545306385-31240-1-git-send-email-tdas@codeaurora.org>
Message-ID: <154533989563.79149.10213938035592547726@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH v1] clk: qcom: lpass: Add CLK_IGNORE_UNUSED for lpass clocks
Date:   Thu, 20 Dec 2018 13:04:55 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-12-20 03:46:25)
> The LPASS clocks has a dependency on the GCC lpass clocks to be enabled
> before accessing them and that was the reason to mark the gcc lpass clocks
> as critical. But in the case where the lpass subsystem would require a
> restart, toggling the lpass reset would from HW clear the SW enable bits
> of the GCC lpass clocks. Thus the next time bringing up the lpass subsyst=
em
> out of reset would fail.
>=20
> Allow the lpass clock driver to enable/disable the gcc lpass clocks and
> mark the lpass clocks not be accessed during late_init if no client vote.

You need to add more details here. It feels like you wrote the beginning
of a paragraph and then stopped abruptly, leaving the reader hanging for
the whole story. Why is late_init important? Why do we need to leave
them on from the bootloader? What if the bootloader doesn't leave them
enabled? This is all rather hacky so I'm deeply confused. Does the lpass
driver need to get these gcc clks and enable/prepare them during probe?
But then it needs to also allow a reset happen and change the clk state?

I suspect this situation is circling a larger problem where a reset is
toggled and that changes some clk state without the clk framework
knowing. There's not much we can do about that besides having some
mechanism for the clks to know that their state is now out of sync. If
that can be done on the provider driver side then we should have an
easier time not needing to write a bunch of framework code to handle
this. OMAP folks are dealing with the same problems from what I recall.

>=20
> Signed-off-by: Taniya Das <tdas@codeaurora.org>

> @@ -77,6 +81,7 @@
>                 .enable_mask =3D BIT(0),
>                 .hw.init =3D &(struct clk_init_data){
>                         .name =3D "lpass_qdsp6ss_sleep_clk",
> +                       .flags =3D CLK_IGNORE_UNUSED,

All uses of CLK_IGNORE_UNUSED and CLK_IS_CRITICAL need comments about
why they're there. It's never obvious why these things are being done.

