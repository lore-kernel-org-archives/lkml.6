Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70082C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254FE206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XbMqm8N9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254FE206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeJBScx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:32:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44916 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbeJBScx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:32:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id 63-v6so1841173wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 04:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZRxoGk/zzzakiuKWp4Swahuw6nOMVqfdxhCmRPFoGNA=;
        b=XbMqm8N9Lclna5BDRdBEB6fvlU0/kYgq3TNhO7ytTz7JqB0fiZ/hIWFnv13pMUMeMI
         bzSVJprXbXBqHXIWLP2i1B1BK7TGupDly17T/eUaOX88gphIbUMPMBCb81A25rw9Id4y
         nAjLAqEZ1k/VzHx+VWIBBXVsL60l/PVQ7GhRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZRxoGk/zzzakiuKWp4Swahuw6nOMVqfdxhCmRPFoGNA=;
        b=mJgD/b+xQI+KOeghLaJsHiX7Wx2oZJ9eHZUm5NSlUBLfs1uYDybL2kIDgXz9tFFcMR
         MMWD3auLvCINlBFDrlvZz+EGECnaT4N5AVsNjgX3xmWJ6ZGdtBCV9L5z0EJPoIJ8uIsP
         YulTdcmVjtaXsva+LO+pIQwjJh8YtIAnRocZT3HJym4f5ilH5P1DZ3T80s19IE7UAoAf
         7s3cnuXat4p6yjYPfy8IRe3jHD3MCBAIeIAN7sbUqhJ0KEOZv6S/fE+dSLgtpIi3fc/G
         zqe8ArzdeKOXco7u+LYyQupZXHoUHH7od7H6Nxwi6MrQKx55t6smq81DUOwqWt/sgAZS
         QPTQ==
X-Gm-Message-State: ABuFfojRHXwRYBf0XLhiWRQnz/btwK9Hu+Nt818ILNAAJOHhjfFfP2LE
        WkK99xqEt1UldXN4BXFcqlPzog==
X-Google-Smtp-Source: ACcGV63KVM6/o81YPBBikjd3Inad2MegWFi/6OAi3HVLMv9wXrhdfm7BmT/ER7+u/D1ayuUJJ02dcQ==
X-Received: by 2002:a05:6000:108c:: with SMTP id y12mr10201285wrw.226.1538480997227;
        Tue, 02 Oct 2018 04:49:57 -0700 (PDT)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id a18sm18057641wrx.55.2018.10.02.04.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 04:49:56 -0700 (PDT)
Subject: Re: [PATCH] nvmem: only build nvmem_find_cell_by_index() if OF is
 enabled
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <greg@kroah.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20181002110246.3175-1-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <13b4b871-8f81-d007-ef37-eb697f984f01@linaro.org>
Date:   Tue, 2 Oct 2018 12:49:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181002110246.3175-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/10/18 12:02, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The following warning is produced when building nvmem core if
> CONFIG_OF is disabled:
> 
> drivers/nvmem/core.c:496:1: warning: 'nvmem_find_cell_by_index' defined but not used [-Wunused-function]
>   nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
>   ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> This is caused by the fact that the only caller of this routine is
> under an ifdef depending on this option. Fix it by adding a relevant
> ifdef to the function in question as well.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/nvmem/core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index cc815bb2eebd..65f61cd0a687 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -492,6 +492,7 @@ static int nvmem_add_cells_from_table(struct nvmem_device *nvmem)
>   	return rval;
>   }
>   
> +#if IS_ENABLED(CONFIG_OF)

You should probably attribute the function with "__maybe_unused"
Instead of adding this condition.

--srini


>   static struct nvmem_cell *
>   nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
>   {
> @@ -507,6 +508,7 @@ nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
>   
>   	return cell;
>   }
> +#endif
>   
>   static struct nvmem_cell *
>   nvmem_find_cell_by_name(struct nvmem_device *nvmem, const char *cell_id)
> 
