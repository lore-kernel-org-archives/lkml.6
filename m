Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7421C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A22207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fGWPTzJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A22207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeJZD7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:59:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42006 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbeJZD7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:59:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id i4-v6so4464065pgq.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 12:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NPH3tMTu4mDqEHhi0QXHxZfFPgrj0p8zunC7Skd0SeM=;
        b=fGWPTzJ4gx+5ZHMfSqcGvGbyO0HytTdiK19JcJiDvGKGoVkd/IxRCbQTZ2CenCTLst
         sEXmgGeumvUPU2K4XcbWnejbSNjVNKDR8sfgdzttiRvuGiNIqS59TdFVvBKpp6bRNTKT
         Mw14jnKy2gp4bBBUcBqkWbFeyhxhvr/m2vpmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NPH3tMTu4mDqEHhi0QXHxZfFPgrj0p8zunC7Skd0SeM=;
        b=Vx9zL22/fdpPe2YS1621b7brvNdOJyRhC04KlWp5tMFxi34/hzCT/xOPij6Df4lyxj
         BZJ+lChZfYSYAmRTv6krhl03TCrUIxONBlwnzhr9ZyvU7wCntXohzG6m4oOMyO16UGEc
         TJ1pl+10DFCTGFz986apRSe6Jpo2Wcd3Lt1vavI2X7YwVo4MQsuXwDbCvcyqqz25IdhJ
         KEjL9pYZfRAj1UHBeJyGD5rzuIOLTo/XZbhD9fUN4DyPlgXj47J8tTN4GqTtV3pcj4/q
         UOddh08J5Qhxzn/TNumr3MRN3QG2W1oz5ZETjU0nmPtPfS/S1B/hDPkwkezdZ8PM52AH
         j6CQ==
X-Gm-Message-State: AGRZ1gK6Gz5UX//L7Uu8Xo/H8pBflrtqiDwEBDuN4jGU091Rnvr5h5dT
        GT/uv0k7HKge2hFcoxTo3Y5cQw==
X-Google-Smtp-Source: AJdET5c4flJuvP5/ik2Y3NTXLFYpZuTxGb/bvBjLvB6O8Eum9fvrI+Lr4B5I2qe0zaZ+L2VerRwItw==
X-Received: by 2002:a62:3a8c:: with SMTP id v12-v6mr496660pfj.118.1540495502679;
        Thu, 25 Oct 2018 12:25:02 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id y12-v6sm18139247pga.77.2018.10.25.12.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 12:25:01 -0700 (PDT)
Date:   Thu, 25 Oct 2018 12:25:01 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 16/16] arm64: dts: sdm845: enable tsens thermal zones
Message-ID: <20181025192501.GZ22824@google.com>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
 <5e2d5fc463a5f5623c4fc1b18ccdf62adc954758.1536744310.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e2d5fc463a5f5623c4fc1b18ccdf62adc954758.1536744310.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

vaguely related question, since you are working on SDM845 thermal
stuff: Do you have plans to add CPU cooling devices? I raised the
point during the review of the CPUfreq HW, however there was no
clear answer: https://lore.kernel.org/patchwork/patch/966833/#1164748
The driver is still under development/review, but I wonder what the
path forward is.

Cheers

Matthias

On Wed, Sep 12, 2018 at 03:23:01PM +0530, Amit Kucheria wrote:
> One thermal zone per cpu is defined
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 170 +++++++++++++++++++++++++++
>  1 file changed, 170 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 0c9a2aa6a1b5..eb801922f6bb 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1104,4 +1104,174 @@
>  			};
>  		};
>  	};
> +
> +	thermal-zones {
> +		cpu0-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 1>;
> +
> +			trips {
> +				cpu_alert0: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit0: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu1-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 2>;
> +
> +			trips {
> +				cpu_alert1: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit1: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu2-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 3>;
> +
> +			trips {
> +				cpu_alert2: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit2: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu3-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 4>;
> +
> +			trips {
> +				cpu_alert3: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit3: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu4-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 7>;
> +
> +			trips {
> +				cpu_alert4: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit4: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu5-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 8>;
> +
> +			trips {
> +				cpu_alert5: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit5: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu6-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 9>;
> +
> +			trips {
> +				cpu_alert6: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit6: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu7-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens0 10>;
> +
> +			trips {
> +				cpu_alert7: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu_crit7: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
>  };
