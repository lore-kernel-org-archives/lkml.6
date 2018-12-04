Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F37AC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6686420672
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KhPodIN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6686420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbeLDRQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:16:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43658 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbeLDRQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:16:23 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so7655411pgk.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 09:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YR29Y1gz98X0VG8cBiczOCK5+owuaWThVpgp4zhtkOY=;
        b=KhPodIN+dd4LqZDvaa59kdYX9V/MntvbVNeTvDxDD+y2DKMF3cJvEZxI8DgkjKJxrO
         9RiSDCtwP5fOGHOwfUUy3ZPx3sP/3sv4h2fxCHWmWpGHHHdPRueSDPVe7zPMrE/hVnUd
         xz2k4M5MmBF2AGwe9vq6P+W74WUbpP1QFmctc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YR29Y1gz98X0VG8cBiczOCK5+owuaWThVpgp4zhtkOY=;
        b=gNRqLSC5kj00Xnp7n0H04Pieh7/EpSvBd5aNNZboD6+Fmx5KobACKhkAi+82kOSg+w
         BZAA58wVO4KPXk6eUvvAP0GBcDSMZHLWr+d3Dla6KWOTJsUDMJgKGRMg/aMohRkmROns
         GPua/KHYI0m5Fz2kxpjaR1Z514rUELketi8Mr2HLCTkZO3DnWAZD+cJ5dD3SSO7uP4jG
         VOGix1fXe1Mf48QQa1BtUlQ+34hLpYGH6/tlTB6dGeXd4jkVuVBIrpECH2nd34U+eUuO
         CActtK1loVBpSrgQ6lluXEq19TQlhB1Qjxkl6sx8Fj4y1GhbYbKNpayHfXvBPqGng4SY
         6GLA==
X-Gm-Message-State: AA+aEWYGwDbTlKTlxdvbXxok1UZZqjzbBZ0iolLSn5DSpIin4lPgCk28
        BGbEZ1wEKosQq+gmMO9lqHs+cw==
X-Google-Smtp-Source: AFSGD/UShh0xDUyLBrRTtaBmOij69+epCyNmJCdkM95xwvk7uRjOFuyFpbux6YTkqs/h47I+FUrcPw==
X-Received: by 2002:a63:cb4a:: with SMTP id m10mr16723528pgi.105.1543943782401;
        Tue, 04 Dec 2018 09:16:22 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id y6sm23008288pfl.187.2018.12.04.09.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 09:16:21 -0800 (PST)
Date:   Tue, 4 Dec 2018 09:16:21 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Airlie <airlied@linux.ie>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/8] ARM: dts: qcom-apq8064: Set 'xo_board' as ref
 clock of the DSI PHY
Message-ID: <20181204171621.GA14307@google.com>
References: <20181201005254.139908-1-mka@chromium.org>
 <20181201005254.139908-9-mka@chromium.org>
 <154394210277.88331.12250945038852318544@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <154394210277.88331.12250945038852318544@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 08:48:22AM -0800, Stephen Boyd wrote:
> Quoting Matthias Kaehlcke (2018-11-30 16:52:54)
> > Add 'xo_board' as ref clock for the DSI PHY, it was previously
> > hardcoded in the PLL 'driver' for the 28nm 8960 PHY.
> 
> Why is driver in quotes?

It's not really a full fledged driver, but part of the 28nm 8960 PHY
driver.

> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Thanks for the review!
