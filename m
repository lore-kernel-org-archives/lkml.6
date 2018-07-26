Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FC7C67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAB820852
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fqqqdR+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EAB820852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbeGZCBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 22:01:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37343 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbeGZCBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 22:01:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id a26-v6so2231192pfo.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 17:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MVeVbkz7IGjEUXcHilxrrnOfv/B43lnO1i4xDDqNktY=;
        b=fqqqdR+/CPYgYgxb1tApM1p+YzJY1EVNfMRt2ZfYArlyG0b6T4cIyrN0QqHf2LX72s
         3B5aMM7y216Awjec1aZVrPjrp/GzNv/g9bKzKxiKW963PJWQko4OltToxenbw09qfLU5
         opTvjjyWtaCucJ+12/+IvDjViCYuDgw3Eug4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MVeVbkz7IGjEUXcHilxrrnOfv/B43lnO1i4xDDqNktY=;
        b=F1qEBRge5591inVQfLmtVXPWGEzXjoiGX5E/HEBbOIjch9bW+8ae87ksmqZlYtbsvV
         H9PK87bTtTVi10XO+THZ5BPjBfkfivD14Rj3Q1k3YscBtcGOsh2BL9GtsxNFytIPJYEM
         aYSMV7kS3zdW+M/52OVvBIJXNg5zL4xd+bmnfIRVVVSz34z9SjUzBz/dmnrSPT435hHg
         sZdC1CDsWMED/gxW0g+oR/1dt3bMnzmPYk+rzOcbpgswVfnScAHotthMl7htIZPz8ZEw
         u16sDr9MZamLmBsX90/mtbDf0XQaoDh5DTf4He4c3AanXlaCCJgEiWJ1h9oYlTpUHaVM
         Re+Q==
X-Gm-Message-State: AOUpUlFR5OTnK2rAkVvHRlIWDHIDB8tPGPhE2UP6jjnbe+tL46t9rf3U
        PWnouBsjdccqoT5/7jU+bq8JxA==
X-Google-Smtp-Source: AAOMgpeEJyXJxMW1fkSmrKQg26qrsJRpkzvfsG+HX1Onq8wmnE/9XcZkPKJgUgYGKpmPUgF2S6URQw==
X-Received: by 2002:a63:4002:: with SMTP id n2-v6mr22163095pga.285.1532566059513;
        Wed, 25 Jul 2018 17:47:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id o4-v6sm15171263pgq.16.2018.07.25.17.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 17:47:38 -0700 (PDT)
Date:   Wed, 25 Jul 2018 17:47:38 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        andy.gross@linaro.org, dianders@chromium.org, edubezval@gmail.com,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] arm64: dts: sdm845: enable tsens thermal zones
Message-ID: <20180726004738.GU129942@google.com>
References: <cover.1531899325.git.amit.kucheria@linaro.org>
 <b3c25cedfa3a9b8a4b481e714992afe62b84ca3b.1531899325.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b3c25cedfa3a9b8a4b481e714992afe62b84ca3b.1531899325.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On Wed, Jul 18, 2018 at 01:19:17PM +0530, Amit Kucheria wrote:
> One thermal zone per cpu is defined
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 170 +++++++++++++++++++++++++++++++++++
>  1 file changed, 170 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 01ff146..a75be7c 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -340,4 +340,174 @@
>  			};
>  		};
>  	};
> +
> +	thermal-zones {
> +		cpu0-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;

In the context of the TSENS patches you mentioned that you are working
on interrupt support. Can the polling delays be removed once that is merged?

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

Dumb DT question: the trip information is the same for all CPUs. Would
it be possible to have a single node and refer to it with a phandle?

I suppose the anwer is no and even if it was possible we probably
wouldn't want it, since it would complicate overriding settings for a
specific CPU (should that ever be needed ...) or cluster. Just wondering.

> +		};
> +	};
>  };

I don't have documentation to verify that the sensors and CPUs match,
but it is in line with what I've seen in some Android tree, so it
seems alright ;-)

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
