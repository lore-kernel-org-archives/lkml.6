Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEB5C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBC920867
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DAlVArFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBC920867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeH1E1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 00:27:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39546 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeH1E1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 00:27:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id w14-v6so347442plp.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 17:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s1Kcn2RxgQBav06NVFJwHLmOaM70bf01iu5qIC0YZPs=;
        b=DAlVArFJDqD8OuTVLo17hJvpssxa/8lYZuYScgZb/V/EHT/Ft0/oIJlg3nu24U27or
         5lK/VfR+zSQ1FiZkTTENLx6GP/XWmoVDTPdNnGEjWCOpbi4mb1hN3YvGUr+g/JyDb/8f
         ijlm339XXMsCKiL3D3HkGPSpzF+A+x71/u+B8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s1Kcn2RxgQBav06NVFJwHLmOaM70bf01iu5qIC0YZPs=;
        b=bQ7dHLPbbfAWEtNKHRpAZDE03PmG1gJTNg9DhdKSozmqqx+gLFZ4hVe8z8mtZU/f77
         1T0obhNLnwWG8ongl83VUpjVV/1KtOdIThfqqcLVDpfmKue+rOskEGUOWaKa09kphB/u
         ++qb48MfT1be2ppd7EWhc2/aL2SdcSi6qAHvzrVLw+GbkaytyaMHVrSkz6zhcNqpdiSt
         Fb5b7k5DEzV6ETIJGbesFzsbnIfh2K9aEV2ocfJrhSM91Qg5kB5lng2JLxyxrtud/PqA
         7U5swDT+mhGfiHgREFMl331SNtrFL221BHaAQQ/PEVF7AWAImb4VXcy0t69w24HTjdEz
         Gl7w==
X-Gm-Message-State: APzg51BdR7vZNiUinPsEyG6T+4E1c6ybE4GG92eRU3Cap5hPDnAqfneK
        50MzTMVtJBWLTZ3UMdw2/qx5aQ==
X-Google-Smtp-Source: ANB0VdZFs0jk3dnIssZvCUsL9y55TXfTJNYNyEki5WumKMP2I5pS9deDcPlhhQfyLlgWzGLmwlN0Sw==
X-Received: by 2002:a17:902:6115:: with SMTP id t21-v6mr15300668plj.92.1535416704337;
        Mon, 27 Aug 2018 17:38:24 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id l127-v6sm516690pfc.55.2018.08.27.17.38.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 17:38:23 -0700 (PDT)
Date:   Mon, 27 Aug 2018 17:38:23 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        ohad@wizery.com, mark.rutland@arm.com, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH v2 1/6] dt-bindings: reset: Add PDC Global binding for
 SDM845 SoCs
Message-ID: <20180828003823.GY160295@google.com>
References: <20180824131900.5353-1-sibis@codeaurora.org>
 <20180824131900.5353-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180824131900.5353-2-sibis@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

On Fri, Aug 24, 2018 at 06:48:55PM +0530, Sibi Sankar wrote:
> Add PDC Global(Power Domain Controller) binding for SDM845 SoCs.

nit: missing blank before the opening parenthesis.

> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  .../bindings/reset/qcom,pdc-global.txt        | 52 +++++++++++++++++++
>  include/dt-bindings/reset/qcom,sdm845-pdc.h   | 20 +++++++
>  2 files changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/qcom,pdc-global.txt
>  create mode 100644 include/dt-bindings/reset/qcom,sdm845-pdc.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/qcom,pdc-global.txt b/Documentation/devicetree/bindings/reset/qcom,pdc-global.txt
> new file mode 100644
> index 000000000000..69f9edca9503
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/qcom,pdc-global.txt
> @@ -0,0 +1,52 @@
> +PDC Global
> +======================================
> +
> +This binding describes a reset-controller found on PDC-Global(Power Domain
> +Controller) block for Qualcomm Technologies Inc SDM845 SoCs.

Are there other PDC reset controllers that aren't 'global'? Otherwise
I'd suggest to use 'pdc-reset' instead of 'pdc-global', which is more
specific and in line with the name of the driver added by this series.
Or something like 'pdc-reset-global/main' if there are other
controllers?

> +Required properties:
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be:
> +		    "qcom,sdm845-pdc-global"
> +
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: must specify the base address and size of the register
> +	            space.
> +
> +- #reset-cells:
> +	Usage: required
> +	Value type: <uint>
> +	Definition: must be 1; cell entry represents the reset index.
> +
> +Example:
> +
> +pdc_reset: reset-controller@b2e0000 {
> +	compatible = "qcom,sdm845-pdc-global";
> +	reg = <0xb2e0000 0x20000>;
> +	#reset-cells = <1>;
> +};
> +
> +PDC reset clients
> +======================================
> +
> +Device nodes that need access to reset lines should
> +specify them as a reset phandle in their corresponding node as
> +specified in reset.txt.
> +
> +For list of all valid reset indicies see

s/indicies/indices/ (or s/indicies/lines/ ?)

Cheers

Matthias
