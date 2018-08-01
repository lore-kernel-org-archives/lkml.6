Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6196BC43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119D520851
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119D520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbeHAE2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 00:28:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10198 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbeHAE2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 00:28:40 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 652C382611FAC;
        Wed,  1 Aug 2018 10:45:19 +0800 (CST)
Received: from [127.0.0.1] (10.121.91.26) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Wed, 1 Aug 2018
 10:45:17 +0800
Subject: Re: [PATCH] timers: fix offset calculation when the expires align
 with LVL_GRAN
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <john.stultz@linaro.org>, <sboyd@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1532669610-103892-1-git-send-email-xuyiping@hisilicon.com>
 <alpine.DEB.2.21.1807301234310.2518@nanos.tec.linutronix.de>
 <c68d9944-1fcc-dcd5-1e3d-07f979323b8c@hisilicon.com>
 <alpine.DEB.2.21.1807311616480.1610@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1807311633430.1610@nanos.tec.linutronix.de>
From:   Xu YiPing <xuyiping@hisilicon.com>
Message-ID: <86709eae-fa35-e36a-cafd-2c917d188276@hisilicon.com>
Date:   Wed, 1 Aug 2018 10:45:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807311633430.1610@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.121.91.26]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/7/31 22:34, Thomas Gleixner wrote:
> 
> 
> On Tue, 31 Jul 2018, Thomas Gleixner wrote:
> 
>> On Tue, 31 Jul 2018, Xu YiPing wrote:
>>> On 2018/7/30 19:03, Thomas Gleixner wrote:
>>>>
>>>> __internal_add_timer(base, timer)
>>>> {  
>>>>    idx = calc_wheel_index(1, 1)
>>>>        {
>>>>            delta = 1 - 1;	<-   0
>>>>
>>>>            if (0 < LVL_START(1))
>>>>                idx = calc_index(1, 0)
>>>>                     {
>>>>                         expires = (1 + LVL_GRAN(0) - 1) >> LVL_SHIFT(0);
>>>> 			----> expires = 0
>>> 			
>>> 			LVL_GRAN(0) = 1 and LVL_SHIFT(0) = 0
>>> 			
>>> 			after the calculation, expires = 1 ?
>>
>> Indeed. You're right. Math is hard... So the index would be 1 and still not
>> fulfil the below:
> 
> Hmm, crap. Let me think about it some more. 34C is way too hot to think.
> 

	when the expire is aligned with LVL_GRAN(x), it could be triggered at expire,
no need to wait another LVL_GRAN(x).

	just a little improvement, useful when expire is small.

> Thanks,
> 
> 	tglx
> 
> .
> 

