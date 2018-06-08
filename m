Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pmhfKDsNG1v0ZAAAmS7hNA
	; Fri, 08 Jun 2018 23:11:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 93E336089E; Fri,  8 Jun 2018 23:11:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 154E1607A4;
	Fri,  8 Jun 2018 23:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 154E1607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753107AbeFHXLw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 19:11:52 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.47]:34074 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752910AbeFHXLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 19:11:51 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id C03237818
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jun 2018 18:11:50 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id RQXufMjVASjJARQXufwMwR; Fri, 08 Jun 2018 18:11:50 -0500
X-Authority-Reason: nr=8
Received: from [187.192.46.223] (port=45286 helo=[192.168.1.70])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89_1)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fRQXu-002jhO-BJ; Fri, 08 Jun 2018 18:11:50 -0500
Subject: Re: [PATCH] IB/mlx5: Fix memory leak in mlx5_ib_create_flow
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Raed Salem <raeds@mellanox.com>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180607191915.GA9092@embeddedor.com>
 <20180608230835.GA24392@ziepe.ca>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <809fbf8a-e37d-2e92-cecb-37653e38290c@embeddedor.com>
Date: Fri, 8 Jun 2018 18:11:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180608230835.GA24392@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.46.223
X-Source-L: No
X-Exim-ID: 1fRQXu-002jhO-BJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.70]) [187.192.46.223]:45286
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>   
>>   	mutex_lock(&dev->flow_db->lock);
>>   
>> @@ -3640,6 +3646,9 @@ static struct ib_flow *mlx5_ib_create_flow(struct ib_qp *qp,
>>   	kfree(ucmd);
>>   	kfree(handler);
>>   	return ERR_PTR(err);
>> +free_ucmd:
>> +	kfree(ucmd);
>> +	return ERR_PTR(err);
>>   }
> 
> This hunk is a bit wonky, can we do this instead? handle never needs
> to be freed.
> 
> destroy_ft:
> 	put_flow_table(dev, ft_prio, false);
> 	if (ft_prio_tx)
> 		put_flow_table(dev, ft_prio_tx, false);
> unlock:
> 	mutex_unlock(&dev->flow_db->lock);
> 	kfree(dst);
> free_ucmd:
> 	kfree(ucmd);
> 	return ERR_PTR(err);
> }
> 
> 

Sure thing. I'll send v2 shortly.

Thanks for the feedback.
--
Gustavo
