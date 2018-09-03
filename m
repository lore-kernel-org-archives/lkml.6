Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F897C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F5320867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GEEHVdmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F5320867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbeICXuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:50:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43099 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbeICXuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:50:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id v66-v6so521007pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 12:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2/qsvH0oXFgxZEt797+uggEFzw0gritaZMBp5X1wL3M=;
        b=GEEHVdmp9dHkDNySG5y62wh3YEuvQYfiFc6lnpM9S0W8d85qSSJGjA+aPxWEc4fhrS
         kXheZ+2d+ESDJOMKsCtkiMRzsX8SqCnrNc42CYitpHvwm3DBoIruHwV6XQPNF4a7HSZZ
         YaHKtzajjue+w6AT43EiOeJnWauKdCT7tcPsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2/qsvH0oXFgxZEt797+uggEFzw0gritaZMBp5X1wL3M=;
        b=CM2JSZ4MFU8gXMx3dhPFhK0awYD6VECKrdzvnCoWbhwNyX/G94OhMOJ0i4NA3mQ8sF
         knLUHPFZpxlMK0WERjBvRg3r9ztThUYDj3bc/NfW1L3NrDlZJXrLNBL7wEt4RqxEzTNu
         mZvnlqPMk/FdYpS+kIIiRh9HE01H4tL5998wiGbRptBrLK78KGv5uxtksCFQly03cUyE
         mZMry7W653sYs0pR0x8fsNBadbMHmM6v9q0ym4k7tGO0Tem2MREXZJ/UZJMae45uyQGE
         slIWm3dAf/oT+843cP1nVf1nmqD6d/5jMwy5wbezlCTYJS5YSlc5p6JB2yqB/uzTHNR3
         IxcQ==
X-Gm-Message-State: APzg51A5H1Bh8WkOuNGf5EL9n4dBXrX4Hn/Pq+QPGzoO+Bz8f0PZt1P6
        SEhbM+f51bfyV58kdtlJQSB3R/eJgAo=
X-Google-Smtp-Source: ANB0VdYW/vxVcHJ4VaFXXy7rpl2JVXcjNxmWHwDkGPPdZZppN4+Sa0xVBhvfwHP7K16hROrLQdruUQ==
X-Received: by 2002:a63:e841:: with SMTP id a1-v6mr12962235pgk.126.1536002915186;
        Mon, 03 Sep 2018 12:28:35 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 193-v6sm11302848pgh.47.2018.09.03.12.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 12:28:34 -0700 (PDT)
Date:   Mon, 3 Sep 2018 12:32:28 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     p.zabel@pengutronix.de, mka@chromium.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH v3 3/6] dt-bindings: remoteproc: qcom: Remove additional
 definition tag
Message-ID: <20180903193228.GI3456@tuxbook-pro>
References: <20180829191215.10071-1-sibis@codeaurora.org>
 <20180829191215.10071-4-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829191215.10071-4-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29 Aug 12:12 PDT 2018, Sibi Sankar wrote:

> Remove the additional definition tag declared for WCSS sub-system
> under reset-names.
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> index 601dd9f389aa..3a66cde5895a 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> @@ -58,8 +58,8 @@ on the Qualcomm Hexagon core.
>  	Usage: required
>  	Value type: <stringlist>
>  	Definition: must be "mss_restart" for the modem sub-system
> -	Definition: must be "wcss_aon_reset", "wcss_reset", "wcss_q6_reset"
> -		    for the wcss syb-system
> +		    must be "wcss_aon_reset", "wcss_reset", "wcss_q6_reset"
> +		    for the wcss sub-system
>  
>  - cx-supply:
>  - mss-supply:
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
