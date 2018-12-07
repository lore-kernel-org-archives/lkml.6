Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575D5C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1760F20837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544225716;
	bh=5MpO0afgjL4LZ3o+dDDDonXRM33KTCXzrj7Zpx14ZKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tF1XTj2FFjsrHD4ITuJoaKQtk96ianyII8tWKvFowLIAZVzdQdb+YvxjgoxknNMAq
	 jxp9lVvjSDfiOCSyTWQXR0pWD175dx37LR4JKCHs4s3m0t0GA3G3I9U5xKTsL65WH+
	 RYCmrUkVNYy2DZWG6aplvQudP0cP+1Q2YLAtPDrU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1760F20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbeLGXfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:35:14 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42399 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGXfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:35:13 -0500
Received: by mail-oi1-f195.google.com with SMTP id w13so4744213oiw.9;
        Fri, 07 Dec 2018 15:35:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q2bWIH9ihGljoH/IISkUNN2ujkG0eAQg9/dnWXuF6sU=;
        b=WhJMYPx8nTkSlB4yobKH7e/QlUvImilGbWQq8xK58BdC5ihDgkZ74RUFx4W9nl9z+5
         mr8mqn/+9ZithqpT2UI1VUWjcQxSGBISRJybOpMnukQemjmp4dY4JWoNryPecpqyFLPF
         3vWX90dLVYvkEK/9E0QdQn31PrnZV77e1nR2WytXYSmLWbyes4KI2Ef+11hKHI4olN+V
         05yV4XtZaGEFti+1B5Gd/9NOBga0tj9rEdofwTFS6ryCNbseGfODAAeypJBXQceQ60/p
         b6QObMmSPgQpQJmgjyEtUFpYE6eM8zclw9bgXy2yQdd31yVaTnvcsduWjad3vOiVzINM
         YeCw==
X-Gm-Message-State: AA+aEWarwZKebpaRr8lf0ZPwmW3B/wJ2SGn9USZOV9CkAxd1OwvTWBx7
        e5D/Kvr8AmKEl3o0AXy+Hw==
X-Google-Smtp-Source: AFSGD/UhqK6lbTif8lqNVTBVRcGPbMX9PRvNiI7/GZWewBDEXpkPcxsFRSskeEAXgqYMAfyWEfGEPA==
X-Received: by 2002:aca:ed48:: with SMTP id l69mr2549441oih.31.1544225712984;
        Fri, 07 Dec 2018 15:35:12 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w108sm819066otb.6.2018.12.07.15.35.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 15:35:12 -0800 (PST)
Date:   Fri, 7 Dec 2018 17:35:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net, overseas.sales@unisoc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 01/15] dt-bindings: Add RDA Micro vendor prefix
Message-ID: <20181207233511.GA9313@bogus>
References: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
 <20181128135106.9255-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181128135106.9255-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 19:20:52 +0530, Manivannan Sadhasivam wrote:
> From: Andreas Färber <afaerber@suse.de>
> 
> Add vendor prefix for RDA Micro which now merged into Unisoc
> Communications Inc.
> 
> Cc: overseas.sales@unisoc.com
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
