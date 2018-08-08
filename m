Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71211C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214D32083D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="p/Bw2F6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214D32083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbeHHN5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 09:57:53 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:40555 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbeHHN5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 09:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Cv+Tn3WHkfXrn/SQlAhjidlfalrP8jIrTTc8zGGVA4A=; b=p/Bw2F6NA/pHOA5A9rH/SYvz0d
        995FGin0KTgpeHt83oOEho9lQLtsMI4BGDjYNnYu7eFyNGBxAxlKWPkZqyU4KvzeGuDgNpXZbpn6P
        Yl06P+BzPiYHimX4ReAM3rTpbOkZVP8Ar8g6Y7D/vTtWP0QQX3RYb4o8uylyost7ZG1YU612O2Zx6
        7v1aYUCCGmLT3QTZFF7ahwcOSvSszXTeOSjTK+i1NU6nci8+09g0FzYxo5ZUuGAfrfX2BeZ5hfYzd
        tFE4BlEjZz1wulkyIIZxuQmChDLXfYTuh72XH0lAmv2IwkjQW976HMKd/k1+tDqPEWrhdQIUKpvYT
        Nn/N5+hw==;
Received: from [193.209.96.43] (helo=[10.21.26.144])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1fnMnM-0004h8-BC; Wed, 08 Aug 2018 14:38:28 +0300
Subject: Re: [PATCH v3 3/8] mailbox: Add transmit done by blocking option
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        ", linux-arm-kernel"@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        srv_heupstream <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-4-mperttunen@nvidia.com>
 <CABb+yY0_dKC_cYFwwb-aeRgrx=sjv=8VLP=C6DJEecFf=v+mkQ@mail.gmail.com>
 <907bac36-0c54-8f38-0f5e-f59196d414c6@kapsi.fi>
Message-ID: <afc8a305-79ea-2194-0af0-919bbb8f675e@kapsi.fi>
Date:   Wed, 8 Aug 2018 14:38:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <907bac36-0c54-8f38-0f5e-f59196d414c6@kapsi.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 193.209.96.43
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04.08.2018 13:45, Mikko Perttunen wrote:
> On 08/03/2018 03:54 PM, Jassi Brar wrote:
>> On Mon, Jul 2, 2018 at 5:10 PM, Mikko Perttunen 
>> <mperttunen@nvidia.com> wrote:
>>> Add a new TXDONE option, TXDONE_BY_BLOCK. With this option, the
>>> send_data function of the mailbox driver is expected to block until
>>> the message has been sent. The new option is used with the Tegra
>>> Combined UART driver to minimize unnecessary overhead when transmitting
>>> data.
>>>
>> 1) TXDONE_BY_BLOCK flag :-
>>          Have you tried setting the flag 
>> mbox_chan->mbox_client->tx_block ?
> 
> No - I suppose I should have done that. I'm a bit concerned about 
> overhead as send_data may be called thousands of times per second, so I 
> tried to make it as close as possible to the downstream driver that just 
> pokes the mailbox register directly.

I tried using polling in the mailbox framework. Some printing is done 
from atomic context so it seems tx_block cannot be used - 
wait_for_completion_timeout understandably does not work in atomic 
context. I also tried without tx_block, in which case I got some 
horribly garbled output, but "Try increasing MBOX_TX_QUEUE_LEN" was 
readable there.

Any opinions?

Thanks,
Mikko

> 
>>
>> 2) Implementing TEGRA_HSP_MBOX_TYPE_SM :-
>>         In mailbox framework, a controller is a collection of identical
>> channels. That is, instances of the same class.
>>         So ideally, in probe you should populate a controller for each
>> type of channel, i.e, DB, SM, SS and AS.
> 
> Hmm, yes, I guess this would be possible if I change the mailbox core to 
> allow registering multiple controllers per device.
> 
> Thanks!
> Mikko
> 
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
