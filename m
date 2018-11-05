Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D63C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B208A2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jkQw3ZmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B208A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387875AbeKFEYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:24:25 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36754 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbeKFEYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:24:25 -0500
Received: by mail-pf1-f195.google.com with SMTP id j22-v6so4883840pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 11:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/Wuhx/JXCRZiwdlt7MmGBpa/GJrzCuPwSEXxKQhDvc8=;
        b=jkQw3ZmGlh8F+JLdUhs7UvGLlNPLmJ/DA50hiw4ytcENYY0VS/Ya57x4rFgU785/Ef
         pY4rFkCzBxRtGPlfHbJSUt+HjXE3VBCxeVqJTrmEPL1M4KNRAK29YKzrMjwfwpI+Bw3k
         SVI1LL3MZYfhys1UMa8N1JFdGVWPdSQ1S+qko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Wuhx/JXCRZiwdlt7MmGBpa/GJrzCuPwSEXxKQhDvc8=;
        b=mV8j8PhpZ9RKVfft4gbGxJ+L8wjJsEL/f5DNynvAFTI71vaaByTHkFBMYXSxu9DzmB
         92MmGhXPVae7pKqaSB1KRr9KTth7k+GNsbT5KaPZROt5lgWyvpNDbrSrhCjHu7129JZz
         yQAoY6lkCB8UJFL6ir77uMvsj7fo+ZCQGKLDK0f7NurL5fLY0wffd17wlAR6AdOlBjtu
         YrlTc6GC5wmPcPhFXyUZVBsJbfA4mrfsAPXLQHtMGjokSjmPc4jtHGdaya6hR7Fn9hIL
         +cLYYFuhB4d5aJZJMofDwg7/HHPHv4CwOQ3f4Srf35CNEbdHnyFSB/YW+Ysvb7hbecT4
         EgsA==
X-Gm-Message-State: AGRZ1gKp8rYX4JVzMnCDLVqGt/TRiATvQj+PqIgHS6BLjeqKLpR7AiNO
        rBezx0AZ66T7k4x29qpijvJssg==
X-Google-Smtp-Source: AJdET5eSoI8vjiciMAlRjoBy4S1ILswhig8QWIwRQRxYvIVfgHlPsOBV+AASSCuAKjDs2JHBm9wLAA==
X-Received: by 2002:a63:104d:: with SMTP id 13mr765616pgq.303.1541444601431;
        Mon, 05 Nov 2018 11:03:21 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q15-v6sm27896344pff.49.2018.11.05.11.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 11:03:20 -0800 (PST)
Date:   Mon, 5 Nov 2018 11:03:18 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/17] arm64: dts: qcom: pms405: add spmi node
Message-ID: <20181105190318.GN2523@minitux>
References: <20181105154529.7614-1-vkoul@kernel.org>
 <20181105154529.7614-9-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105154529.7614-9-vkoul@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05 Nov 07:45 PST 2018, Vinod Koul wrote:

> Add the pms405 DT file with spmi node.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/pms405.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pms405.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
> new file mode 100644
> index 000000000000..8a585180f102
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, Linaro Limited
> +
> +#include <dt-bindings/spmi/spmi.h>
> +
> +&spmi_bus {
> +

Please drop the empty line.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> +	pms405_0: pms405@0 {
> +		compatible = "qcom,spmi-pmic";
> +		reg = <0x0 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +	};
> +};
> -- 
> 2.14.4
> 
