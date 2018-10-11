Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CA8C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE0020841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igel-co-jp.20150623.gappssmtp.com header.i=@igel-co-jp.20150623.gappssmtp.com header.b="Swwco+IP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE0020841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbeJKRt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:49:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46559 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbeJKRt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:49:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id r64-v6so4175429pfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 03:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZStt7IIvYOnb4qcll4eb3T6jsGKN9NrsdjMdEL/Mx38=;
        b=Swwco+IPnYLlibrDfV04FKO2aZDt3Nc4LN4EZgcRqaAYihWLuRhci+P5XJ2TYWlCJE
         4pp0TzsfDFRmR31wYrgQkiMMPxse8Yq3Fqms3HDFUrRkyO/vlr1bmoneUAv285oBh/sd
         ULSzYbjaijQg//USOyw8yxpR8ik40ga1m4PtQWHkoAyKxMUWIIRNZGzgB2SUygY2f5Sw
         Qqei5z2RkJxZssHouV9tG3RZTsTPVgQDCyscHRjb79zTOmhcobpL3W6MtLo402ftM0W9
         2OfOKffD15WdksXvVlPYp5zkKPopp6+x65xk6IadP2XOYaBtid46DrtTm5t3rg+7CcB9
         vV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZStt7IIvYOnb4qcll4eb3T6jsGKN9NrsdjMdEL/Mx38=;
        b=bOhjLi0Sz+dEJxm90tEL2542Z2loyqMLbqLH+X7WMhp7eD4JpXm4mMRSEj6o4HeOq7
         iYoifEnIhs/fidAzCxbJTacbzDwUPs4K2T5ePH1REo4NMozMPews3CZK9G8BcRRgIZIo
         eOr444ElspFQdYswu5B/APvOdzbTmtf0U2zJFNM+Ey669MRr6PsoKzSSXqwFat78+Ll8
         WMZeh03/jw/LyMW2/Dh0JE+A/OWngl0guIzxZPZ5/qBpk1Q+VIztVOCvjBdAlJ9XUt0X
         niXnoVJG8TFTHPI8BNsVd/pBcA7Sm66bTKNXOsRvBb/2Iu76QzpKVLy50OpycYKGkpN5
         7feA==
X-Gm-Message-State: ABuFfogfRFNJxPYlRGJCersEppP7Y+YeiVII/vDIh5QaK8wnbqENCoxX
        mEenBqkQ0eBafV8UF/Cf3zoi8DB9gzb8MA==
X-Google-Smtp-Source: ACcGV63LuWiVbaOLM8cwyuobr+onYHDg5bVNs4atRTUaAv41QE+kgz4KCP4f8RiVg4zzxbKpND5FUg==
X-Received: by 2002:a63:dc14:: with SMTP id s20-v6mr883290pgg.398.1539253371003;
        Thu, 11 Oct 2018 03:22:51 -0700 (PDT)
Received: from [10.16.144.1] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id u36-v6sm67914401pgn.56.2018.10.11.03.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 03:22:50 -0700 (PDT)
Subject: Re: [PATCH] virtio_net: enable tx after resuming from suspend
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181011075127.2608-1-ake@igel.co.jp>
 <dd530053-efab-b661-3423-1faaab8fb12f@redhat.com>
From:   ake <ake@igel.co.jp>
Message-ID: <7e87b140-79ae-c79e-40ed-dc76b38eeae4@igel.co.jp>
Date:   Thu, 11 Oct 2018 19:22:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <dd530053-efab-b661-3423-1faaab8fb12f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年10月11日 18:44, Jason Wang wrote:
> 
> 
> On 2018年10月11日 15:51, Ake Koomsin wrote:
>> commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
>> disabled the virtio tx before going to suspend to avoid a use after free.
>> However, after resuming, it causes the virtio_net device to lose its
>> network connectivity.
>>
>> To solve the issue, we need to enable tx after resuming.
>>
>> Fixes commit 713a98d90c5e ("virtio-net: serialize tx routine during
>> reset")
>> Signed-off-by: Ake Koomsin <ake@igel.co.jp>
>> ---
>>   drivers/net/virtio_net.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index dab504ec5e50..3453d80f5f81 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -2256,6 +2256,7 @@ static int virtnet_restore_up(struct
>> virtio_device *vdev)
>>       }
>>         netif_device_attach(vi->dev);
>> +    netif_start_queue(vi->dev);
> 
> I believe this is duplicated with netif_tx_wake_all_queues() in
> netif_device_attach() above?

Thank you for your review.

If both netif_tx_wake_all_queues() and netif_start_queue() result in
clearing __QUEUE_STATE_DRV_XOFF, then is it possible that some
conditions in netif_device_attach() is not satisfied? Without
netif_start_queue(), the virtio_net device does not resume properly
after waking up.

Is it better to report this as a bug first? If I am to do more
investigation, what areas should I look into?


Best Regards
Ake Koomsin

