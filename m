Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DF1C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A4020883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oV39gvRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbfAIDVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 22:21:01 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37183 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbfAIDVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 22:21:01 -0500
Received: by mail-pg1-f196.google.com with SMTP id c25so2662000pgb.4;
        Tue, 08 Jan 2019 19:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=SWCXaCtZFfpZUUjAQbyRZvhBG34mDWdsUhu4bEg3TZM=;
        b=oV39gvRHBzPvq92Dm75t+B25/fgdlhQ2HiQEaa8WsIIXCMZSL9Ed9Sy+rgOo9Jowo5
         H9BBOtOBQT73V0JVLJR7IVW3jdLzsJ1nY4MqNIGn4mGpuVgu6FT2I5aRIJpWd+iE8+E1
         zcMxjNOMG6o/pjW70TRcvQN9wRT42Q3Ko9Hw3914NWTywOY3eUMKDHiUtX5btLAB0JSj
         62CDZglR5qCTHN0F9ij6HMI972vP7fITfWRUHf8Gxn0zThS+oZSIWtCydqnuxRRUHThf
         OytfPWeHGzUBx7dNWpLPyTXRLXH2z1mlJsTSAquLV3Fn7z7dUDeJgKIrMAfiSPzwFf/O
         CSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SWCXaCtZFfpZUUjAQbyRZvhBG34mDWdsUhu4bEg3TZM=;
        b=Z8ZnCdrLXKLynZe72lcdZTRy4yiHJm9N2Zg2oy34PM/aT/+fhZGHnd9N0sZp5zSrq2
         tWoTKqDukwBQBkP94PwfrzqVTiZ95FRMS2A3D7i3A65wizMcp4VoDVdvlGW8GaKdZdgQ
         Ymwf8vtPtvc8hwsxL7970XdIyztKG1zIgmr1ul01n/dURayGRv+UkXuFA1izvLzJLxKR
         IU7yYN7Zgst+eBSNWORlETUMZEpYnYhWGeGkHsla6yEdkznZyA5RzBi4lyOgxgjGHtq0
         jrVPAD0q/4kTaJkd9smMtZQqixPduICbkzrlCVHLdqWavK9xoFRh/6yEIOfgrpbiqmfU
         CGMw==
X-Gm-Message-State: AJcUukcLzy3DDkzmsWGnGkuvOvPt4GpT59mwxnQI/HHSDeur7ReDrA3n
        +Vd23hPypoPtQFrqsiWy+y3yAnwR
X-Google-Smtp-Source: ALg8bN47U8npreO+GMs2tbZG3Dlv/tUDLhKXni+GlofRX/rzS2qziUpGPlRK5lLsSAi+Dv2OfzIz0w==
X-Received: by 2002:a65:4904:: with SMTP id p4mr3914816pgs.384.1547004059632;
        Tue, 08 Jan 2019 19:20:59 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.59? ([2402:f000:1:1501:200:5efe:a66f:473b])
        by smtp.gmail.com with ESMTPSA id 24sm295301867pfl.32.2019.01.08.19.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 19:20:58 -0800 (PST)
Subject: Re: [PATCH] net: nvidia: forcedeth: Fix two possible concurrency
 use-after-free bugs
To:     Yanjun Zhu <yanjun.zhu@oracle.com>, davem@davemloft.net,
        keescook@chromium.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190108124518.21986-1-baijiaju1990@gmail.com>
 <27392ae0-2c0f-f099-05d8-f9cdbfbd313e@oracle.com>
 <f9ab7ba3-573c-6703-1b01-37a9e0a9b769@gmail.com>
 <f87bd4b7-81d5-1f0c-137e-ecbc02753257@oracle.com>
 <a1a71d06-9c1c-7e18-0e24-103fa89facf2@gmail.com>
 <a861dacb-c992-13d7-5458-09445183655b@oracle.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <54c2efce-18ac-46d4-7fb5-8510699b528e@gmail.com>
