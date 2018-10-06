Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AD5C64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 06:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603122086D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 06:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6R7EhW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603122086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeJFNyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 09:54:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39350 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbeJFNyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 09:54:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id r9-v6so5645895pgv.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 23:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6TkP8MWEbWtffRGPSJ89iTo+cuEsEYSiil3uBhZLSuE=;
        b=T6R7EhW7V+g22+wo49Gi67WRQn/HZNh6GkVaKf9ncwacA0N244eXFWsDDecJ6cNA7M
         /6SBv4lINzrIHaAKlodfJHQ0IOyg2KLdx6DrGXyReKCy/hUXqV1lXS9PJgsYTISe/Rvd
         6uDgnEqIb22J0E0ZXBcIXz6crtMIVCTFomjrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6TkP8MWEbWtffRGPSJ89iTo+cuEsEYSiil3uBhZLSuE=;
        b=Bfa17xUL7DggUCgg0pfk5cYaljbTDCNnr15yrDklvQ7dR0bv4N1dIdzmH9vqKcWnZL
         ZXyqDp36nNVJDpn+tuhSjM9wr3U6mwfVMKnmL3r3IucGoIu/crvZGkiUbuMsFTR3umhv
         tUnx3erx7h9xT2rNZU6eH+vcUEZVJecDqx6Z78NnJ/b7x+uebrTv4j0yhcdwyVgWQgys
         n4uzkA+fZCchAOxm25pXlMcnGFCACQTPbEgkf0k8x32mFgkWIhfXI6/aP+CeZ2/4t0kj
         fqhQ/50zKtJrUjwV4Q+kF3j1wpepUpaF+JtMcftsrEJZcDCc+6UknnamB4+b036qS/r2
         x+VQ==
X-Gm-Message-State: ABuFfoiXRLecsTosBQIuUmieEIvY4b78wA3DgVuFVPrrjdk5M5d/MhEQ
        o0y/6ysiKn3wyIMvidL+Ob4j9w==
X-Google-Smtp-Source: ACcGV62jOqHJCOmgqydkFHhgSNdIoa7lDK2qbomoluMnRi/v6E2Yt2wmXA17KQSrXl20F2JNryn4pQ==
X-Received: by 2002:a62:fc13:: with SMTP id e19-v6mr15389211pfh.101.1538808743405;
        Fri, 05 Oct 2018 23:52:23 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v83-v6sm19956154pfa.103.2018.10.05.23.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 23:52:22 -0700 (PDT)
Date:   Fri, 5 Oct 2018 23:55:08 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     ohad@wizery.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com
Subject: Re: [PATCH v4] dt-binding: remoteproc: Add QTI ADSP PIL bindings
Message-ID: <20181006065508.GK12063@builder>
References: <1536638041-11033-1-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536638041-11033-1-git-send-email-rohitkr@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10 Sep 20:54 PDT 2018, Rohit kumar wrote:
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt b/Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt
[..]
> += EXAMPLE
> +The following example describes the resources needed to boot control the
> +ADSP, as it is found on SDM845 boards.
> +	adsp-pil {

Updated this to remoteproc@17300000 and applied the patch to rproc-next.

Regards,
Bjorn

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
