Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9161C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D10D20672
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731321AbeLQHey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 02:34:54 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50723 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeLQHey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 02:34:54 -0500
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1gYnQS-00078o-Nw; Mon, 17 Dec 2018 08:34:52 +0100
Subject: Re: [PATCH] mailbox: imx: Fix clk handling in imx_mu_probe()
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
References: <1544914904-3809-1-git-send-email-khoroshilov@ispras.ru>
 <20181217060111.hsay6vhqpxyfdbiu@pengutronix.de>
 <3ccce5b6-75a5-da94-08e3-985880382d00@ispras.ru>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <a508d43a-deed-1060-8b15-cbdad60f810e@pengutronix.de>
Date:   Mon, 17 Dec 2018 08:34:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <3ccce5b6-75a5-da94-08e3-985880382d00@ispras.ru>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.12.18 08:24, Alexey Khoroshilov wrote:
> Hi Oleksij,
> 
> By chance I took a look at another implementations:
> 
> arch/arm/mach-ep93xx/clock.c#L266
> 
> int clk_enable(struct clk *clk)
> {
> 	unsigned long flags;
> 
> 	if (!clk)
> 		return -EINVAL;
> ...
> 
> arch/c6x/platforms/pll.c#L48
> 
> int clk_enable(struct clk *clk)
> {
> 	unsigned long flags;
> 
> 	if (clk == NULL || IS_ERR(clk))
> 		return -EINVAL;
> 
> So, I am not sure the NULL resistance is a part of the clk_enable()
> contract?

Main framework is always preferred. If some local code provide 
replacement of a functions already provided by the clk framework and not 
follow same rules, then this code should be fixed. If this code is even 
exporting this function for global use, then it is probably buggy.
And if i see it correctly:
1d81eedb8f6c1 (Lennert Buytenhek  2006-06-24 10:33:02 +0100 266) int 
clk_enable(struct clk *clk)

It is ancient code... it just can't be correct.

> --
> Alexey
> 
> 
> On 17.12.2018 9:01, Oleksij Rempel wrote:
>> Hi Alexey,
>>
>> On Sun, Dec 16, 2018 at 02:01:44AM +0300, Alexey Khoroshilov wrote:
>>> Handling of devm_clk_get() suggests that the driver should support
>>> lack of priv->clk. But imx_mu_probe() fails on clk_prepare_enable(NULL)
>>> in that case.
>>>
>>> The patch removes the try to enable absent clk and adds error handling
>>> for mbox_controller_register().
>>>
>>> Found by Linux Driver Verification project (linuxtesting.org).
>>>
>>> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
>>> ---
>>>   drivers/mailbox/imx-mailbox.c | 18 +++++++++++++-----
>>>   1 file changed, 13 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
>>> index 363d35d5e49d..ddde398f576e 100644
>>> --- a/drivers/mailbox/imx-mailbox.c
>>> +++ b/drivers/mailbox/imx-mailbox.c
>>> @@ -292,10 +292,12 @@ static int imx_mu_probe(struct platform_device *pdev)
>>>   		priv->clk = NULL;
>>>   	}
>>>   
>>> -	ret = clk_prepare_enable(priv->clk);
>>> -	if (ret) {
>>> -		dev_err(dev, "Failed to enable clock\n");
>>> -		return ret;
>>> +	if (priv->clk) {
>>> +		ret = clk_prepare_enable(priv->clk);
>>> +		if (ret) {
>>> +			dev_err(dev, "Failed to enable clock\n");
>>> +			return ret;
>>> +		}
>>>   	}
>>>   
>>>   	for (i = 0; i < IMX_MU_CHANS; i++) {
>>> @@ -324,7 +326,13 @@ static int imx_mu_probe(struct platform_device *pdev)
>>>   
>>>   	imx_mu_init_generic(priv);
>>>   
>>> -	return mbox_controller_register(&priv->mbox);
>>> +	ret = mbox_controller_register(&priv->mbox);
>>> +	if (ret) {
>>> +		clk_disable_unprepare(priv->clk);
>>> +		return ret;
>>> +	}
>>> +
>>> +	return 0;
>>>   }
>>>   
>>>   static int imx_mu_remove(struct platform_device *pdev)
>>> -- 
>>> 2.7.4
>>>
>>>
>>
>> NACK for this patch.
>>
>> Here are code snippets from clk framework:
>> ============================================================================
>> /* clk_prepare_enable helps cases using clk_enable in non-atomic context. */
>> static inline int clk_prepare_enable(struct clk *clk)
>> {
>> 	int ret;
>>
>> 	ret = clk_prepare(clk);
>> 	if (ret)
>> 		return ret;
>> 	ret = clk_enable(clk);
>> 	if (ret)
>> 		clk_unprepare(clk);
>>
>> 	return ret;
>> }
>>
>> int clk_prepare(struct clk *clk)
>> {
>> 	if (!clk)
>> 		return 0;
>>
>> 	return clk_core_prepare_lock(clk->core);
>> }
>>
>> int clk_enable(struct clk *clk)
>> {
>> 	if (!clk)
>> 		return 0;
>>
>> 	return clk_core_enable_lock(clk->core);
>> }
>> ============================================================================
>>
>> As you can see, complete code path is NULL resistant. Are you trying to
>> fix some real issue, or it is a theoretical work?
>>
> 
> 
