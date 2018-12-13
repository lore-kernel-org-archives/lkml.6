Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5819CC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F359A2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kjKwWXmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F359A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeLMWR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 17:17:26 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44908 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeLMWRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 17:17:25 -0500
Received: by mail-vs1-f66.google.com with SMTP id g68so2171837vsd.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 14:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KIYfbN7VWYCuqaPaV9kIDkWGodkDaEx+R5hCfSRrSIU=;
        b=kjKwWXmRhS6+j5XsOBQe2cQWzG0aXBdwkIdJM0gGBArRmy0J3vIJgM3GPyraC4lyyu
         3e4rxzZDun2rc5Dlflm6ESbmoEkioiPOw39u3VzfGNYJjftW4SOQ68aXcHk/vz8Wsu53
         /HVxANxpXcdkIqsZLct8xvEyrIMYvzMO8chuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KIYfbN7VWYCuqaPaV9kIDkWGodkDaEx+R5hCfSRrSIU=;
        b=Wfq4T0IfTaY8aatdNYkolO4iL3apI5cCreza/nI3EYG/OlJFKiHKGj4fkzWxDGh6OO
         pGkFNWZl6vHBD0UJk31luB5yrPXzEiSuMQXgz8+vVHeD5TORkPkH9Emum+wW1H6gSnYh
         22jgdBoYcvZnZcCIuP4HHqDZtfBhKtKcrxNqjpwtS3qR/6x7XQBz9FEF3lS5n65jtGNr
         CMRsfJRMvt6ZLQsLQbgeRBx5rhjPV1tEf3RTHPGZkLNEJPvDfzGCeYmBVnf9zZsIFJ+f
         f/tTKRPPcsSvH+C/m+8F0Tu6t4N/EuMj4ir9CYWLVONBHla/RGzZWQxiKr5Rgk5zgzhd
         bdQQ==
X-Gm-Message-State: AA+aEWbqjI9ycuoPrgjKWvKu55LFDpjxpkkt+C5JDBrW7ghOpvBiWaIG
        HAhEULV0ogONhMJczUKAcIXOovUrc3M=
X-Google-Smtp-Source: AFSGD/XZzfM9qF0NeLRvV6pvmfGLtDChEIfz7B3T2qPZS2kWb6V6KVtLadoV7YrIhEpvn9V+koUung==
X-Received: by 2002:a67:8904:: with SMTP id l4mr253863vsd.239.1544739443965;
        Thu, 13 Dec 2018 14:17:23 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id g14sm868898uah.10.2018.12.13.14.17.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 14:17:22 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id e16so1293643uam.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 14:17:22 -0800 (PST)
X-Received: by 2002:a9f:3ba6:: with SMTP id r38mr295974uah.52.1544739442450;
 Thu, 13 Dec 2018 14:17:22 -0800 (PST)
MIME-Version: 1.0
References: <20181127085828.17908-1-sibis@codeaurora.org>
In-Reply-To: <20181127085828.17908-1-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 13 Dec 2018 14:17:11 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U+LHa0QpPuZhd04=WkMrrM1kBUYhkS9RqSSR6uLijbBA@mail.gmail.com>
Message-ID: <CAD=FV=U+LHa0QpPuZhd04=WkMrrM1kBUYhkS9RqSSR6uLijbBA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Add Q6V5 MSS node
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

On Tue, Nov 27, 2018 at 12:58 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> This patch adds Q6V5 MSS remoteproc node for SDM845 SoCs.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>
> The remoteproc mss node depends on the following bindings:
> https://patchwork.kernel.org/patch/10490559/ - rpmhp dt bindings

This is an older version of the patch.  Now at v7 at
<https://patchwork.kernel.org/patch/10725801/>


> https://patchwork.kernel.org/patch/10678301/ - AOP QMP dt bindings
> https://patchwork.kernel.org/patch/10691215/ - mss power-domain dt bindings
> https://patchwork.kernel.org/patch/10691213/ - shutdown-ack dt bindings
>
> It also depends on the mpss and mba memory regions and pdc reset node.
> https://patchwork.kernel.org/patch/10662089/
> https://patchwork.kernel.org/patch/10657325/
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 63 ++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 58870273dbc9..df16ee464872 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1095,6 +1095,69 @@
>                         };
>                 };
>
> +               remoteproc@4080000 {
> +                       compatible = "qcom,sdm845-mss-pil";
> +                       reg = <0x04080000 0x408>, <0x04180000 0x48>;

s/0x04080000/0x4080000 to appease the DT folks.


> +                       reg-names = "qdsp6", "rmb";
> +
> +                       interrupts-extended =
> +                               <&intc GIC_SPI 266 IRQ_TYPE_EDGE_RISING>,
> +                               <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +                               <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +                               <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +                               <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
> +                               <&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
> +
> +                       interrupt-names = "wdog", "fatal", "ready",
> +                                         "handover", "stop-ack",
> +                                         "shutdown-ack";

nit: maybe remove blank line between "interrupts-extended" and
"interrupt-names".  Nice to keep -names close to the things they're
naming.


> +                       clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
> +                                <&gcc GCC_MSS_Q6_MEMNOC_AXI_CLK>,
> +                                <&gcc GCC_BOOT_ROM_AHB_CLK>,
> +                                <&gcc GCC_MSS_GPLL0_DIV_CLK_SRC>,
> +                                <&gcc GCC_MSS_SNOC_AXI_CLK>,
> +                                <&gcc GCC_MSS_MFAB_AXIS_CLK>,
> +                                <&gcc GCC_PRNG_AHB_CLK>,
> +                                <&rpmhcc RPMH_CXO_CLK>;
> +
> +                       clock-names = "iface", "bus", "mem", "gpll0_mss",
> +                                     "snoc_axi", "mnoc_axi", "prng", "xo";

Bindings list clock-names as "iface", "bus", "mem".  You have "iface",
"bus", "mem", "gpll0_mss", "snoc_axi", "mnoc_axi", "prng", "xo".  It
looks like these extra clocks were added in commit 231f67d1fb2f
("remoteproc: q6v5: Add support for mss remoteproc on SDM845") but you
forgot to update the bindings.  Looking in that patch I also see an
"axis2" which you seem to be missing.  Do you need it?


> +                       qcom,smem-states = <&modem_smp2p_out 0>;
> +                       qcom,smem-state-names = "stop";
> +
> +                       resets = <&aoss_reset AOSS_CC_MSS_RESTART>,
> +                                <&pdc_reset PDC_MODEM_SYNC_RESET>;
> +                       reset-names = "mss_restart", "pdc_reset";
> +
> +                       qcom,halt-regs = <&tcsr_mutex_regs
> +                                               0x23000 0x25000 0x24000>;
> +
> +                       power-domains = <&aoss_qmp_pd AOSS_QMP_LS_MODEM>,
> +                                       <&rpmhpd SDM845_CX>,
> +                                       <&rpmhpd SDM845_MX>,
> +                                       <&rpmhpd SDM845_MSS>;
> +                       power-domain-names = "aop", "cx", "mx", "mss";
> +
> +                       mba {
> +                               memory-region = <&mba_region>;
> +                       };
> +
> +                       mpss {
> +                               memory-region = <&mpss_region>;
> +                       };
> +
> +                       glink-edge {
> +                               interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
> +                               label = "modem";
> +                               qcom,remote-pid = <1>;

The "qcom,remote-pid" property isn't documented for "glink-edge".  Do
you need it?  ...if you do, please send a patch to update the
bindings.


-Doug
