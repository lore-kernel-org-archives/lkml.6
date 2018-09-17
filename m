Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25578ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8865214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8865214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbeIQOIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 10:08:31 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:38469 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeIQOIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 10:08:31 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42DKP80gB5z1qxQN;
        Mon, 17 Sep 2018 10:42:03 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42DKP74HMKz1r45B;
        Mon, 17 Sep 2018 10:42:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id hhH72BPfeCtV; Mon, 17 Sep 2018 10:42:02 +0200 (CEST)
X-Auth-Info: apX/yAMFFAJ7BP0mXwzgOFDe2foS9aoDFfWp/T2uAVG4Fs1bGVrHx4K5YXqI3k5o
Received: from hawking (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 17 Sep 2018 10:42:02 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <davem@davemloft.net>, <ubraun@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-s390@vger.kernel.org>
Subject: Re: [PATCH net-next] net/smc: cast sizeof to int for comparison
References: <20180915100036.20100-1-yuehaibing@huawei.com>
        <87zhwj6liz.fsf@igel.home>
        <b598de63-f026-c3ff-3380-8b1814f90b82@huawei.com>
X-Yow:  I've gotta GO, now!!  I wanta tell you you're a GREAT bunch of guys
 but you ought to CHANGE your UNDERWEAR more often!!
Date:   Mon, 17 Sep 2018 10:42:02 +0200
In-Reply-To: <b598de63-f026-c3ff-3380-8b1814f90b82@huawei.com> (YueHaibing's
        message of "Mon, 17 Sep 2018 11:57:40 +0800")
Message-ID: <mvm8t40zfad.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 17 2018, YueHaibing <yuehaibing@huawei.com> wrote:

> On 2018/9/15 19:35, Andreas Schwab wrote:
>> On Sep 15 2018, YueHaibing <yuehaibing@huawei.com> wrote:
>> 
>>> Comparing an int to a size, which is unsigned, causes the int to become
>>> unsigned, giving the wrong result. kernel_sendmsg can return a negative
>>> error code.
>>>
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>> ---
>>>  net/smc/smc_clc.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
>>> index 83aba9a..fd0f5ce 100644
>>> --- a/net/smc/smc_clc.c
>>> +++ b/net/smc/smc_clc.c
>>> @@ -446,7 +446,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, int smc_type,
>>>  	vec[i++].iov_len = sizeof(trl);
>>>  	/* due to the few bytes needed for clc-handshake this cannot block */
>>>  	len = kernel_sendmsg(smc->clcsock, &msg, vec, i, plen);
>>> -	if (len < sizeof(pclc)) {
>>> +	if (len < (int)sizeof(pclc)) {
>>>  		if (len >= 0) {
>>>  			reason_code = -ENETUNREACH;
>>>  			smc->sk.sk_err = -reason_code;
>> 
>> It would perhaps be better to handle len < 0 first.
>
> That need refactor the err hangding, is worth doing it?

Just a few lines moving around, IFAICS.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
