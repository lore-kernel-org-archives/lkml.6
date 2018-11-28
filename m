Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00890C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E272082F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bplo53fR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E272082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeK1ROc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 12:14:32 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42454 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeK1ROc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 12:14:32 -0500
Received: by mail-vs1-f65.google.com with SMTP id b74so15338444vsd.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Ve3r8U3X5hes3hzah7mGfTA45tELFjJj2jydqsRFCY=;
        b=Bplo53fRDrkSibdNSIbgNW1EXoGumlz9V4UOfQePTz3OUC6TzZ9iLOTFM5f3oBeLzL
         Mag8bJTA5uIInA1bblXO8Qr9FVG+JqLDp/4QqPoNuhux51nevJbSue2aAdXs12OLVqYe
         t8cGEAYLQiYZ4gFa1MLQvnnxo+FM3kfdMkRR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Ve3r8U3X5hes3hzah7mGfTA45tELFjJj2jydqsRFCY=;
        b=L05uuFiPg1Oq4gbi3MmWJdzJduaxK4ieB1NfoukQmOqFEwBhat4Mw+x1McxlT3mcrE
         oNwUDhbya4DAmR4tpUC5/Tst/rIr+XGN+dkLzEzAKF7+I33/y19uahhayaHzIoGafRyH
         +m3K1BIYXGNIch7gQJ0wdXlwu6dGYyWSkYDE2ealTp5s96NN8CEsVcrt9IcF1niQPjtv
         E9vQqKqj9rOcMFidO1kZl+O1nGFbqeF8e8G+UXlMkVrLMUehY8Wp6eJ5+3+ApOIxP6R9
         1rtkUmtBAZwPRa6zfb0i8AJLaaDioIaN3gW4uF60Qny2R09f10CN61Vjy3Zsjkd1mC4H
         A9ow==
X-Gm-Message-State: AGRZ1gJjvr5HYTtWvXGb1GZ5ETJkj3tYMANNBdFOggXo0nN7FPEQeDXv
        tM/cSlo/rrzJdH8+OHAfph2ydxh8s2I=
X-Google-Smtp-Source: AJdET5c8JX8INGglgJV6mH9rpDmykeYnie3pDRxy1HDFse5LJS9yg1D/g4YZX0WagksWWwwwdulYyA==
X-Received: by 2002:a67:7ad3:: with SMTP id v202mr15347502vsc.49.1543385641603;
        Tue, 27 Nov 2018 22:14:01 -0800 (PST)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id 30sm2028618vkq.49.2018.11.27.22.14.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 22:14:00 -0800 (PST)
Received: by mail-vk1-f173.google.com with SMTP id q80so5667640vka.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 22:14:00 -0800 (PST)
X-Received: by 2002:a1f:4301:: with SMTP id q1mr14916667vka.70.1543385639650;
 Tue, 27 Nov 2018 22:13:59 -0800 (PST)
MIME-Version: 1.0
References: <20181126231159.122298-1-mka@chromium.org> <20181126231159.122298-8-mka@chromium.org>
In-Reply-To: <20181126231159.122298-8-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 27 Nov 2018 22:13:47 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xbb4GchyndP2EDM660gfHPOtEEeoF6A8j9xr+kz-MWaA@mail.gmail.com>
Message-ID: <CAD=FV=Xbb4GchyndP2EDM660gfHPOtEEeoF6A8j9xr+kz-MWaA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] drm/msm/dsi: 10nm PHY: Get ref clock from the DT
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 26, 2018 at 3:12 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Get the ref clock of the PHY from the device tree instead of
> hardcoding its name and rate.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - remove anonymous array in clk_init_data assignment
> - log error code if devm_clk_get() fails
> - don't log devm_clk_get() failures for -EPROBE_DEFER
> - updated commit message
> ---
>  drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Same feedback as with 14nm PHY patch; if you address that feedback
feel free to add my Reviewed-by here too.

-Doug
