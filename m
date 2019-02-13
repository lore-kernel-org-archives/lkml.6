Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E6CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C1F222D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404927AbfBMS1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:27:37 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44003 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733194AbfBMS1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:27:37 -0500
Received: by mail-qt1-f196.google.com with SMTP id y4so3732901qtc.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 10:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CELVvMHWEQNmZg7WH/AGOO1zgue2daiPTmFdOz2TZoI=;
        b=GxTtP13tlNBShuuIni9z6yCHgAYjpX8+RKU4YSC5JihXoM6+32Qsofl3mdwwh3aShE
         xN1zSY60JRxLBlMi7ZWRi8ISjj4KJUtmRaQw4DYwqptQ18+upbxk0x1NMhgC+RFI1kqs
         jfsXXl5xO0iPZSDyWYd6ST7r0+b4dhZ2UkZcp1WrL5eQ5U2ZK4Avc4+UVjK8vQebLt8D
         h3t3mv0DxH0wY2xHU8jhjZ+PX+lW3HEFiH//l5N1CwMGVCm5CzepwXcDPbdXYDDNOtLO
         5dwQNwxCOsShZmZLJI3gf/BDPpkhmULCapw8IyySjgJMzw++vw5Rw0fIdLY/Yo+6wbA5
         tQBw==
X-Gm-Message-State: AHQUAuaycQcKm1MCmaL2T+DdrgV4pW4J6mRuoIkKkkM5ib/35wYkRskA
        32TVVL3kJbL5S8MxtChPvUywZg==
X-Google-Smtp-Source: AHgI3IZgcOmBl4L0W+u8vy9cp3Xh1b/ZUGtRkag+ZfCG1s8pf3A0Y7A0rRT3a/q4xu+aYNNxT+7pQg==
X-Received: by 2002:a0c:8062:: with SMTP id 89mr1438604qva.181.1550082455473;
        Wed, 13 Feb 2019 10:27:35 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::112f? ([2601:602:9800:dae6::112f])
        by smtp.gmail.com with ESMTPSA id m66sm5142352qkb.93.2019.02.13.10.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 10:27:34 -0800 (PST)
Subject: Re: [PATCH] staging: android: ion: Use low_order_gfp_flags for
 smaller allocations
To:     Jing Xia <jing.xia.mail@gmail.com>, sumit.semwal@linaro.org,
        gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        puck.chen@hisilicon.com
Cc:     devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        yuming.han@unisoc.com, zhaoyang.huang@unisoc.com,
        orson.zhai@unisoc.com, wenan.hu@unisoc.com
References: <1549955366-19930-1-git-send-email-jing.xia@unisoc.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <19b0aefd-d265-2092-4787-34de20033ec1@redhat.com>
Date:   Wed, 13 Feb 2019 10:27:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549955366-19930-1-git-send-email-jing.xia@unisoc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 11:09 PM, Jing Xia wrote:
> gfp_flags is always set high_order_gfp_flags even if allocations of
> order 0 are made.But for smaller allocations, the system should be able
> to reclaim some memory.
> 
> Signed-off-by: Jing Xia <jing.xia@unisoc.com>
> Reviewed-by: Yuming Han <yuming.han@unisoc.com>
> Reviewed-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> Reviewed-by: Orson Zhai <orson.zhai@unisoc.com>
> ---
>   drivers/staging/android/ion/ion_system_heap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
> index 0383f75..20f2103 100644
> --- a/drivers/staging/android/ion/ion_system_heap.c
> +++ b/drivers/staging/android/ion/ion_system_heap.c
> @@ -223,10 +223,10 @@ static void ion_system_heap_destroy_pools(struct ion_page_pool **pools)
>   static int ion_system_heap_create_pools(struct ion_page_pool **pools)
>   {
>   	int i;
> -	gfp_t gfp_flags = low_order_gfp_flags;
>   
>   	for (i = 0; i < NUM_ORDERS; i++) {
>   		struct ion_page_pool *pool;
> +		gfp_t gfp_flags = low_order_gfp_flags;
>   
>   		if (orders[i] > 4)
>   			gfp_flags = high_order_gfp_flags;
> 

This was already submitted in
https://lore.kernel.org/lkml/1549004386-38778-1-git-send-email-saberlily.xia@hisilicon.com/T/#u
(I'm also very behind on Ion e-mail and need to catch up...)

Laura
