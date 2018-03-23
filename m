Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752384AbeCWRNv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:13:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51790 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752025AbeCWRNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:13:49 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 67AC66030F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v5 3/5] bnx2x: Eliminate duplicate barriers on
 weakly-ordered archs
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ariel.elior@cavium.com, everest-linux-l2@cavium.com,
        linux-kernel@vger.kernel.org
References: <cb6a0522-2c53-b252-49db-5779d24963c6@codeaurora.org>
 <20180323.124326.2170503491903886041.davem@davemloft.net>
 <4bd9ccd2-df8f-acad-2513-eefe065dc852@codeaurora.org>
 <20180323.130418.2223623186761161723.davem@davemloft.net>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <b4553d26-b326-15be-dcac-12594ea7c5b5@codeaurora.org>
Date: Fri, 23 Mar 2018 13:13:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323.130418.2223623186761161723.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/2018 1:04 PM, David Miller wrote:
> From: Sinan Kaya <okaya@codeaurora.org>
> Date: Fri, 23 Mar 2018 12:51:47 -0400
> 
>> It could if txdata->tx_db was not a union. There is a data dependency
>> between txdata->tx_db.data.prod and txdata->tx_db.raw. 
>>
>> So, no reordering.
> 
> I don't see it that way, the code requires that:
> 
>  	txdata->tx_db.data.prod += nbd;
> 
> is visible before the doorbell update.> 
> barrier() doesn't provide that.
> 
> Neither does writel_relaxed().  However plain writel() does.

Correct for some architectures including ARM but not correct universally.

writel() just guarantees register read/writes before and after to be
ordered when HW observes it. 

writel() doesn't guarantee that the memory update is visible to the HW
on all architectures.

If you need memory update visibility, that barrier() should have been a
wmb()

A correct multi-arch pattern is

wmb()
writel_relaxed()
mmiowb()

We have decided to drop a similar patch on Infiniband due to incorrect
usage of barrier(). If you feel strongly about it, I can remove the
DOORBELL change.

> 
> Therefore the code is only correct as-is, and your change potentially
> adds a reordering problem.
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
