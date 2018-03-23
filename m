Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeCWQbS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:31:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53144 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeCWQbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:31:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4809560588
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v5 3/5] bnx2x: Eliminate duplicate barriers on
 weakly-ordered archs
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ariel.elior@cavium.com, everest-linux-l2@cavium.com,
        linux-kernel@vger.kernel.org
References: <1521738603-23596-1-git-send-email-okaya@codeaurora.org>
 <1521738603-23596-4-git-send-email-okaya@codeaurora.org>
 <20180323.122035.1380806748695640531.davem@davemloft.net>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <cb6a0522-2c53-b252-49db-5779d24963c6@codeaurora.org>
Date: Fri, 23 Mar 2018 12:31:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323.122035.1380806748695640531.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/2018 12:20 PM, David Miller wrote:
> From: Sinan Kaya <okaya@codeaurora.org>
> Date: Thu, 22 Mar 2018 13:10:00 -0400
> 
>> Code includes wmb() followed by writel(). writel() already has a
>> barrier on some architectures like arm64.
>  ...
>> @@ -4155,7 +4155,7 @@ netdev_tx_t bnx2x_start_xmit(struct sk_buff *skb, struct net_device *dev)
>>  	txdata->tx_db.data.prod += nbd;
>>  	barrier();
>>  
>> -	DOORBELL(bp, txdata->cid, txdata->tx_db.raw);
>> +	DOORBELL_RELAXED(bp, txdata->cid, txdata->tx_db.raw);
>>  
>>  	mmiowb();
>  ...
>> @@ -2592,7 +2592,7 @@ static int bnx2x_run_loopback(struct bnx2x *bp, int loopback_mode)
>>  
>>  	txdata->tx_db.data.prod += 2;
>>  	barrier();
>> -	DOORBELL(bp, txdata->cid, txdata->tx_db.raw);
>> +	DOORBELL_RELAXED(bp, txdata->cid, txdata->tx_db.raw);
> 
> These are compiler barriers being used here, not wmb().
> 
> Look, if I can't see a clear:
> 
> 	wmb()
> 	writel()
> 
> sequence in the patch hunks, I am going to keep pushing back on
> these changes.

Sorry, you got me confused now.

If you look at the code closer, you'll see this.

	wmb();

	txdata->tx_db.data.prod += nbd;
	barrier();

	DOORBELL(bp, txdata->cid, txdata->tx_db.raw);

and you also asked me to rename DOORBELL to DOORBELL_RELAXED() to make
it obvious that we have a relaxed operator inside the macro.

Did I miss something?

of course, treating barrier() universally as a write barrier is wrong.

> 
> Thank you.
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
