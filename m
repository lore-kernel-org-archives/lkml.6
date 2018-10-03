Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3998C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7DB20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YMUF5xe+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7DB20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeJCPPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 11:15:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34468 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbeJCPPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 11:15:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id z4-v6so5086855wrb.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 01:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FKmtYQMvatKBOR5toFTor6D2vbYujCN/1CKLlMN8sNY=;
        b=YMUF5xe+am3zKoBLoC2Js2+M3WQie6phM3ewpXmSxnEavro4NG7sBNrmQrpVZir6CC
         4FcYYpiZNPvBC/1NtZ31u2tZN9sX3dIVeTB8bC5iIZgQ0Thz2SKBM/T1T6w+3GIKl++u
         cjnASgwBljAuvK75ndXQAWHp6zPU1eD1/2pMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FKmtYQMvatKBOR5toFTor6D2vbYujCN/1CKLlMN8sNY=;
        b=fsSUX8JV9YfMnZ+pyhdCYWJ2kqyoGCL4uzVVHhLtbrBvHStHIz5Q2oGkYxj6WGC8oh
         10syiXjEmn3s056b2Jm6vAzzZ1t/AyPQA073wm4Bo7S72sGYcGFlpedf9p1g73x3tO0W
         SjT+NENAVI/1wBWA7u1K8WgSgxkkWDOzDZQFtXLqW2P0HQwE046sxqn6V79b4LHx5QaX
         5tSHBjVVhKKs9ipJDBaSV7rph4vgGBpZtPEOfr8gdRpJwpk8S0DuiYJ+X5IxaIMUMqHT
         2MjZdoGFc3v1VYQw80Yu5Uw9XfK3BuDppuEy3F8LmJgYGewDumVhSxcIfA6RpGabP9dr
         IkzA==
X-Gm-Message-State: ABuFfojfbxt5VTSSKUH3gv+6nLseB5RgRE0shU4we5UVYSxbAODQ25K+
        jJM045aPxj3UU9Bgesq22OkG2vanZVw=
X-Google-Smtp-Source: ACcGV61mfJ4rXnuzca834+PWPmujrtQc+6bpChbzNVg/r4v6svlkMMs49ubh5HB8Iz7Ghho/pGx4Hw==
X-Received: by 2002:adf:dd4c:: with SMTP id u12-v6mr387191wrm.2.1538555290780;
        Wed, 03 Oct 2018 01:28:10 -0700 (PDT)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id e67-v6sm1249294wmd.41.2018.10.03.01.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 01:28:09 -0700 (PDT)
Subject: Re: [PATCH v3] nvmem: fix nvmem_cell_get_from_lookup()
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <greg@kroah.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20181003073111.27212-1-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <16778679-514a-a3f6-edd5-b92e0e23830a@linaro.org>
Date:   Wed, 3 Oct 2018 09:28:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181003073111.27212-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/10/18 08:31, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We check if the pointer returned by __nvmem_device_get() is not NULL
> while we should actually check if it is not IS_ERR(nvmem). Fix it.
> 
> While we're at it: fix the next error path where we should assign an
> error value to cell before returning.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
> v1 -> v2:
> - use ERR_CAST() instead of a direct pointer cast
> 
> v2 -> v3:
> - added the Reported-by tag
> 
>   drivers/nvmem/core.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index ad1227df1984..f49474e1ad49 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -952,9 +952,9 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
>   		    (strcmp(lookup->con_id, con_id) == 0)) {
>   			/* This is the right entry. */
>   			nvmem = __nvmem_device_get(NULL, lookup->nvmem_name);
> -			if (!nvmem) {
> +			if (IS_ERR(nvmem)) {
>   				/* Provider may not be registered yet. */
> -				cell = ERR_PTR(-EPROBE_DEFER);
> +				cell = ERR_CAST(nvmem);
>   				goto out;
>   			}
>   
> @@ -962,6 +962,7 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
>   						       lookup->cell_name);
>   			if (!cell) {
>   				__nvmem_device_put(nvmem);
> +				cell = ERR_PTR(-ENOENT);
>   				goto out;
>   			}
>   		}
> 
