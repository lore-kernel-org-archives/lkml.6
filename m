Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C233C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D1A21A13
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F5vVVwdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D1A21A13
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731296AbeHHXBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:01:07 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:36338 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHHXBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:01:06 -0400
Received: by mail-ua0-f194.google.com with SMTP id c12-v6so3910137uan.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 13:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=quAE55nWvV7E8UXCtpxGbr7sG79MYJa6fnLPq1PkBbM=;
        b=F5vVVwddbv3GmnvfoxoqbBe58bfHaTI8W60sO/8p3nYixyn5DwNP3bd24SiWnq3460
         v3pCrWzWFJ9htqUngBmCKq8n+lHCN135tYle3EMNzViCZ+SdAgJImCel2VWrs4MIsIqx
         UX+dz+ggMCKdTSroQQC3aJRPHmdfRFHANCKO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=quAE55nWvV7E8UXCtpxGbr7sG79MYJa6fnLPq1PkBbM=;
        b=fMr8RN3DjuGEPLAgH9AkWJgN9Z8pfHl+aXMRxVRaRqs51vcUE39EJsfGkDxuzEcdti
         oEYycyCzxyKRqVx7rUu/ybJer7exQcx5jb/Ccez69Cd9GoVJjggjPqAoAMC1Ds5kVAss
         5IVUFa619uzNogU0tnNVwfRfUVwi+u44CoA1GWhr0FreRPu90ISlk07aCzw+4WZ3KhZL
         Omij4HjUMLL7/57zr4+8KN4hm2iFbrudeB4Jn0DUMeLCkOvp97cHtOoXrfO5zfi9l6FM
         iTuqztWCgOybSwzjOUJ6fOEp7HBxkM2Ovxsnj7ToDJq/8NFUe+J1gBYH++FOsicLgWNK
         6Spw==
X-Gm-Message-State: AOUpUlG5fkATB0AirTKmpS4CStOoGl90Sxnelkm8Rx5kBc5FnYkL7imm
        qRTxjY0Oy0DyZdi207Agff1mpmHXtvE=
X-Google-Smtp-Source: AA+uWPwCQuI16Vowb2nZ12XQl5GOwD613MQZThjFVvcvEWwZ0wZsKa3Hpw6Mgdoqybvh3GfP4IF9YA==
X-Received: by 2002:ab0:5068:: with SMTP id z37-v6mr3140416uaz.149.1533760785509;
        Wed, 08 Aug 2018 13:39:45 -0700 (PDT)
Received: from mail-ua0-f178.google.com (mail-ua0-f178.google.com. [209.85.217.178])
        by smtp.gmail.com with ESMTPSA id c68-v6sm1452133vke.19.2018.08.08.13.39.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 13:39:44 -0700 (PDT)
Received: by mail-ua0-f178.google.com with SMTP id k25-v6so3859051uao.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 13:39:44 -0700 (PDT)
X-Received: by 2002:ab0:1163:: with SMTP id g35-v6mr3068024uac.135.1533760784008;
 Wed, 08 Aug 2018 13:39:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 13:39:43 -0700 (PDT)
In-Reply-To: <20180803222059.146666-1-mka@chromium.org>
References: <20180803222059.146666-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 8 Aug 2018 13:39:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VwRp4ip_icn5bUWBbE0XatZrmu5m3pyfifm-s8cS0ShA@mail.gmail.com>
Message-ID: <CAD=FV=VwRp4ip_icn5bUWBbE0XatZrmu5m3pyfifm-s8cS0ShA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sdm845: Add dispcc node
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 3, 2018 at 3:20 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> This adds the display clock controller node to sdm845 based on the
> examples in the bindings.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> The dispcc driver and DT bindings landed in the clk-qcom-dispcc-845
> branch of the clk tree.
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)

Peachy keen.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
