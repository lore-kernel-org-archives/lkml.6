Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F430C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E34B20657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vSXuM0Nb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E34B20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeJ3CRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:17:35 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53522 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbeJ3CRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:17:35 -0400
Received: by mail-it1-f194.google.com with SMTP id f16-v6so2975669ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 10:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=JJa4QjoSR7L22FTHEbArzuX5XAjy0u6zdPaUR1soXoY=;
        b=vSXuM0NbPe7SJFVDhz2NwqfenB+PxlHmphZC1N3Me+JI8StTQZyoTnf5PEa9d1P51j
         xjJ3//MjEb2SS+cqxXIWyZ0XJTyxkp9fKVu0LTfQ8XvN6MnvfkQUm87qonja/vblFpw8
         adozznn34DJ1FRIL/wDqdgPrzvMcHpH7SBHbddCXDipLRgq7DTlUbbWAI6TOC0U0CEUS
         /d5PFOcbbRKfOzKIYCTdW/8ZmiRwZa/Ptviw6yoesyH9kMz8pcrgKXZQvkVKIFNh74FO
         /EYopAtGXplDWpcxI4oQSqd8Jv2V+VypH6/aJnkOBQgrPQ6hCPw0wLb7NdyHtRpZfrUN
         nx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JJa4QjoSR7L22FTHEbArzuX5XAjy0u6zdPaUR1soXoY=;
        b=LOu9cziV53sDLvIAo//2Ag5vzTQCaG29rhJe+OkkAxAeYCQFo5ifNkh+K9S9rRA4ku
         8HPiXahVYXHvjMp2C7Q+AJbwDMNw71kgnq8z+FQdh6Ym0GFFtTh8LqS2lzpuo1Styv3S
         M2dDBKy4qctxloEKMMopBRyzcchqlDTGdlB8WTifXj48YRXN1VusBXtAxZo1SHkOOTVn
         NCeEd8Z9AUU4ECLJlie7cCUNsZFKqL9zezZ9l76ypFBrQkmIa6z/YxHiSFy1eEzQUCQR
         7NJWsiE7YJSDgz03tZs8KtSi0ONJtmRTsfAf9j0WPOAlr/RVVoe6sO6oYixr0EdOHaHb
         UTTg==
X-Gm-Message-State: AGRZ1gKQUzDo53r9sCQz5hdyx/ZnmGwy1x/UU2JkF+VyY8GBJGrJd/B5
        4gInp2RTkMxpkG/wAYDWfcrvPNO5yr4=
X-Google-Smtp-Source: AJdET5c6+scwurXJEeZRxqXSCjDPyFRd/cQsx8k5NGCLy271EYt5QJETuS5swm+cu4jrBj018J564Q==
X-Received: by 2002:a24:bc5:: with SMTP id 188-v6mr10691393itd.172.1540834080375;
        Mon, 29 Oct 2018 10:28:00 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q185-v6sm5425995itc.30.2018.10.29.10.27.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 10:27:59 -0700 (PDT)
Subject: Re: [PATCH 03/14] blk-mq: provide dummy blk_mq_map_queue_type()
 helper
To:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181029163738.10172-1-axboe@kernel.dk>
 <20181029163738.10172-4-axboe@kernel.dk> <1540833779.196084.56.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ac06591d-f3de-514d-7d29-cbfc34ffeb1c@kernel.dk>
Date:   Mon, 29 Oct 2018 11:27:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540833779.196084.56.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/18 11:22 AM, Bart Van Assche wrote:
> On Mon, 2018-10-29 at 10:37 -0600, Jens Axboe wrote:
>> diff --git a/block/blk-mq.h b/block/blk-mq.h
>> index 889f0069dd80..79c300faa7ce 100644
>> --- a/block/blk-mq.h
>> +++ b/block/blk-mq.h
>> @@ -80,6 +80,12 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
>>  	return q->queue_hw_ctx[set->map[0].mq_map[cpu]];
>>  }
>>  
>> +static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *q,
>> +							  int type, int cpu)
>> +{
>> +	return blk_mq_map_queue(q, cpu);
>> +}
>> +
>>  /*
>>   * sysfs helpers
>>   */
> 
> How about renaming 'type' into something like hw_ctx_type to make it more
> clear what its meaning is? How about declaring both the 'type' and 'cpu'
> arguments as unsigned ints?

I can do that. For the CPU type, the existing prototype is already
int for CPU. But may as well just update them both in the same patch.

-- 
Jens Axboe

