Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3C2C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A732D215E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 11:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WS6xtR5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A732D215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbeHQOfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 10:35:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39676 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeHQOfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 10:35:36 -0400
Received: by mail-wm0-f66.google.com with SMTP id q8-v6so7121712wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 04:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8lcCqkpTQJ0wHawPeYZ/OpXbWRt7h2rAG2p4JMe7xxw=;
        b=WS6xtR5UsHJUERLnbvKR0KoIuXCUAHUYccw4JNR9S6/AQby0Hwy8L66XAZMNGTAstQ
         dTGSTBzxGlPh4hv+fl+LpcTTuHQg8Dny8vTxm485sDEiHIqyeoFnUZ7q5xjoN/enmBgm
         m5M/31BIxcDlFAt4Cvl+ViVPvFbX2bwW8GxlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8lcCqkpTQJ0wHawPeYZ/OpXbWRt7h2rAG2p4JMe7xxw=;
        b=YkZEXW7T/RtyC2rjSSrdsfGn7e+Uy+jqkIbaq5XCkIIXhucknu0K7/Huyf/L0flGMi
         7jppDBkEEPWh/xTsOdf7suQ6VKRz40SPpYQOvtzbNXNXt1ugPVESGUHwpCNJShJFr0iT
         9gPZvnvOR1HYOorGkSXVUE4SPfyl1+fAPzmZPSfcIJ7V0xotx6NEpoj2A9ySyuMmphHY
         mC85H8u48ASftGC43I2Eia4gfQItiR3rCFDy+gE+WK27lcPRDa7E+2w8AopyBCNJVzNx
         5PS9h3u3IIagBM9/3aYylphKh01BDj7eLP0CToJ4SFOAzhczos620fs0CgyvbbhApF4x
         gOxw==
X-Gm-Message-State: AOUpUlH0eyKlfGRBrH5jVCKdp+DE5oLktjqKlUkzgMZ64zOI/lIb6HfT
        QsPyEHZJ9BPI5ApK3Af27UOL9/Z2f9A=
X-Google-Smtp-Source: AA+uWPwCdX9r0RnlaXk+zXBCtJm85B08vjH10IZ36D1nclLNdE/kWxLJxm7RQcMoBdRbHvpArVb67A==
X-Received: by 2002:a1c:64c:: with SMTP id 73-v6mr17416206wmg.7.1534505547914;
        Fri, 17 Aug 2018 04:32:27 -0700 (PDT)
Received: from [192.168.27.197] ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id l15-v6sm1626566wrt.67.2018.08.17.04.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 04:32:26 -0700 (PDT)
Subject: Re: [PATCH] media: camss: mark PM functions as __maybe_unused
To:     Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hansverk@cisco.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180817095425.2630974-1-arnd@arndb.de>
From:   Todor Tomov <todor.tomov@linaro.org>
Message-ID: <080262bf-d354-1ec4-761c-a086a7e268fb@linaro.org>
Date:   Fri, 17 Aug 2018 14:32:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180817095425.2630974-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Arnd.

On 17.08.2018 12:53, Arnd Bergmann wrote:
> The empty suspend/resume functions cause a build warning
> when they are unused:
> 
> drivers/media/platform/qcom/camss/camss.c:1001:12: error: 'camss_runtime_resume' defined but not used [-Werror=unused-function]
> drivers/media/platform/qcom/camss/camss.c:996:12: error: 'camss_runtime_suspend' defined but not used [-Werror=unused-function]
> 
> Mark them as __maybe_unused so the compiler can silently drop them.
> 
> Fixes: 02afa816dbbf ("media: camss: Add basic runtime PM support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Todor Tomov <todor.tomov@linaro.org>

> ---
>  drivers/media/platform/qcom/camss/camss.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index dcc0c30ef1b1..9f19d5f5966b 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -993,12 +993,12 @@ static const struct of_device_id camss_dt_match[] = {
>  
>  MODULE_DEVICE_TABLE(of, camss_dt_match);
>  
> -static int camss_runtime_suspend(struct device *dev)
> +static int __maybe_unused camss_runtime_suspend(struct device *dev)
>  {
>  	return 0;
>  }
>  
> -static int camss_runtime_resume(struct device *dev)
> +static int __maybe_unused camss_runtime_resume(struct device *dev)
>  {
>  	return 0;
>  }
> 

-- 
Best regards,
Todor Tomov
