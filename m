Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84641C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8022086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LoALxVrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8022086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeIJXXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:23:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36778 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIJXXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:23:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so10900701pfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 11:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UFOS6gF331GD/ZxFCdtctx81v9bzaieZUgMkkoYWF0U=;
        b=LoALxVrRC/+tqB+eEHgkG8inNt9ghIIzxeQJ9jq1ihnYPAngIL00skjfQokSu1G8qF
         fY2wznhZMzBbzm0Uslwwrf9Cckkbm6krpMyxla4XTTURcjksd3p78QSfxb4x4I6lY5vR
         X9upKmkhQUINxo8hghcq1Up7NeHsXKbVSXmhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UFOS6gF331GD/ZxFCdtctx81v9bzaieZUgMkkoYWF0U=;
        b=MbzPANz5YSqNF6WSKLECVhEQykpxLdHYSRbeEiMI8v5Ib8jrZm1ABLnL3r8ankiwaA
         L888zEVDSw82bCmTCVBDwVE3T+tqnQmlwd8AeP6RIsqRAjtoyj4lZg9fIVQhzcixKTzI
         oEX3KaC0SkWfcjIhQEMq+JJOHGkeoAeAH/CJO+wnTSm5APSduX+mJ1s6HCqJRFBKEaVJ
         DOmJmCCkcGn0WEDwvzU10bBUM1bMWCczUGgPKjcBl5hUhV5LpT2P8jKS8PIPbUY5FUJe
         g25Mx562dlnVG5tBdhrtoKcLrFEIxFFnntyi56KvWpU5aMfuZQFRfZ/DLsAyJ8sctwDb
         qt8w==
X-Gm-Message-State: APzg51AR27bBLDBPME6oIEAbox7NhMdkAGkB5q60/7nx5k/VO/DxQw57
        V02WlkG6WEnZiCTlOz77mqB5Ag==
X-Google-Smtp-Source: ANB0VdYER0RqSqkvbhRmlchenL8XrvNkQU359gIj7HLm1AdA8LA1bC6GY8Y+WKatXUgZiysXgZkUCg==
X-Received: by 2002:a62:1089:: with SMTP id 9-v6mr25252078pfq.30.1536604074912;
        Mon, 10 Sep 2018 11:27:54 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g15-v6sm41016711pfg.98.2018.09.10.11.27.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 11:27:54 -0700 (PDT)
Date:   Mon, 10 Sep 2018 11:27:52 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     ohad@wizery.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org
Subject: Re: [PATCH v3 1/2] dt-binding: remoteproc: Add QTI ADSP PIL bindings
Message-ID: <20180910182752.GD2523@minitux>
References: <1535975560-8200-1-git-send-email-rohitkr@codeaurora.org>
 <1535975560-8200-2-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535975560-8200-2-git-send-email-rohitkr@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 03 Sep 04:52 PDT 2018, Rohit kumar wrote:

> Add devicetree bindings documentation file for Qualcomm
> Technolgies Inc ADSP Peripheral Image Loader.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>

Rob, this revision looks good to me and I would like to move ahead and
merge it.

Regards,
Bjorn

> ---
>  .../bindings/remoteproc/qcom,adsp-pil.txt          | 123 +++++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt b/Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt
> new file mode 100644
> index 0000000..f1c215a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt
> @@ -0,0 +1,123 @@
> +Qualcomm Technology Inc. ADSP Peripheral Image Loader
> +
> +This document defines the binding for a component that loads and boots firmware
> +on the Qualcomm Technology Inc. ADSP Hexagon core.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be one of:
> +		    "qcom,sdm845-adsp-pil"
> +
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: must specify the base address and size of the qdsp6ss register
> +
> +- interrupts-extended:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: must list the watchdog, fatal IRQs ready, handover and
> +		    stop-ack IRQs
> +
> +- interrupt-names:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "wdog", "fatal", "ready", "handover", "stop-ack"
> +
> +- clocks:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition:  List of phandle and clock specifier pairs
> +
> +- clock-names:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: List of clock input name strings sorted in the same
> +				order as the clocks property.
> +
> +- power-domains:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: reference to cx power domain node.
> +
> +- resets:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: reference to the reset-controller for the lpass
> +
> +- reset-names:
> +        Usage: required
> +        Value type: <stringlist>
> +        Definition: must be "pdc_sync" and "cc_lpass"
> +
> +- qcom,halt-regs:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: a phandle reference to a syscon representing TCSR followed
> +			by the offset within syscon for lpass halt register.
> +
> +- memory-region:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: reference to the reserved-memory for the ADSP
> +
> +- qcom,smem-states:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: reference to the smem state for requesting the ADSP to
> +		    shut down
> +
> +- qcom,smem-state-names:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "stop"
> +
> +
> += SUBNODES
> +The adsp node may have an subnode named "glink-edge" that describes the
> +communication edge, channels and devices related to the ADSP.
> +See ../soc/qcom/qcom,glink.txt for details on how to describe these.
> +
> += EXAMPLE
> +The following example describes the resources needed to boot control the
> +ADSP, as it is found on SDM845 boards.
> +	adsp-pil {
> +		compatible = "qcom,sdm845-adsp-pil";
> +
> +		reg = <0x17300000 0x40c>;
> +
> +		interrupts-extended = <&intc 0 162 IRQ_TYPE_EDGE_RISING>,
> +			<&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +			<&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +			<&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +			<&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-names = "wdog", "fatal", "ready",
> +			"handover", "stop-ack";
> +
> +		clocks = <&rpmhcc RPMH_CXO_CLK>,
> +			<&gcc GCC_LPASS_SWAY_CLK>,
> +			<&lpasscc LPASS_AUDIO_WRAPPER_AON_CLK>,
> +			<&lpasscc LPASS_Q6SS_AHBS_AON_CLK>,
> +			<&lpasscc LPASS_Q6SS_AHBM_AON_CLK>,
> +			<&lpasscc LPASS_QDSP6SS_XO_CLK>,
> +			<&lpasscc LPASS_QDSP6SS_SLEEP_CLK>,
> +			<&lpasscc LPASS_QDSP6SS_CORE_CLK>;
> +		clock-names = "xo", "sway_cbcr", "lpass_aon",
> +			"lpass_ahbs_aon_cbcr",
> +			"lpass_ahbm_aon_cbcr", "qdsp6ss_xo",
> +			"qdsp6ss_sleep", "qdsp6ss_core";
> +
> +		power-domains = <&rpmhpd SDM845_CX>;
> +
> +		resets = <&pdc_reset PDC_AUDIO_SYNC_RESET>,
> +			 <&aoss_reset AOSS_CC_LPASS_RESTART>;
> +		reset-names = "pdc_sync", "cc_lpass";
> +
> +		qcom,halt-regs = <&tcsr_mutex_regs 0x22000>;
> +
> +		memory-region = <&pil_adsp_mem>;
> +
> +		qcom,smem-states = <&adsp_smp2p_out 0>;
> +		qcom,smem-state-names = "stop";
> +	};
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
> is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
