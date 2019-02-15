Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9213BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EC2206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AsPU6xGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389192AbfBOJ2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:28:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34081 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732633AbfBOJ2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:28:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so6201244wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 01:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4vuwJfCjaymcrQMHuhlHrbRPg7VDf027mF0EyK6vTag=;
        b=AsPU6xGzd2Ww1oDpvRjd764AlORojlxzX3HhXH5Ax3iiNg2WB97GK5yy8s5SW91icG
         00krXHPhu/ptPeAoORMVVaphubQMeisy6Cs4OjRm2FmezzTvohOEFWlTO/DSIIePeEht
         EBIgzqwfIiOjo3gFSgqiFGoJvpaXNcjyU6Cug92ZdyKxLLVxxd7DWBSENNTCcNqkGOg8
         XdfWlg9RdbYx+tWgLyGNmIJHMZTpK1aFxUt1tckPABYjIe8TpNpRILVz/B11PUmCD0GS
         dTMKKrb+ePLhDAwpNUCeIBY++jrZb428/aICEcLTERgooOy55jXE4/PnK16PpGoYdJEL
         fKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4vuwJfCjaymcrQMHuhlHrbRPg7VDf027mF0EyK6vTag=;
        b=VN1eBZSz02jMGIOIZ4FLGWr9bwgTu3RDhz+GqM/zupWj/KFYjYzThJIYI5nCqWJybi
         A3NG/UEZtyqSiwhiR5ttpX+uxTOAQBhYW6fo3gBKWCfPW40ZzsJIi29lQYDAGkg6UnPs
         xqGEGiJ71hpyMazLHnD8OSpHra+HYbnpZhwgF23Z5z0ss0EyB01D3t6CBXipPfgWg1gq
         i7laYnHUdMutYb7/JyD+LU/fMKJelp+oH9c7MQc20yEWBQXH6MVxX574h16d0noQAAr0
         lHCjzAxqkx4Ybhf53B99hny4EJyxTvirTwZM0S3FIc4Ud+EAhLV3hqKKGgB9XO6Z6TMu
         07qw==
X-Gm-Message-State: AHQUAuZWz39+ZyHjGbpMvf0U3f/4jDNMrV6eT8kSxz3r5xmp5Y47BVIU
        TCLpw7dj321wtdSgbBrwN9A2EQ==
X-Google-Smtp-Source: AHgI3IZiFbeA12c2rsy3vAf4bim1CuIfd9UQiHAViiNTRyX4AOYmr5cqhZuI2nJqPqitN1KXzyn17Q==
X-Received: by 2002:a1c:f20a:: with SMTP id s10mr5459321wmc.123.1550222889404;
        Fri, 15 Feb 2019 01:28:09 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id 62sm10123312wra.46.2019.02.15.01.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 01:28:08 -0800 (PST)
Subject: Re: [PATCH] nvmem: core: fix the return value check when calling the
 notifier chain
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
References: <20190214162349.22740-1-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e566b4ba-0f3e-052a-bf08-ad881cf7b7c0@linaro.org>
Date:   Fri, 15 Feb 2019 09:28:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214162349.22740-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/02/2019 16:23, Bartosz Golaszewski wrote:
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index f7301bb4ef3b..a3bed2d9aec7 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -687,7 +687,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   		goto err_remove_cells;
>   
>   	rval = blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
> -	if (rval)
> +	if (rval < 0)
>   		goto err_remove_cells;

rval will be masked with STOP MASK, so the above statement could be 
false even if we have error.
So you should consider returning an errono which can be understood by user:

may be something like this:

if (rval & NOTIFY_STOP_MASK) {
	rval = notifier_to_errno(rval);
	goto err_remove_cells
}


--srini
