Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3460CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3457208B9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nyFC/Qaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3457208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeHXTsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:48:11 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:41094 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbeHXTsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:48:11 -0400
Received: by mail-pf1-f177.google.com with SMTP id h79-v6so3877772pfk.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 09:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=LIaeu3tjDF5Qeam0ovx7QaRDQIZ/ujseTUd7PrH8caU=;
        b=nyFC/Qajp92KBi496BWb6WDZN+XYrni9MpJDn+7wYW2770C9QzN5saa3qRRbme2POL
         OSh4XwZ9s1xzsibmcdu4iOwIJsZHKk/5+WuAVToiqdsMnbATsmZXG0HeuT/Tjhq3GB8y
         sPTPxm3d+1EmMS98bbSLSL0br/UxLHt6V58EQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=LIaeu3tjDF5Qeam0ovx7QaRDQIZ/ujseTUd7PrH8caU=;
        b=JHGyIIzJYq0aFlzaJtRG4hbLZZ1k5ViZXoUwCbE/DUP/NdBpfxkNoJRI1TAmB5+cxN
         qkQcCiOAyUNSlKhkr6pgsVf1BIOogoAVAwbZkgsOvaRvQD7R8Pna9CcpEybkVjFmy09j
         SWOcTb24DGTn8mlq+uhHlCGZ8F4NaMfzDkD33x6SzYjAL1n7AnKHD9CP6sknktoA25H5
         UnrbhHiCQzJP0i12mlPj8yA8+mSNeAk8cL9gFX4JXanQOFgm2gBaLu/KGUobh2x4XCDv
         SWyu3du0opPDR+uCyZE9xw746mruUCqVFXiASuCwwBU44ghLYP4DB81RzdgVmenPaSpz
         Jsmw==
X-Gm-Message-State: APzg51D8p1Ar0FY3enYn1taqMXrj+H1PUSE0ncFpqZijXXrYQzK++a/5
        7p7L0ox/UDg9qouSnVuK3KMiAw==
X-Google-Smtp-Source: ANB0VdZABVAF0OLsqpav1DsMmGFAChShXCwQpTL/y/rDPt50EMrvb8Vd/E+a9DOLlcDuCcQM/dMYYw==
X-Received: by 2002:a62:1605:: with SMTP id 5-v6mr2661686pfw.11.1535127173368;
        Fri, 24 Aug 2018 09:12:53 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id p12-v6sm8269750pgr.6.2018.08.24.09.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 09:12:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180822173629.202885-2-dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, tfiga@chromium.org,
        Manu Gautam <mgautam@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
References: <20180822173629.202885-1-dianders@chromium.org>
 <20180822173629.202885-2-dianders@chromium.org>
Message-ID: <153512717223.28926.18108382621865510615@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 1/3] arm64: dts: qcom: sdm845: Add USB-related nodes
Date:   Fri, 24 Aug 2018 09:12:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2018-08-22 10:36:27)
> From: Manu Gautam <mgautam@codeaurora.org>
> =

> This adds nodes for USB and related PHYs.
> =

> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> [dianders: reworked quite a bit]
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

