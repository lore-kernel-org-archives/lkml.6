Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAEEC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2935C20824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NcL8KQCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2935C20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeJ3EOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:14:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36307 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeJ3EOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:14:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id j22-v6so710080pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 12:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jeY+Fwl6HjYqJOylmECU/00BZzrbwp9rRqFGzBl6c1k=;
        b=NcL8KQCifc/ycl5p190NvhfY5xh81HqgTKaYBcUhan9v6XkmeymDABhX68OxJlCySY
         h19s/ScyurTfmo/veg4xAl3PgFWKjokKONhpgyyaRisrBmUwkWTCzXnou/K1GDKuRyly
         Xfi1koflBzB0DmtaCLokZ2i+KDKM0QmbUe3PFZmOHmxjAWY0mWOtb2DNXpvE0/oMj3Wp
         mdYDjfiWtFRTGUMeP2q3oAAIdS3duyaGlfQBMqS4ip4VJkLmEBI9xkiX3MtOoKmFrdof
         om6627uNeYH72foGN3glwgTunTT1BWqkeNNwANvml5d9eQeyaiC5/vWX1EE5YQJYDVef
         uDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jeY+Fwl6HjYqJOylmECU/00BZzrbwp9rRqFGzBl6c1k=;
        b=q0ZzQXejQfELruj6y86RQoBsWAkvlB+N6IKVHbMBZGd4jqjUcPepCFpoxvacn7P6cr
         OJxx/AHIDXCLtV4hMdsndAez2MUvF7QO+/6/fOVpLBtioE/xTh40Fv13bm+bhOAliUKY
         iWiYpe+PfXvZSyuGVQMccofwrqeSnKvQvN4eBvtYfWcK78PKx0jXFiYN48g72KfsjGv0
         D9TGoZPfJ2f+1xcPOQpHLVNvWW9WGK7f7gRev4J3AQIiBUGrdEaLpSgSjbTOSccxu2Ub
         Ww58b80BAU6qlYTqxkvl8rF39A9wKsHn1vGcqLBCm9bkwueueRm+9RPqYi7+vDkKGi/5
         g67g==
X-Gm-Message-State: AGRZ1gKYaz8ozY7DPQp41gkFF3YJfdfFQsrvo2qdq/ex2ioXnTdTB4nz
        HN64ODC+QMGJSzULNchFn//Wiv20Z/Y=
X-Google-Smtp-Source: AJdET5dNA1E+BEMRIrgscRfKA15uTlOS/2ltmziGLf56ps5b3kpDM/5qiXxNjdkvRRQBwKtqs9TJfw==
X-Received: by 2002:a63:484c:: with SMTP id x12mr8053533pgk.375.1540841066314;
        Mon, 29 Oct 2018 12:24:26 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id s85-v6sm33527281pfi.15.2018.10.29.12.24.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 12:24:25 -0700 (PDT)
Subject: Re: [PATCH 07/14] blk-mq: support multiple hctx maps
To:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181029163738.10172-1-axboe@kernel.dk>
 <20181029163738.10172-8-axboe@kernel.dk> <1540836903.196084.70.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <214cdac8-9c13-213b-023f-2fb1bf67c8db@kernel.dk>
Date:   Mon, 29 Oct 2018 13:24:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540836903.196084.70.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/18 12:15 PM, Bart Van Assche wrote:
> On Mon, 2018-10-29 at 10:37 -0600, Jens Axboe wrote:
>> -static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
>> -						     unsigned int flags,
>> -						     int cpu)
>> +static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *q,
>> +							  int type, int cpu)
>>  {
>>  	struct blk_mq_tag_set *set = q->tag_set;
>>  
>> -	return q->queue_hw_ctx[set->map[0].mq_map[cpu]];
>> +	return q->queue_hw_ctx[set->map[type].mq_map[cpu]];
>>  }
>>  
>> -static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *q,
>> -							  int type, int cpu)
>> +static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
>> +						     unsigned int flags,
>> +						     int cpu)
>>  {
>> -	return blk_mq_map_queue(q, type, cpu);
>> +	int type = 0;
>> +
>> +	if (q->mq_ops->flags_to_type)
>> +		type = q->mq_ops->flags_to_type(q, flags);
>> +
>> +	return blk_mq_map_queue_type(q, type, cpu);
>>  }
> 
> How about adding a comment above both these functions that explains their
> purpose? Since blk_mq_map_queue() maps rq->cmd_flags and the cpu index to
> a hardware context, how about renaming blk_mq_map_queue() into
> blk_mq_map_cmd_flags()?

I don't want to rename it, but I've added a kerneldoc function header to
both of them.

>> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
>> index f9e19962a22f..837087cf07cc 100644
>> --- a/include/linux/blk-mq.h
>> +++ b/include/linux/blk-mq.h
>> @@ -86,6 +86,7 @@ enum {
>>  
>>  struct blk_mq_tag_set {
>>  	struct blk_mq_queue_map	map[HCTX_MAX_TYPES];
>> +	unsigned int		nr_maps;
>>  	const struct blk_mq_ops	*ops;
>>  	unsigned int		nr_hw_queues;
>>  	unsigned int		queue_depth;	/* max hw supported */
>> @@ -109,6 +110,7 @@ struct blk_mq_queue_data {
>>  
>>  typedef blk_status_t (queue_rq_fn)(struct blk_mq_hw_ctx *,
>>  		const struct blk_mq_queue_data *);
>> +typedef int (flags_to_type_fn)(struct request_queue *, unsigned int);
> 
> How about adding a comment that the format of the second argument of
> flags_to_type_fn is the same as that of rq->cmd_flags?

Done

-- 
Jens Axboe

