Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BA1C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA93217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EoumtdMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405805AbfBOKoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:44:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35958 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729925AbfBOKoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:44:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id j125so9142623wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 02:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qUuLlEE5Q2koJzCqTmzBLqwiL5p0RjZAe3xDJW/0IW0=;
        b=EoumtdMWqu7DCuu4Htoqan0BeyZLmdmaT0U9OXpqjrcDp4Vc542cDgSBchWpQhvSQ4
         1gxqskTK8VZkniRlcds0ze6JL/VH6R5gfEhbrs/Pe/46UUgwqUSYOWt7QykidOxqW6Si
         ohsU3uqpdxjdQa9JRPk4GMoKUS4oF6trvlgTdYu8UEHuGZy5eby4igyBWM/ZW+vJa7qe
         wA3h+sop6mRPKh3cBlf7wMz1TDbnM0v/vNo7GCST1VcvJ+XnsVobr6hM3Sd1Z3csV27l
         iwJQAD5nK7mdbz6xhwssLQar5oWP4yUVctaqm95LPHeq+fsNzptQsW/f2E9ToPq1ckud
         /6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qUuLlEE5Q2koJzCqTmzBLqwiL5p0RjZAe3xDJW/0IW0=;
        b=HyBDmeMltsmQFe2PMAKi21Ac513d29Xj00n9+DT3Lb6NlxjukEYlvrmd2AWx2c3+1Y
         LSazroIPycQ7gmIZb/itZOi/B9jrDwKj+rd9jc9bxrvq4nvJKyvMJOPIvsf2sHISriLO
         FsfriPbbajWT9p9+5I12T3IqGXklSYZpiUprDguwlBoW2O/+la5ORUtCcQOyOcMT4uMf
         0+XX8JKd/xDeE3svgrkXXQlMicQwjjwlQsnquwjCO5pCKCR+148pI9S/ZeCitnHNAert
         LNUaWbes4ZxxbgJBlgOp4ngTgbfCYkZLa9EPmiMa8+XzbPg0u/p62z2pWmAZvepkdjwn
         pkBA==
X-Gm-Message-State: AHQUAubbluiwkLchZlWIvOB32EV97HXim8hSHts0xcUBYAQ58ILA0dZQ
        VdkeEiTkoGB1kDfAxthL44cOAA==
X-Google-Smtp-Source: AHgI3IaqGTaXpusueaipWKnq/d5AZMXYOm/VykERtFt7frUE44AHzKYcI1e+NslnZ0Mv50zBwTFxOQ==
X-Received: by 2002:a7b:c777:: with SMTP id x23mr6284037wmk.71.1550227476333;
        Fri, 15 Feb 2019 02:44:36 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id q12sm2693163wmf.2.2019.02.15.02.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 02:44:35 -0800 (PST)
Subject: Re: [PATCH] nvmem: core: don't check the return value of notifier
 chain call
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
References: <20190215104259.30732-1-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4c60a96c-7995-fd12-39b6-990ae0ffad4f@linaro.org>
Date:   Fri, 15 Feb 2019 10:44:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215104259.30732-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/02/2019 10:42, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> blocking_notifier_call_chain() returns the value returned by the last
> registered callback. A positive return value doesn't indicate an error
> and an nvmem device should correctly register irrespective of any
> notifier callback failures. Drop the retval check.
> 
> Fixes: bee1138bea15 ("nvmem: add a notifier chain")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Thanks for the fix!

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   drivers/nvmem/core.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index f7301bb4ef3b..3ce65927e11c 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -686,9 +686,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	if (rval)
>   		goto err_remove_cells;
>   
> -	rval = blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
> -	if (rval)
> -		goto err_remove_cells;
> +	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
>   
>   	return nvmem;
>   
> 
