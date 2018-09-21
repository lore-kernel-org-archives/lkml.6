Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3420EECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DE421537
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hbeMFD0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DE421537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388836AbeIUGCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 02:02:39 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33164 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeIUGCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 02:02:39 -0400
Received: by mail-lf1-f65.google.com with SMTP id m26-v6so9977800lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 17:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NNpwHh3xn9csWo2Dau7RUQRer//AyK3BiKVSZKenDXI=;
        b=hbeMFD0Mi88aFOAWbalcHOLzMtp1GDdVZDdByUxFAWCtSqeq1Zsg5agUyq3jrNkgio
         s53Hw+ecEMNdfkXasCGk8HwZk+/zJXgUBEWwkl17yHBf7l6wC+xctX5S3sET3FMRPmqj
         H3vgZkq7WzB7suMKuKyisC3lr+u9KRMs7XzYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NNpwHh3xn9csWo2Dau7RUQRer//AyK3BiKVSZKenDXI=;
        b=jAPWqOwh8YF2kZ89rV4zy2L7UdzLIxBw8gWBW1g+lLxhHvWUPmZEE9iSdz2wARyi8n
         6CzEgrbvVQuHg5yKurVgqaehvZf1qqo5kg4qs2X8kj/mDV2jUcT92uznoD0zkYr+wBF4
         +LGTj0AcOUT+P7+149kbsodjgPPhOZcy6SkOhOjx8gdI33SqJJBdHSj2LwZ3P+aoHYHk
         mNvs5PhLiZMcaOWKX74YWnK6/pxZV7WWj9zhNpxcZUAzCyjdNJuQP/bp0Mtt4va66Z+Y
         Rgmv+upMtvyEtCu9HvEBXxIxfbCq70ruumcS23RJOVEQjgR3u1Q+8FBI87adbng7iD+s
         qQiw==
X-Gm-Message-State: APzg51BsYVv8u/Gwi3m/qN4+7z9VXO3Ud5GULpLnO2uKY4xFAVJArVbE
        +HajzJbxKajclKH29Jbm9jwjoOYFNIU=
X-Google-Smtp-Source: ANB0Vdaug+7mGJB+VFq2cB63mAte1hBtfvYwWZ/4RepFSFG2MENRDPu+sBF/x3YgloayAsBwfrby3A==
X-Received: by 2002:a19:5a8f:: with SMTP id y15-v6mr12058193lfk.15.1537488991874;
        Thu, 20 Sep 2018 17:16:31 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id n3-v6sm558348lfi.96.2018.09.20.17.16.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 17:16:31 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id q127-v6so9993957ljq.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 17:16:30 -0700 (PDT)
X-Received: by 2002:a2e:1248:: with SMTP id t69-v6mr26168933lje.129.1537488989765;
 Thu, 20 Sep 2018 17:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <1537424558-17989-1-git-send-email-vbadigan@codeaurora.org> <1537424558-17989-3-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1537424558-17989-3-git-send-email-vbadigan@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 20 Sep 2018 17:15:51 -0700
X-Gmail-Original-Message-ID: <CAE=gft6w_iV+vm=u=ZKNvDLVTHcAO+AR0A9Yg9etTHW8bJy05w@mail.gmail.com>
Message-ID: <CAE=gft6w_iV+vm=u=ZKNvDLVTHcAO+AR0A9Yg9etTHW8bJy05w@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] dt-bindings: mmc: sdhci-msm: Add entries for
 passing load values
To:     vbadigan@codeaurora.org
Cc:     adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        robh+dt@kernel.org, linux-mmc@vger.kernel.org,
        asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayali <sayalil@codeaurora.org>,
        Doug Anderson <dianders@google.com>, vviswana@codeaurora.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 11:24 PM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> From: Vijay Viswanath <vviswana@codeaurora.org>
>
> The load a particular sdhc controller should request from a regulator
> is device specific and hence each device should individually vote for
> the required load.
>
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 502b3b8..3720385 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -26,6 +26,11 @@ Required properties:
>         "cal"   - reference clock for RCLK delay calibration (optional)
>         "sleep" - sleep clock for RCLK delay calibration (optional)
>
> +Optional properties:
> +- qcom,<supply>-current-level-microamp - specifies load levels for supply during BUS_ON and
> +                                       BUS_OFF states in power irq. Should be specified in
> +                                       pairs (lpm, hpm), for BUS_OFF and BUS_ON respectively.
> +                                       Units uA.
>  Example:
>
>         sdhc_1: sdhci@f9824900 {
> @@ -37,6 +42,7 @@ Example:
>
>                 vmmc-supply = <&pm8941_l20>;
>                 vqmmc-supply = <&pm8941_s3>;
> +               qcom,vqmmc-current-level-microamp = <200 22000>;
>
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&sdc1_clk &sdc1_cmd &sdc1_data>;
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
>

Aren't the regulator load levels pretty coarse? Would it be safe to
say that pretty much all sd/mmc devices need the high powered mode, or
are there really some devices that can get by with LPM all the time?
-Evan
