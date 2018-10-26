Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F5CC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD26B2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD26B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbeJZWb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:31:27 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41207 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeJZWb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:31:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id x31-v6so1363607edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 06:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uvBaF/KGNhjgNwshRtzvAB6Ei+xoAOKzAnbXhw+6tyM=;
        b=SGqkbnBH/ZkRHK8z5FsvFrUtR0hNeoay4ZLEJ5Z4IPvHqUscsyry7E3/oX7s66mmbR
         3gr1WuvlqDEwnvr9pkKS+0aHYEnEsMz7ASowuZlCIuIFBbh4hdMlxj4xxPRlY12e6EyI
         btpU6cxINkS/6wk3NFhMmY81xJh7/x9/OYTW/VWkCckAZSIyGUfyqsz9iQPxm6wzjGrh
         VfkqiGC9QHiSy8CU4xPpjOTIdhUqY5WxA8Bj2mw0QOMWqC+TdVdSpLAYsTkeI4TqdcsP
         v8rpP/6eIB4/AGQMXlavihaoBpWXgpr8jW3nCtlTA3gqDoOKg13GWCaS8nTp4rX96c3S
         W2mg==
X-Gm-Message-State: AGRZ1gI4OGgEdlP86iiBCSojhIZyS2JXlPlBPNygSG6Gihdsz05M/CNA
        bC2rtQVq1WkOxdRvp0evCPRsuw==
X-Google-Smtp-Source: AJdET5c+VTuPKmFfkuUtXrGBgIE47hPsyk+Ao2faR7SMxdtDz8AoPwkWX06h6eFjFsfcfVyWrPEDvA==
X-Received: by 2002:a17:906:564d:: with SMTP id v13-v6mr2524807ejr.107.1540562055629;
        Fri, 26 Oct 2018 06:54:15 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id 9-v6sm2214391ejw.46.2018.10.26.06.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 06:54:14 -0700 (PDT)
Subject: Re: [PATCH v3] libata: Apply NOLPM quirk for SAMSUNG
 MZ7TD256HAFV-000L9
To:     Diego Viola <diego.viola@gmail.com>
Cc:     axboe@kernel.dk, tj@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20181026134516.1234-1-diego.viola@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d1ea9309-dd12-a497-a95c-cb0316533f18@redhat.com>
Date:   Fri, 26 Oct 2018 15:54:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181026134516.1234-1-diego.viola@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26-10-18 15:45, Diego Viola wrote:
> med_power_with_dipm causes my T450 to freeze with a SAMSUNG
> MZ7TD256HAFV-000L9 SSD (firmware DXT02L5Q).
> 
> Switching the LPM to max_performance fixes this issue.
> 
> Signed-off-by: Diego Viola <diego.viola@gmail.com>

Thanks, looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/ata/libata-core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index a9dd4ea7467d..6e594644cb1d 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4553,6 +4553,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>   	/* These specific Samsung models/firmware-revs do not handle LPM well */
>   	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
>   	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM, },
> +	{ "SAMSUNG MZ7TD256HAFV-000L9", "DXT02L5Q", ATA_HORKAGE_NOLPM, },
>   
>   	/* devices that don't properly handle queued TRIM commands */
>   	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
> 
