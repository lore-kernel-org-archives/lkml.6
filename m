Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E00C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153D020883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PmqOlPMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfAIDXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 22:23:15 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53744 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfAIDXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 22:23:14 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x093IkIk006372;
        Wed, 9 Jan 2019 03:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=nDTuGwzb2ztOT657bQQ05B52gaR+nwKF5TCGqEJRaRw=;
 b=PmqOlPMdKOwkFkOnPSS16CNR0zZgZ0OrmgZaVM41YbLY4Ora0f3OboFvHJL/2WsISwqy
 ZPsrNJBRQjA39tSOP7VIiWkMTyFkuRJ7GHPj4OKQN7NiSKNBlsjoEBar7lcfMYgATWEW
 8nlP3eiBkAJyROzQIM/ONALdb4KdZy4zXa4Y2ICGLjPDRBl/Hvmdz45Zpc29JekNKCJ3
 eE1uzyEXlnQywRVHLxlMUG63nWOSDavMgfFZAT4qexKyojY+bLeIqlojIs2hJRcIaZMX
 9RixgNSmbvMAp+Lf4s5+mxaAZJdH0mjYw/hC/BDuiebiX1pNmmAjqif/ePlMeXEOMV41 mA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2ptn7qxwn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jan 2019 03:23:09 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x093N9ek012544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Jan 2019 03:23:09 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x093N8oP002607;
        Wed, 9 Jan 2019 03:23:08 GMT
Received: from [10.182.69.170] (/10.182.69.170)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Jan 2019 19:23:08 -0800
Subject: Re: [PATCH] net: nvidia: forcedeth: Fix two possible concurrency
 use-after-free bugs
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, davem@davemloft.net,
        keescook@chromium.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190108124518.21986-1-baijiaju1990@gmail.com>
 <27392ae0-2c0f-f099-05d8-f9cdbfbd313e@oracle.com>
 <f9ab7ba3-573c-6703-1b01-37a9e0a9b769@gmail.com>
 <f87bd4b7-81d5-1f0c-137e-ecbc02753257@oracle.com>
 <a1a71d06-9c1c-7e18-0e24-103fa89facf2@gmail.com>
 <a861dacb-c992-13d7-5458-09445183655b@oracle.com>
 <54c2efce-18ac-46d4-7fb5-8510699b528e@gmail.com>
