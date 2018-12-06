Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF9CC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C54220868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YkanS55L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C54220868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbeLFRAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:00:08 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35305 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeLFRAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:00:07 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so413607pgs.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 09:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4BnNI82cnQEBULbxdE9Ye6qxDd0TyOjoILEX5O2cSQM=;
        b=YkanS55LXYOfuyiA+wrk70C7P/rTrWnC7Dv5Utg//sfC//8hWctqgVE1bFrVbO//PC
         bt/czhPty6pZqffpFz/CzarBvckqAZ5YY2XByhQD25e/SzaYN9s5pMW86YpP1M2GBXVv
         ZXZgrQV2tJJDPJ0DrNHjVqrQXoL0k12HW+soE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4BnNI82cnQEBULbxdE9Ye6qxDd0TyOjoILEX5O2cSQM=;
        b=JMRQE9q8alPNGC4ui8hpRH+Iv+ibGE2O0qTqWnHlGMSvtXYALfrQfQE9y/2j/uw5DM
         TqC9FUgbbBEnMI4U/rq5DywRDPFwUlcac0+h1OIG5bMcNIPSJWzFwIaygQlzJQAmdUSg
         t66G4EPrN9wAxyJyM+mLphvrWIyoiL588ntRufBDqFanLBaibouhE9OnJZCWTLextAIv
         GRTX90neIJC0cqAMV4DpPUT9c+aYDuLHNBjs7jEWsNSzSTSHbYoHJX34h2YVzsh82Mo+
         QTtgcH6UMJVVEoHudWG2kYpNtG2hxzMWlpnMtA1KC8h+PJIw5pfyj5k3ndXFGlgMwH3k
         60Xg==
X-Gm-Message-State: AA+aEWbKQaoV5hcFIn7BatYb/YRBGC6LTfeRFXSNnusX4G5T5/XzNOC+
        41PH0H2tDYyMEZve7jnz+0aR4g==
X-Google-Smtp-Source: AFSGD/VemMwCKMrjnq8RdBw+S/potXyOlirgcqKJq/VPabIPCBG4nXQJkBeag08qtGq2Nhf/O4//ww==
X-Received: by 2002:a63:b30f:: with SMTP id i15mr24843384pgf.240.1544115606303;
        Thu, 06 Dec 2018 09:00:06 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t5sm1168815pfb.60.2018.12.06.09.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 09:00:05 -0800 (PST)
Date:   Thu, 6 Dec 2018 08:58:10 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     robh+dt@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        ohad@wizery.com, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: remoteproc: qcom: Add power-domain bindings
 for Q6V5
Message-ID: <20181206165810.GC31596@builder>
References: <20181120210828.12590-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120210828.12590-1-sibis@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 20 Nov 13:08 PST 2018, Sibi Sankar wrote:

> Add power-domain bindings for Q6V5 MSS on SDM845 SoCs.
> 

Thanks Sibi,

> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
> 
> Add dt-binding corresponding to https://patchwork.kernel.org/patch/10586893/
> (remoteproc: q6v5: Add support to vote for rpmh power domains)
> 
>  .../devicetree/bindings/remoteproc/qcom,q6v5.txt      | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> index 14947562bc67..bd9f4882fcf0 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> @@ -75,6 +75,17 @@ on the Qualcomm Hexagon core.
>  	Definition: reference to the regulators to be held on behalf of the
>  		    booting of the Hexagon core
>  
> +- power-domains:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: reference to the cx, mx and mss power-domains to be held on
> +		    behalf of the booting the Hexagon core

This should mention that these are the domains for SDM845, as the list
seems to differ somewhat between platforms. Please also define the
requirements for MSM8996 (cx & mx) here, while you're at it.

Let's also make sure it includes the "load_state", for SDM845.

Regards,
Bjorn

> +
> +- power-domain-names:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "cx", "mx", "mss"
> +
>  - qcom,smem-states:
>  	Usage: required
>  	Value type: <phandle>
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
