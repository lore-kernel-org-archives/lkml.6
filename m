Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBE8C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25092081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25092081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbeJaJou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 05:44:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39124 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbeJaJot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 05:44:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id b5-v6so5773048pla.6;
        Tue, 30 Oct 2018 17:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AuchJ4ddeGBgfUQQTngTi9H89jpGpqNIPneuiFWnjRU=;
        b=Et38WGzMKHybJqp9gQjbLoY6izosLXd9it6PI4DlJNYphlIRy6IVBiCrEUBEhkAfRp
         6iriJ8L7u4fAU2FUhmbmJyOleTqo2fUwcvPUpmjJ7EiOVBtBf8Grcu0z3Q3OMRdw5sBM
         c5bGyid4+5otbnO1RYfVww9ZIQCIkhjmixU8sVhs7WJalae8oUrDTxngR8XYDsaeD+Cu
         Dtb4CjUKUjCHhMPm4W3gVp+Hmbb1EECREBYsFlATHklmFAEyt3p5feFUL0qy17R1dDJv
         88XTMs2iaB7YXJDwuOgdyXKSHXJcVL3dpEYBokiulBls1B+Riyd41sLY27MLvx+KIH8K
         6gVg==
X-Gm-Message-State: AGRZ1gK6ya7R09cHhCUg/2i+cIB3Hxx5DEhZlKJhx/GSShlSpMfib7sU
        MXd0bBXJ1jj4xyVlorladm/9KS+r
X-Google-Smtp-Source: AJdET5ecIsDRi6DnsOmTxfYehg/03yDG0z5+blD8ncKkyOgFWJ0IuHbWjzh0GgAwTarmucxaE4da7Q==
X-Received: by 2002:a17:902:28a8:: with SMTP id f37-v6mr1022667plb.264.1540946944204;
        Tue, 30 Oct 2018 17:49:04 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:e9fd:d0f6:3e3:43a5? ([2601:647:4800:973f:e9fd:d0f6:3e3:43a5])
        by smtp.gmail.com with ESMTPSA id y85-v6sm34527507pfa.120.2018.10.30.17.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 17:49:03 -0700 (PDT)
Subject: Re: [PATCH 05/16] blk-mq: allow software queue to map to multiple
 hardware queues
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-6-axboe@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f5bff9c7-2c94-8988-cf76-318fa0808cf0@grimberg.me>
Date:   Tue, 30 Oct 2018 17:49:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-6-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> @@ -2342,10 +2346,16 @@ static void blk_mq_map_swqueue(struct request_queue *q)
>   
>   		ctx = per_cpu_ptr(q->queue_ctx, i);
>   		hctx = blk_mq_map_queue_type(q, 0, i);
> -
> +		hctx->type = 0;
>   		cpumask_set_cpu(i, hctx->cpumask);
> -		ctx->index_hw = hctx->nr_ctx;
> +		ctx->index_hw[hctx->type] = hctx->nr_ctx;
>   		hctx->ctxs[hctx->nr_ctx++] = ctx;
> +
> +		/*
> +		 * If the nr_ctx type overflows, we have exceeded the
> +		 * amount of sw queues we can support.
> +		 */
> +		BUG_ON(!hctx->nr_ctx);

Was this added because nr_ctx became short? What was the motivation
for that? save space? structure alignment?

Perhaps this should be mentioned in the change log (as it contradicts
that no functional changes exist in this patch). Or, if this can happen
even when 32bit nr_ctx, it should be a separate small patch?