From:   Yanjun Zhu <yanjun.zhu@oracle.com>
Organization: Oracle Corporation
Message-ID: <cb47b5e1-bac9-b44b-8b47-9e654c7cffc1@oracle.com>
Date:   Wed, 9 Jan 2019 11:24:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <54c2efce-18ac-46d4-7fb5-8510699b528e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9130 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=659
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901090025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/9 11:20, Jia-Ju Bai wrote:
>
>
> On 2019/1/9 10:35, Yanjun Zhu wrote:
>>
>> On 2019/1/9 10:03, Jia-Ju Bai wrote:
>>>
>>>
>>> On 2019/1/9 9:24, Yanjun Zhu wrote:
>>>>
>>>> On 2019/1/8 20:57, Jia-Ju Bai wrote:
>>>>>
>>>>>
>>>>> On 2019/1/8 20:54, Zhu Yanjun wrote:
>>>>>>
>>>>>> 在 2019/1/8 20:45, Jia-Ju Bai 写道:
>>>>>>> In drivers/net/ethernet/nvidia/forcedeth.c, the functions
>>>>>>> nv_start_xmit() and nv_start_xmit_optimized() can be concurrently
>>>>>>> executed with nv_poll_controller().
>>>>>>>
>>>>>>> nv_start_xmit
>>>>>>>    line 2321: prev_tx_ctx->skb = skb;
>>>>>>>
>>>>>>> nv_start_xmit_optimized
>>>>>>>    line 2479: prev_tx_ctx->skb = skb;
>>>>>>>
>>>>>>> nv_poll_controller
>>>>>>>    nv_do_nic_poll
>>>>>>>      line 4134: spin_lock(&np->lock);
>>>>>>>      nv_drain_rxtx
>>>>>>>        nv_drain_tx
>>>>>>>          nv_release_txskb
>>>>>>>            line 2004: dev_kfree_skb_any(tx_skb->skb);
>>>>>>>
>>>>>>> Thus, two possible concurrency use-after-free bugs may occur.
>>>>>>>
>>>>>>> To fix these possible bugs,
>>>>>>
>>>>>>
>>>>>> Does this really occur? Can you reproduce this ?
>>>>>
>>>>> This bug is not found by the real execution.
>>>>> It is found by a static tool written by myself, and then I check 
>>>>> it by manual code review.
>>>>
>>>> Before "line 2004: dev_kfree_skb_any(tx_skb->skb); ",
>>>>
>>>> "
>>>>
>>>>                 nv_disable_irq(dev);
>>>>                 nv_napi_disable(dev);
>>>>                 netif_tx_lock_bh(dev);
>>>>                 netif_addr_lock(dev);
>>>>                 spin_lock(&np->lock);
>>>>                 /* stop engines */
>>>>                 nv_stop_rxtx(dev);   <---this stop rxtx
>>>>                 nv_txrx_reset(dev);
>>>> "
>>>>
>>>> In this case, does nv_start_xmit or nv_start_xmit_optimized still 
>>>> work well?
>>>>
>>>
>>> nv_stop_rxtx() calls nv_stop_tx(dev).
>>>
>>> static void nv_stop_tx(struct net_device *dev)
>>> {
>>>     struct fe_priv *np = netdev_priv(dev);
>>>     u8 __iomem *base = get_hwbase(dev);
>>>     u32 tx_ctrl = readl(base + NvRegTransmitterControl);
>>>
>>>     if (!np->mac_in_use)
>>>         tx_ctrl &= ~NVREG_XMITCTL_START;
>>>     else
>>>         tx_ctrl |= NVREG_XMITCTL_TX_PATH_EN;
>>>     writel(tx_ctrl, base + NvRegTransmitterControl);
>>>     if (reg_delay(dev, NvRegTransmitterStatus, NVREG_XMITSTAT_BUSY, 0,
>>>               NV_TXSTOP_DELAY1, NV_TXSTOP_DELAY1MAX))
>>>         netdev_info(dev, "%s: TransmitterStatus remained busy\n",
>>>                 __func__);
>>>
>>>     udelay(NV_TXSTOP_DELAY2);
>>>     if (!np->mac_in_use)
>>>         writel(readl(base + NvRegTransmitPoll) & 
>>> NVREG_TRANSMITPOLL_MAC_ADDR_REV,
>>>                base + NvRegTransmitPoll);
>>> }
>>>
>>> nv_stop_tx() seems to only write registers to stop transmitting for 
>>> hardware.
>>> But it does not wait until nv_start_xmit() and 
>>> nv_start_xmit_optimized() finish execution.
>> There are 3 modes in forcedeth NIC.
>> In throughput mode (0), every tx & rx packet will generate an interrupt.
>> In CPU mode (1), interrupts are controlled by a timer.
>> In dynamic mode (2), the mode toggles between throughput and CPU mode 
>> based on network load.
>>
>> From the source code,
>>
>> "np->recover_error = 1;" is related with CPU mode.
>>
>> nv_start_xmit or nv_start_xmit_optimized seems related with 
>> ghroughput mode.
>>
>> In static void nv_do_nic_poll(struct timer_list *t),
>> when  if (np->recover_error), line 2004: 
>> dev_kfree_skb_any(tx_skb->skb); will run.
>>
>> When "np->recover_error=1", do you think nv_start_xmit or 
>> nv_start_xmit_optimized will be called?
>
> Sorry, I do not know about these modes...
> But I still think nv_start_xmit() or nv_start_xmit_optimized() can be 
> called here, in no matter which mode :)


:-P

If you have forcedeth NIC, you can make tests with it.:-)
>
>
> Best wishes,
> Jia-Ju Bai
>
