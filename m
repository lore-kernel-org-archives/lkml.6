Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFB6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A2A214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TZg+3R0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A2A214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbeKVFCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:02:04 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37385 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeKVFCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:02:03 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so6668284plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 10:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=ZefPGQm9UeBSAR9JjKT6Djn61pX7abreiy6xc6xR5PQ=;
        b=TZg+3R0w6T2P7WeR3GAOjMW85IoFzWnhvEv9B3oFwd6u02D7C5E/JMSIDJ2bzsN7Mh
         bjMmTX3++DcpqrCD+Gc8HXA8zePaa5HC12m1Mq19Kdn+oO3SozU8af4y5EZJIfFr3+K+
         Jv8BDCYQ+7qOs9hddQZsEmx6pyc7+b5C7kh/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=ZefPGQm9UeBSAR9JjKT6Djn61pX7abreiy6xc6xR5PQ=;
        b=MFbbYGMq+0FGnHqlzk4lssCunwkTFtRn8jsv/WMBiIGh/bkeR6h+t41MeXCjhHSW7+
         gtjYHYxyopADq+sBTKzq8WOAEgtIKQmuabzlvGMuQ39f+h7SYZpiCgTN/J5oX0SPOdjN
         caWYrVXRotFRxzyUGczQILxdaNXO9yFnQTPk4L585Oce15gJHCRAGkUjedcUVn2BuEdY
         /nmSQwsX5ThFqz/jOCh8lCA4tN8nyContlBiQbR+M/b+8VPqHTjFJfox3uVUI38EYDW1
         ZYuPmmgGlfPYTL23rbDV1qBRYQTerI4pS6PnRuwI5raSol387V2DaMPswTeM+jaJO+rn
         YOUA==
X-Gm-Message-State: AGRZ1gIDZ+o6tFU0dCKFn8oukHCB4IXvUTURFnx+U/BNiDs0jAuPxlts
        jA+wD9BCASkKAuuNjH1j/Fjb2x3VB4Q=
X-Google-Smtp-Source: AJdET5ewDclOb3PVaAfLgnoeuEVGNUnrss5hVWe12ONRILoIwYcZj+ugwIE9SfbHfp+Pjk14Opfxrw==
X-Received: by 2002:a62:85:: with SMTP id 127-v6mr7882020pfa.24.1542824797248;
        Wed, 21 Nov 2018 10:26:37 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id u29sm56141774pgn.23.2018.11.21.10.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 10:26:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <153210869376.48062.15842782379577271631@swboyd.mtv.corp.google.com>
Cc:     sre@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1531977529-23304-1-git-send-email-rnayak@codeaurora.org>
 <20180719054200.GB30024@minitux>
 <ca74b7f4-3e60-2f3b-3d66-ac167c913c0e@codeaurora.org>
 <153210869376.48062.15842782379577271631@swboyd.mtv.corp.google.com>
Message-ID: <154282479571.88331.5041132574563990889@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] power: reset: msm: Add support for download-mode control
Date:   Wed, 21 Nov 2018 10:26:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2018-07-20 10:44:53)
> Quoting Rajendra Nayak (2018-07-18 23:59:20)
> > On 7/19/2018 11:12 AM, Bjorn Andersson wrote:
> > > On Wed 18 Jul 22:18 PDT 2018, Rajendra Nayak wrote:
> > >> diff --git a/Documentation/devicetree/bindings/power/reset/msm-power=
off.txt b/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
> > >> index ce44ad3..9dd489f 100644
> > >> --- a/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
> > >> +++ b/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
> > >> @@ -8,6 +8,9 @@ settings.
> > >>   Required Properties:
> > >>   -compatible: "qcom,pshold"
> > >>   -reg: Specifies the physical address of the ps-hold register
> > >> +Optional Properties:
> > >> +-qcom,dload-mode: phandle to the TCSR hardware block and offset of =
the
> > >> +             download mode control register
> > >>   =

> > >>   Example:
> > >>   =

> > >> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconf=
ig
> > >> index df58fc8..0c97e34 100644
> > >> --- a/drivers/power/reset/Kconfig
> > >> +++ b/drivers/power/reset/Kconfig
> > >> @@ -104,6 +104,17 @@ config POWER_RESET_MSM
> > >>      help
> > >>        Power off and restart support for Qualcomm boards.
> > >>   =

> > >> +config POWER_RESET_MSM_DOWNLOAD_MODE
> > > =

> > > How about moving QCOM_SCM_DOWNLOAD_MODE_DEFAULT to
> > > drivers/soc/qcom/Kconfig (and removing "SCM") and referencing this in
> > > both drivers?
> > =

> > yes, thats possible, but I am not sure how to make the command line
> > option common for both. One other option I thought was if we could hand=
le it
> > within the scm driver itself with an additional
> > binding to specify the non-secure download mode address.
> > something like qcom,dload-mode-ns?
> =

> Is the SCM device and driver always going to be present though? It may
> be better to make a TCSR platform device driver on designs that would
> configure the cookie with direct read/writes from Linux to break the
> relationship with scm entirely. Then the different configurations could
> flow from the DTS file either describing scm that has scm call, a
> special scm_writel address for TCSR, or a specific TCSR node with the
> address of the download mode cookie that triggers a TCSR driver to probe
> and register a reboot handler.
> =


Does my proposal work? I haven't seen anything new on the list since
this email.

