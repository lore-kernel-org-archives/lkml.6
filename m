Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42ACEC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0971C21582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iacsgEmH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0971C21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388822AbeKPFPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:15:02 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33468 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeKPFPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:15:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id v68-v6so10149711pfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 11:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5EWbEROrU0zaWW7UOv3ESx84BUVxAc0dB7SceFTrffA=;
        b=iacsgEmHICoq37kGEMWGdXKcjHOClmixHpMd+CbdBwmA9rxnDp4Xtl2rLj7/GF9Lim
         xaG5Cag3bpYrVC7MhEwyrgFwFqnMwuvQ6Z4FM7ZqAL3kBky1d3pTPAzltHMpnUE6gft4
         ih53FYYxt3lFZ23ZzyxPFCTfvK8Cel9lvWAuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5EWbEROrU0zaWW7UOv3ESx84BUVxAc0dB7SceFTrffA=;
        b=JWoOz4kI/lRzbGHrcwkcaHFsRf0CO1vTgq91Ja8CUZiWbYc2ePAwKEW+cXBTt0JnJf
         fQFzEO7V3P6z+ZW3rchetrBcZUKT3IwoeHrLvLTvdb+klrZ3x4GmdRQzquVVUUTi90Lq
         FcRk1QX+m2Fp6rxzuD9YiObrd3jRbB3CCbCSX1X7nYL5h0Gi74wKP4S7EYud+4V9Dtm+
         82N9UBaF/BZTkBaJCAHc/W2sgdC7e1xYT38qcJFPNfTox9VAm9V2cCSihSHNuNaRvasQ
         MQxu6/ktWiTQUhGnvF28avBDdCaaeC48Wu8Xq2pzkYkWmNgOcT8l6MY42MoxfPT/qCLA
         4VeA==
X-Gm-Message-State: AGRZ1gIXsjaoGb8zoXdN2sExGM+floVvyfESYRUt4/YySZ43uUj1uOCB
        i4xgqezp3csVTJY96K4ObgPbzw==
X-Google-Smtp-Source: AJdET5cQguhSaGWG3ddMXpMSvS6ZyCnKpd43GpU3c6IUOBQXM87a1JGkJjEZeiH5UlLXuGEELZlrKA==
X-Received: by 2002:aa7:86d3:: with SMTP id h19-v6mr7608122pfo.225.1542308761003;
        Thu, 15 Nov 2018 11:06:01 -0800 (PST)
Received: from localhost ([64.114.255.97])
        by smtp.gmail.com with ESMTPSA id b5-v6sm35539284pfe.60.2018.11.15.11.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:06:00 -0800 (PST)
Date:   Thu, 15 Nov 2018 11:05:59 -0800
From:   Andy Gross <andy.gross@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     david.brown@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: qcom: msm8998-mtp: Add external SD
Message-ID: <20181115190559.GA17484@hector>
References: <1542302291-6864-1-git-send-email-jhugo@codeaurora.org>
 <1542302291-6864-5-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542302291-6864-5-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 10:18:11AM -0700, Jeffrey Hugo wrote:
> The externally accessible SD card slot on the MTP is driven by SDCC2.
> Wire it up for use.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 13 +++++++++++++
>  arch/arm64/boot/dts/qcom/msm8998.dtsi     |  1 +
>  2 files changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> index b4276da..a90b427 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> @@ -241,3 +241,16 @@
>  		};
>  	};
>  };
> +
> +&sdhc2 {
> +	status = "okay";
> +        cd-gpios = <&tlmm 95 GPIO_ACTIVE_LOW>;
> +
> +        vmmc-supply = <&vreg_l21a_2p95>;
> +        vqmmc-supply = <&vreg_l13a_2p95>;
> +
> +        pinctrl-names = "default", "sleep";
> +        pinctrl-0 = <&sdc2_clk_on  &sdc2_cmd_on  &sdc2_data_on  &sdc2_cd_on>;
> +        pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;

Fix to use tabs instead of spaces.


Regards,
Andy