Date:   Wed, 9 Jan 2019 11:20:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <a861dacb-c992-13d7-5458-09445183655b@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/1/9 10:35, Yanjun Zhu wrote:
>
> On 2019/1/9 10:03, Jia-Ju Bai wrote:
>>
>>
>> On 2019/1/9 9:24, Yanjun Zhu wrote:
>>>
>>> On 2019/1/8 20:57, Jia-Ju Bai wrote:
>>>>
>>>>
>>>> On 2019/1/8 20:54, Zhu Yanjun wrote:
>>>>>
>>>>> 在 2019/1/8 20:45, Jia-Ju Bai 写道:
>>>>>> In drivers/net/ethernet/nvidia/forcedeth.c, the functions
>>>>>> nv_start_xmit() and nv_start_xmit_optimized() can be concurrently
>>>>>> executed with nv_poll_controller().
>>>>>>
>>>>>> nv_start_xmit
>>>>>>    line 2321: prev_tx_ctx->skb = skb;
>>>>>>
>>>>>> nv_start_xmit_optimized
>>>>>>    line 2479: prev_tx_ctx->skb = skb;
>>>>>>
>>>>>> nv_poll_controller
>>>>>>    nv_do_nic_poll
>>>>>>      line 4134: spin_lock(&np->lock);
>>>>>>      nv_drain_rxtx
>>>>>>        nv_drain_tx
>>>>>>          nv_release_txskb
>>>>>>            line 2004: dev_kfree_skb_any(tx_skb->skb);
>>>>>>
>>>>>> Thus, two possible concurrency use-after-free bugs may occur.
>>>>>>
>>>>>> To fix these possible bugs,
>>>>>
>>>>>
>>>>> Does this really occur? Can you reproduce this ?
>>>>
>>>> This bug is not found by the real execution.
>>>> It is found by a static tool written by myself, and then I check it 
>>>> by manual code review.
>>>
>>> Before "line 2004: dev_kfree_skb_any(tx_skb->skb); ",
>>>
>>> "
>>>
>>>                 nv_disable_irq(dev);
>>>                 nv_napi_disable(dev);
>>>                 netif_tx_lock_bh(dev);
>>>                 netif_addr_lock(dev);
>>>                 spin_lock(&np->lock);
>>>                 /* stop engines */
>>>                 nv_stop_rxtx(dev);   <---this stop rxtx
>>>                 nv_txrx_reset(dev);
>>> "
>>>
>>> In this case, does nv_start_xmit or nv_start_xmit_optimized still 
>>> work well?
>>>
>>
>> nv_stop_rxtx() calls nv_stop_tx(dev).
>>
>> static void nv_stop_tx(struct net_device *dev)
>> {
>>     struct fe_priv *np = netdev_priv(dev);
>>     u8 __iomem *base = get_hwbase(dev);
>>     u32 tx_ctrl = readl(base + NvRegTransmitterControl);
>>
>>     if (!np->mac_in_use)
>>         tx_ctrl &= ~NVREG_XMITCTL_START;
>>     else
>>         tx_ctrl |= NVREG_XMITCTL_TX_PATH_EN;
>>     writel(tx_ctrl, base + NvRegTransmitterControl);
>>     if (reg_delay(dev, NvRegTransmitterStatus, NVREG_XMITSTAT_BUSY, 0,
>>               NV_TXSTOP_DELAY1, NV_TXSTOP_DELAY1MAX))
>>         netdev_info(dev, "%s: TransmitterStatus remained busy\n",
>>                 __func__);
>>
>>     udelay(NV_TXSTOP_DELAY2);
>>     if (!np->mac_in_use)
>>         writel(readl(base + NvRegTransmitPoll) & 
>> NVREG_TRANSMITPOLL_MAC_ADDR_REV,
>>                base + NvRegTransmitPoll);
>> }
>>
>> nv_stop_tx() seems to only write registers to stop transmitting for 
>> hardware.
>> But it does not wait until nv_start_xmit() and 
>> nv_start_xmit_optimized() finish execution.
> There are 3 modes in forcedeth NIC.
> In throughput mode (0), every tx & rx packet will generate an interrupt.
> In CPU mode (1), interrupts are controlled by a timer.
> In dynamic mode (2), the mode toggles between throughput and CPU mode 
> based on network load.
>
> From the source code,
>
> "np->recover_error = 1;" is related with CPU mode.
>
> nv_start_xmit or nv_start_xmit_optimized seems related with ghroughput 
> mode.
>
> In static void nv_do_nic_poll(struct timer_list *t),
> when  if (np->recover_error), line 2004: 
> dev_kfree_skb_any(tx_skb->skb); will run.
>
> When "np->recover_error=1", do you think nv_start_xmit or 
> nv_start_xmit_optimized will be called?

Sorry, I do not know about these modes...
But I still think nv_start_xmit() or nv_start_xmit_optimized() can be 
called here, in no matter which mode :)


Best wishes,
Jia-Ju Bai
