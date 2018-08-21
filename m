Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3484C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EED0217BF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kLRFAGaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EED0217BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbeHVBa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 21:30:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38528 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbeHVBa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 21:30:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id x17-v6so9150090pfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 15:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D8/Hn7Wdqa1+TM7RznIRPLj5ZlW1UyKghVd47g+2sNs=;
        b=kLRFAGaJxrMvW+y5ViuDgwnUTWGyGKPMoegeVukA+0oPy0GtZ+SAabUxCrF6XUnce5
         UicU7Ee3SXkj3FtCmXoS+D2B+DBQOKQrb+4CKN1VegcoPd+iPKDBk4TNIsa0brmKAVZM
         /wK52HmVDznsb2MOqRdoZtVnrJzFyDbVAFNbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D8/Hn7Wdqa1+TM7RznIRPLj5ZlW1UyKghVd47g+2sNs=;
        b=r0cN3x9+etD/ojmeMWR6wCAcjdJU5QrRr047YySphpproMR5yxuhefQQK39IjpVqFo
         EauoqTpoLqQo77JGqWzcHQktiz8EK5saAvthVhdP3XF/C2eWlNnwiXLmzL8hrIucLnpP
         oDWV9lpwh5P9AnmlCvzx1BeD6tJS+Gd4KfHMhuWuC6EnwaGUoyueLNkUGCQdyfvWAmY7
         sBGzSDdMp5eamnRHj4dxAb2NUT94tnqtUMn6TGs872jU+qtLuX1si09ItGDp5rF5WqJQ
         CXAjEmEwUWZrkUz0HlJ5M3OuitmIlc01NU6cqCrBp+yqwuBlMEUYCgn8VORgi7iLoiwx
         hb0w==
X-Gm-Message-State: AOUpUlE3z0r/+SXHqtEXktf1wzVPvhQtkToGl44F2/ZQSBuDFJief55s
        rJOw7Lq/9rgOic/8M3HIVjAFzw==
X-Google-Smtp-Source: AA+uWPyXRyra9uC8/ds+xWCMhGwSuiHr2xEOw+K8hdS89fUhwC9+5sYjYcKvptMZV1J9Mvsdrv58cg==
X-Received: by 2002:a63:6283:: with SMTP id w125-v6mr16115109pgb.83.1534889309191;
        Tue, 21 Aug 2018 15:08:29 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n9-v6sm20267765pfg.21.2018.08.21.15.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 15:08:28 -0700 (PDT)
Date:   Tue, 21 Aug 2018 15:08:26 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ohad@wizery.com, mark.rutland@arm.com,
        sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
Subject: Re: [PATCH 1/4] dt-bindings: reset: Add PDC reset binding for SDM845
 SoCs
Message-ID: <20180821220826.GA2353@minitux>
References: <20180727152811.15258-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727152811.15258-1-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 27 Jul 08:28 PDT 2018, Sibi Sankar wrote:

> Add SDM845 PDC (Power Domain Controller) reset controller binding
> 

Even though this is currently describing only a reset controller I think
this binding better be talking about the "PDC Global" hardware.

> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  .../bindings/reset/qcom,pdc-reset.txt         | 52 +++++++++++++++++++
>  include/dt-bindings/reset/qcom,sdm845-pdc.h   | 20 +++++++
>  2 files changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt
>  create mode 100644 include/dt-bindings/reset/qcom,sdm845-pdc.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt b/Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt

Rename this qcom,pdc-global to match the compatible, and hardware name.

> new file mode 100644
> index 000000000000..85e159962e08
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/qcom,pdc-reset.txt
> @@ -0,0 +1,52 @@
> +PDC Reset Controller

PDC Global

> +======================================
> +
> +This binding describes a reset-controller found on PDC-Global(Power Domain
> +Controller) block for Qualcomm Technologies Inc SDM845 SoCs.

This looks good.

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

This is perfectly fine, in its current form it is a reset-controller.

> +	compatible = "qcom,sdm845-pdc-global";
> +	reg = <0xb2e0000 0x20000>;
> +	#reset-cells = <1>;
> +};
> +

Apart from this, the binding looks good!

Regards,
Bjorn
