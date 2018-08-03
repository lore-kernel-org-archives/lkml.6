Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E84FC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422E1216F3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="EET/D4GA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422E1216F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbeHCJ5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:57:18 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:57474 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727199AbeHCJ5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:57:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 9E31F100EAAA1;
        Fri,  3 Aug 2018 16:05:44 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3LpIeRBp0M5L; Fri,  3 Aug 2018 16:05:42 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 74388142826CD;
        Fri,  3 Aug 2018 16:05:42 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 74388142826CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533283542;
        bh=hRoBe97hJ3IPdaAKo0w+WYh2iEg9420IniSRNzr08bA=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=EET/D4GAvyQR+IWaHN1HOUE+nIxkZCdD2tNJ7cyNgvnzi3R1INAnHHMLX7utN59KQ
         fNgWw/wF2EWRVUWzRCqPr5K7uLgp3PS51IqJhelQQvv5PUUvs4NYG3oU24Mv8VULhb
         NjzjHnCSVZ1QyjSxN8LCd6KbQRscIlfb+IoCwwlw=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id l16u8PdCsfHk; Fri,  3 Aug 2018 16:05:42 +0800 (CST)
Received: from [192.168.128.73] (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 25222100EAAA1;
        Fri,  3 Aug 2018 16:05:41 +0800 (CST)
Subject: Re: [PATCH 09/46] dmaengine: cppi41: use
 dmaenginem_async_device_register to simplify the code
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.jiang@intel.com, radhey.shyam.pandey@xilinx.com,
        appana.durga.rao@xilinx.com, jmkrzyszt@gmail.com,
        gomonovych@gmail.com, keescook@chromium.org,
        horms+renesas@verge.net.au, geert+renesas@glider.be,
        shawnguo@kernel.org, baoyou.xie@linaro.org,
        michal.simek@xilinx.com, baohua@kernel.org,
        ludovic.desroches@microchip.com, linus.walleij@linaro.org,
        david.brown@linaro.org
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
 <20180803072016.21544-10-sjhuang@iluvatar.ai>
 <43458794-d124-13df-c944-e473dc8ee1c2@ti.com>
From:   Huang Shijie <sjhuang@iluvatar.ai>
Message-ID: <b95f7ce3-b50f-ea62-dbfb-d25973230ec4@iluvatar.ai>
Date:   Fri, 3 Aug 2018 16:02:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <43458794-d124-13df-c944-e473dc8ee1c2@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A8 2018=E5=B9=B408=E6=9C=8803=E6=97=A5 15:55, Peter Ujfalusi =E5=86=
=99=E9=81=93:
>
> On 2018-08-03 10:19, Huang Shijie wrote:
>> Use dmaenginem_async_device_register to simplify the code:
>>     remove dma_async_device_unregister
>>
>> Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
>> ---
>>   drivers/dma/ti/cppi41.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
>> index 1497da367710..d2998a19ed2e 100644
>> --- a/drivers/dma/ti/cppi41.c
>> +++ b/drivers/dma/ti/cppi41.c
>> @@ -1096,21 +1096,19 @@ static int cppi41_dma_probe(struct platform_de=
vice *pdev)
>>   		goto err_chans;
>>   	cdd->irq =3D irq;
>>  =20
>> -	ret =3D dma_async_device_register(&cdd->ddev);
>> +	ret =3D dmaenginem_async_device_register(&cdd->ddev);
>>   	if (ret)
>>   		goto err_chans;
>>  =20
>>   	ret =3D of_dma_controller_register(dev->of_node,
>>   			cppi41_dma_xlate, &cpp41_dma_info);
>>   	if (ret)
>> -		goto err_of;
>> +		goto err_chans;
>>  =20
>>   	pm_runtime_mark_last_busy(dev);
>>   	pm_runtime_put_autosuspend(dev);
>>  =20
>>   	return 0;
>> -err_of:
>> -	dma_async_device_unregister(&cdd->ddev);
>>   err_chans:
>>   	deinit_cppi41(dev, cdd);
>>   err_init_cppi:
>> @@ -1132,7 +1130,6 @@ static int cppi41_dma_remove(struct platform_dev=
ice *pdev)
>>   		dev_err(&pdev->dev, "%s could not pm_runtime_get: %i\n",
>>   			__func__, error);
>>   	of_dma_controller_free(pdev->dev.of_node);
>> -	dma_async_device_unregister(&cdd->ddev);
> If I read the code right then this is not safe.
> We would have deinitalized cppi41 driver which is not functional, but w=
e
> will still have the dma device registered and if a channel is requested
> we will have kernel crash.
>
> It falls in the same case as omap-dma, edma.
Thanks for pointing this, we can drop the patches for omap-dma, edma.

Huang Shijie

