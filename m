Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0686FC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8034218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IC4m+FX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfAYKbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:31:13 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45088 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfAYKbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:31:12 -0500
Received: by mail-oi1-f193.google.com with SMTP id y1so7295315oie.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 02:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sl/prQtqVPLJ78onHUm4hCQeo9i5tdeKWJiivO1EFYY=;
        b=IC4m+FX8sDgIl85AeyI/DDxhe3mF27KxZGzeLwXOKmMB1WDJe5Ferees8HCMtqS9J/
         rSKQwnoY39wax58Hpqow5bbhuWrJH4zS60yIzBee/TPY7Yn4Kk/AnSYz2f4PrYqrHVN5
         fvJuwwj9jV0RuADLE2ueh3Eo2/8GuBOWQQfc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sl/prQtqVPLJ78onHUm4hCQeo9i5tdeKWJiivO1EFYY=;
        b=L+FrYBbkskftr7GsEZG7k/+8HYyvSFhCz4W0vEDrpvLRgBlwtAgWeMvlMPQtK/snlR
         MSrN5ctpCYVm8Pm+h3HrhJjDi4p9L+1oqiYjiNMCzRifVe39lcjkXViaUJwEjwjmntRk
         nhnfPJ4v3ELE1CyElVllHlurcq2IIgBaKnsxRbfjzefsFpxYBk7erlqMIgMqUP3KcUdX
         ZgK6D7s/CVpgko+8QKKPTuregQs2rAsP/z/o6i8i2NEETH28d5X6p8PorWoyZGcuEwrV
         UkP/rCql7K99QJJeJiCDmgkTFV1it+X8ThsO9vsTxSsMj7dFSoW6/uUxN2Ef+gqOcEsO
         3gCA==
X-Gm-Message-State: AHQUAuYcqhIVo2EpHZY1oQHFKoeOUFEVsxhPx0jNOYbcpLqey0nFHnt6
        Z9b6YSIDhqU1NHkO7w2MHxdnr/xf0TI=
X-Google-Smtp-Source: ALg8bN6f1r+7BpUFNns1aGgshOfmXwmXQhTI0yTpibu6vw6zi1CoXyGHcc4cnJEHIWhV+xAJcGk9Ug==
X-Received: by 2002:a05:6808:18a:: with SMTP id w10mr955943oic.63.1548412271159;
        Fri, 25 Jan 2019 02:31:11 -0800 (PST)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id a12sm1025883otl.39.2019.01.25.02.31.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 02:31:10 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id w13so7296824oiw.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 02:31:10 -0800 (PST)
X-Received: by 2002:aca:dec1:: with SMTP id v184mr892068oig.217.1548411069749;
 Fri, 25 Jan 2019 02:11:09 -0800 (PST)
MIME-Version: 1.0
References: <1545292023-5489-1-git-send-email-mgottam@codeaurora.org>
 <0ee6676f-f169-1ea1-506e-16e4097d1c04@linaro.org> <CAPBb6MWedPvoFW2jrqhZhNP-41PrEC+G4xnXs=cex1ywnVdm-w@mail.gmail.com>
 <323bca85-6dc3-4d28-ec02-69ce57bc6506@linaro.org>
In-Reply-To: <323bca85-6dc3-4d28-ec02-69ce57bc6506@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 25 Jan 2019 19:10:57 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUOqQVY=L8cu=RN9pWBsDZhmpvHh_3-kvvuSRHQpyTbAQ@mail.gmail.com>
Message-ID: <CAPBb6MUOqQVY=L8cu=RN9pWBsDZhmpvHh_3-kvvuSRHQpyTbAQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: sdm845: add video nodes
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Malathi Gottam <mgottam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 5:32 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Alex,
>
> On 1/25/19 9:46 AM, Alexandre Courbot wrote:
> > On Thu, Jan 17, 2019 at 8:58 PM Stanimir Varbanov
> > <stanimir.varbanov@linaro.org> wrote:
> >>
> >> Hi Malathi,
> >>
> >> On 12/20/18 9:47 AM, Malathi Gottam wrote:
> >>> This adds video nodes to sdm845 based on the examples
> >>> in the bindings.
> >>>
> >>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> >>> ---
> >>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 35 +++++++++++++++++++++++++++++++++++
> >>>  1 file changed, 35 insertions(+)
> >>
> >> Looks good to me:
> >>
> >> Reviewed-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> >>
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >>> index b72bdb0..ccd2b10 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> >>> @@ -87,6 +87,11 @@
> >>>                       reg = <0 0x86200000 0 0x2d00000>;
> >>>                       no-map;
> >>>               };
> >>> +
> >>> +             venus_region: memory@95800000 {
> >>> +                     reg = <0x0 0x95800000 0x0 0x500000>;
> >>> +                     no-map;
> >>> +             };
> >>>       };
> >>>
> >>>       cpus {
> >>> @@ -1403,5 +1408,35 @@
> >>>                               status = "disabled";
> >>>                       };
> >>>               };
> >>> +
> >>> +             video-codec@aa00000 {
> >>> +                     compatible = "qcom,sdm845-venus";
> >>> +                     reg = <0x0aa00000 0xff000>;
> >>> +                     interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> >>> +                     power-domains = <&videocc VENUS_GDSC>;
> >>> +                     clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
> >>> +                              <&videocc VIDEO_CC_VENUS_AHB_CLK>,
> >>> +                              <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>;
> >>> +                     clock-names = "core", "iface", "bus";
> >>> +                     iommus = <&apps_smmu 0x10a0 0x8>,
> >>> +                              <&apps_smmu 0x10b0 0x0>;
> >>> +                     memory-region = <&venus_region>;
> >>> +
> >>> +                     video-core0 {
> >>> +                             compatible = "venus-decoder";
> >>> +                             clocks = <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
> >>> +                                      <&videocc VIDEO_CC_VCODEC0_AXI_CLK>;
> >>> +                             clock-names = "core", "bus";
> >>> +                             power-domains = <&videocc VCODEC0_GDSC>;
> >>> +                     };
> >>> +
> >>> +                     video-core1 {
> >>> +                             compatible = "venus-encoder";
> >>> +                             clocks = <&videocc VIDEO_CC_VCODEC1_CORE_CLK>,
> >>> +                                      <&videocc VIDEO_CC_VCODEC1_AXI_CLK>;
> >>> +                             clock-names = "core", "bus";
> >>> +                             power-domains = <&videocc VCODEC1_GDSC>;
> >>> +                     };
> >>> +             };
> >
> > This patch lacks the video-firmware node, it should at the very least
> > be added before this gets merged.
>
> The firmware node should be added in board dts file, the for example
> sdm845-mtp will not populate firmware node because it uses TZ for
> firmware loading.

Ah, that's a good point. In that case the previous patch was alright,
sorry Malathi!
