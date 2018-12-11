Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7F1C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE9A2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544566290;
	bh=fbY5cy91EnG1bmyjTBblCjvp0IKwuuin+q2Xmjlhlbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KoLaK323pgUdiyrqBC40k9QVTNw+j/OemKqxNXYqFsk7i740o9Hl/kJQAxaG+PLcr
	 PtGS4Tvj06AYydIiS49Td7fhYl/9jdtG23sAPHN0ilSV727vXWjtT8hHyJ/lQuZ5aw
	 OeimD+kROTpcoVztHH+gvEXVDuwC4JUC6oRJ2RlA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE9A2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeLKWL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:11:29 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43698 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLKWL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:11:29 -0500
Received: by mail-oi1-f196.google.com with SMTP id u18so13370972oie.10;
        Tue, 11 Dec 2018 14:11:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UwTLHImGnhHPqQHRWYwLA7kWhbAY2YbRVPBJsH9MFtU=;
        b=OmYCZrqbogl/Okhpc3Fc1YgnM0rrrsbezNgrLimNXqs7KrpfdnPNtOz9eUOrnn4VDz
         CYKXrOTlm+z7nWDisABRs0i6hRYGp932cgr4IUqbn8CxWmIPYZjneGYurhT42Oj51DP4
         75l6Q3W0n6UDB2n1f0KW8yDP0PhbawFZmfUpqATkAE7rXnZ208aKvbBjg/MgQt5qr7wn
         9aKC7M46x3EVwt7E9sJfzYDVzp1Om6jB7w3uCUnBuVo07/2rJBRtEkyeA1wy30Bo2f9E
         qXjg2ZPeGnpa+jAx+alvE2Fn2iMHTQhDjUnxWD+EJ88D11I7LPYCfiCNinJJ9GPKMS4Z
         H0pA==
X-Gm-Message-State: AA+aEWaLNWGbdaG5a3MODOze5g1pVqxWhzATKmpvNFbBjLfshtXUSQls
        wGAtJy7W2X6HfUuCHwhzcA==
X-Google-Smtp-Source: AFSGD/UVExkZpPnBEaIgAWnBNp941HLGB5GRhCYdoLZJYVZP1bICVPTeiyJbfIqZVL09xz0VbZYgYg==
X-Received: by 2002:aca:3209:: with SMTP id y9mr2199847oiy.198.1544566287736;
        Tue, 11 Dec 2018 14:11:27 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d3sm7369982otb.79.2018.12.11.14.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 14:11:26 -0800 (PST)
Date:   Tue, 11 Dec 2018 16:11:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/2] dt-bindings: gpu: add Allwinner H6 Mali Midgard
 binding
Message-ID: <20181211221126.GA12250@bogus>
References: <20181127074249.15204-1-icenowy@aosc.io>
 <20181127074249.15204-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127074249.15204-2-icenowy@aosc.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 03:42:49PM +0800, Icenowy Zheng wrote:
> Allwinner H6 SoC uses a Mali T720 GPU, which is one of the GPUs in the
> Midgard GPU product line.
> 
> Add binding for the H6 Mali Midgard GPU.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../devicetree/bindings/gpu/arm,mali-midgard.txt    | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> index 02f870cd60e6..c897dd7be48f 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> @@ -18,6 +18,7 @@ Required properties:
>      + "amlogic,meson-gxm-mali"
>      + "rockchip,rk3288-mali"
>      + "rockchip,rk3399-mali"
> +    + "allwinner,sun50i-h6-mali"
>  
>  - reg : Physical base address of the device and length of the register area.
>  
> @@ -44,6 +45,18 @@ Optional properties:
>    for details.
>  
>  
> +Vendor-specific bindings
> +------------------------
> +
> +The Mali GPU is integrated very differently from one SoC to
> +another. In order to accomodate those differences, you have the option

WARNING: 'accomodate' may be misspelled - perhaps 'accommodate'?                                                      
#50: FILE: Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt:52:                                             

> +to specify one more vendor-specific compatible, among:
> +
> +  - allwinner,sun50i-h6-mali
> +    Required properties:
> +      * resets: phandle to the reset line for the GPU
> +
> +
>  Example for a Mali-T760:
>  
>  gpu@ffa30000 {
> -- 
> 2.18.1
> 
