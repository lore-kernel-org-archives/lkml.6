Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95FBC6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E9E20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E9E20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbeJaJzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 05:55:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33854 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbeJaJzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 05:55:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id f78-v6so6737642pfe.1;
        Tue, 30 Oct 2018 17:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=53YZnkZLmdgHqpLUuNnLlFB9Av28FPplb4e3MJvowj0=;
        b=tcWKU4hRaOVsvgntLmDLDbgFcesSJWIdhGH/z1+ZRHKfeMtXNibHYEeD2ioYSTiAyp
         KbineD3QcnAhCPjGZtz19Rw1bTCb79K7tdaaeLKZymsDB5T5k9awrs+8Xj4wXv2dyfcv
         b7eiUcjvO0Rz7kAliNTyiEAszg3m1KMyQUIHLgprQU7OBNl0/zFqCQu3isGnZ3L3pL2k
         uvjIQOGigh4+SlLUzklM+efJ1noPaiY28IghMF780+YdWE0g9NCvGk5zETatQLzSEGDI
         YbdcKjIq8OZteo00dT3BzKghAISmvQIYOzyUpESRGIiO7i/OMNljR0mvOefxJPZNbeS2
         KUGw==
X-Gm-Message-State: AGRZ1gIXHUAzLSC4DZH4Eyz3DD1lo7FrdfcJ/RDw7e2HGGnwrPniYGyt
        Zn6+ilX/0Wg/wowEAQwaQbGGb2nl
X-Google-Smtp-Source: AJdET5cn3zQY6n1lbifAAUoVNdmwyIQNxEdwl2DYSn1zBIYM7C8w5n/itH8TUgat1R6oygH+MMbgtA==
X-Received: by 2002:a62:114c:: with SMTP id z73-v6mr1019805pfi.192.1540947589343;
        Tue, 30 Oct 2018 17:59:49 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:e9fd:d0f6:3e3:43a5? ([2601:647:4800:973f:e9fd:d0f6:3e3:43a5])
        by smtp.gmail.com with ESMTPSA id n63-v6sm30096140pfn.9.2018.10.30.17.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 17:59:48 -0700 (PDT)
Subject: Re: [PATCH 07/16] blk-mq: support multiple hctx maps
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-8-axboe@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1e523ea4-1134-c299-281d-0dad276825d2@grimberg.me>
Date:   Tue, 30 Oct 2018 17:59:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-8-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 1821f448f7c4..8329017badc8 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -72,20 +72,37 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
>    */
>   extern int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int);
>   
> -static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
> -						     unsigned int flags,
> -						     unsigned int cpu)
> +/*
> + * blk_mq_map_queue_type() - map (hctx_type,cpu) to hardware queue
> + * @q: request queue
> + * @hctx_type: the hctx type index
> + * @cpu: CPU
> + */
> +static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *q,
> +							  unsigned int hctx_type,
> +							  unsigned int cpu)
>   {
>   	struct blk_mq_tag_set *set = q->tag_set;
>   
> -	return q->queue_hw_ctx[set->map[0].mq_map[cpu]];
> +	return q->queue_hw_ctx[set->map[hctx_type].mq_map[cpu]];
>   }
>   
> -static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *q,
> -							  unsigned int hctx_type,
> -							  unsigned int cpu)
> +/*
> + * blk_mq_map_queue() - map (cmd_flags,type) to hardware queue
> + * @q: request queue
> + * @flags: request command flags
> + * @cpu: CPU
> + */
> +static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
> +						     unsigned int flags,
> +						     unsigned int cpu)
>   {
> -	return blk_mq_map_queue(q, hctx_type, cpu);
> +	int hctx_type = 0;
> +
> +	if (q->mq_ops->flags_to_type)
> +		hctx_type = q->mq_ops->flags_to_type(q, flags);

nitpick: I think that rq_flags_to_type is a bit more descriptive here.
just a personal opinion.

Other than that,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
