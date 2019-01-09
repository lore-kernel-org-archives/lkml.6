Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEC5C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7EA2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qLpMAXKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfAIBZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:25:52 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:45796 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbfAIBZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 20:25:52 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x091O0mE122455;
        Wed, 9 Jan 2019 01:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=xM8IWqHOSj+73Zz5F/OaVEMSCY+NXIbMroPaQzX7ZY0=;
 b=qLpMAXKB0S7emwm6na2jYsYuNTG6GnAWxZgfcacCutCspLQqouNOvBFpEBoiDYfEasaW
 i2YdcH09ts52Aq0Cxxw8/TFLpemsYy1ZhPGhR4P6404xTEjzdUn/r908j/oQxkxX+7sA
 binK2D/QXQ1MHCFknqGywUQmjr/28llWNCQWqqJ7Ib2cmgocRtFVxoeZQo8zqWUUPxA3
 h+/9C4N6xeQyPf9oFfucB3+k7AK9vx/RbcKnmw89rPHpI1HrXQ2CyezvjAM36jiNsMU5
 oBmVQv9Sx81FaBJkOArEG0krSH/vOfaug9S8G3hmRwoqR2kYnNQhfn8zG/AQGn2bAKGE FA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2ptj3dy0bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jan 2019 01:25:46 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x091PjSk027040
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Jan 2019 01:25:45 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x091Pj9o004034;
        Wed, 9 Jan 2019 01:25:45 GMT
Received: from [10.182.69.145] (/10.182.69.145)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Jan 2019 17:25:45 -0800
Subject: Re: [PATCH] net: nvidia: forcedeth: Fix two possible concurrency
 use-after-free bugs
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, davem@davemloft.net,
        keescook@chromium.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190108124518.21986-1-baijiaju1990@gmail.com>
 <27392ae0-2c0f-f099-05d8-f9cdbfbd313e@oracle.com>
 <f9ab7ba3-573c-6703-1b01-37a9e0a9b769@gmail.com>
From:   Yanjun Zhu <yanjun.zhu@oracle.com>
Organization: Oracle Corporation
Message-ID: <f87bd4b7-81d5-1f0c-137e-ecbc02753257@oracle.com>
Date:   Wed, 9 Jan 2019 09:24:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f9ab7ba3-573c-6703-1b01-37a9e0a9b769@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9130 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=681
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901090008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/8 20:57, Jia-Ju Bai wrote:
>
>
> On 2019/1/8 20:54, Zhu Yanjun wrote:
>>
>> 在 2019/1/8 20:45, Jia-Ju Bai 写道:
>>> In drivers/net/ethernet/nvidia/forcedeth.c, the functions
>>> nv_start_xmit() and nv_start_xmit_optimized() can be concurrently
>>> executed with nv_poll_controller().
>>>
>>> nv_start_xmit
>>>    line 2321: prev_tx_ctx->skb = skb;
>>>
>>> nv_start_xmit_optimized
>>>    line 2479: prev_tx_ctx->skb = skb;
>>>
>>> nv_poll_controller
>>>    nv_do_nic_poll
>>>      line 4134: spin_lock(&np->lock);
>>>      nv_drain_rxtx
>>>        nv_drain_tx
>>>          nv_release_txskb
>>>            line 2004: dev_kfree_skb_any(tx_skb->skb);
>>>
>>> Thus, two possible concurrency use-after-free bugs may occur.
>>>
>>> To fix these possible bugs,
>>
>>
>> Does this really occur? Can you reproduce this ?
>
> This bug is not found by the real execution.
> It is found by a static tool written by myself, and then I check it by 
> manual code review.

Before "line 2004: dev_kfree_skb_any(tx_skb->skb); ",

"

                 nv_disable_irq(dev);
                 nv_napi_disable(dev);
                 netif_tx_lock_bh(dev);
                 netif_addr_lock(dev);
                 spin_lock(&np->lock);
                 /* stop engines */
                 nv_stop_rxtx(dev);   <---this stop rxtx
                 nv_txrx_reset(dev);
"

In this case, does nv_start_xmit or nv_start_xmit_optimized still work well?

Zhu Yanjun

>
>
> Best wishes,
> Jia-Ju Bai
