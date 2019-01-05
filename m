Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE30C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 04:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83ACF21874
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 04:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WYx1VGXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfAEEAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 23:00:40 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45591 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfAEEAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 23:00:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so18240993plm.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 20:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XBES4MHEsab8Mdz+58srwkH7ZLLmKHt+tAAztkoTbrA=;
        b=WYx1VGXR/gZsC3TfRyX0MXNF/wE/KqMdD9PnmpAVuuwhoPbviNmAd5mmFOpdZzzpNk
         I0gQNq4+QSQLdzcH0NJ4lsKzJlqhrILmjSonY/dPf2/rfG3ogtH1AOi08h9uowQSBOQv
         9XlGBQ10Tn8VIXyMJvaJTE6CYEM9z238pqxwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XBES4MHEsab8Mdz+58srwkH7ZLLmKHt+tAAztkoTbrA=;
        b=SKF70M0qycB4jNY3vywFGhpBU9CoiJsnlKOQNzVPGUoryaI0K/ofeQmwZcNcXROU9U
         JckJPmTjgQ6x1iQNGyoBJrXk8d6WnD9se+OAw8oMx9eGXZtroWBRKc9K8Xf88NVhz3Oc
         wqj+2VJhxtI33PVIwRF0mP8W3X6IUuPBwruCpzc5P3t3XwGL17mcER+snkyx9t/14aM4
         /fhS4unNP/YSm5D9toI2P4NJLKU9TmuMsmPZV5LWY+t4jjNlDuPii8y1DnAg9i5M3UPh
         OOq//EF/BVZZqkEo6NjKJUYorhtfsslFdNDPw+u5l+O9qdj0vmsZejcfA/xZCM4lszcC
         lWMQ==
X-Gm-Message-State: AJcUukdoC4/aMIQHgFgg9eDn9fawews539E93H2VG3sX4i8yBcy4G64x
        QfHr2pcbuW+8OMYB1TI2YyUI
X-Google-Smtp-Source: ALg8bN5Rf3inoXsTskm4Jhz0Qehk1qvyaIdRc/KShbEsoXbOnh9s6XhsblrGze2RV+VTVOhFnF+WCQ==
X-Received: by 2002:a17:902:a98c:: with SMTP id bh12mr53680357plb.31.1546660839175;
        Fri, 04 Jan 2019 20:00:39 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:72cb:a88d:406c:3ac8:e78f:4779])
        by smtp.gmail.com with ESMTPSA id z186sm91652033pfz.119.2019.01.04.20.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 20:00:38 -0800 (PST)
Date:   Sat, 5 Jan 2019 09:30:30 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/8 v2] Documentation: bindings: k3dma: Add binding for
 dma-avail-chan
Message-ID: <20190105040030.GF2477@Mani-XPS-13-9360>
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
 <1546635388-13795-3-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546635388-13795-3-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, Jan 04, 2019 at 12:56:22PM -0800, John Stultz wrote:
> Some dma channels can be reserved for secure mode or other
> hardware on the SoC, so provide a binding for a bitmask
> listing the available channels for the kernel to use.
> 
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Tanglei Han <hantanglei@huawei.com>
> Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> Cc: Ryan Grachek <ryan@edited.us>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: dmaengine@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  Documentation/devicetree/bindings/dma/k3dma.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
> index 10a2f15..1c466c1 100644
> --- a/Documentation/devicetree/bindings/dma/k3dma.txt
> +++ b/Documentation/devicetree/bindings/dma/k3dma.txt
> @@ -14,6 +14,9 @@ Required properties:
>  		have specific request line
>  - clocks: clock required
>  
> +Optional properties:
> +- dma-avail-chan: Bitmask of available physical channels
> +

This property looks too generic. Since this is specific to HiSi SoCs,
this could be "hisi-dma-avail-chan"?

Thanks,
Mani

>  Example:
>  
>  Controller:
> -- 
> 2.7.4
> 
