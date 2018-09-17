Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CF7ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E13206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E13206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbeIQJXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 05:23:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48203 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbeIQJXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 05:23:17 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 73BD6E6167771;
        Mon, 17 Sep 2018 11:57:44 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Mon, 17 Sep 2018
 11:57:41 +0800
Subject: Re: [PATCH net-next] net/smc: cast sizeof to int for comparison
To:     Andreas Schwab <schwab@linux-m68k.org>
References: <20180915100036.20100-1-yuehaibing@huawei.com>
 <87zhwj6liz.fsf@igel.home>
CC:     <davem@davemloft.net>, <ubraun@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-s390@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <b598de63-f026-c3ff-3380-8b1814f90b82@huawei.com>
Date:   Mon, 17 Sep 2018 11:57:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <87zhwj6liz.fsf@igel.home>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/15 19:35, Andreas Schwab wrote:
> On Sep 15 2018, YueHaibing <yuehaibing@huawei.com> wrote:
> 
>> Comparing an int to a size, which is unsigned, causes the int to become
>> unsigned, giving the wrong result. kernel_sendmsg can return a negative
>> error code.
>>
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
> 
> It would perhaps be better to handle len < 0 first.

That need refactor the err hangding, is worth doing it?

> 
> Andreas.
> 

