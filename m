Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2796C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 08:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABCE20831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 08:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcvGbL6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABCE20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeKBRZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 13:25:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeKBRZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 13:25:43 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A676720847;
        Fri,  2 Nov 2018 08:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541146764;
        bh=VHu/m2oqXNqBTSoFBw7j54YwDQ2UAzdtPzrHV9w+6PQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kcvGbL6nFTtuffuFjBvMppyx4h1i/LRq4X1wR0l99vCzd0JQ6W27fC02VVmYiMpm7
         4rlX2CAS6jA4STC6u+aUSNr7Fys2bc8cypSMQoH52/iBP1PdKGE2JLbeA4J2KDW5Dr
         IJJQc/8zF4miY1e30x5lGeGBZuGP0KcIwvyqypks=
Received: by mail-lj1-f182.google.com with SMTP id z21-v6so1010652ljz.0;
        Fri, 02 Nov 2018 01:19:23 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLFrjyvc9vr9swOLBKzhbuIQ6e/rZB62LgwALhunnwTqjZ8Fab0
        koWijCdrWfJ4nb+uHsuVBT1sIQE6oRE94IjF5hE=
X-Google-Smtp-Source: AJdET5ddBEeDxGY8VJnSMEPPMdA6KOdScrnbsF5cjrMUSFV91TAiY2A7xuzhwJ0VUV6awHEuXTtePLy3ihK/2/slV3o=
X-Received: by 2002:a2e:990e:: with SMTP id v14-v6mr7563777lji.60.1541146761787;
 Fri, 02 Nov 2018 01:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1541054985.git.matti.vaittinen@fi.rohmeurope.com> <8e396e22b328f35538a01193797fbd0d001f885d.1541054985.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <8e396e22b328f35538a01193797fbd0d001f885d.1541054985.git.matti.vaittinen@fi.rohmeurope.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 2 Nov 2018 09:19:10 +0100
X-Gmail-Original-Message-ID: <CAJKOXPeM18c3a2nWeGGGw+Fn-GQ2C0ridwE3eqRsd1gVQ6zB5w@mail.gmail.com>
Message-ID: <CAJKOXPeM18c3a2nWeGGGw+Fn-GQ2C0ridwE3eqRsd1gVQ6zB5w@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] clk: clk-s3c2410-dclk: clean up clkdev lookup leak
To:     matti.vaittinen@fi.rohmeurope.com
Cc:     corbet@lwn.net, mturquette@baylibre.com, sboyd@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, kgene@kernel.org,
        s.nawrocki@samsung.com, Tomasz Figa <tomasz.figa@gmail.com>,
        andrew.smirnov@gmail.com, sre@kernel.org, linux@roeck-us.net,
        robh@kernel.org, sjhuang@iluvatar.ai, Akshu.Agrawal@amd.com,
        rafael.j.wysocki@intel.com, djkurtz@chromium.org,
        mazziesaccount@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2018 at 08:19, Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:
>
> Use devm variant of clkdev lookup registration in order to avoid
> clkdev lookup leak at device remove.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  drivers/clk/samsung/clk-s3c2410-dclk.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Driver has suppress_bind_attrs and it cannot be built as module so
device removal should not be possible. There is no need to use devm.

Best regards,
Krzysztof
