Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FE0C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 18:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5266A252C7
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 18:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5266A252C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751665AbeFXSH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 14:07:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53590 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbeFXSHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 14:07:55 -0400
Received: by mail-wm0-f65.google.com with SMTP id x6-v6so6807759wmc.3;
        Sun, 24 Jun 2018 11:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sY8k+51LcoTqNjd5h6jQX9iWxQiiFeU02dMZ1Rzhtgo=;
        b=jFYqKlL2U1VvzgTytPL/pC5qQBKXmAFXDfXXoYTTYMqtd16Zb1NgjePwLEJfR/1r0q
         xTH/G5ZscMh7uXDGopZUR+CtVGpRK/ipLmZlK4zhbZ0jbSLWZJCArGUGot1wgiilGyZB
         cPw9Zq3h3V/koA4P47UMC7VNU4nv/zqbnySjfqp/p9vymHs02JUXSAJL8hzWpBi701Xc
         x6hexiRCuxXReENatznvQ2hme57sa61l+Cp24seHexhyJq6Z+tRNSeGdUKOq2wa5ZOZ9
         fxjzW8TyekcNO4sdyd0Xkdt6j0NGVcIxm/dE/GvwxwgLD//XV1HGi5Ep/J62URl2gsuq
         sjVQ==
X-Gm-Message-State: APt69E1nTNlDQkpjRMI39Fuy+jinMQkYJWEdjAN7uqtvbOBisEP3HKLS
        /gykL0sy15B5Xx3u5FLO0Sn366b1
X-Google-Smtp-Source: ADUXVKKRO3jL5BK1Wv+MREU2FS/g1t1ETt0BNrmTlIIKj3lKti7NPSADu8G4WugkPssj6HpOXETkHw==
X-Received: by 2002:a1c:da4e:: with SMTP id r75-v6mr7103430wmg.64.1529863673466;
        Sun, 24 Jun 2018 11:07:53 -0700 (PDT)
Received: from [192.168.64.169] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q17-v6sm12976061wrr.7.2018.06.24.11.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 11:07:52 -0700 (PDT)
Subject: Re: [PATCH 5/5] nvme: use __blk_mq_complete_request in timeout path
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com, keith.busch@intel.com,
        josef@toxicpanda.com, ulf.hansson@linaro.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1529500964-28429-1-git-send-email-jianchao.w.wang@oracle.com>
 <1529500964-28429-6-git-send-email-jianchao.w.wang@oracle.com>
 <20180620143956.GA20950@lst.de>
 <42583ee2-fe9d-39da-b82a-38a27b03fdb3@oracle.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1817441e-6810-ed40-a8fd-403742818aae@grimberg.me>
Date:   Sun, 24 Jun 2018 21:07:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <42583ee2-fe9d-39da-b82a-38a27b03fdb3@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi Christoph
> 
> Thanks for your kindly response.
> 
> On 06/20/2018 10:39 PM, Christoph Hellwig wrote:
>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>> index 73a97fc..2a161f6 100644
>>> --- a/drivers/nvme/host/pci.c
>>> +++ b/drivers/nvme/host/pci.c
>>> @@ -1203,6 +1203,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>>>   		nvme_warn_reset(dev, csts);
>>>   		nvme_dev_disable(dev, false);
>>>   		nvme_reset_ctrl(&dev->ctrl);
>>> +		__blk_mq_complete_request(req);
>>>   		return BLK_EH_DONE;
>>>   	}
>>>   
>>> @@ -1213,6 +1214,11 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>>>   		dev_warn(dev->ctrl.device,
>>>   			 "I/O %d QID %d timeout, completion polled\n",
>>>   			 req->tag, nvmeq->qid);
>>> +		/*
>>> +		 * nvme_end_request will invoke blk_mq_complete_request,
>>> +		 * it will do nothing for this timed out request.
>>> +		 */
>>> +		__blk_mq_complete_request(req);
>>
>> And this clearly is bogus.  We want to iterate over the tagetset
>> and cancel all requests, not do that manually here.
>>
>> That was the whole point of the original change.
>>
> 
> For nvme-pci, we indeed have an issue that when nvme_reset_work->nvme_dev_disable returns, timeout path maybe still
> running and the nvme_dev_disable invoked by timeout path will race with the nvme_reset_work.
> However, the hole is still there right now w/o my changes, but just narrower.

Given the amount of fixes (and fixes of fixes) we had in the timeout 
handler, maybe it'd be a good idea to step back and take a another look?

Won't it be better to avoid disabling the device and return
BLK_EH_RESET_TIMER if we are not aborting in the timeout handler?
