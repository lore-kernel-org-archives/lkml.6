Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC32C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EDF21479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aNgrI9KO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfACXvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 18:51:08 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45008 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfACXvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 18:51:08 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so17375464pfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 15:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=saMLBDa1yVhaDCuniObQZq2BWACV/iRztOiZRWNzN0E=;
        b=aNgrI9KO/0alhiKiQipDGrav+3Owzq3DY+M5iLrDItyglPHPg2Kpr7YDrxKhrekm1j
         nFbmK0oO8AN4IcEox1FG2zaa+FKl1T+ZTSdMZGbBHw0PEQdvbgHu82s8mQAlPSYxtEv2
         46XG574p4jGLkV3ERB57cODDgOkexvfFXO3CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=saMLBDa1yVhaDCuniObQZq2BWACV/iRztOiZRWNzN0E=;
        b=kOolEz4N7qWmVfb5KfJ96OVtf2+XMVTfoCF+LtmFtyaSAUOYJJz/pinaj4BwcT9uaK
         9naRzUL5cdRKSMrk1B/o1HQSKU73AY+C+CYAcOM3y5PqhPESgExwaQJiL1ot/WSbE3YI
         c0dMdmYZef9T3C8phPWX0wxjhCYto7DeeDiqWrAi7Sv1jbDfP1w3ybhAn815Bf6+mzrb
         so69ARemxGkCk35Jpp5HJ3HVckvCzt0mJmnwFxRyhgDYQKVoYwQNcruwO1Hbc8sZKl7e
         YLRZDXcWhQSxHyyyEIdZZfH0AtkS4jY+t4kglJPZDVBVPN2t0Ztsxc1OvZZr7cIBq5kl
         0T4A==
X-Gm-Message-State: AJcUukeNk3sh01lTWC5UejKL5xj4vCsdbLLAu+AUesHz/P7cblfeRmco
        vJfUWb/YaAljsRRVPJ479c+FZw==
X-Google-Smtp-Source: ALg8bN6dT/eY/ZhBlZIMU+kHzIdiNdrmzTaR6tP8Q/DFTXfQzbOThR1xJINEmhXqSxc21TwKfOy31A==
X-Received: by 2002:a63:c451:: with SMTP id m17mr18613708pgg.27.1546559467180;
        Thu, 03 Jan 2019 15:51:07 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n7sm100508362pff.36.2019.01.03.15.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 15:51:06 -0800 (PST)
Date:   Thu, 3 Jan 2019 15:50:02 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     dianders@chromium.org, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sdm845: Add Q6V5 ADSP node
Message-ID: <20190103235002.GI31596@builder>
References: <1545313174-13481-1-git-send-email-rohitkr@codeaurora.org>
 <1545313174-13481-3-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545313174-13481-3-git-send-email-rohitkr@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 20 Dec 05:39 PST 2018, Rohit kumar wrote:

> This patch adds Q6V5 ADSP remoteproc node for SDM845 SoCs.
> 

Thanks Rohit, nice to see these things on the list!

> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 96 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 95 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index c0a012f..dfeb3cf 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -13,6 +13,9 @@
>  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> +#include <dt-bindings/soc/qcom,apr.h>
> +#include <dt-bindings/sound/qcom,q6afe.h>
> +#include <dt-bindings/sound/qcom,q6asm.h>
>  
>  / {
>  	interrupt-parent = <&intc>;
> @@ -1691,7 +1694,98 @@
>  				status = "disabled";
>  			};
>  		};
> -	};
> +
> +		adsp_pil: remoteproc@17300000 {

Please sort nodes by address, then name.

> +			compatible = "qcom,sdm845-adsp-pil";
> +
> +			reg = <0x17300000 0x410>;
> +			reg-names = "qdsp6ss";

reg-names was dropped from the binding (iirc), please omit it here.

> +
> +			interrupts-extended = <&intc 0 162 IRQ_TYPE_EDGE_RISING>,

s/0/GIC_SPI/

> +				<&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +				<&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +				<&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +				<&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "wdog", "fatal", "ready",
> +					  "handover", "stop-ack";
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_LPASS_SWAY_CLK>,
> +				 <&lpasscc LPASS_Q6SS_AHBS_AON_CLK>,
> +				 <&lpasscc LPASS_Q6SS_AHBM_AON_CLK>,
> +				 <&lpasscc LPASS_QDSP6SS_XO_CLK>,
> +				 <&lpasscc LPASS_QDSP6SS_SLEEP_CLK>,
> +				 <&lpasscc LPASS_QDSP6SS_CORE_CLK>;
> +
> +			clock-names = "xo", "sway_cbcr", "lpass_ahbs_aon_cbcr",
> +				      "lpass_ahbm_aon_cbcr", "qdsp6ss_xo",
> +				      "qdsp6ss_sleep", "qdsp6ss_core";
> +
> +			resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
> +				 <&aoss_reset AOSS_CC_LPASS_RESTART>;
> +			reset-names = "pdc_sync", "cc_lpass";
> +
> +			qcom,halt-regs = <&tcsr_mutex_regs 0x22000>;
> +
> +			memory-region = <&pil_adsp_mem>;
> +
> +			qcom,smem-states = <&adsp_smp2p_out 0>;
> +			qcom,smem-state-names = "stop";
> +
> +			glink-edge {

So we will end up duplicating these between the PAS based and non-PAS
based remoteprocs. I don't have a better idea right now, but this
deserves some thought.

> +				compatible = "qcom,glink-smem";
> +				interrupts = <0 156 IRQ_TYPE_EDGE_RISING>;

s/0/GIC_SPI/

> +
> +				label = "lpass";
> +				qcom,remote-pid = <2>;
> +				mboxes = <&apss_shared 8>;
> +				mbox-names = "adsp_smem";

mbox-names is not a documented property, please omit it.

> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				apr@4 {
> +					compatible = "qcom,apr-v2";
> +					qcom,glink-channels = "apr_audio_svc";
> +					reg = <APR_DOMAIN_ADSP>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					q6core {
> +						compatible = "qcom,q6core";
> +						reg = <APR_SVC_ADSP_CORE>;
> +					};
> +
> +					q6afe {
> +						compatible = "qcom,q6afe";
> +						reg = <APR_SVC_AFE>;
> +						q6afedai: afedais {
> +							compatible = "qcom,q6afe-dais";
> +							#sound-dai-cells = <1>;
> +							#address-cells = <1>;
> +							#size-cells = <0>;
> +						};
> +					};
> +
> +					q6asm {
> +						compatible = "qcom,q6asm";
> +						reg = <APR_SVC_ASM>;
> +						q6asmdai: asmdai{
> +							compatible = "qcom,q6asm-dais";
> +							iommus = <&apps_smmu 0x1821 0x0>;
> +							#sound-dai-cells = <1>;
> +						};
> +					};
> +
> +					q6adm {
> +						compatible = "qcom,q6adm";
> +						reg = <APR_SVC_ADM>;
> +						q6routing: routing {
> +							compatible = "qcom,q6adm-routing";
> +							#sound-dai-cells = <0>;
> +						};
> +					};
> +				};
> +			};
> +			status = "disabled";

Properties must come before subnodes.

> +		};

Regards,
Bjorn
