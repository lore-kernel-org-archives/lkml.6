Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDCCC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994AF206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gCc11O3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994AF206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbeLDQrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:47:37 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:42140 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbeLDQrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:47:37 -0500
Received: by mail-pf1-f177.google.com with SMTP id 64so8484263pfr.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 08:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=wq92PnsVnZhUlD/432EGtor7vOJgfdfCTWs+Qw1pFoo=;
        b=gCc11O3luthpI1GuEeFdIZBWiGRbiaQ3w9dqVug+nNKa2SL3jMtpYj03AcxCpYiXYA
         IZT+5hOTZdermRChOYrYcmRnbbIk09AoW7wXeYX+M/M4ubsCLMWh/Mvbs1SOXiwKOsY8
         VPU8dbnuSBMSmeeootS+jkLlVzFwW+UlyiUPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=wq92PnsVnZhUlD/432EGtor7vOJgfdfCTWs+Qw1pFoo=;
        b=KPfgL9ICbEN8glIF3UamvtunZHJyzqZPHe8AGQXJjuhyCtB2oy44tfErvS/cKyWztH
         X0apkJoBUzx7TNlLO4lN2mJoPdxrj90Mbc6HtiIxgq+o6YXGjvI2E1k/4wFiWx2Z1QI4
         n9l+3y1TtyLyVb61QcACrN3E8fzrXN4QBs3BP6iCWLBsxTY4FwNZsaqxi1aJ38d5YhpX
         EJuEMX9gEani9h6YVTICZ+251wyf8ovUNxSGYPDlm4wrLtOcflToamLnPE37scIzJjHX
         7BaoYLAwHjY01RXVeN4+gZ5GnFeaqNh729U6kOAKNSBPOA1xvWOIq8g9k3O7e/e2HGlU
         arAg==
X-Gm-Message-State: AA+aEWYUH3ONHZW6QEqxtPJL1S6H3EsWFQsKVe2rE6o5AtNhJVNp+2WZ
        1h6oO23CEQu8ZTMCckgWk+xIWw==
X-Google-Smtp-Source: AFSGD/XD8Aq0ncjKVlRS1ugUPflqsGzo6y9SjlKVhflU2xJ4GKT72FTbu69fcoqlIse82j2HQzwHIQ==
X-Received: by 2002:a62:2606:: with SMTP id m6mr20250351pfm.133.1543942056793;
        Tue, 04 Dec 2018 08:47:36 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id 84sm30380275pfk.134.2018.12.04.08.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 08:47:36 -0800 (PST)
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
In-Reply-To: <20181201005254.139908-8-mka@chromium.org>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
References: <20181201005254.139908-1-mka@chromium.org>
 <20181201005254.139908-8-mka@chromium.org>
Message-ID: <154394205560.88331.1566181785945668881@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 7/8] arm64: dts: sdm845: Set 'bi_tcxo' as ref clock of the DSI
 PHYs
Date:   Tue, 04 Dec 2018 08:47:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2018-11-30 16:52:53)
> Add 'bi_tcxo' as ref clock for the DSI PHYs, it was previously
> hardcoded in the PLL 'driver' for the 10nm PHY.
> =

> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

