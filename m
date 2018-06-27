Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2FAC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AB8217BD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaCiV2r/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3AB8217BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934233AbeF0AlY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 20:41:24 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46775 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753244AbeF0AlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 20:41:22 -0400
Received: by mail-pg0-f66.google.com with SMTP id q14-v6so128883pgt.13;
        Tue, 26 Jun 2018 17:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ts8BBOj3Jcs5+sSJUpRl+YPIrSWUIBkaQK+/JZKi0aM=;
        b=AaCiV2r/BGR+9w4knmUTYabVhCv+CFDGpNV2JXaux3VRH1/fBabxodezk3nIQiXvLL
         cRb5QiJg7g4FihcMH8ZOHAQhFR+RgfJvgh59HBE99DckHvF6gYBqiI9s5bZmFfEK/eVN
         dwDIstb0WvoEdCfoLrojf1EPX7bhle1cr3zbPwPMuMfCNrRRwpC4yEPbrgLSf6QuQq9W
         B1AX+dVh+GFqQA/Mf9Tyxm2JXcWCnVjBc0NSi8tw1+SUqHUk6Y8NtB6qPXRNcFQZGPbN
         uEMk83DkofVdxJLliacfWa3AGXhZ+3i2MZFeBtF6o/OCxv2cLO5Hay11g1VFZPxeETz9
         GXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ts8BBOj3Jcs5+sSJUpRl+YPIrSWUIBkaQK+/JZKi0aM=;
        b=L8LdTOy33A49XvfkKLG6hU9k2ZoxCb2ZccSXkEN2TgFUmsyqPgHEBfq+Jn2wUuZdVH
         SzJDHLkWK/bKY2agxE0VjIzDRY7EGWi+6xyttzmii6IV3igSQTn4RVrFkjHIWg6c6fYS
         f+iK28dBFC2d9bLulAB5kI0NwnUCgOmxSSEaQ++MVeeey9rOohE+PrD052fIef7u2UCk
         o45Tkq5LvW9Zm8UipuErL2u144nfeTjz9D8dfz0LdI7szgTgzv1t+KePccKA1IBdtuRF
         cOWM6e5hdYPAhE45ci6gdmka0Xwoq01Pug334NoN/gfM/uNtSOntekwfDmAS+Jg0yjPR
         Is8w==
X-Gm-Message-State: APt69E3OowXJe/b76+eIj6wKC/wvpkDzwsizf7z/MaiZquDIJRQMEJBe
        7fd6w9jhlAVcTDd1pHY7A4jcUg==
X-Google-Smtp-Source: ADUXVKJUG/5x8bj00X6qR/lBBA5TRToWSgFUYCb5jcDLwJcCah/D7ms6PhyOpDGDpKdZjj/TR+bMew==
X-Received: by 2002:a65:4b4a:: with SMTP id k10-v6mr3330281pgt.12.1530060082001;
        Tue, 26 Jun 2018 17:41:22 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id o4-v6sm5816964pfa.128.2018.06.26.17.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 17:41:21 -0700 (PDT)
Subject: Re: [PATCH V5 1/5] dt-bindings: watchdog: add stm32mp1 support
To:     Ludovic Barre <ludovic.Barre@st.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1529941383-8653-1-git-send-email-ludovic.Barre@st.com>
 <1529941383-8653-2-git-send-email-ludovic.Barre@st.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a3e9d3a1-eb7a-5752-6c87-fa1906889543@roeck-us.net>
Date:   Tue, 26 Jun 2018 17:41:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529941383-8653-2-git-send-email-ludovic.Barre@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2018 08:42 AM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch adds support of stm32mp1.
> stm32mp1 requires 2 clocks lsi and pclk.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Following Rob's lead here.

Reviewed-by: Guenter Roeck Linux@roeck-us.net>

> ---
>   .../devicetree/bindings/watchdog/st,stm32-iwdg.txt          | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
> index cc13b10a..d8f4430 100644
> --- a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
> +++ b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
> @@ -2,9 +2,15 @@ STM32 Independent WatchDoG (IWDG)
>   ---------------------------------
>   
>   Required properties:
> -- compatible: "st,stm32-iwdg"
> -- reg: physical base address and length of the registers set for the device
> -- clocks: must contain a single entry describing the clock input
> +- compatible: Should be either:
> +  - "st,stm32-iwdg"
> +  - "st,stm32mp1-iwdg"
> +- reg: Physical base address and length of the registers set for the device
> +- clocks: Reference to the clock entry lsi. Additional pclk clock entry
> +  is required only for st,stm32mp1-iwdg.
> +- clock-names: Name of the clocks used.
> +  "lsi" for st,stm32-iwdg
> +  "lsi", "pclk" for st,stm32mp1-iwdg
>   
>   Optional Properties:
>   - timeout-sec: Watchdog timeout value in seconds.
> @@ -15,5 +21,6 @@ iwdg: watchdog@40003000 {
>   	compatible = "st,stm32-iwdg";
>   	reg = <0x40003000 0x400>;
>   	clocks = <&clk_lsi>;
> +	clock-names = "lsi";
>   	timeout-sec = <32>;
>   };
> 

