Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592A5C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24CE265BE
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LakC61lw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24CE265BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeF0Aqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 20:46:55 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39613 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934427AbeF0Aqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 20:46:53 -0400
Received: by mail-pf0-f195.google.com with SMTP id s21-v6so147684pfm.6;
        Tue, 26 Jun 2018 17:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FsYl1dv/4/eMfHC2S6vtbm1KattXPEP5GZhmostV0E4=;
        b=LakC61lweCRXa4Wj3QeXBf1LMoZhRbfLsm6Zjhtr6wHDVh6NjgDrg1FhTh+FAikZyA
         PCnQOqSGfTa91InIMJjACffOeMxpZy8Ee9jYj6r87GYlyou01SQ0lnMvuKlKw5pfENmF
         YW71Sm3TEErxRLIYO50iTvQ985HAB0/MADzRca+0TiBcCec2TKE9r9x/NNor/7LDacU/
         0CLCH6ZOMGjlYO323SC+j2093Du824m1jiE1T35l5jbhGiA0fVTzf435U0K+xy6fUeuA
         WZcYihCqvTVjbXGZPmBYvPstvK/QXWXrcZq0Fa1pEVPIacoY9Q12I9bs1MxnbkrE8YXx
         Z6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FsYl1dv/4/eMfHC2S6vtbm1KattXPEP5GZhmostV0E4=;
        b=YWdJDPtiTPzehTDy4sLts+AKeZg/qWIFqwNnyCh0vUWqG2ZOjNC+T28ANzOWN3gX68
         hqzIzFfb+gK2IngEBnSbzavKhAP/VJ0Y3S/wDdB760n+XRZ3jtpVLXKL+8G5ifIVluzq
         YZcb4J3lakUuEA/XaElCR3rQpS7Vwti+aEe52SwpyeO5j2w+hmJMHTovzauXof9wZQJc
         3BeaDMVJZ4B+tF1fQwy21xUXi4mB4yNcvjypZX1B9xbGhMzNrr3oLI2gmK8rRKEWfjdt
         ccAhHe4anHkJ4xaFm+0p34pIsZncmOPKT3AiMQsLEtQSyi2IizN7rLOcwjKryagOcJhq
         R2Xg==
X-Gm-Message-State: APt69E3jQ9qKpqOngHKLKshex+jBu76KHPj0LE39BR0N8OQRKm5O3pei
        VwmrYJ/OFHX0l2EjiZwqZo8mlg==
X-Google-Smtp-Source: ADUXVKJsZs4tp9gi/cGcclyxMY0bjheT7zOzG6p+HCrR3xcKvow0a4Ptc8vyTw//9C5ZPeKLg1WdNw==
X-Received: by 2002:a65:6699:: with SMTP id b25-v6mr3278452pgw.426.1530060412382;
        Tue, 26 Jun 2018 17:46:52 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id j13-v6sm4837349pgq.73.2018.06.26.17.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 17:46:51 -0700 (PDT)
Subject: Re: [PATCH V5 4/5] ARM: dts: stm32: add iwdg2 support for
 stm32mp157c-ed1
To:     Ludovic Barre <ludovic.Barre@st.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1529941383-8653-1-git-send-email-ludovic.Barre@st.com>
 <1529941383-8653-5-git-send-email-ludovic.Barre@st.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <2c5091b6-bea7-827a-a37a-c679ecbfcc07@roeck-us.net>
Date:   Tue, 26 Jun 2018 17:46:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529941383-8653-5-git-send-email-ludovic.Barre@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2018 08:43 AM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch activates independent watchdog support for
> stm32mp157c board.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/arm/boot/dts/stm32mp157c-ed1.dts | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
> index ae33653..8af263a 100644
> --- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
> @@ -68,6 +68,11 @@
>   	status = "okay";
>   };
>   
> +&iwdg2 {
> +	timeout-sec = <32>;
> +	status = "okay";
> +};
> +
>   &uart4 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&uart4_pins_a>;
> 

