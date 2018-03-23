Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeCWQvw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:51:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56732 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbeCWQvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:51:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2845B601D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v5 3/5] bnx2x: Eliminate duplicate barriers on
 weakly-ordered archs
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ariel.elior@cavium.com, everest-linux-l2@cavium.com,
        linux-kernel@vger.kernel.org
References: <1521738603-23596-4-git-send-email-okaya@codeaurora.org>
 <20180323.122035.1380806748695640531.davem@davemloft.net>
 <cb6a0522-2c53-b252-49db-5779d24963c6@codeaurora.org>
 <20180323.124326.2170503491903886041.davem@davemloft.net>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <4bd9ccd2-df8f-acad-2513-eefe065dc852@codeaurora.org>
Date: Fri, 23 Mar 2018 12:51:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323.124326.2170503491903886041.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/2018 12:43 PM, David Miller wrote:
> From: Sinan Kaya <okaya@codeaurora.org>
> Date: Fri, 23 Mar 2018 12:31:12 -0400
> 
>> Sorry, you got me confused now.
>>
>> If you look at the code closer, you'll see this.
>>
>> 	wmb();
>>
>> 	txdata->tx_db.data.prod += nbd;
>> 	barrier();
>>
>> 	DOORBELL(bp, txdata->cid, txdata->tx_db.raw);
>>
>> and you also asked me to rename DOORBELL to DOORBELL_RELAXED() to make
>> it obvious that we have a relaxed operator inside the macro.
> 
> This still doesn't match the stated pattern.

I can certainly update the commit text for this or spin into its own
patch to make it obvious.

> 
> 	wmb();
> 	/* no other memory or I/O or IOMEM operation */
> 	writel();
> 
> There is a write to a producer index there and then no non-compiler
> barrier or any kind before the writel().
> 
> So, in fact, it might really need that implicit writel() barrier here!
> 

It could if txdata->tx_db was not a union. There is a data dependency
between txdata->tx_db.data.prod and txdata->tx_db.raw. 

So, no reordering.

I can argue that barrier() here is useless in fact.

Anyhow, I'll spin this piece out of this patch so that we pay special
attention with a better description.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
