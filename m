Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE281C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82021206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mrm9kC3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82021206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeLDQhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:37:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44072 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbeLDQhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:37:06 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so8466816pfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 08:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=E3Vue+GYHhxlBh/4CTCsLMymNzd62WD3fIT5gcFNc70=;
        b=mrm9kC3HC6VPHGzlpDgOtKH+ykfzjd8wrdqmu4PdvJ5PhGHFS09fqqyxR9a1SRYpGl
         Jc4Bqs4xjimMIQ4o5WlhVXzx/mN7hjzXWk8xWJvBEkHPzCnZ1P+ZRf7ZyFYq5sdkjuTC
         3PiBnTPPFoCH4S51y0OU9l7Eu4KSkw3jMXtDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=E3Vue+GYHhxlBh/4CTCsLMymNzd62WD3fIT5gcFNc70=;
        b=thhquZYZ+KyWsuxSTWK5nbU/o3NOuut+F1wozniz4L8ITiUXh0YMf+ltCw0fdIcQuY
         91g/QQYDdQIjwuABkv5KNp8qcYVcvpEUFoVcGBAhyDlJT01rvVn0wr/0+f41nkVFESlX
         Yeh8LC3ONWM4fEimUD75leuvSUS1FuLdJcSLFOx/HPo+A2/a2lN7Wr7VcaDW/QWNXY9L
         Y2AxAzkFRZpmQNaxrvxpKjA5xIP9CbAuFh+3iryxHwqAI3rh8NX/JT62wlMvTXN8qH0Q
         9PpRmLU78E/KxiKtOIxJOluMmqhUq8dGlxWtKVHoivNcak0G/++s7hXQJfftAd7guZrl
         A1Ag==
X-Gm-Message-State: AA+aEWbUGSWMSKVsnniHdrHZ9pb9nn/x8XIdZxIHhTXmIGUlbXScFfTt
        OJUn+ix7EoqugwxqQ+kEV3cRdA==
X-Google-Smtp-Source: AFSGD/VGAIE7ncxFKKGOfSfmR/PpT5xPyzLhXZS7kIpEfsAMFhGmzCS7bV6aUEupypHeVgxr4Hu9mg==
X-Received: by 2002:a62:37c3:: with SMTP id e186mr21253696pfa.251.1543941425532;
        Tue, 04 Dec 2018 08:37:05 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id c13sm24532685pfo.121.2018.12.04.08.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 08:37:04 -0800 (PST)
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
In-Reply-To: <20181201005254.139908-2-mka@chromium.org>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
References: <20181201005254.139908-1-mka@chromium.org>
 <20181201005254.139908-2-mka@chromium.org>
Message-ID: <154394142383.88331.5951120294209155140@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 1/8] dt-bindings: msm/dsi: Add ref clock for PHYs
Date:   Tue, 04 Dec 2018 08:37:03 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2018-11-30 16:52:47)
> Allow the PHY drivers to get the ref clock from the DT.
> =

> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

