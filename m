Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3F5C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1382084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eo1314Vo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1382084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeLJNn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:43:59 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44898 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeLJNn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:43:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id k8so5267460pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 05:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qJe0lFdLiJyGkTG0oQdocR5mjS1UsdR4VanVd0I9Q8w=;
        b=Eo1314VoNon8bLdZlyfwfUAf1ykCo8qmhZGLSdKegOTdsmsRlb+PlpcVhmJti/SdmV
         iiLeXMGuBH5IDJlzSfsHOxUisOx3SVX/N2rfk2SZODlB6x3gHNvsQmKOyxZwszpZwsSh
         ARNmQNFDDJ2Tlm9gIb4WoGUGpuCnX5nieZOIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qJe0lFdLiJyGkTG0oQdocR5mjS1UsdR4VanVd0I9Q8w=;
        b=LWij1P+K7mMrUZ5i0tpXo0oxiBAvK7MIfE7YSrOoMamFP98mi3pEIT3JT3YU4LSDrT
         jQxNa9IbNuWcYM6pkhg+AGSoJKZ8lIQLikSg6s7jzE97V55AKigz7ZuPoFOdONUiGyNj
         9ErTRB0mI1Fosfuity9pWKs1ptMmciG8aCfhDJIIOxaaS+4yL9ECVLL9w/GbfiMSXabJ
         qVhmMRGZbmKz9D/jHe5QxKxs04GwU8ZRNbryeECL9rr3cA3cow/im51PRTzh4CXAS+km
         VYeABU9VveMgHVO6PgaGfHKk0LraFEdcFnT2gdirf2gLf6pG4jsETujxJnHk5hSthyG+
         YgSw==
X-Gm-Message-State: AA+aEWb8LDMhpvMOXkiEOsdIVgkVcnKq5cdaGarvRlP1vZbobwC48jKY
        boguU6mr6UUqrt8MfySfpBae
X-Google-Smtp-Source: AFSGD/UHb5IGpz9bGG8llAfD90QCB9DY7MrCtdfQS9mYFp/z8hgMIhSCbvWZQ4NN1bFXRAjiikY6aA==
X-Received: by 2002:a17:902:142:: with SMTP id 60mr12556491plb.330.1544449438254;
        Mon, 10 Dec 2018 05:43:58 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
        by smtp.gmail.com with ESMTPSA id v5sm22756891pgn.5.2018.12.10.05.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 05:43:57 -0800 (PST)
Date:   Mon, 10 Dec 2018 19:13:48 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Parthiban Nallathambi <pn@denx.de>
Cc:     afaerber@suse.de, robh+dt@kernel.org, mark.rutland@arm.com,
        wsa@the-dreams.de, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@cubietech.com,
        thomas.liau@actions-semi.com
Subject: Re: [PATCH v2 1/4] dt-bindings: i2c: Add S700 support for Actions
 Semi Soc's
Message-ID: <20181210134348.GA25368@Mani-XPS-13-9360>
References: <20181126185821.2480449-1-pn@denx.de>
 <20181126185821.2480449-2-pn@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126185821.2480449-2-pn@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 07:58:18PM +0100, Parthiban Nallathambi wrote:
> Add s700 compatible string to Actions Semi SoC dt-bindings.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-owl.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-owl.txt b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
> index b743fe444e9f..dfa1197e0dbf 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-owl.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
> @@ -2,7 +2,7 @@ Actions Semiconductor Owl I2C controller
>  
>  Required properties:
>  
> -- compatible        : Should be "actions,s900-i2c".
> +- compatible        : Should be "actions,s700-i2c" or "actions,s900-i2c".

Since this driver will also support S500 in future, the above could be
phrased as:

compatible:	Should be one of the following:

		- "actions,s700-i2c" for S700 SoC
		- "actions,s900-i2c" for S900 SoC

Regards,
Mani

>  - reg               : Offset and length of the register set for the device.
>  - #address-cells    : Should be 1.
>  - #size-cells       : Should be 0.
> -- 
> 2.17.2
> 
