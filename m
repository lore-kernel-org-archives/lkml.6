Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B227C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9F82184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y7cxGGBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfACXaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 18:30:21 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40203 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfACXaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 18:30:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so16538199plq.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 15:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YZdiLFz27MwzAJATkQ5G6PPb/2nW68MQTnuMbzyBzeg=;
        b=Y7cxGGBqd0T8C/+HxXAVoJlI4P08lOXEl3hB9pBbzIc4ghMCCxMppDtOzAHDbxTCsj
         DJCQ8k9E+GUwm4xnLFnDd+W8e/SsQ9ttcPZC+X+iwjhmsm/Oa4O0AA8rdONuCBhLc3ED
         APiUsOpPr9D9B/9lGEE7zywMj/DA1fugeHPrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YZdiLFz27MwzAJATkQ5G6PPb/2nW68MQTnuMbzyBzeg=;
        b=QyEEc1OxEA5eysIiv0aAVb1SPT3/EgExhf2iJzqPMyLHtSBm+qnZB12+9sI/U72X0W
         Jee9yuL3v4MhgNT2v+LpIRC5JygeoIzkmHSYMC5F+D5ynrUGdHPMjABaSzAQ5TjVUkLJ
         O/hQbsnood+L45UetYwiulVMdPxAz8VQDD5D6le46gcTdz22oRwI3+WhON9DwQvXFaRf
         vohvfJe0tD+rlg4ga9fqrjOf/ZiDvA8ohrWF27uuB3fMyVKvEZ7Fg0bd7d/P/3oWEgUS
         1MqvYP8AV2s8UxDCzmoR0TerFm5qtpejOBM8Wk/1hrpHMoCtsh0GiXa74yB+j89GfH2j
         CZGQ==
X-Gm-Message-State: AJcUukfa0ApTNNIMsKLxuohSnZuvA039+8e/Rc3Xp4UKGlHU7jFnHb6t
        Dyo6XZ4/8bBFVCoQjlbNNoShmQ==
X-Google-Smtp-Source: ALg8bN63fz09CIUDYjT97rQ2I+nayCIJqZI9i94UUcqtYf7QTLN9GoTldaNbpmIsOSkdEdL0/Idl2A==
X-Received: by 2002:a17:902:d697:: with SMTP id v23mr7472476ply.261.1546558219090;
        Thu, 03 Jan 2019 15:30:19 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id b202sm115419460pfb.88.2019.01.03.15.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 15:30:17 -0800 (PST)
Date:   Thu, 3 Jan 2019 15:30:15 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        akdwived@codeaurora.org, clew@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: remoteproc: qcom: Add firmware
 bindings for Q6V5
Message-ID: <20190103233014.GA181833@google.com>
References: <20181228044819.5697-1-sibis@codeaurora.org>
 <20181228044819.5697-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228044819.5697-2-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

On Fri, Dec 28, 2018 at 10:18:18AM +0530, Sibi Sankar wrote:
> Add optional "firmware-name" bindings for Q6V5 MSS and PAS based
> remoteprocs. For Q6V5 MSS/PAS the two/one relative firmware
> paths/path are to be listed respectively. Fallback to the default
> images for mba/modem for Q6V5 MSS or the default Hexagon image
> for Q6V5 PAS if the "firmware-name" binding is not present.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt | 6 ++++++
>  Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 7 +++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> index 9c0cff3a5ed8..60ee0f73071a 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> @@ -27,6 +27,12 @@ on the Qualcomm ADSP Hexagon core.
>  	Value type: <stringlist>
>  	Definition: must be "wdog", "fatal", "ready", "handover", "stop-ack"
>  
> +- firmware-name:
> +	Usage: optional
> +	Value type: <string>
> +	Definition: must list the relative firmware image path for the
> +		    Hexagon Core.

Relative to what? I still think it's a terrible idea that your driver
looks for files at the top-level /lib/firmware/ directory, but now
you're leaking this into the device tree. This should at a bare minimum
be namespaced to something like the qcom/ sub-directory. But ideally,
the driver would automatically be deriving a further sub-directory of
qcom/ based on the chipset or something, and then the only thing you'd
describe here is some kind of variant string -- something akin to
ath10k's qcom,ath10k-calibration-variant (see
Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt), which
doesn't require a full path-name or any hierarchy.

Brian

> +
>  - clocks:
>  	Usage: required
>  	Value type: <prop-encoded-array>
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> index 9ff5b0309417..3a99e7379d8c 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> @@ -36,6 +36,13 @@ on the Qualcomm Hexagon core.
>  	Value type: <stringlist>
>  	Definition: must be "wdog", "fatal", "ready", "handover", "stop-ack"
>  
> +- firmware-name:
> +	Usage: optional
> +	Value type: <stringlist>
> +	Definition: must list the relative firmware image paths for mba and
> +		    modem. They are used for booting and authenticating the
> +		    Hexagon core.
> +
>  - clocks:
>  	Usage: required
>  	Value type: <phandle>
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
