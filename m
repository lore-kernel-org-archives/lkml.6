Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E618C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02925217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KwkymQCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbeLRAAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:00:03 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35419 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbeLRAAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 19:00:02 -0500
Received: by mail-vs1-f68.google.com with SMTP id e7so8908318vsc.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 16:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eaVvu34d0qaD97yOqEh3I+K8VrRLlvxcuACvAqx7jlY=;
        b=KwkymQCUbl+iLWZDNn7TCTYriTJpa5IzzthK3UE8zCwWVLQYvwBDbq2yMZhxoINEFA
         GF7hsuEpXEKsqrZtW0AGxqDAimSGRG8/ZSme91aeq+691Du33FoFGLqfLlgUuIGXL5C0
         aHS3yNUNWMJ1PorBTHQqq9q9gsC6VG2tSVYuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eaVvu34d0qaD97yOqEh3I+K8VrRLlvxcuACvAqx7jlY=;
        b=Z7Tiv6U0XFU4ixqKDQxEMOJzo2YonIYckZzG5tLNwbQBhyjWznN5al1TuGbkzyOBWy
         IBfAcqEoxg1iDKPrAvRT8Ad/CF6nWXP6ibPtGfgv7l47SHCquSeIba8s785oLX/+lPJr
         Ah83DECHwgp1I7f1YrFKIKbAFNXIHruwfFyn65Z9gU/nKgcQbKw0kFGdN2TIUpfb7H1w
         0SSE422Iwuf5HU1wjVXncFZj1LZb3kkjbJEIK2SKUnLFzzTK/775ROxD56Fwn46xCqFY
         HEMAIxKU0i+SvCyb7XNMwrh/4Bbb9btxjrmegaUkCvIBq6v6ZYUbTdFbnrPqlONyHi7E
         8t1g==
X-Gm-Message-State: AA+aEWYzrSTrNdsJ+pI5LDzsFdr/OmvPIwIOpiM0fU40+LD4ea2AoxPy
        gToZ8AgBKmPndGhbe4/yeVW7SBhCP2g=
X-Google-Smtp-Source: AFSGD/VIlbLzDSUaS5PVB/MUoeot7CjP+UD0KqTNcKtxg7FzI4QiAA1qZZlPGa8FbzvU5vfwwG9PHg==
X-Received: by 2002:a67:c01d:: with SMTP id v29mr7478363vsi.124.1545091199927;
        Mon, 17 Dec 2018 15:59:59 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id n15sm5761455vsi.5.2018.12.17.15.59.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 15:59:59 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id p9so5094883uaa.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 15:59:59 -0800 (PST)
X-Received: by 2002:ab0:1c12:: with SMTP id a18mr6799230uaj.15.1545091198708;
 Mon, 17 Dec 2018 15:59:58 -0800 (PST)
MIME-Version: 1.0
References: <20181217100724.4593-1-sibis@codeaurora.org> <20181217100724.4593-2-sibis@codeaurora.org>
In-Reply-To: <20181217100724.4593-2-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 17 Dec 2018 15:59:47 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Ui6ys4R3nenix3USeRPAd_vVdrArXxdf-iEc=4QRhE+A@mail.gmail.com>
Message-ID: <CAD=FV=Ui6ys4R3nenix3USeRPAd_vVdrArXxdf-iEc=4QRhE+A@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: remoteproc: qcom: Add clock bindings
 for Q6V5
To:     sibis@codeaurora.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 17, 2018 at 2:07 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Add missing clock bindings for Q6V5 MSS on SDM845 SoCs.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  .../devicetree/bindings/remoteproc/qcom,q6v5.txt       | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Fixes: 9f058fa2efb1 ("remoteproc: qcom: Add support for mss remoteproc
on msm8996")
Fixes: fb22022ff63d ("dt-bindings: remoteproc: Add Q6v5 Modem PIL
binding for SDM845")

...it probably doesn't matter too much but if we wanted to be really
careful we could split into two patches, one for the msm8996 and one
for sdm845.  I don't think people care that much about stable
backports of bindings though (someone can feel free to correct me)...


> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> index 9ff5b0309417..780adc043b37 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> @@ -39,13 +39,17 @@ on the Qualcomm Hexagon core.
>  - clocks:
>         Usage: required
>         Value type: <phandle>
> -       Definition: reference to the iface, bus and mem clocks to be held on
> -                   behalf of the booting of the Hexagon core
> +       Definition: reference to the list of 4 clocks for the modem sub-system
> +                   reference to the list of 8 clocks for the modem sub-system
> +                   on SDM845 SoCs

The above is confusing because you don't list the SoCs that are
supposed to use the 4 clocks.  How about instead:

Definition: reference to the clocks that match clock-names


>  - clock-names:
>         Usage: required
>         Value type: <stringlist>
> -       Definition: must be "iface", "bus", "mem"
> +       Definition: must be "iface", "bus", "mem", "xo" for the modem sub-system
> +                   must be "iface", "bus", "mem", "gpll0_mss", "snoc_axi",
> +                   "mnoc_axi", "prng", "xo" for the modem sub-system on SDM845
> +                   SoCs

Same here where it's confusing.  ...but also, it it correct?  As far
as I can tell you're missing msm8996.  It's better to just be explicit
and list each one, ideally without all the prose.

Definition: The clocks needed depend on the compatible string:

qcom,sdm845-mss-pil: "xo", "prng", "iface", "snoc_axi", "bus", "mem",
"gpll0_mss", "mnoc_axi"
qcom,msm8996-mss-pil: "xo", "pnoc", "iface", "bus", "mem", "gpll0_mss_clk"
qcom,msm8974-mss-pil: "xo", "iface", "bus", "mem"
qcom,msm8916-mss-pil: "xo", "iface", "bus", "mem"
qcom,q6v5-pil: "xo", "iface", "bus", "mem"

...as far as I can tell this binding is supposed to account for
"qcom,ipq8074-wcss-pil" too but it seems that one doesn't have
clock-names.


-Doug
