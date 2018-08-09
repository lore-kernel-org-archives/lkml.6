Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0DEC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C361E21EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcPH6X+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C361E21EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbeHIUIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:08:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33398 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731115AbeHIUIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:08:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id r24-v6so2927475wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 10:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2XhuBmyKjWmTTTvXZEo8tRx6czrBDX0Z7/WnpDy9m14=;
        b=QcPH6X+QoAVsU84yVrs4db8ShfObFZ3LlCLCbzWJ+4haZ7iJkjC3XdffboZhNYgTDp
         8zgqY1S8//Rxtn5oZnjZi+j+rJK8DfL1Qz+Yhgllbf7XY31gGuEpVeAWyn8bO2ldTort
         X6p96ZZumESYiLFeG2ajmWclgW+iOvKOyQS/CmmUmcpmPhWoEcnDMIEKJuaYn+qLikbA
         WXI4fLeDsnN/VmdFFQSuFHyAVkpCwtbfTlIa25A4G67/G9rQ9rnZ5bncmcrK0BYRLVAl
         yF4WzO9xWPyyqm391cS/IECjqB7zMr4XAfBDhF93h8AAhP/r+QdFxFEp+t9NFfMfY9GQ
         Mucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2XhuBmyKjWmTTTvXZEo8tRx6czrBDX0Z7/WnpDy9m14=;
        b=AQCYsOK5lRB2f8gX2ia21RqIz7R4PgzJydCgxWxq3YBWV5Zdqh567Q8PzVoOtqHv6F
         ROW4Cu9vaUwI+DWOyz4gBzCqpRcDECOBucEQx9TIGzrEGX++eQSMS8dYvy7JTP1AzO01
         1I46ZQ8EDAO7ins+eIsXE2JJfZsC295aeuUmFd2RysrMDogPA1YmKw1f/X1oLNUhGRLq
         4g/0HlnfYyiZ+8ohHKUtw5nfPvogYeC4aijzGnkmQIF6eDl/R09W2FLPqygli8u+4j1I
         EACqXNGlB69YCuUuXssl/d8Ty2CVDfI9/BNNDIw9c5Jrn7jZFTbsP5IduLHjeX4Wdjyd
         8u0g==
X-Gm-Message-State: AOUpUlEBfc9p+gfzoNCRrUpPMat8V60uZ8lO7Ejba5gRFcAxQlCzDe1W
        UDhRf2THEvFmr6zrFA/V4rdQxxzV
X-Google-Smtp-Source: AA+uWPzhqjR4nf4baQM+B5DzhSRp92spIJHfTuDbbVTxJigeFE6Iy0sAz46olUFQebNyKWqsqS1wiQ==
X-Received: by 2002:a1c:dc89:: with SMTP id t131-v6mr2399313wmg.50.1533836540790;
        Thu, 09 Aug 2018 10:42:20 -0700 (PDT)
Received: from ?IPv6:2a02:8108:85c0:57c8:32db:916d:97a2:c4eb? ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id n12-v6sm4977430wrm.62.2018.08.09.10.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 10:42:20 -0700 (PDT)
Subject: Re: [PATCH 3/5] staging: rtl8188eu: use is_multicast_ether_addr in
 rtw_xmit.c
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180809170131.29279-1-straube.linux@gmail.com>
 <20180809170131.29279-3-straube.linux@gmail.com>
 <e1c49e8a5c93b07542899f1e8b238a70ec89801b.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <d1f2ab32-ff10-9575-ad61-0286ee3811ae@gmail.com>
Date:   Thu, 9 Aug 2018 19:42:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <e1c49e8a5c93b07542899f1e8b238a70ec89801b.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/18 7:13 PM, Joe Perches wrote:
> On Thu, 2018-08-09 at 19:01 +0200, Michael Straube wrote:
>> Use is_multicast_ether_addr instead of custom IS_MCAST in
>> core/rtw_xmit.c.
> 
> Have you verified that all accesses are __aligned(2) ?
> 
> If so, please state that in the patch description.
> 
>> diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
> []
>> @@ -460,10 +460,10 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
>>   	if ((pattrib->ether_type == ETH_P_ARP) || (pattrib->ether_type == ETH_P_PAE) || (pattrib->dhcp_pkt == 1))
>>   		rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_SPECIAL_PACKET, 1);
>>   
>> -	bmcast = IS_MCAST(pattrib->ra);
>> +	mcast = is_multicast_ether_addr(pattrib->ra);
> 
> i.e.:  is pattrib->ra __aligned(2) ?
> 
> etc...
> 

Hi Joe,

I looked at the function comment for is_multicast_ether_addr in etherdevice.h.
There is not mentioned that __aligned(2) is required. If it is, I will check.

So, is it required although it's not mentioned for is_multicast_ether_addr?

Thanks,
Michael




