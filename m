Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18605C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB4720685
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SHmCu/jr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB4720685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeIYXrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:47:39 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38503 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeIYXrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:47:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so22579096ljc.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 10:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ouH4n09/ojxjMH+cdgh6kJGsc2Zq9OTlO+9jcYp+R7U=;
        b=SHmCu/jrF32wvQNqDOGKXIU/g2vEPCL6ePpzFL17CxtG6/BpcqJNsf6jlDSCRBZsLE
         uVtCxcX6Vo8inDIwmcOGRi3Uwuplu/88XYXnCXmvJ6nmGeHbBWca3hg67CSdQixPA13Q
         b05oyoxnLSDIQ+SdPOlKt9fWagNxesPAinBjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ouH4n09/ojxjMH+cdgh6kJGsc2Zq9OTlO+9jcYp+R7U=;
        b=P7wKWRmYEQsuYVoIk+/GPLqy+YCfuhmS4CZT4QA2P/RE1FL0E4dkFkr8E/JcbI204s
         +/EoNyGnsEYR870bSFyYYVftDNZs6FKFodke04j+d+nNpb/fA3XHgDeIdwKVd4un2JTI
         8xtYbn6UleJD0bTqADclLv6k1aak1L0nARX/6pStDtlcHCfTgODPFM3+s6PHXr2O8BZZ
         zKygBGy0AeBnbvTpjjdGQtkZoppjqRBD74a+U1ZVFb7Qp/icW3V5Ta4fsYof53N4EVX+
         DA4Oenx3L8G16AsSWb8jt3apmzavFzyEO3VwVjize7anVTBtxn9alK+1rNbX0YVEpSpw
         dRFw==
X-Gm-Message-State: ABuFfohUrTrhJUAIO969gxaa5pk1hX9stkAQo90diqvNZG4HAxIEtk/u
        9XJLZ7A5m13A4tbhSxw4dhQRl78OCUo=
X-Google-Smtp-Source: ACcGV636v9R79PyVWMgIehBw0FeXr4wiLPibmRg5JrGvR67Wo/eEOV5SURLDXP+QXcrumiN6qtTuAA==
X-Received: by 2002:a2e:2942:: with SMTP id u63-v6mr1660774lje.28.1537897143642;
        Tue, 25 Sep 2018 10:39:03 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id x5-v6sm534265lfi.45.2018.09.25.10.39.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 10:39:03 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id j25-v6so2563572ljg.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 10:39:02 -0700 (PDT)
X-Received: by 2002:a2e:5554:: with SMTP id j81-v6mr1645611ljb.53.1537897141912;
 Tue, 25 Sep 2018 10:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <1537887875-29494-1-git-send-email-vbadigan@codeaurora.org> <1537887875-29494-2-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1537887875-29494-2-git-send-email-vbadigan@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 25 Sep 2018 10:38:23 -0700
X-Gmail-Original-Message-ID: <CAE=gft6Bxtdev+1Zo58LHNaYkB5MTfUZx8eFayvuixVJFWMw_Q@mail.gmail.com>
Message-ID: <CAE=gft6Bxtdev+1Zo58LHNaYkB5MTfUZx8eFayvuixVJFWMw_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sdhci-msm: Add flag for restoring dll
To:     vbadigan@codeaurora.org
Cc:     adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        robh+dt@kernel.org, asutoshd@codeaurora.org,
        riteshh@codeaurora.org, stummala@codeaurora.org,
        sayali <sayalil@codeaurora.org>,
        Doug Anderson <dianders@google.com>, mark.rutland@arm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 8:05 AM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> The dll settings of SDHC controller needs to be restored whenever
> controller clocks are gated. This restoration is needed only on
> few SDHCI-MSM controllers. This dt flag indicates whether dll
> restoration is needed or not.
>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 3720385..207ce36 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -31,6 +31,8 @@ Optional properties:
>                                         BUS_OFF states in power irq. Should be specified in
>                                         pairs (lpm, hpm), for BUS_OFF and BUS_ON respectively.
>                                         Units uA.
> +- qcom,restore-dll-config - Flag indicates that restoration of dll config after clock gating
> +                           is needed on given platform. This wouldn't be needed for every MSM.
>  Example:
>
>         sdhc_1: sdhci@f9824900 {
> @@ -49,6 +51,8 @@ Example:
>
>                 clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
>                 clock-names = "core", "iface";
> +
> +               qcom,restore-dll-config;

Hi Veera,
I'm not sure this is the best approach. It might be better to key this
behavior off of the compatible string. Actually I'm noticing now that
the binding for this device doesn't include an SoC-specific compatible
string, which I think is now the preferred way (eg
"qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"). I think we should add that
to sdhci-msm.txt, then use the compatible string to enable this
behavior you're adding now.

-Evan
