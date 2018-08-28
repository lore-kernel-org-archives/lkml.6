Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61486C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B0520880
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XonmVABv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B0520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeH1EWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 00:22:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39310 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbeH1EWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 00:22:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so357648pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 17:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=79ZfBSXkQtImARBwKHoiptRIWNNaJKd5xUCLr0/g9OE=;
        b=XonmVABv9HAlK90XdnrXtEq9cQ0YYfxK0UBYttoBqJfmc72SQOYFECH6EiTO+NDNJi
         /JZfFSem0aNkjetJ/Mmb/esbmAJpLLyRsjsqjLaCz8uM0m7K70UDsStFwAY8gkiHe3nn
         J2tBaGDhFvTOL7CQf7d3Snlx4fFu7U3khPgWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=79ZfBSXkQtImARBwKHoiptRIWNNaJKd5xUCLr0/g9OE=;
        b=gMhfNNg6CnQoQPt8dApL7xtBm7VfdHFZr+AtZ99npEx/2+zT5YresW+tgoyFY2SSQG
         ajsZJjJcC/lgNtxzSexyv/XSy2aa1INRgEKDED7pshqGQ/lK7IhTMdZ24DrZ/CWU8apU
         ieGoCZwxsCu6nhqkkcvMNy69EByNTi9eopfuW2e81L5Rgvv36QV667RJG5NpGwvRWID2
         UdNPcIM+uJq3YBOHCoUgGpZra0yBxENJM8Uvvmvgtq4ORvkVXJKGYHrG6w2kmekXyuVp
         GJS572R7ux99KDAzTQjKQ1/WxgKdK50PVuJoi4auoA8eDKDu5KJ+I/62oHum7QabtBxM
         8pTA==
X-Gm-Message-State: APzg51AGmj4fOfJOPcd2uDh+BIj4gXMZdvhn1UpVD/oTzIo8J6oRqLvY
        dHEiDxGkIwCDL1DeGYYuyUbT4Q==
X-Google-Smtp-Source: ANB0VdZvhO9eGK9vGwn6UrL5nnLA3AuQvqTIH/3j6Vdmb6sRns2V6j7K5e6F5mGilly14PMiTrzD4g==
X-Received: by 2002:a65:5581:: with SMTP id j1-v6mr13900091pgs.203.1535416385140;
        Mon, 27 Aug 2018 17:33:05 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f186-v6sm418088pgc.4.2018.08.27.17.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 17:33:04 -0700 (PDT)
Date:   Mon, 27 Aug 2018 17:33:02 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ohad@wizery.com, mark.rutland@arm.com,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Subject: Re: [PATCH v2 1/6] dt-bindings: reset: Add PDC Global binding for
 SDM845 SoCs
Message-ID: <20180828003302.GE2523@minitux>
References: <20180824131900.5353-1-sibis@codeaurora.org>
 <20180824131900.5353-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824131900.5353-2-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 24 Aug 06:18 PDT 2018, Sibi Sankar wrote:

> Add PDC Global(Power Domain Controller) binding for SDM845 SoCs.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

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
> +
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
> +<dt-bindings/reset/qcom,sdm845-pdc.h>
> +
> +Example:
> +
> +modem-pil@4080000 {
> +	...
> +
> +	resets = <&pdc_reset PDC_MODEM_SYNC_RESET>;
> +	reset-names = "pdc_reset";
> +
> +	...
> +};
> diff --git a/include/dt-bindings/reset/qcom,sdm845-pdc.h b/include/dt-bindings/reset/qcom,sdm845-pdc.h
> new file mode 100644
> index 000000000000..53c37f9c319a
> --- /dev/null
> +++ b/include/dt-bindings/reset/qcom,sdm845-pdc.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_RESET_PDC_SDM_845_H
> +#define _DT_BINDINGS_RESET_PDC_SDM_845_H
> +
> +#define PDC_APPS_SYNC_RESET	0
> +#define PDC_SP_SYNC_RESET	1
> +#define PDC_AUDIO_SYNC_RESET	2
> +#define PDC_SENSORS_SYNC_RESET	3
> +#define PDC_AOP_SYNC_RESET	4
> +#define PDC_DEBUG_SYNC_RESET	5
> +#define PDC_GPU_SYNC_RESET	6
> +#define PDC_DISPLAY_SYNC_RESET	7
> +#define PDC_COMPUTE_SYNC_RESET	8
> +#define PDC_MODEM_SYNC_RESET	9
> +
> +#endif
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
