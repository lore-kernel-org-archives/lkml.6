Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05E3C46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 01:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741E220824
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 01:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dbsRVL8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741E220824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeJZKOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 06:14:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46130 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeJZKOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 06:14:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id bb7-v6so4684706plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 18:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KUVe3KaxdURq69OjvKSUip0fjXz3j9j/wEMjvhJEVLA=;
        b=dbsRVL8FV3jD15pkgWchlCLbf98LAEStVvMT+r+P92DBfhnt2gMVk1bD1OEX2RkDEU
         NqtOKrx1zU/ZNKwphevl//rHX1MvwIieNL9NSXk6WAwAFi2Pi7kXAoqVxs7k7Ry23W2q
         7Plw9a8bV5WNKREE/u28p/h9WG+0PiFQ4hNJAFLSkc60owJWgcxXW7DTSJScL+/p+w2H
         4lK09gWHN/kQ6Xr4jGWjxmPQ7VXHnyYVnQjA+PHXhY55Vjz15jtogMI7aXcTv9OM9E+B
         yIJAtY6zNMKNfQZdraBrvnBcnvlKkYUuMescUpFTRIkQOw5hKABATApaYjwdxYT9lKVR
         B0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KUVe3KaxdURq69OjvKSUip0fjXz3j9j/wEMjvhJEVLA=;
        b=gPm6uOMOxHQrhcJuUhYCRFPT+8svQ+T5/zB7u2+2ALPnww2UnLZzrkuCO0ctjQ4LzH
         wqcjkyNaENRZLBzHa9HMemjZo9MH/RHW8faPVQRPANU4BIcIasSR44LFDD5QnKO0Z+b+
         uOwQAU+ziqrPPZ77ToaHUYHzFKWZ9hwXHCyjmgDDHB57/3zxlh3XZaqwVMHC4c7JqxJ5
         pJM/jmrGryBt1E1HgzFJtDjpuBhvUiM9sB6qQh+zYNnTUbXUQEY8Vlq6T3DodV2oP742
         uLlUzN9Kljb3Z41GSHCV6xojIBLMsDk0EwEvfvz3hSlyXmn4PvIQBS3pi12ZmG0STjsL
         Xmag==
X-Gm-Message-State: AGRZ1gKQO4OM+T1bJrD8KPOrfSvuxpDV+sPQgpKeM6FVV42PjFsXPUTb
        hECWaxRC1xiGL1PHmlUWFh5KwcT8ak0=
X-Google-Smtp-Source: AJdET5dHtCqh6Jc+sy8/4Xe7ex+4nw1s/35u1X65d3Cwy3otEHIju2MsrgWA+R2h9/Lbb3/rhrN+9w==
X-Received: by 2002:a17:902:a412:: with SMTP id p18-v6mr1525608plq.338.1540517993215;
        Thu, 25 Oct 2018 18:39:53 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 67-v6sm10656505pfk.134.2018.10.25.18.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 18:39:51 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: ensure hctx to be ran on mapped cpu when issue
 directly
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1540394407-20769-1-git-send-email-jianchao.w.wang@oracle.com>
 <a25dbb6a-2ffe-a843-abc4-1a6608c17a49@kernel.dk>
 <ab0ee728-ed8f-7f9e-4318-e07200d936ac@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <354df854-1b0e-6076-c522-d3ee62c98149@kernel.dk>
Date:   Thu, 25 Oct 2018 19:39:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <ab0ee728-ed8f-7f9e-4318-e07200d936ac@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/18 7:38 PM, jianchao.wang wrote:
> Hi Jens
> 
> On 10/26/18 12:25 AM, Jens Axboe wrote:
>> On 10/24/18 9:20 AM, Jianchao Wang wrote:
>>> When issue request directly and the task is migrated out of the
>>> original cpu where it allocates request, hctx could be ran on
>>> the cpu where it is not mapped. To fix this, insert the request
>>> if BLK_MQ_F_BLOCKING is set, check whether the current is mapped
>>> to the hctx and invoke __blk_mq_issue_directly under preemption
>>> disabled.
>>>
>>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>>> ---
>>>  block/blk-mq.c | 17 ++++++++++++++++-
>>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index e3c39ea..0cdc306 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -1717,6 +1717,12 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>>>  {
>>>  	struct request_queue *q = rq->q;
>>>  	bool run_queue = true;
>>> +	blk_status_t ret;
>>> +
>>> +	if (hctx->flags & BLK_MQ_F_BLOCKING) {
>>> +		bypass_insert = false;
>>> +		goto insert;
>>> +	}
>>
>> I'd do a prep patch that moves the insert logic out of this function,
>> and just have the caller do it by return BLK_STS_RESOURCE, for instance.
>> It's silly that we have that in both the caller and inside this function.
> 
> Yes.
> 
>>
>>> @@ -1734,6 +1740,11 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>>>  	if (q->elevator && !bypass_insert)
>>>  		goto insert;
>>>  
>>> +	if (!cpumask_test_cpu(get_cpu(), hctx->cpumask)) {
>>> +		bypass_insert = false;
>>> +		goto insert;
>>> +	}
>>
>> Should be fine to just do smp_processor_id() here, as we're inside
>> hctx_lock() here.
>>
> 
> If the rcu is preemptible, smp_processor_id will not enough here.

True, for some reason I keep forgetting that rcu_*_lock() doesn't
imply preempt_disable() anymore.

-- 
Jens Axboe

