Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3EFEBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4852086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L5gthDtT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4852086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932941AbeFLFj6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:39:58 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40379 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753943AbeFLFj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:39:56 -0400
Received: by mail-pf0-f195.google.com with SMTP id z24-v6so11480330pfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 22:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rT7/2cQm+XgPbqD4s2gQ3emxw6lyO4aTylJUGXMzl78=;
        b=L5gthDtTqAoqrgmImfzIVVtCol1IuAPrQeehbXfasTLcgC5ChxcTm0YB3HxvsJR1RB
         batmpqrtPsvgREmYRtPX7thr+ahZsYLbIqtXd6F62wWckcKaW+VrB++lk3AZ6EO/PeZ3
         2GyFwUtk0oMWuAXJhXpqiG3Tffe3wD3UVeQv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rT7/2cQm+XgPbqD4s2gQ3emxw6lyO4aTylJUGXMzl78=;
        b=SYWAV36JLo2X0FgJSSp11cSsgBbsKD7x32vnKGygsAjYvy4esyF1S5IWF8fg4ICptv
         Mi8yRRAJkKNMgEQEfNJQxsujcHtNOD09GNr1N8HYyb4BjtTOSg9Bm8p5eH1J4Ab5NmbD
         M046kULgwQjjp6W84s5TqGbL5B7jI5YIogNKAqnf2Bv4DavmvoSoMWplM1mO7Q1FPQSR
         qybgr3nZpELZ6T1RgqQm1TbVj39NrmIZj/2p17j7Y35tMdlB0LTBdAT8CpU1HZUBMAAx
         L05mTREY1DEHUjLZz1+pkLljrNxY+TPLZ4275jYbJvfaDlgNB6LHnl6rXXC796RorpSs
         cMwg==
X-Gm-Message-State: APt69E3lDJHZ3pzVKJVooDStIoJ0mpaYrkfjVHnaCWaPbYeiTF5Qg6O9
        1DqbxKqhXOkx+Y8PM7wpkop+1w==
X-Google-Smtp-Source: ADUXVKLzt5AdgPiw1llsyCCIoVo+MPuKIjgqCO6OvekmzhsmQ7ZxZ2HJ0gHdnsn0lyfniyPevzLEYA==
X-Received: by 2002:a62:3ad8:: with SMTP id v85-v6mr2329652pfj.184.1528781996155;
        Mon, 11 Jun 2018 22:39:56 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l26-v6sm120505pgn.55.2018.06.11.22.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 22:39:55 -0700 (PDT)
Date:   Mon, 11 Jun 2018 22:39:53 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] dt-bindings: power: Add qcom rpmh power domain
 driver bindings
Message-ID: <20180612053953.GA18050@builder>
References: <20180612044052.4402-1-rnayak@codeaurora.org>
 <20180612044052.4402-6-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612044052.4402-6-rnayak@codeaurora.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11 Jun 21:40 PDT 2018, Rajendra Nayak wrote:

> Add DT bindings to describe the rpmh powerdomains found on Qualcomm
> Technologies, Inc. SoCs. These power domains communicate a performance
> state to RPMh, which then translates it into corresponding voltage on
> a PMIC rail.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  .../devicetree/bindings/power/qcom,rpmhpd.txt | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmhpd.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmhpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmhpd.txt
> new file mode 100644
> index 000000000000..41ef7afa6b24
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmhpd.txt
> @@ -0,0 +1,65 @@
> +Qualcomm RPMh Power domains
> +
> +For RPMh Power domains, we communicate a performance state to RPMh
> +which then translates it into a corresponding voltage on a rail
> +
> +Required Properties:
> + - compatible: Should be one of the following
> +	* qcom,sdm845-rpmhpd: RPMh Power domain for the sdm845 family of SoC

Afaict this binding is identical to the one introduced in patch 1, so I
would suggest that you just add the compatible there.

Regards,
Bjorn

> + - power-domain-cells: number of cells in power domain specifier
> +	must be 1
> + - operating-points-v2: Phandle to the OPP table for the power-domain.
> +	Refer to Documentation/devicetree/bindings/power/power_domain.txt
> +	and Documentation/devicetree/bindings/opp/qcom-opp.txt for more details
> +
> +Example:
> +
> +	rpmhpd: power-controller {
> +		compatible = "qcom,sdm845-rpmhpd";
> +		#power-domain-cells = <1>;
> +		operating-points-v2 = <&rpmhpd_opp_table>;
> +	};
> +
> +	rpmhpd_opp_table: opp-table {
> +		compatible = "operating-points-v2-qcom-level";
> +
> +		rpmhpd_opp_ret: opp1 {
> +			qcom-level = <16>;
> +		};
> +
> +		rpmhpd_opp_min_svs: opp2 {
> +			qcom-level = <48>;
> +		};
> +
> +		rpmhpd_opp_low_svs: opp3 {
> +			qcom-level = <64>;
> +		};
> +
> +		rpmhpd_opp_svs: opp4 {
> +			qcom-level = <128>;
> +		};
> +
> +		rpmhpd_opp_svs_l1: opp5 {
> +			qcom-level = <192>;
> +		};
> +
> +		rpmhpd_opp_nom: opp6 {
> +			qcom-level = <256>;
> +		};
> +
> +		rpmhpd_opp_nom_l1: opp7 {
> +			qcom-level = <320>;
> +		};
> +
> +		rpmhpd_opp_nom_l2: opp8 {
> +			qcom-level = <336>;
> +		};
> +
> +		rpmhpd_opp_turbo: opp9 {
> +			qcom-level = <384>;
> +		};
> +
> +		rpmhpd_opp_turbo_l1: opp10 {
> +			qcom-level = <416>;
> +		};
> +	};
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
