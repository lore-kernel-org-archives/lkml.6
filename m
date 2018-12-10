Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86223C65BB3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4949120821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z15hBQ3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4949120821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbeLJPrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:47:12 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43349 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbeLJPrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:47:11 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so5421292plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 07:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:message-id:to
         :subject:from:user-agent:references:cc:date;
        bh=80O20TIRHNWHGan1ylMqZPo9S/FaFTC0bRq+MjpNMhk=;
        b=Z15hBQ3r0xQWGQfgJNpwkqNTeznrTZW4rJ5SNIIjM63oyL9MXtqb1kXYpryiqiwJ9M
         WpWEI0Lkj4bND/rL6nJgs+SA6LDypX53vBuEIp0aTvPJIi2SoxXDbdgZFRX1Iazt/Lv5
         85C/YObUc9VPQRAw7yfoMX26zoBXpm6Vx/AGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:message-id:to:subject:from:user-agent:references:cc
         :date;
        bh=80O20TIRHNWHGan1ylMqZPo9S/FaFTC0bRq+MjpNMhk=;
        b=OYi8rhIEPbE4Be525gFmDpVpYrL6+I2nvHV+Icz7//bOr3pPZ7+fnWruAJPmAj4c8u
         HYPOuLfHJUVwTx7Ug2vLaXBfr6DIeSDuqL6F1SXXs8FkSzb8s9UkQ6I691vkLsGDlPCT
         PU8FL5UQwwqmmgEXCAXWmY/iTlCRJnuEyAzMS5TZ9gXvvg8ZAMSTH1IbxFE2bGTM6Y+c
         v63kgpso9o+nv4QKSekvstBEvRHGlPXd8ksX7DC2tPnUVMiuqOIw0HLp0q6Gh1iCHbVu
         k+G++ESeF06F1IPhkfWzv/oBed6kCgL1PJm1ZQu+qik1/WqFbsucasouobYr2mROV5gJ
         6v9w==
X-Gm-Message-State: AA+aEWZ+yibf5cejwMGIhdTNOQlYl4wxYoz5yPI/84AIOc7hOkQz4STf
        ybuYrmKbKx8ynDHeAJpny4f/Vw==
X-Google-Smtp-Source: AFSGD/XBmS9gASztAWDgMYSa9ab7wffdS08TrJQHGovYnWA/X2oYHa5qKRegSxeknGNavE3iQY2Yqw==
X-Received: by 2002:a17:902:aa8c:: with SMTP id d12mr12792528plr.25.1544456830494;
        Mon, 10 Dec 2018 07:47:10 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s4sm13556829pgp.13.2018.12.10.07.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 07:47:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181204224234.62619-3-mka@chromium.org>
Message-ID: <154445682870.17204.3423155526165233895@swboyd.mtv.corp.google.com>
To:     Andy Gross <andy.gross@linaro.org>,
        David Airlie <airlied@linux.ie>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 2/8] drm/msm/dsi: 28nm 8960 PHY: Get ref clock from the DT
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.7
References: <20181204224234.62619-1-mka@chromium.org> <20181204224234.62619-3-mka@chromium.org>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Date:   Mon, 10 Dec 2018 07:47:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2018-12-04 14:42:28)
> Get the ref clock of the PHY from the device tree instead of
> hardcoding its name and rate.
>=20
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

