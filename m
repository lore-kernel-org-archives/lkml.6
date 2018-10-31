Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4769CC6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FCF2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02FCF2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbeJaJdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 05:33:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38908 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbeJaJdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 05:33:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id f8-v6so6490690pgq.5;
        Tue, 30 Oct 2018 17:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Af/vBFxnFO/1ehRDf4VOlISmYa9db9j8LKh1aBAHPgA=;
        b=Ttj3eDa95sgddEcC/q1VLp9RJOq7aOurLu/vhnzGIkghuBBKKLfiB3mpsGqeMhKpZa
         5BZfhP1RiIXPfxm+O5QKBmke/RYCyZjWGP9VzFViHRL4YrOZv27997k6pvSwZk8U9Ct3
         RZpLoGrEManTLieiCKZ+hduSCZFY8lhQrxelXjTr5neNwG2CRTEm/ajRsvnuUucwRo20
         dJxxJTwpOoLAsdNvX8vqQvbN3sGS4TFdp9H8pxe4vWQc9i/9dUqcHER/TRfzF1tZLImD
         tBbiYAXawUi6mfJrrXX7pYrQTQPr3X9zoqkJHuIPjUXfn99gmb3661xMskEmaxd3355U
         L9Ww==
X-Gm-Message-State: AGRZ1gJISc46YuG5oTYHnU3rTw7Uyb1Nla3p46SCMfEQkxmL8FG4iIYW
        WI4iFkC2TN+0vHLriJjDSUNAvoBk
X-Google-Smtp-Source: AJdET5f+iC1ujy5ruM8ylSFQ1hpg/wLxUc8o+9Ey1BA/w7/TW3X7nuGMKI2D4HsYYcBFX46mlaW8eQ==
X-Received: by 2002:a63:1765:: with SMTP id 37-v6mr924687pgx.131.1540946281229;
        Tue, 30 Oct 2018 17:38:01 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:e9fd:d0f6:3e3:43a5? ([2601:647:4800:973f:e9fd:d0f6:3e3:43a5])
        by smtp.gmail.com with ESMTPSA id i13-v6sm9612727pgs.51.2018.10.30.17.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 17:38:00 -0700 (PDT)
Subject: Re: [PATCH 04/16] blk-mq: pass in request/bio flags to queue mapping
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-5-axboe@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <50a9c2d1-abc5-b04f-1f95-878f216a47b1@grimberg.me>
Date:   Tue, 30 Oct 2018 17:37:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-5-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>   static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
> +						     unsigned int flags,
>   						     unsigned int cpu)
>   {
>   	struct blk_mq_tag_set *set = q->tag_set;
> @@ -84,7 +85,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *
>   							  unsigned int hctx_type,
>   							  unsigned int cpu)
>   {
> -	return blk_mq_map_queue(q, cpu);
> +	return blk_mq_map_queue(q, hctx_type, cpu);
>   }

Haven't read through the rest of the patch set, but it looks a bit
strange that a type enumeration is being passed on as flags field.
