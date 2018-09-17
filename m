Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46E5ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FAD2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FAD2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeIQPFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:05:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12589 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726753AbeIQPFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 11:05:25 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DC27AB63C0407;
        Mon, 17 Sep 2018 17:38:45 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.399.0; Mon, 17 Sep 2018
 17:38:42 +0800
Subject: Re: [PATCH net-next] net/smc: cast sizeof to int for comparison
To:     Ursula Braun <ubraun@linux.ibm.com>
References: <20180915100036.20100-1-yuehaibing@huawei.com>
 <554a145a-d59d-9033-1702-4987a9c4bc94@linux.ibm.com>
CC:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-s390@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <c50b9154-e72b-437b-d0c4-40f2b8943c65@huawei.com>
Date:   Mon, 17 Sep 2018 17:38:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <554a145a-d59d-9033-1702-4987a9c4bc94@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/9/17 16:49, Ursula Braun wrote:
> 
> 
> On 09/15/2018 12:00 PM, YueHaibing wrote:
>> Comparing an int to a size, which is unsigned, causes the int to become
>> unsigned, giving the wrong result. kernel_sendmsg can return a negative
>> error code.
>>
> 
> Thanks for reporting this issue!
> 
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  net/smc/smc_clc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
>> index 83aba9a..fd0f5ce 100644
>> --- a/net/smc/smc_clc.c
>> +++ b/net/smc/smc_clc.c
>> @@ -446,7 +446,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, int smc_type,
>>  	vec[i++].iov_len = sizeof(trl);
>>  	/* due to the few bytes needed for clc-handshake this cannot block */
>>  	len = kernel_sendmsg(smc->clcsock, &msg, vec, i, plen);
>> -	if (len < sizeof(pclc)) {
>> +	if (len < (int)sizeof(pclc)) {
>>  		if (len >= 0) {
>>  			reason_code = -ENETUNREACH;
>>  			smc->sk.sk_err = -reason_code;
>>
> 
> Your fix helps, but I would like to follow the hint of Andreas Schwab, and split
> the return value check like this:
> 
> ---
>  net/smc/smc_clc.c |   14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
> @@ -446,14 +446,12 @@ int smc_clc_send_proposal(struct smc_soc
>  	vec[i++].iov_len = sizeof(trl);
>  	/* due to the few bytes needed for clc-handshake this cannot block */
>  	len = kernel_sendmsg(smc->clcsock, &msg, vec, i, plen);
> -	if (len < sizeof(pclc)) {
> -		if (len >= 0) {
> -			reason_code = -ENETUNREACH;
> -			smc->sk.sk_err = -reason_code;
> -		} else {
> -			smc->sk.sk_err = smc->clcsock->sk->sk_err;
> -			reason_code = -smc->sk.sk_err;
> -		}
> +	if (len < 0) {
> +		smc->sk.sk_err = smc->clcsock->sk->sk_err;
> +		reason_code = -smc->sk.sk_err;
> +	} else if (len < (int)sizeof(pclc)) {
> +		reason_code = -ENETUNREACH;
> +		smc->sk.sk_err = -reason_code;
>  	}
>  
>  	return reason_code;
> 
> Agreed?

Yes, Need a new patch from me?

> 
> Regards, Ursula
> 
> 
> 

