Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAC3C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8862086A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="1VYa2zkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8862086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeH2R0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:26:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43978 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbeH2R0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:26:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id v66-v6so2320221pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 06:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mg6i3BNyC3V1mb4RsrYHN4Hb0V+dL46JxXBrElqnx7o=;
        b=1VYa2zkD5JP9LJbnr/PEOzht9p4ExDsM5F+L7K50B9TMhYGBUJX88P1VLg4OoOU993
         PkRZV7EFp/4C/wY0F0+xbfxq4fMHh7LDaNwX9hjwUgEcct9UE09Ptnm6PMrtmxnXkwHx
         MgDa7FM+RdEiWq203QAqCG+DxPDLGjtAo9dbZ/v+Rodewv7rlnnCTsi+Y1fsWaexjcbk
         cZO6a2UcjPzrTht49mvSmjXmnJ02rqiqq09wQMRVfKFiyEoY1UvLJl5eIqwJCJSX04dl
         flP4MxIFdcqDlFQS00OHQs+mbCuu66N0oxf7VeDMsKim3E18jZGfAB0RPDpQlQf9Lnbr
         Jm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mg6i3BNyC3V1mb4RsrYHN4Hb0V+dL46JxXBrElqnx7o=;
        b=jXh4HPzSLxeCPCcS4at9qhAG3WBqZWQ8jfYU81CNcvVYI4F/GpJGNRcCymmM45cyng
         cuMEpP3g3oCeTIKzg9FhAgqk6OrdY5TDWurRWJo3vx9bcE+ROWIt5UYfnPI7QuRFCIdk
         FLbPda1RcfaeueR5PHHg0r48lJaI3CY1tAt0Iy0S6jK651eF1LJPLV6qXsxyuTB9ThRY
         lFU7jpGAT0qtA7mxg3apl0xtAX44WyBXqw2zrGQNEK/2+eU6AMuv1Ct0Ur5emT5Woen6
         EE4qgKb0K7VrZME2MiDnwPzU9DlFjUpQZfUKNW/YQ8I0qeFTKiFj49/DeOH7rXCuOOrx
         XTdg==
X-Gm-Message-State: APzg51BJpJ6ADYb9jXA2rxGXysuSZHrHpTBhtGpOJJaAaMyrf+Zq7Reh
        DiK+pZro9dsvACK2h+PMs0p+fQ==
X-Google-Smtp-Source: ANB0VdZBcK8bkny4+3XKar/a6wKqXTagAYGTYWY2JBXMo78YAQY36SElEEz4qomgUxDUGL+SXxuGNQ==
X-Received: by 2002:a63:c44a:: with SMTP id m10-v6mr5801262pgg.416.1535549346749;
        Wed, 29 Aug 2018 06:29:06 -0700 (PDT)
Received: from [10.86.62.45] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id x4-v6sm5568215pfm.119.2018.08.29.06.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 06:29:05 -0700 (PDT)
Subject: Re: [PATCH 4/7] lightnvm: pblk: move global caches to module
 init/exit
To:     hans.ml.holmberg@owltronix.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com
References: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1535545414-550-5-git-send-email-hans.ml.holmberg@owltronix.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <92a2b562-c485-47ff-7aa9-5aa82b992e40@lightnvm.io>
Date:   Wed, 29 Aug 2018 15:29:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1535545414-550-5-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 02:23 PM, Hans Holmberg wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> Pblk's global caches should not be initialized every time
> a pblk instance is created, so move the creation and destruction
> of the caches to module init/exit.
> 
> Also remove the global pblk lock as it is no longer needed after
> the move.
> 

The original goal was to not allocate memory for the caches unless a 
pblk instance was initialized. This instead uses up memory without pblk 
being used, which I don't think is a good idea.

> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-init.c | 42 ++++++++++++++++++++----------------------
>   1 file changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index 76a4a271b9cf..0be64220b5d8 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -27,7 +27,6 @@ MODULE_PARM_DESC(write_buffer_size, "number of entries in a write buffer");
>   
>   static struct kmem_cache *pblk_ws_cache, *pblk_rec_cache, *pblk_g_rq_cache,
>   				*pblk_w_rq_cache;
> -static DECLARE_RWSEM(pblk_lock);
>   struct bio_set pblk_bio_set;
>   
>   static int pblk_rw_io(struct request_queue *q, struct pblk *pblk,
> @@ -306,21 +305,17 @@ static int pblk_set_addrf(struct pblk *pblk)
>   	return 0;
>   }
>   
> -static int pblk_init_global_caches(struct pblk *pblk)
> +static int pblk_init_global_caches(void)
>   {
> -	down_write(&pblk_lock);
>   	pblk_ws_cache = kmem_cache_create("pblk_blk_ws",
>   				sizeof(struct pblk_line_ws), 0, 0, NULL);
> -	if (!pblk_ws_cache) {
> -		up_write(&pblk_lock);
> +	if (!pblk_ws_cache)
>   		return -ENOMEM;
> -	}
>   
>   	pblk_rec_cache = kmem_cache_create("pblk_rec",
>   				sizeof(struct pblk_rec_ctx), 0, 0, NULL);
>   	if (!pblk_rec_cache) {
>   		kmem_cache_destroy(pblk_ws_cache);
> -		up_write(&pblk_lock);
>   		return -ENOMEM;
>   	}
>   
> @@ -329,7 +324,6 @@ static int pblk_init_global_caches(struct pblk *pblk)
>   	if (!pblk_g_rq_cache) {
>   		kmem_cache_destroy(pblk_ws_cache);
>   		kmem_cache_destroy(pblk_rec_cache);
> -		up_write(&pblk_lock);
>   		return -ENOMEM;
>   	}
>   
> @@ -339,15 +333,13 @@ static int pblk_init_global_caches(struct pblk *pblk)
>   		kmem_cache_destroy(pblk_ws_cache);
>   		kmem_cache_destroy(pblk_rec_cache);
>   		kmem_cache_destroy(pblk_g_rq_cache);
> -		up_write(&pblk_lock);
>   		return -ENOMEM;
>   	}
> -	up_write(&pblk_lock);
>   
>   	return 0;
>   }
>   
> -static void pblk_free_global_caches(struct pblk *pblk)
> +static void pblk_free_global_caches(void)
>   {
>   	kmem_cache_destroy(pblk_ws_cache);
>   	kmem_cache_destroy(pblk_rec_cache);
> @@ -381,13 +373,10 @@ static int pblk_core_init(struct pblk *pblk)
>   	if (!pblk->pad_dist)
>   		return -ENOMEM;
>   
> -	if (pblk_init_global_caches(pblk))
> -		goto fail_free_pad_dist;
> -
>   	/* Internal bios can be at most the sectors signaled by the device. */
>   	ret = mempool_init_page_pool(&pblk->page_bio_pool, NVM_MAX_VLBA, 0);
>   	if (ret)
> -		goto free_global_caches;
> +		goto free_pad_dist;
>   
>   	ret = mempool_init_slab_pool(&pblk->gen_ws_pool, PBLK_GEN_WS_POOL_SIZE,
>   				     pblk_ws_cache);
> @@ -455,9 +444,7 @@ static int pblk_core_init(struct pblk *pblk)
>   	mempool_exit(&pblk->gen_ws_pool);
>   free_page_bio_pool:
>   	mempool_exit(&pblk->page_bio_pool);
> -free_global_caches:
> -	pblk_free_global_caches(pblk);
> -fail_free_pad_dist:
> +free_pad_dist:
>   	kfree(pblk->pad_dist);
>   	return -ENOMEM;
>   }
> @@ -480,7 +467,6 @@ static void pblk_core_free(struct pblk *pblk)
>   	mempool_exit(&pblk->e_rq_pool);
>   	mempool_exit(&pblk->w_rq_pool);
>   
> -	pblk_free_global_caches(pblk);
>   	kfree(pblk->pad_dist);
>   }
>   
> @@ -1067,7 +1053,6 @@ static void pblk_exit(void *private, bool graceful)
>   {
>   	struct pblk *pblk = private;
>   
> -	down_write(&pblk_lock);
>   	pblk_gc_exit(pblk, graceful);
>   	pblk_tear_down(pblk, graceful);
>   
> @@ -1076,7 +1061,6 @@ static void pblk_exit(void *private, bool graceful)
>   #endif
>   
>   	pblk_free(pblk);
> -	up_write(&pblk_lock);
>   }
>   
>   static sector_t pblk_capacity(void *private)
> @@ -1237,9 +1221,22 @@ static int __init pblk_module_init(void)
>   	ret = bioset_init(&pblk_bio_set, BIO_POOL_SIZE, 0, 0);
>   	if (ret)
>   		return ret;
> +
>   	ret = nvm_register_tgt_type(&tt_pblk);
>   	if (ret)
> -		bioset_exit(&pblk_bio_set);
> +		goto fail_exit_bioset;
> +
> +	ret = pblk_init_global_caches();
> +	if (ret)
> +		goto fail_unregister_tgt_type;
> +
> +	return 0;
> +
> +fail_unregister_tgt_type:
> +	nvm_unregister_tgt_type(&tt_pblk);
> +fail_exit_bioset:
> +	bioset_exit(&pblk_bio_set);
> +
>   	return ret;
>   }
>   
> @@ -1247,6 +1244,7 @@ static void pblk_module_exit(void)
>   {
>   	bioset_exit(&pblk_bio_set);
>   	nvm_unregister_tgt_type(&tt_pblk);
> +	pblk_free_global_caches();
>   }
>   
>   module_init(pblk_module_init);
> 

