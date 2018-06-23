Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CA0C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 00:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA3724A50
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 00:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oz0QTBhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA3724A50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934487AbeFWAmQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 20:42:16 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43266 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934302AbeFWAmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 20:42:14 -0400
Received: by mail-pf0-f194.google.com with SMTP id y8-v6so3922734pfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 17:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DlhA9dFiz7jnmPXZkDT9bL7K+8KG0MUEKhksdJzH3X8=;
        b=Oz0QTBhpFVF5yFTDyLJGWnJiu22vbjTydPSkwpxsz/oXSsStiRyHdspvSvs4HPXywk
         CPVGZNxjBPMB2qvzpCZUelThplJYGgLOrcrHYhfRP094r7S5VPPVKO/nnXJOVF0IgLOS
         C9j/mA9V0nPd3mui2/ta3Yv6H1UvZS7PBbaLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DlhA9dFiz7jnmPXZkDT9bL7K+8KG0MUEKhksdJzH3X8=;
        b=hPswPf3dCTGkgEsXF0FOU0FPGJdVSc2dhd5IBuJly5xqQIo7oLtopuJxrcgBzg8x7B
         BCko7HFKrZtLKXZy/CB0kHlctQ+Tg46L43d8a7izHqM6fc7OXFoYTbkn1+d2LgehFuc2
         M0k6le/MCsno6rD4ICjYhvsZ33vZMPMLoJNrdyfLXkPcT2Dwr/zF9NLQ8pO0mSlRX518
         J6mr+WXNlufAtWNkWu80B/2qaHrFiHMgT4Fn0TzB0AVmMG5Mmi+OJ9IDWGUhxeaLqfVX
         L0T3K51Az5OexATaKn0/5d7ljmTYJH7b81wqarzZ81iiF5iFUs2vQba//6thx+hzQWUk
         TruQ==
X-Gm-Message-State: APt69E1sbF+n8LSZvQra7gAJ7FYPD0MBCReRDPD3y5LkntNxEjmrm7wZ
        hsSoHBRUPte4vakFjdmuk+HkIQ==
X-Google-Smtp-Source: ADUXVKKxt6fy06OAEP2vFYN/2K8/OM+Z1d9KDzf0CjHHs7UK2DLcelOGPnfUfFZ1BTYd2GIp0+pz8Q==
X-Received: by 2002:a62:418b:: with SMTP id g11-v6mr3836448pfd.51.1529714533688;
        Fri, 22 Jun 2018 17:42:13 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j23-v6sm13195147pfi.137.2018.06.22.17.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 17:42:12 -0700 (PDT)
Date:   Fri, 22 Jun 2018 17:44:33 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        jassisinghbrar@gmail.com, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH v5 1/8] dt-bindings: reset: Add AOSS reset bindings for
 SDM845 SoCs
Message-ID: <20180623004433.GQ3402@tuxbook-pro>
References: <20180521172714.8551-1-sibis@codeaurora.org>
 <20180521172714.8551-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521172714.8551-2-sibis@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21 May 10:27 PDT 2018, Sibi Sankar wrote:

> Add SDM845 AOSS (always on subsystem) reset controller binding
> 

I think it would be better if you made the binding represent the entire
clock controller, rather than only the reset-related portion of it.

As I can't find anything in the downstream kernel that references the
clock part of the hardware block I think the driver can be kept as is
(with updated compatible and adjust the offsets of the registers)


This makes the DT better represents the hardware and it makes it
possible to control the clocks in the future, without breaking backwards
compatibility with existing DTBs.

> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  .../bindings/reset/qcom,aoss-reset.txt        | 52 +++++++++++++++++++
>  include/dt-bindings/reset/qcom,sdm845-aoss.h  | 17 ++++++
>  2 files changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
>  create mode 100644 include/dt-bindings/reset/qcom,sdm845-aoss.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
> new file mode 100644
> index 000000000000..cd5dcafb4ed7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
> @@ -0,0 +1,52 @@
> +Qualcomm AOSS Reset Controller
> +======================================
> +
> +This binding describes a reset-controller found on AOSS (always on subsystem)
> +for Qualcomm SDM845 SoCs.
> +
> +Required properties:
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be:
> +		    "qcom,sdm845-aoss-reset"

qcom,sdm845-aoss-cc

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
> +aoss_reset: reset-controller@c2b0000 {
> +	compatible = "qcom,sdm845-aoss-reset";
> +	reg = <0xc2b0000 0x21000>;

reg = <0xc2a0000 0x31000>;

> +	#reset-cells = <1>;
> +};
> +

Apart from this the binding looks good!

Regards,
Bjorn
