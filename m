Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CC4C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8AD20C01
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XuH2Jl/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8AD20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeHVBzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 21:55:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37951 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeHVBzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 21:55:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so9177165pfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 15:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qVeehcspRqsI/EgNEMmGs6zu+N6L5Fx86J56pcGpSdc=;
        b=XuH2Jl/Com/Q6yJ1X/1XtUhco4H3nNO1K8zLDDycjm+fXoeE1dV/5YjUaY0TbakGSr
         TkcdC4Iy4grqDWLxGfgzisj1gByZm8AvxdxuAyLpNafhpQFvMBfHylo2SeTZkp8o1b+C
         /jic2n7LSCezzknp9K7mLIKSKR15HQcgPLvE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qVeehcspRqsI/EgNEMmGs6zu+N6L5Fx86J56pcGpSdc=;
        b=oRYM9vngXOGdxFEHGRuRcuFCyCmkHk2MyFoKeqFQcybuy6A0b3YKpNp0mXt2u2lud7
         tPyeo/GPuVIzxVhtSmQAnH5rQd8Kv2tREfo9o9izf/SRy0PMkt4ZhDy5RYMk8Ussheq7
         mVqdmDfMjqtHQGILSmYltKywVyD7UToX62rSVC4y1xQSQcGysZP1OPiDXgFcEwtHYKiu
         bm3Lchs6l30YOqWzke1zSHCnhYZQqoukfKkjy+ul7/skDymm8PGT/e6VmEHTW+0WtiIA
         IF8ZEp00HcqqeyGaYJQdy6tRjWLQK1xMjtYReVcb9G5AAtJmaO5msWCQ+E/4jAzN2B39
         fM2g==
X-Gm-Message-State: AOUpUlEgu8CBcdaO2jUqNUvtr2U89EStpjnfA4DweZo0XR3sXTuOlEUz
        HC3NBS/b0ZhS0PlWxyCmcv3bDw==
X-Google-Smtp-Source: AA+uWPwskAimvdJ8uFFw0C8ZgUZFXbGKL6yhhrE149V5PGiCfaTWiAjpqmh2ijyyR1qj5KhEHEejhQ==
X-Received: by 2002:a62:13ca:: with SMTP id 71-v6mr55092681pft.34.1534890822568;
        Tue, 21 Aug 2018 15:33:42 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t9-v6sm13706482pgi.87.2018.08.21.15.33.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 15:33:41 -0700 (PDT)
Date:   Tue, 21 Aug 2018 15:33:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ohad@wizery.com, mark.rutland@arm.com,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Subject: Re: [PATCH 4/4] remoteproc: qcom: q6v5-pil: Add PDC restart for
 modem on SDM845 SoCs
Message-ID: <20180821223339.GA2523@minitux>
References: <20180727152811.15258-1-sibis@codeaurora.org>
 <20180727152811.15258-4-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727152811.15258-4-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 27 Jul 08:28 PDT 2018, Sibi Sankar wrote:

> In the presence of a PDC block working with subsystem RSC,
> assert/deassert PDC restart in modem start/stop path.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  .../bindings/remoteproc/qcom,q6v5.txt         |  4 +++
>  drivers/remoteproc/qcom_q6v5_pil.c            | 27 ++++++++++++++++---
>  2 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> index 601dd9f389aa..124fb1dc6fb8 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> @@ -51,6 +51,8 @@ on the Qualcomm Hexagon core.
>  	Usage: required
>  	Value type: <phandle>
>  	Definition: reference to the reset-controller for the modem sub-system
> +		    reference to the list of 2 reset-controllers for the modem
> +		    sub-system on SDM845 SoCs
>  		    reference to the list of 3 reset-controllers for the
>  		    wcss sub-system
>  
> @@ -58,6 +60,8 @@ on the Qualcomm Hexagon core.
>  	Usage: required
>  	Value type: <stringlist>
>  	Definition: must be "mss_restart" for the modem sub-system
> +	Definition: must be "mss_restart", "pdc_restart" for the modem
> +		    sub-system on SDM845 SoCs
>  	Definition: must be "wcss_aon_reset", "wcss_reset", "wcss_q6_reset"
>  		    for the wcss syb-system

Seems like we got an additional "Definition:" added here as we added the
wcss. Please don't add another one.

The rest looks good.

Regards,
Bjorn
