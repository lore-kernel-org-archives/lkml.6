Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24D9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC95B2146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 21:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfBSVSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 16:18:53 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42394 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbfBSVSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 16:18:52 -0500
Received: by mail-qt1-f196.google.com with SMTP id b8so24883173qtr.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 13:18:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Df3qk2wHmoALDlp4ABrIinTCAobQQC6o9h2dy0CDQnQ=;
        b=h1awx1AAh8FYqmwjJHeqzEGnzdpZ6/XolF4C6pjG6KT91AYvXBMh1yuX5WdnZWX0sd
         sWbQZslDoqGBlgZ6zrDG7W1tOSGUPi2uNgE3OtK7RHELsRk+dlpxQzmxpawJrqjDsPCA
         DwsSls88s+PrgGqE+VyuIRlFaSrbGFnJqr/cguzwFxn5P3J8YEyL3MWid7/g5hzKEymQ
         drDwwy13umEfYq6wo08Vt4WJJ6mumEZst8wx29VZQ/otuJH56UK6AuFm/wAjtJeOZbj7
         GdK9+1wxBWB6QQDwZW3SBWRDZsc4bBfz/D/jz2toqJOWuhHaFIGc+dafLZy9HSEDoA1J
         3txw==
X-Gm-Message-State: AHQUAub+zBp3Uk0ogjQHnesGpotagxymHBJv8bbTmmiFm1E2w0JMuAXB
        QhEU/R3Z/abScJ1pdHPS0vYJ4Q==
X-Google-Smtp-Source: AHgI3IYD8aBhcM0A742jMzve7QDAcgzSsSASQ5DAwHSYALs3JYgxecLUe7jF3D2odwchEOFgeHVhqQ==
X-Received: by 2002:a0c:d791:: with SMTP id z17mr22823386qvi.149.1550611132057;
        Tue, 19 Feb 2019 13:18:52 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::112f? ([2601:602:9800:dae6::112f])
        by smtp.gmail.com with ESMTPSA id k127sm9171765qkf.4.2019.02.19.13.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 13:18:51 -0800 (PST)
Subject: Re: [PATCH] staging: android: ion: fix sys heap pool's gfp_flags
To:     Qing Xia <saberlily.xia@hisilicon.com>, sumit.semwal@linaro.org,
        gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com
Cc:     linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devel@driverdev.osuosl.org,
        daniel.liuyi@hisilicon.com, yudongbin@hisilicon.com,
        kongfei@hisilicon.com, puck.chen@hisilicon.com
References: <1549004386-38778-1-git-send-email-saberlily.xia@hisilicon.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <4f28e830-fd2b-c24b-3ffe-e711bb3cf3d3@redhat.com>
Date:   Tue, 19 Feb 2019 13:18:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549004386-38778-1-git-send-email-saberlily.xia@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/19 10:59 PM, Qing Xia wrote:
> In the first loop, gfp_flags will be modified to high_order_gfp_flags,
> and there will be no chance to change back to low_order_gfp_flags.
> 
> Fixes: e7f63771 ("ION: Sys_heap: Add cached pool to spead up cached buffer alloc")
> Signed-off-by: Qing Xia <saberlily.xia@hisilicon.com>
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

Acked-by: Laura Abbott <labbott@redhat.com>
