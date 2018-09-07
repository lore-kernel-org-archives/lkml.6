Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FB9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB792086D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB792086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbeIGVkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:40:46 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37123 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbeIGVkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:40:46 -0400
Received: by mail-qt0-f196.google.com with SMTP id n6-v6so16928217qtl.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 09:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NlL9nZga5xYUX7/g0MadwmGxPf4AbtU+t4JBhAed+6Q=;
        b=Y35OL/bN5glYQ+ejuC5u1ufGbIgchWJ0gb0ZDnkc6epJ+HubVQSMkQuiW9CfvjsOJZ
         EFzBtuuhQPXpFnU/e9JFzuXtOUJmcFNXOTk9MtG6VwUfuiwK8L5WUCFRzq72WHs6VFUi
         Yn/Z0GO+/rSo2PoVBsCjIysua9BA7RzEHs/kRoh17DmxmHUtxIA7WVtEFlQx6Rry2Dfq
         mV8VQLUExINDMQrIbFR6lk6KrGJO23f+/wmlxsyh5mwcDM+6jhz0lXUVfKhyXiMaUX6W
         ikk6cdSDJI4SL5GLdsV781KszTEF5E6cwmilqFVo4jAQU0Pb58FweCPzJicPhjTuwjBS
         jQeg==
X-Gm-Message-State: APzg51Bl5HEve0BGh1a5mtW2tzapWE8dRpMRoBOcMc+KDkSmBc/plpZI
        v/4Aea0LeMbOWR1cJSPM2fcQYw==
X-Google-Smtp-Source: ANB0VdZ3vofSVGuCJw47NWuMNOfYZo2E+ebUlH+BCJpCj6C8lNu1SiLmTP9CLz3BNOvyMHErWGAC6A==
X-Received: by 2002:ac8:3365:: with SMTP id u34-v6mr6635119qta.73.1536339537353;
        Fri, 07 Sep 2018 09:58:57 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc::3c7a? ([2601:602:9802:a8dc::3c7a])
        by smtp.gmail.com with ESMTPSA id u7-v6sm5442270qtc.76.2018.09.07.09.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 09:58:56 -0700 (PDT)
Subject: Re: [PATCH] android:ion: the order and count are in the wrong
 position
To:     jun qian <hangdianqj@163.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>
Cc:     devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Barry song <21cnbao@gmail.com>
References: <20180907152032.45956-1-hangdianqj@163.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <61e6a1ea-0c40-f191-2434-8086e035fed0@redhat.com>
Date:   Fri, 7 Sep 2018 09:58:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907152032.45956-1-hangdianqj@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 08:20 AM, jun qian wrote:
> The value in the wrong position will cause misunderstanding,
> when the debug infomations display in the window.
> 

I think the existing order is okay, it's just not separated
well. It's "$count pages of order $order". I also just acked a
patch to remove all this code because it's dead on mainline
anyway. For future work, we should look to make the debugfs
output clearer to avoid ambiguity.

Thanks,
Laura

> Signed-off-by: jun qian <hangdianqj@163.com>
> ---
>   drivers/staging/android/ion/ion_system_heap.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
> index 701eb9f3b0f1..54b8a7710958 100644
> --- a/drivers/staging/android/ion/ion_system_heap.c
> +++ b/drivers/staging/android/ion/ion_system_heap.c
> @@ -225,10 +225,10 @@ static int ion_system_heap_debug_show(struct ion_heap *heap, struct seq_file *s,
>   		pool = sys_heap->pools[i];
>   
>   		seq_printf(s, "%d order %u highmem pages %lu total\n",
> -			   pool->high_count, pool->order,
> +			   pool->order, pool->high_count,
>   			   (PAGE_SIZE << pool->order) * pool->high_count);
>   		seq_printf(s, "%d order %u lowmem pages %lu total\n",
> -			   pool->low_count, pool->order,
> +			   pool->order, pool->low_count,
>   			   (PAGE_SIZE << pool->order) * pool->low_count);
>   	}
>   
> 

