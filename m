Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABEDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0B42054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lba8EueQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0B42054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbeJaXQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:16:00 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:36345 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729463AbeJaXP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:15:59 -0400
Received: by mail-io1-f50.google.com with SMTP id o19-v6so9779666iod.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 07:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5UpullBLVcT/e6vPfRg78NsTkfPPe4/w8oFXT4PilmA=;
        b=lba8EueQnK78efeF9qGMYV5J0rVPNt9iIROLA3aUpB3IUhSvB2xP484EJ2C7DcmFvi
         JUCfZFf2eSvDA3vmOac0O0RqL90JKbfH1spJmJw2CptZ44bb6BFL4EA6445gGiBz0vy7
         0lPOOTjq7LaqGCIgiywH8E3xIDdQrTnA4qxPUHxo9yefL1kdISSWeEOh/GVmnUQUaaOf
         r8gTQXoshJTRJl9TnykIsFpYzM13Mil81zgutsGIWn8eMyY/bQc6J+ETzVw/Wr4/7aA3
         SVFEFwPriKRSQ4PNiMKj2yHrYdFFRsG001kxc81wR5zA49mdfqn1TC3gT3s666KR/p92
         BdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5UpullBLVcT/e6vPfRg78NsTkfPPe4/w8oFXT4PilmA=;
        b=KI2fM2QMguclzF+ZabkkmAyAHtoDgXlDRfpDI8PV0eQ1PsrIvYL4iJmW21I+KyIEjE
         nRRVSc4UxPEDCWGMhq67fdeJ859FNPLWVe60g9aPjnLwpl3z/Ed/BbLpiyohKmgZ03Hc
         6YBWyHuCh/OQdtCTNXI8LqC6Luri8OdabSDm2eQ/oHr5MZ0p0U1x6P6J5QwWINpEtDAS
         H6UcwEMAy+NFQ60RHITQGZ7QCPLQRnawj4GHc/PatiBUFm6M7A9ovM2bFSEM6QupsZA6
         STA561cIsRSyusBkjIu+l4A/l8J39CaGIvKzr6R9wgh7zlQhmgnJFa2bkQgBkrijYMhS
         Iz/A==
X-Gm-Message-State: AGRZ1gJ6pNRCNnqTqmh23toqBDjvUEYfeETwFK3Xmkmm8d1u7HbrQt9t
        LLy/QO7ec5MP14Rc3671uCZOcA7xwtk=
X-Google-Smtp-Source: AJdET5d+CRyioTZxlx2kgUQJNk6GyA5VkuXq+sOQqohkIUDLrnX+87oXx6XKsjtxGiX0q+YOwUITcA==
X-Received: by 2002:a6b:590d:: with SMTP id n13-v6mr2248148iob.176.1540995465911;
        Wed, 31 Oct 2018 07:17:45 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k133-v6sm9955191itb.16.2018.10.31.07.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 07:17:44 -0700 (PDT)
Subject: Re: [PATCH 02/16] blk-mq: abstract out queue map
To:     Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-3-axboe@kernel.dk>
 <725b4d35-2390-58d9-4041-0bac6de6cd77@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cc5771b1-5ca9-8463-f575-9f5f9cad4fe3@kernel.dk>
Date:   Wed, 31 Oct 2018 08:17:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <725b4d35-2390-58d9-4041-0bac6de6cd77@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 6:31 PM, Sagi Grimberg wrote:
> 
>> @@ -41,12 +41,12 @@ int blk_mq_rdma_map_queues(struct blk_mq_tag_set *set,
>>   			goto fallback;
>>   
>>   		for_each_cpu(cpu, mask)
>> -			set->mq_map[cpu] = queue;
>> +			set->map[0].mq_map[cpu] = queue;
> 
> Any reason not to change the signature like the other mappers?

No particular reason, outside of not wanting to touch more than
I had to.

-- 
Jens Axboe

