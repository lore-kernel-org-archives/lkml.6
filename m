Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA05EC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2112084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544566152;
	bh=thNpAFkJelcWh8hcF39eoklTOGw9e3vtPydbRadMt1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NLZ5vCX2cE1ngt4MmxYQs7XL4S0zcgaiEM09yg7PuPkJwlg2NmFxFnvAcEwTkoddq
	 /a1r3uDeYSb7QBYP82rOpbtJslE4u+clvpRS/U6BbPs+kp10dNeGz+9BKycbeZwpdx
	 0FwPC+2T7iqAAqn7aH0WCdAUhWOLOOGz94GvJkJc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2112084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeLKWJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:09:11 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38424 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLKWJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:09:11 -0500
Received: by mail-ot1-f65.google.com with SMTP id e12so15680592otl.5;
        Tue, 11 Dec 2018 14:09:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FotndLqEEb2ioeteBv4Gr2fL2VzNTPeG00RFqgJ3yBQ=;
        b=BbeW57fsykx2AaL8HP0f87tEOnTn2CHMnleQxAER029SlgHKY/79XWIFvbJETGop4U
         /4y2jTS4ntWx4i3GceIXB7mCTjy0SC3n9VeQStQB5R1XTC2iKr5TVdyQbchq/1fzx54j
         ILiWjf7cFGNLc4UknlcFJ4H9RTjyrjpPKswNbmnOZtoCWDJeA2cUvR9p6D0I38sgNKod
         gpqlEfGV7HTl/Gb9odEdYozgem0KPc3Bm4gS4Se5rWQDH4EDoYi7G+3n8qaytXmYQYs8
         4Z++DDUhPhK5AyCuSNNmYWwj1ow6GnQ3csMHtRIiu+yc5+58eBvhi301O11Ejzim8sbe
         2n+g==
X-Gm-Message-State: AA+aEWYOOw10b3R/CwGyp8imcCe1XWlWJoxqGsFvWGcf5oBdLHY/Mn70
        plyQYn5QHviYZyIBPBZ+bUYyOVg=
X-Google-Smtp-Source: AFSGD/Xfu7gc5TpOOxb0t5ZwFxozR/FY9tB+/jVoUUwG3fxBYDt51vWpXk7ApkxyUyBRO9hzojoOSw==
X-Received: by 2002:a05:6830:2081:: with SMTP id y1mr13490265otq.40.1544566150213;
        Tue, 11 Dec 2018 14:09:10 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w17sm7199244otk.12.2018.12.11.14.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 14:09:08 -0800 (PST)
Date:   Tue, 11 Dec 2018 16:09:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/2] dt-bindings: gpu: add bus clock for Mali Midgard GPUs
Message-ID: <20181211220908.GA7630@bogus>
References: <20181127074249.15204-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127074249.15204-1-icenowy@aosc.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 03:42:48PM +0800, Icenowy Zheng wrote:
> Some SoCs adds a bus clock gate to the Mali Midgard GPU.
> 
> Add the binding for the bus clock.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> index 18a2cde2e5f3..02f870cd60e6 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> @@ -31,6 +31,12 @@ Optional properties:
>  
>  - clocks : Phandle to clock for the Mali Midgard device.
>  
> +- clock-names : Specify the names of the clocks specified in clocks
> +  when multiple clocks are present.
> +    * bus: bus clock for the GPU
> +    * core: clock driving the GPU itself (When only one clock is present,
> +      assume it's this clock.)

'core' should be first since it already exists.

> +
>  - mali-supply : Phandle to regulator for the Mali device. Refer to
>    Documentation/devicetree/bindings/regulator/regulator.txt for details.
>  
> -- 
> 2.18.1
> 
