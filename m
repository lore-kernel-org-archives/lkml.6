Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED1CC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8826920837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OM+rcR9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8826920837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754204AbeFUJ4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 05:56:39 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39808 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754065AbeFUJ4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 05:56:37 -0400
Received: by mail-wm0-f65.google.com with SMTP id p11-v6so4791174wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 02:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A5t3YtebOCMzD3dFpt10pJGyYD5CdCR0KNKJxyS3Ulo=;
        b=OM+rcR9HRGGRw/akpxU5owWg48nAt1NOS3lCpWRh3tWQfXTYLJ19DpDLCenkAuMiud
         L96t6IrS1+6AFUOCCzfrh6zGQDqG4tX/VfKLDGhU9G2FQ1NNTOqCjEEqqKd70IkCarGE
         a1tyze5/0grjkMqO0zHOdJPB1A60sfrBlp/i4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A5t3YtebOCMzD3dFpt10pJGyYD5CdCR0KNKJxyS3Ulo=;
        b=hPy6jELVxahpT5waB3MMUctbQZpiJbXlcNq0sLjMY3Zwu3mXrOK+lvwvqUFOhiGrug
         RnKbsd3X/q0GvVz30gm9kTEa/w8cIV1besfSLUh2dBSZqppANNF+nuh/eeNVBoUNHvM5
         CS74ouUjHAWUdQEXdZzCoxOi57nTL/SEEMnL5WSBgQgtrbLvB1CUPq9rizwU781CRrR6
         xmctuaAiRIMND6y1SGA6e1SBSqLcisgUnqWm/UF9lB7KadQOJ+P302gGLZAB+mAjwq93
         KhVxM2YkJlO32CSoOboiMRLXbg7sTYkakqpFm12ZeksJbQjWhiEJYpSm2BroA2zWR6R/
         8CLw==
X-Gm-Message-State: APt69E2hku5gwfshcpWUNQirBX0r/9JYBqHWu2ScswMwx531wspDuSQs
        nGmk+QzQmcoNM1QFq0O8o2sSHg==
X-Google-Smtp-Source: ADUXVKJx5kmkwnRSzK8d0XcZbWgHpi4XVmWkSwf0+E5/3cJwUjq5+g3G5ATzN4dR7ZKLB7IzVYeTwA==
X-Received: by 2002:a1c:4203:: with SMTP id p3-v6mr4894913wma.111.1529574996310;
        Thu, 21 Jun 2018 02:56:36 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id l15-v6sm6042774wrs.95.2018.06.21.02.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 02:56:35 -0700 (PDT)
Subject: Re: [PATCH 3/3] hwrng: msm - Add support for prng v2
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Vinod Koul <vinod.koul@linaro.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
References: <20180618141259.23141-1-vkoul@kernel.org>
 <20180618141259.23141-4-vkoul@kernel.org>
 <20180619142853.wgi5easw4zv6ttrb@gondor.apana.org.au>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <966e9cd4-70a3-8d54-df0f-16df3df45fb5@linaro.org>
Date:   Thu, 21 Jun 2018 12:56:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180619142853.wgi5easw4zv6ttrb@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On 06/19/2018 05:28 PM, Herbert Xu wrote:
> On Mon, Jun 18, 2018 at 07:42:59PM +0530, Vinod Koul wrote:
>> Qcom 8996 and later chips support prng v2 where we need to only
>> implement .read callback for hwrng.
>>
>> Add a new table for v2 which supports this and get version required for
>> driver data.
>>
>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> 
> Is this really a pseudo-RNG? If so it needs to be moved over to
> the algif_rng interface.

Despite the register name (PRNG_ registers prefix) the IP is using FIPS
approved algorithm and we can claim that this is true hardware entropy
generator.

I don't think that we need to move to algif_rng.

-- 
regards,
Stan
