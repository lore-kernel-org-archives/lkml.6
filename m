Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4D0C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B0521EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jyFExdDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B0521EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeHIXbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:31:49 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:32861 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeHIXbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:31:49 -0400
Received: by mail-pl0-f68.google.com with SMTP id b90-v6so3067721plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 14:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=23xEfH2+Vy6XMyTATpfgVL5qYWG+2hXTZ13Q5FEZdqk=;
        b=jyFExdDfcTpeGk/zk1nqRNBpWfCgzp2QpWZflW8sc9Xg5uRjMnHZ8oDpGc9llSq2YL
         sKh9rYyxB1m6OPNvUD1aDV6ypnD9pqmignp3EGv2CdDdrgUOlFjkSsRxgk+TnrmI/iux
         UfOU+o+BRQRNAkUZfgwP/Q20fGi5NfV4ATHqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=23xEfH2+Vy6XMyTATpfgVL5qYWG+2hXTZ13Q5FEZdqk=;
        b=DeX8W0wa+C51aEBHohEMnxEw+Un0LGif7fZzLIZMZKKjgGiTZyBw2OrKd6J14D3eEa
         huRyWFgbfe9WLHun6pigGx8U4KsAEA4Y8W9CbtNmWI/D8t0ioKPZntj/8p6ngXyQSEJW
         yyxgdWWKjFH81xntI5jPeY8maRuhjhWlkMI0aKe1v1DZn5Tp07Wd2jCO6IrbEeorE9/r
         Ggak5O/y0hKBkKyHLOlwwybuVQQZ4OMyj36ZaWXCFweVE2hiO5ZdwkP4ea22hZFjVLXr
         YK8hBPh+OKg6q9tG3+oQ884/X5ORov03XH+6go0ADzR2KYvVnKCS8NIDT1hxGJaa7m2s
         31Wg==
X-Gm-Message-State: AOUpUlEP2CI8hh02fGcz3ARJPP10SyZLM4M3u409gTPdgcmkhppFCkoh
        BpPuGyhS0LRJKYdQa5xLYbNLBA==
X-Google-Smtp-Source: AA+uWPwI6uwRjDVPeskj+Yr55YXNijY6HJvc8IMGKnSm5QD/ZfbunobQBZoDND+3HmOTqc48HaeJag==
X-Received: by 2002:a17:902:6b44:: with SMTP id g4-v6mr3448270plt.50.1533848712987;
        Thu, 09 Aug 2018 14:05:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id n83-v6sm20661632pfk.19.2018.08.09.14.05.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 14:05:12 -0700 (PDT)
Date:   Thu, 9 Aug 2018 14:05:11 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 09/10] arm64: dts: qcom: Add reg-names for all tsens
 nodes
Message-ID: <20180809210511.GQ160295@google.com>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <188c07144d98bfbe2bbbb7d1f2941acdcf4e6682.1533815718.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <188c07144d98bfbe2bbbb7d1f2941acdcf4e6682.1533815718.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 06:02:41PM +0530, Amit Kucheria wrote:
> Instead of showing up as thermal-sensor@<addr>, the nodes will show up as
> tsens0_tm, tsen1_tm, tsens1_srot, etc. in /proc/iomem making it easier to
> read.
> 
> IOW,
> 
> 0c222000-0c2221fe : thermal-sensor@c263000
> 0c223000-0c2231fe : thermal-sensor@c265000
> 0c263000-0c2631fe : thermal-sensor@c263000
> 0c265000-0c2651fe : thermal-sensor@c265000
> 
> becomes
> 
> 0c222000-0c2221fe : tsens0_srot
> 0c223000-0c2231fe : tsens1_srot
> 0c263000-0c2631fe : tsens0_tm
> 0c265000-0c2651fe : tsens1_tm
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-msm8974.dtsi   | 1 +
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 1 +
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 ++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi  | 2 ++
>  4 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index 3c4b81c29798..64c9f81ddd90 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -431,6 +431,7 @@
>  			compatible = "qcom,msm8974-tsens";
>  			reg = <0xfc4a9000 0x1000>, /* TM */
>  			      <0xfc4a8000 0x1000>; /* SROT */
> +			reg-names = "tsens_tm", "tsens_srot";
>  			nvmem-cells = <&tsens_calib>, <&tsens_backup>;
>  			nvmem-cell-names = "calib", "calib_backup";
>  			#qcom,sensors = <11>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index abf84df5a7bc..4e6a5e462a91 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -778,6 +778,7 @@
>  			compatible = "qcom,msm8916-tsens";
>  			reg = <0x4a9000 0x1000>, /* TM */
>  			      <0x4a8000 0x1000>; /* SROT */
> +			reg-names = "tsens_tm", "tsens_srot";
>  			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
>  			nvmem-cell-names = "calib", "calib_sel";
>  			#qcom,sensors = <5>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index c2dca3a30091..7e5982daa2ed 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -969,6 +969,7 @@
>  			compatible = "qcom,msm8996-tsens";
>  			reg = <0x4a9000 0x1000>, /* TM */
>  			      <0x4a8000 0x1000>; /* SROT */
> +			reg-names = "tsens0_tm", "tsens0_srot";
>  			#qcom,sensors = <13>;
>  			#thermal-sensor-cells = <1>;
>  		};
> @@ -977,6 +978,7 @@
>  			compatible = "qcom,msm8996-tsens";
>  			reg = <0x4ad000 0x1000>, /* TM */
>  			      <0x4ac000 0x1000>; /* SROT */
> +			reg-names = "tsens1_tm", "tsens1_srot";
>  			#qcom,sensors = <8>;
>  			#thermal-sensor-cells = <1>;
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index f722785df26b..efd5d7abd1cd 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1531,6 +1531,7 @@
>  			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
>  			reg = <0xc263000 0x1ff>, /* TM */
>  			      <0xc222000 0x1ff>; /* SROT */
> +			reg-names = "tsens0_tm", "tsens0_srot";
>  			#qcom,sensors = <13>;
>  			#thermal-sensor-cells = <1>;
>  		};
> @@ -1539,6 +1540,7 @@
>  			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
>  			reg = <0xc265000 0x1ff>, /* TM */
>  			      <0xc223000 0x1ff>; /* SROT */
> +			reg-names = "tsens1_tm", "tsens1_srot";
>  			#qcom,sensors = <8>;
>  			#thermal-sensor-cells = <1>;
>  		};

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
