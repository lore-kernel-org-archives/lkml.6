Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62148C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284E5206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iZS4L1RY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284E5206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeLDQsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:48:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34725 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeLDQsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:48:24 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so8510481pfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 08:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=l07xBod8I/XqiRyzrIibaJtF9Qopp48gR64W4ldYQzo=;
        b=iZS4L1RYJzvBhpPcJnerWL/HPNzEddOHUfBqNfsMXVf5QiB5PBArlqS3WO2c0s+m2b
         vGQRgvnK9r3L9F0pr4yRh2QEi+Mzzl+IMWxt3VfS1dQFE09D99I8rIa2KDnnO6Rg+CaK
         imRSIC4q81CiDs0cXkWsh4zM8acZ2BZaovly0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=l07xBod8I/XqiRyzrIibaJtF9Qopp48gR64W4ldYQzo=;
        b=Q5/E+rxhcYbVIKJWsh2HUwrJVVFQew8CxR4Z/DGjmt//2viWDUWzREJfbUHuKqm/s+
         hxIQ4lq6w+ES/BjE5o6bwfYlcbyZMKv9Y0XJcpeLO1o9UOS9cDk/TmmLgdJhH7F4CzK7
         TmC9zJST82c0RGhpLjEzBizJj45QQCt8WBh0khBHvqsLA9v7oIf1zYkcPZjXITCpbPrh
         +lAyDuhINFkc7IWIe/PryMZllNYUNFZMN7onWU+CbbITCBFBS7gs/z3DA1S+OOx4fXn3
         vIc5s2btRyGRCFKtS8q2XL41ARDUc9NzjFV4uWOeAfVtRsGHz2cR1+DacvHU3St/7XM7
         athQ==
X-Gm-Message-State: AA+aEWa98op/N6npJhO4LlGXf/ErOcKTf/jumN0tQl5NHMg3d/KOKBaZ
        b6zVIW92utpo4du4/L3FoIImFg==
X-Google-Smtp-Source: AFSGD/WHjX04uXwL6yrJqLlRQsyWW2WWhgxLU4wqwsSeLhetb80saVyyhJLUzxEglHmZkVVHsCv+6w==
X-Received: by 2002:a63:235f:: with SMTP id u31mr17208664pgm.122.1543942103953;
        Tue, 04 Dec 2018 08:48:23 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id j197sm17897917pgc.76.2018.12.04.08.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 08:48:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        David Airlie <airlied@linux.ie>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181201005254.139908-9-mka@chromium.org>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
References: <20181201005254.139908-1-mka@chromium.org>
 <20181201005254.139908-9-mka@chromium.org>
Message-ID: <154394210277.88331.12250945038852318544@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 8/8] ARM: dts: qcom-apq8064: Set 'xo_board' as ref clock of
 the DSI PHY
Date:   Tue, 04 Dec 2018 08:48:22 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2018-11-30 16:52:54)
> Add 'xo_board' as ref clock for the DSI PHY, it was previously
> hardcoded in the PLL 'driver' for the 28nm 8960 PHY.

Why is driver in quotes?

> =

> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
