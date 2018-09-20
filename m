Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A86ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7835214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7835214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbeITGyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 02:54:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40441 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726020AbeITGyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 02:54:43 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CEBD412EF2651;
        Thu, 20 Sep 2018 09:14:01 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.399.0; Thu, 20 Sep 2018
 09:13:45 +0800
Subject: Re: [PATCH -next] RDMA/core: Properly return the error code of
 rdma_set_src_addr_rcu
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <20180919122838.28184-1-yuehaibing@huawei.com>
 <20180919161426.GC9867@ziepe.ca>
CC:     <dledford@redhat.com>, <leon@kernel.org>, <parav@mellanox.com>,
        <danielj@mellanox.com>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <438ee883-31a6-7c9d-fddb-1c3c0f9d654a@huawei.com>
Date:   Thu, 20 Sep 2018 09:13:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180919161426.GC9867@ziepe.ca>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/20 0:14, Jason Gunthorpe wrote:
> On Wed, Sep 19, 2018 at 08:28:38PM +0800, YueHaibing wrote:
>> rdma_set_src_addr_rcu should check copy_src_l2_addr fails,
>> rather than always return 0. Also copy_src_l2_addr should return
>> 'ret' as its return value while rdma_translate_ip fails.
>>
>> Fixes: c31d4b2ddf07 ("RDMA/core: Protect against changing dst->dev during destination resolve")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> Reviewed-by: Parav Pandit <parav@mellanox.com>
>> ---
>>  drivers/infiniband/core/addr.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> Applied to for-next, thanks
> 
>> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
>> index 7a0356c..8a31b11 100644
>> --- a/drivers/infiniband/core/addr.c
>> +++ b/drivers/infiniband/core/addr.c
>> @@ -468,7 +468,7 @@ static int addr_resolve_neigh(const struct dst_entry *dst,
>>  	return ret;
>>  }
>>  
>> -static void copy_src_l2_addr(struct rdma_dev_addr *dev_addr,
>> +static int copy_src_l2_addr(struct rdma_dev_addr *dev_addr,
>>  			     const struct sockaddr *dst_in,
>>  			     const struct dst_entry *dst,
>>  			     const struct net_device *ndev)
> 
> I fixed the indenting as Parav pointed out
> 
>> @@ -492,6 +492,8 @@ static void copy_src_l2_addr(struct rdma_dev_addr *dev_addr,
>>  						RDMA_NETWORK_IPV6;
>>  	else
>>  		dev_addr->network = RDMA_NETWORK_IB;
>> +
>> +	return ret;
>>  }
>>  
>>  static int rdma_set_src_addr_rcu(struct rdma_dev_addr *dev_addr,
>> @@ -499,6 +501,7 @@ static int rdma_set_src_addr_rcu(struct rdma_dev_addr *dev_addr,
>>  				 const struct sockaddr *dst_in,
>>  				 const struct dst_entry *dst)
>>  {
>> +	int ret;
>>  	struct net_device *ndev = READ_ONCE(dst->dev);
>>  
>>  	*ndev_flags = ndev->flags;
>> @@ -515,8 +518,8 @@ static int rdma_set_src_addr_rcu(struct rdma_dev_addr *dev_addr,
>>  			return -ENODEV;
>>  	}
>>  
>> -	copy_src_l2_addr(dev_addr, dst_in, dst, ndev);
>> -	return 0;
>> +	ret = copy_src_l2_addr(dev_addr, dst_in, dst, ndev);
>> +	return ret;
>>  }
> 
> And made this just 'return copy_src_l2_addr' without the ret.

Thank you.

> 
> Jason
> 
> .
> 

