Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1AFECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D0F20671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gwRwsQaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D0F20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388279AbeGTSeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:34:14 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41197 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388034AbeGTSeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:34:13 -0400
Received: by mail-pl0-f68.google.com with SMTP id w8-v6so5483019ply.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 10:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=B/Rm2vKLbr2UpplS2yYLyWCu+pE+GT9jDocqSOUw1bo=;
        b=gwRwsQaU2X1SP0vHo+Fk8US9i7s4Jf822P70CqSXNT5uLIzP4W4xpUuqMyOqu+zrfr
         AwkEky3dWwf2f/Lm76Mr60CjvQO6359pxnA8iTHX1hP37zbaBRYaLqi6syCDVdE8O4nc
         4hObmyPL7RpYxpW+XGIQNm7s3yBxBKa9NrUhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=B/Rm2vKLbr2UpplS2yYLyWCu+pE+GT9jDocqSOUw1bo=;
        b=VXGE7Rrg0vzIHQcgC8c0jjkRxqWwZxoXRuLocG1IVSvrrL3UeMwmqCho3y71+eZmLc
         Vc8wwi4bB3NB/P8YYDyhAHxWaKQV5dUaA519gc5ssIZhE6KXaXk8KBxYi65Gh5gQEeFX
         3q071pDvGB7Zh/K3dO2DMNVYNeja5yOmhwumAcqNXewvPbuYNwwUcuOl/riSLog+xkBD
         dtlpEt8851TAHK3C2JhNWmWRF5n+xfHQXi9ibSXS+6wBatF+dnhIDW7jfgnznfBkLNGU
         kyN+ZrUOdzwRAc7Dz1w0rVGwJNWMdpQpqfvVUbrFtdYPQOvKjvBejm0AMgiqD64FnAox
         tcOA==
X-Gm-Message-State: AOUpUlGsAcjc/Az9hKXnJkFQKnRY7XGq8pCss2zLLP6dJecwH3FrSsQN
        qVTJ+rkS4N3dgvLFomDcH+S1PQ==
X-Google-Smtp-Source: AAOMgpfecgvsQiJwLghhUYKBCNutWyNrLhKax8otc+K7uU6goJdUhJKRrqC6oCgdHFIIGvrFXt9P1A==
X-Received: by 2002:a17:902:bc41:: with SMTP id t1-v6mr3059107plz.26.1532108695041;
        Fri, 20 Jul 2018 10:44:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id d12-v6sm3250970pfn.118.2018.07.20.10.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 10:44:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <ca74b7f4-3e60-2f3b-3d66-ac167c913c0e@codeaurora.org>
Cc:     sre@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1531977529-23304-1-git-send-email-rnayak@codeaurora.org>
 <20180719054200.GB30024@minitux>
 <ca74b7f4-3e60-2f3b-3d66-ac167c913c0e@codeaurora.org>
Message-ID: <153210869376.48062.15842782379577271631@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] power: reset: msm: Add support for download-mode control
Date:   Fri, 20 Jul 2018 10:44:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2018-07-18 23:59:20)
> =

> =

> On 7/19/2018 11:12 AM, Bjorn Andersson wrote:
> > On Wed 18 Jul 22:18 PDT 2018, Rajendra Nayak wrote:
> > =

> >> commit '8c1b7dc9b: firmware: qcom: scm: Expose download-mode control'
> >> added support for download-mode control using the scm firmware
> >> driver for platforms which require a secure call to write the magic
> >> cookie into the tcsr location.
> >>
> >> For platforms which *do not* need an scm call and where the kernel can
> >> write the cookie by a direct read/write, add similar support in the
> >> msm-poweroff driver.
> >> Similar to the scm driver, the msm-poweroff driver clears the cookie
> >> during a clean reboot.
> >>
> >> Download mode using msm-poweroff driver can be enabled by including
> >> msm-poweroff.download_mode=3D1 on the command line.
> >>
> > =

> > Should have thought about this when I wrote the scm code...
> > =

> > I would prefer if we could find a way to consolidate the two
> > implementations behind the same Kconfig and command line parameters.
> =

> The only problem I saw with this was that *both* drivers would think
> its enabled and try their own ways to enable it, and one of it would
> always fail. We could fail silently, which would mean we will miss
> cases when its a genuine failure but that should be fine?

Should be fine if SCM fails silently. If TCSR is specified it better
work because that doesn't really rely on anything besides writing into a
memory location.

> =

> >> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> >> ---
> >>   .../bindings/power/reset/msm-poweroff.txt          |  3 ++
> >>   drivers/power/reset/Kconfig                        | 11 +++++++
> >>   drivers/power/reset/msm-poweroff.c                 | 38 ++++++++++++=
++++++++++
> >>   3 files changed, 52 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/power/reset/msm-powerof=
f.txt b/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
> >> index ce44ad3..9dd489f 100644
> >> --- a/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
> >> +++ b/Documentation/devicetree/bindings/power/reset/msm-poweroff.txt
> >> @@ -8,6 +8,9 @@ settings.
> >>   Required Properties:
> >>   -compatible: "qcom,pshold"
> >>   -reg: Specifies the physical address of the ps-hold register
> >> +Optional Properties:
> >> +-qcom,dload-mode: phandle to the TCSR hardware block and offset of the
> >> +             download mode control register
> >>   =

> >>   Example:
> >>   =

> >> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> >> index df58fc8..0c97e34 100644
> >> --- a/drivers/power/reset/Kconfig
> >> +++ b/drivers/power/reset/Kconfig
> >> @@ -104,6 +104,17 @@ config POWER_RESET_MSM
> >>      help
> >>        Power off and restart support for Qualcomm boards.
> >>   =

> >> +config POWER_RESET_MSM_DOWNLOAD_MODE
> > =

> > How about moving QCOM_SCM_DOWNLOAD_MODE_DEFAULT to
> > drivers/soc/qcom/Kconfig (and removing "SCM") and referencing this in
> > both drivers?
> =

> yes, thats possible, but I am not sure how to make the command line
> option common for both. One other option I thought was if we could handle=
 it
> within the scm driver itself with an additional
> binding to specify the non-secure download mode address.
> something like qcom,dload-mode-ns?

Is the SCM device and driver always going to be present though? It may
be better to make a TCSR platform device driver on designs that would
configure the cookie with direct read/writes from Linux to break the
relationship with scm entirely. Then the different configurations could
flow from the DTS file either describing scm that has scm call, a
special scm_writel address for TCSR, or a specific TCSR node with the
address of the download mode cookie that triggers a TCSR driver to probe
and register a reboot handler.


