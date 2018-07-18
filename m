Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CAAECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D942075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W/6jGllS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D942075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbeGRAoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 20:44:24 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43370 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731035AbeGRAoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 20:44:23 -0400
Received: by mail-pl0-f67.google.com with SMTP id o7-v6so1157162plk.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 17:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AA82tWf76cM3Q3FAPV3s8WRWu3eAMkpzIrSrwsA8oQ4=;
        b=W/6jGllShl5PtV7zObceEdVx1/yOYb6USW+C+JgsozFiCOUrO46mrjiF8ghxFnwWOv
         c4oA4xbVYitaoPqjHk10GQ58M8HECAX9zQdS8Jqiiw0VLx4JXpMouGthBj23eBfCCyu4
         QZhz6X95HW3+ViEs+GDiJXYQeytOjnhafeMB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AA82tWf76cM3Q3FAPV3s8WRWu3eAMkpzIrSrwsA8oQ4=;
        b=aig5VaWb9EKVMyw4rnloqtSQh1HKAl1qcNB1QaXOqqApLFqCAfeg90agZyh9v00Xl0
         MFKzUNDGKuP+39QKNcO/NAi4peQFONYlhAo5ZwAmWFZqBHcDlH+Ldf3hB9yIwxwesul1
         SafBzyqIwr441lpbjS0OUwSSouUgdocF6YutMLMYwJ8aQLXVkqYS35vuYSikGymfoAyq
         tahpiCE2aQ3FmrrpaTkKGokWUaJ0dGQyzIL6b9pJxwKlAQHfS0k+UDIVve0dIYbZcHDu
         dDBwtNlVe1GmiqbRH/a8zc6T6zCzTd6BwGPGrItadT7tce0gg39jzjP9ihUlTHwVuEAP
         5ykA==
X-Gm-Message-State: AOUpUlHsAuUEy+gaRSR93D0PtgxVF0f2XxGGGMzEIDcE+xnBBUkReFMS
        akVv2s/Gi42V8sxoV0fHGhuJgg==
X-Google-Smtp-Source: AAOMgpcWPN2AwBoxPJqgbQFjWGs4P9eKQnbkkv0O02r8R5xMIgIhUbWfGRKuU2S/bEK+kEKcdlhhDg==
X-Received: by 2002:a17:902:7147:: with SMTP id u7-v6mr3539078plm.154.1531872559381;
        Tue, 17 Jul 2018 17:09:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id e24-v6sm2904485pfi.70.2018.07.17.17.09.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 17:09:18 -0700 (PDT)
Date:   Tue, 17 Jul 2018 17:09:18 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        vivek.gautam@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 5/7] dt: thermal: tsens: Document the fallback DT
 property for v2 of TSENS IP
Message-ID: <20180718000918.GG129942@google.com>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
 <a385dfac661b04befd221f3012b2ca56576aada9.1531384019.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a385dfac661b04befd221f3012b2ca56576aada9.1531384019.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 02:09:06PM +0530, Amit Kucheria wrote:
> We want to create common code for v2 of the TSENS IP block that is used in
> a large number of Qualcomm SoCs. "qcom,tsens-v2" should be able to handle
> most of the common functionality start with a common get_temp() function.
> 
> It is also necessary to split out the memory regions for the TM and SROT
> register banks because their offsets are not constant across SoC families.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  .../devicetree/bindings/thermal/qcom-tsens.txt     | 31 +++++++++++++++++-----
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> index 06195e8..b5312a8 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
> @@ -1,18 +1,28 @@
>  * QCOM SoC Temperature Sensor (TSENS)
>  
>  Required properties:
> -- compatible :
> - - "qcom,msm8916-tsens" : For 8916 Family of SoCs
> - - "qcom,msm8974-tsens" : For 8974 Family of SoCs
> - - "qcom,msm8996-tsens" : For 8996 Family of SoCs
> +- compatible:
> +  Must be one of the following:
> +    - "qcom,msm8916-tsens" (MSM8916)
> +    - "qcom,msm8974-tsens" (MSM8974)
> +    - "qcom,msm8996-tsens" (MSM8996)
> +    - "qcom,msm8998-tsens", "qcom,tsens-v2" (MSM8998)
> +    - "qcom,sdm845-tsens", "qcom,tsens-v2" (SDM845)
> +  The generic "qcom,tsens-v2" property must be used as a fallback for any SoC
> +  with version 2 of the TSENS IP. MSM8996 is the only exception beacause the

s/beacause/because/

> +  generic property did not exist when support was added.
> +
> +- reg: Address range of the thermal registers.
> +  New platforms containing v2.x.y of the TSENS IP must specify the SROT and TM
> +  register spaces separately, with order being TM before SROT.
> +  See Example 2, below.
>  
> -- reg: Address range of the thermal registers
>  - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
>  - #qcom,sensors: Number of sensors in tsens block
>  - Refer to Documentation/devicetree/bindings/nvmem/nvmem.txt to know how to specify
>  nvmem cells
>  
> -Example:
> +Example 1 (legacy support before a fallback tsens-v2 propoerty was introduced):

s/propoerty/property/

>  tsens: thermal-sensor@900000 {
>  		compatible = "qcom,msm8916-tsens";
>  		reg = <0x4a8000 0x2000>;
> @@ -20,3 +30,12 @@ tsens: thermal-sensor@900000 {
>  		nvmem-cell-names = "caldata", "calsel";
>  		#thermal-sensor-cells = <1>;
>  	};
> +
> +Example 2 (for any platform containing v2 of the TSENS IP):
> +tsens0: thermal-sensor@c263000 {
> +		compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> +		reg = <0xc263000 0x1ff>, /* TM */
> +			<0xc222000 0x1ff>; /* SROT */
> +		#qcom,sensors = <13>;
> +		#thermal-sensor-cells = <1>;
> +	};

Besides the typos:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Oh, and you also might want to reorder the patches as suggested by
Doug on v6 to put the changes in the binding before the code changes.
