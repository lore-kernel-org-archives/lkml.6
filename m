Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7ED0C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801652081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKNyfQ2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801652081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeJ3WLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:11:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38425 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbeJ3WLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:11:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so5830650pfi.5;
        Tue, 30 Oct 2018 06:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8LJWRBBkkxLnc7SPxPWVctsIV8DRE28HiSImpvKnjkc=;
        b=LKNyfQ2q0Lv5b5YDKLXkRPppvawFjcq2vFDNNRUEyq2Nq8aP3rNB5tZZv2bdHwEp+w
         NVO88uZN9eKoQMPsuCKNxnR8/JHEjr1IHHUO2ss18CPpkz4ORz06kd1ZGDFb7DVCol2W
         JV7me5AEtnbHw6ExSBVe97ksidmksv1aSxYjJYXGd/gMRRGghKB+s6Ns0GUCacHYB5bs
         anoymUrA4ArxZQeJ30nABYFpLBylACfhCeS/VwSiOzcyCb/KterkVB6RblL+CiNxwDd7
         Of/v4TTRhMIXWN6r/L6xB0kFzXNrQP/l9NAC6ktwgO3UjMY0PIGfeeXnZuOLorJ1QhWm
         FTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8LJWRBBkkxLnc7SPxPWVctsIV8DRE28HiSImpvKnjkc=;
        b=iyesinRoGy2JedcLwpDTOEPMUzG7YuwrRv8waESI8sE7SUQmotcxThhVlQiXWDLHWw
         Hq3wSSSzEOC993o/zOjCSrD0rfY7gDnEDQ074ptDJBpz0FOcSKHj7ywWGqZY8lEiP/tR
         KrZ4yP/HmiWX5PwiMDpLTvwnpa1BFC9g6EKPrWyhD+h6qMxLz/Xv4ipvCoLnHdNeHQxZ
         ZITMkoxHpM5aO6EVSYKXmjlaBsW3LpXIL0p5MxlO1Yj0Whz99Gaxq1ElbN06iBY4HIjg
         XR0DNGeqPsrdvS3qfhOKU4OHuu8Hk9++2kVqk7P2eMLCaoqNYvUIXcCCZMD4CV3U2jJ3
         0Z/w==
X-Gm-Message-State: AGRZ1gKqJphbst1VmcTWTVpNa9y6iHg0DFfFFDrYd2Yn15GMyFdkALza
        C0iGiMIB2cuxMTqCOLN6790=
X-Google-Smtp-Source: AJdET5ezkT7WGIzFJ/NKirspMYEVuk2NGlKhFBHE1QGr6k4iFKGGELmF5T5CuzstcRR9XW2EpfdBdA==
X-Received: by 2002:a62:35c2:: with SMTP id c185-v6mr2896674pfa.69.1540905457739;
        Tue, 30 Oct 2018 06:17:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n2-v6sm16903463pgg.86.2018.10.30.06.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 06:17:36 -0700 (PDT)
Subject: Re: [PATCH v5 7/8] dt-bindings: watchdog: document stpmic1 pmic
 watchdog
To:     Pascal PAILLET-LME <p.paillet@st.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
References: <1540830122-2577-1-git-send-email-p.paillet@st.com>
 <1540830122-2577-8-git-send-email-p.paillet@st.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e74f50d1-0508-a7b1-7352-2d8eb867ee3b@roeck-us.net>
Date:   Tue, 30 Oct 2018 06:17:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540830122-2577-8-git-send-email-p.paillet@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/18 9:22 AM, Pascal PAILLET-LME wrote:
> The stpmic1 PMIC embeds a watchdog which is disabled by default.
> In case of watchdog, the PMIC goes off.
> 
> Signed-off-by: Pascal Paillet <p.paillet@st.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> changes in v5: nothing
> 
>   Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt b/Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt
> new file mode 100644
> index 0000000..7cc1407
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt
> @@ -0,0 +1,11 @@
> +STMicroelectronics STPMIC1 Watchdog
> +
> +Required properties:
> +
> +- compatible : should be "st,stpmic1-wdt"
> +
> +Example:
> +
> +watchdog {
> +	compatible = "st,stpmic1-wdt";
> +};
> 

