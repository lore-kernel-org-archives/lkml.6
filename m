Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0106C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7393020850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="P1LVz/ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7393020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754217AbeFRMiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:38:02 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52259 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbeFRMh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:37:59 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180618123757euoutp02da30dace488f3b8cf4bce7d769baec7f~5QWtaDCUv1999519995euoutp02A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 12:37:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180618123757euoutp02da30dace488f3b8cf4bce7d769baec7f~5QWtaDCUv1999519995euoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529325477;
        bh=QlwuFQyGAF6KKqslToY4YrpdwwGYsrlHIrnNQLWiZ2E=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=P1LVz/epKagWaPXwCH6qkY3K8iGog0ODnVUCLmiyBbvLEBFloZ1wgSRfswPsIpwda
         Zs3a1BLc6QwhKEnFGXwvPUmbAcJgRVs4hRE3A8Xh1UpUUKY4UZOkJl/4Kyh6P7sDvl
         UWjKIsm2pqRgzZIH14A940IjWKnPtA7xL1khpMoo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180618123755eucas1p2c18345be115e4c7e88d145371c74611a~5QWrQ6z5i1751117511eucas1p2N;
        Mon, 18 Jun 2018 12:37:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id DD.BC.05700.2A7A72B5; Mon, 18
        Jun 2018 13:37:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180618123754eucas1p231492b472e018cce4baa163a814d70f0~5QWqFaHuq1750617506eucas1p2E;
        Mon, 18 Jun 2018 12:37:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180618123753eusmtrp24ee52a9cbb98210dc632d087f09ac481~5QWpnYFkI0354803548eusmtrp2N;
        Mon, 18 Jun 2018 12:37:53 +0000 (GMT)
X-AuditID: cbfec7f2-1dbff70000011644-53-5b27a7a262a2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4C.D8.04183.1A7A72B5; Mon, 18
        Jun 2018 13:37:53 +0100 (BST)
Received: from [106.120.51.25] (unknown [106.120.51.25]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180618123753eusmtip27af7c540dd14d2c5210cf768687bd4c0~5QWpNuqsH0825908259eusmtip2V;
        Mon, 18 Jun 2018 12:37:53 +0000 (GMT)
Subject: Re: [PATCH 5/7] regulator: core: Lock dependent regulators
To:     Lucas Stach <l.stach@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, Carlos Hernandez <ceh@ti.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Maciej Purski <m.purski@samsung.com>
Date:   Mon, 18 Jun 2018 14:37:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1528122047.2728.10.camel@pengutronix.de>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djPc7qLlqtHG8z/ZWMx9eETNot9fb/Z
        LB7MvclksenxNVaLy7vmsFnMXtLPYrH2yF12i/1XvBw4PL59ncTisWlVJ5vH5iX1Hv1/DTz6
        tqxi9Dh+YzuTx+dNcgHsUVw2Kak5mWWpRfp2CVwZi/YXFCzWrfg2V6+B8aJKFyMnh4SAicTP
        r/dYuhi5OIQEVjBK7Nu3gBUkISTwhVHi7bo8iMRnRonuT7+ZYDqOrfwB1bGcUeJA7woo5y2j
        xK/tc5lBqoQFnCVaz29jAbFFBHIlNvw+xw5SxCywiVHi9vFVQDs4ONgEtCTWtMeD1LAIqEr8
        OnwIrFdUIEJi4dSnjCA2r4CgxMmZT8DmcAqYSfTOOw0WZxYQl7j1ZD4ThC0v0bx1NjPIfAmB
        Q+wSLT33WSGayyQ+zP3NDrJLQsBFYv1sI4gPhCVeHd/CDmHLSPzfOR/qs2qJlS+Xs0DMaWCU
        +HL3MjNEwlri8PGLYDczC2hKrN+lDxF2lDj9+gMrxHg+iRtvBSHO4ZOYtG06M0SYV6KjTQii
        WknixYy/UJskJJaefMQ6gVFpFpInZyF5bBaSx2Yh7F3AyLKKUTy1tDg3PbXYMC+1XK84Mbe4
        NC9dLzk/dxMjMCmd/nf80w7Gr5eSDjEKcDAq8fA+6FOLFmJNLCuuzD3EKMHBrCTCqy6jHi3E
        m5JYWZValB9fVJqTWnyIUZqDRUmcN06jLkpIID2xJDU7NbUgtQgmy8TBKdXA6JK6a/PkzMl2
        Ia6cb9c4GM5hb/xZpq6pUr+gJkq1dmeZz5X5lxe9+S3yfN3Sh0qPNHUec3kKySV1rdjDcGOr
        rNVZ+4D4TlanCx/k5stkKK+ynG02qz8mPf6/vo5k4eaQELeqyfM/ffgWx30gW7w5+OKDPXuy
        znx9ffuAcEFM/ysWFo7OMIOHSizFGYmGWsxFxYkA428w8kYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xe7oLl6tHG0xcq24x9eETNot9fb/Z
        LB7MvclksenxNVaLy7vmsFnMXtLPYrH2yF12i/1XvBw4PL59ncTisWlVJ5vH5iX1Hv1/DTz6
        tqxi9Dh+YzuTx+dNcgHsUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2
        Kak5mWWpRfp2CXoZi/YXFCzWrfg2V6+B8aJKFyMnh4SAicSxlT9Yuhi5OIQEljJKvPvyhA0i
        ISFx9v5/VghbWOLPtS42iKLXjBJnF99jAkkICzhLtJ7fBtTNwSEikCtxbJIrSJhZYBOjxMSP
        KVBDmSRmfvnKClLDJqAlsaY9HqSGV8BOYvbmk2C7WARUJX4dPsQMYosKREh0rpzPAlEjKHFy
        5hMwm1PATKJ33mlGiPlmEvM2P2SGsMUlbj2ZzwRhy0s0b53NPIFRaBaS9llIWmYhaZmFpGUB
        I8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwDjcduznlh2MXe+CDzEKcDAq8fA+6FOLFmJN
        LCuuzD3EKMHBrCTCqy6jHi3Em5JYWZValB9fVJqTWnyI0RTouYnMUqLJ+cAUkVcSb2hqaG5h
        aWhubG5sZqEkznveoDJKSCA9sSQ1OzW1ILUIpo+Jg1OqgfFkTsKkkC0tfzZsqj14P3TCCof8
        9T8v2HvfvFL6pDr0M0/l88abs98ppN96nZZt+OTZRT6RBQ/M7sxhrM+cxtUU9GPKrk+PWKU2
        adbc5D76N/3fxlW103fqGoWt//ZGdtFMXrc9bu3rJ0hoS0ddfsXUb3TiK+fig6YNZ0vXbWN4
        Pzeuok3rriCPEktxRqKhFnNRcSIAgRDqOtkCAAA=
Message-Id: <20180618123754eucas1p231492b472e018cce4baa163a814d70f0~5QWqFaHuq1750617506eucas1p2E@eucas1p2.samsung.com>
X-CMS-MailID: 20180618123754eucas1p231492b472e018cce4baa163a814d70f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180604135954eucas1p2156fed3300b5514a4efa2baf9e7b9bc5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180604135954eucas1p2156fed3300b5514a4efa2baf9e7b9bc5
References: <20180530144505.GB5705@atomide.com>
        <1528120764-14316-1-git-send-email-m.purski@samsung.com>
        <CGME20180604135954eucas1p2156fed3300b5514a4efa2baf9e7b9bc5@eucas1p2.samsung.com>
        <1528120764-14316-6-git-send-email-m.purski@samsung.com>
        <1528122047.2728.10.camel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/04/2018 04:20 PM, Lucas Stach wrote:
> Hi Maciej,
> 
> Am Montag, den 04.06.2018, 15:59 +0200 schrieb Maciej Purski:
>> Implementing coupled regulators adds a new dependency between
>> regulators. Therefore, the current locking model should be changed.
>> Coupled regulators should be locked with regulator's supplies at the
>> same time.
>>
>> Add new function regulator_lock_dependent(), which locks all regulators
>> related with the one, that is being changed.
> 
> Sort of high level comment, but this doesn't look right: With dependent
> regulators you don't strictly lock the regulators in the direction of
> the tree root, but also siblings at the same level. This is prone with
> deadlocks, as you can't control the order of the regulator locks being
> taken by different tasks. This really needs a ww_mutex to be
> implemented in a robust way.
> 
> Regards,
> Lucas
> 

Thanks for that. You are right and it needs fixing. I'll consider it in my
next version. However, that error should arise only, when we have the actual
coupled regulators, so it shouldn't be a problem in Tony's case.

Best regards,

Maciej Purski

>> Signed-off-by: Maciej Purski <m.purski@samsung.com>
>> ---
>>   drivers/regulator/core.c | 75 +++++++++++++++++++++++++++++++++---------------
>>   1 file changed, 52 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
>> index 0b366c5..7c57268 100644
>> --- a/drivers/regulator/core.c
>> +++ b/drivers/regulator/core.c
>> @@ -201,38 +201,67 @@ static void regulator_unlock(struct regulator_dev *rdev)
>>>   	}
>>   }
>>   
>> -/**
>> - * regulator_lock_supply - lock a regulator and its supplies
>> - * @rdev:         regulator source
>> - */
>> -static void regulator_lock_supply(struct regulator_dev *rdev)
>> +static int regulator_lock_recursive(struct regulator_dev *rdev,
>>> +				    unsigned int subclass)
>>   {
>>> +	struct regulator_dev *c_rdev;
>>>   	int i;
>>   
>>> -	for (i = 0; rdev; rdev = rdev_get_supply(rdev), i++)
>>> -		regulator_lock_nested(rdev, i);
>>> +	for (i = 0; i < rdev->coupling_desc.n_coupled; i++) {
>>> +		c_rdev = rdev->coupling_desc.coupled_rdevs[i];
>> +
>>> +		if (!c_rdev)
>>> +			continue;
>> +
>>> +		regulator_lock_nested(c_rdev, subclass++);
>> +
>>> +		if (c_rdev->supply)
>>> +			subclass =
>>> +				regulator_lock_recursive(c_rdev->supply->rdev,
>>> +							 subclass);
>>> +	}
>> +
>>> +	return subclass;
>>   }
>>   
>>   /**
>> - * regulator_unlock_supply - unlock a regulator and its supplies
>> - * @rdev:         regulator source
>> + * regulator_unlock_dependent - unlock regulator's suppliers and coupled
>>> + *				regulators
>>> + * @rdev:			regulator source
>> + *
>> + * Unlock all regulators related with rdev by coupling or suppling.
>>    */
>> -static void regulator_unlock_supply(struct regulator_dev *rdev)
>> +static void regulator_unlock_dependent(struct regulator_dev *rdev)
>>   {
>>> -	struct regulator *supply;
>>> +	struct regulator_dev *c_rdev;
>>> +	int i;
>>   
>>> -	while (1) {
>>> -		regulator_unlock(rdev);
>>> -		supply = rdev->supply;
>>> +	for (i = 0; i < rdev->coupling_desc.n_coupled; i++) {
>>> +		c_rdev = rdev->coupling_desc.coupled_rdevs[i];
>>   
>>> -		if (!rdev->supply)
>>> -			return;
>>> +		if (!c_rdev)
>>> +			continue;
>> +
>>> +		regulator_unlock(c_rdev);
>>   
>>> -		rdev = supply->rdev;
>>> +		if (c_rdev->supply)
>>> +			regulator_unlock_dependent(c_rdev->supply->rdev);
>>>   	}
>>   }
>>   
>>   /**
>> + * regulator_lock_dependent - lock regulator's suppliers and coupled regulators
>>> + * @rdev:			regulator source
>> + *
>> + * This function as a wrapper on regulator_lock_recursive(), which locks
>> + * all regulators related with rdev by coupling or suppling.
>> + */
>> +static inline void regulator_lock_dependent(struct regulator_dev *rdev)
>> +{
>>> +	regulator_lock_recursive(rdev, 0);
>> +}
>> +
>> +/**
>>    * of_get_regulator - get a regulator device node based on supply name
>>    * @dev: Device pointer for the consumer (of regulator) device
>>    * @supply: regulator supply name
>> @@ -3332,12 +3361,12 @@ int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
>>>   	int ret = 0;
>>   
>>>   	pr_err("%s: %d\n", __func__, __LINE__);
>>> -	regulator_lock_supply(regulator->rdev);
>>> +	regulator_lock_dependent(regulator->rdev);
>>   
>>>   	ret = regulator_set_voltage_unlocked(regulator, min_uV, max_uV,
>>>   					     PM_SUSPEND_ON);
>>   
>>> -	regulator_unlock_supply(regulator->rdev);
>>> +	regulator_unlock_dependent(regulator->rdev);
>>   
>>>   	return ret;
>>   }
>> @@ -3415,12 +3444,12 @@ int regulator_set_suspend_voltage(struct regulator *regulator, int min_uV,
>>>   	if (regulator_check_states(state) || state == PM_SUSPEND_ON)
>>>   		return -EINVAL;
>>   
>>> -	regulator_lock_supply(regulator->rdev);
>>> +	regulator_lock_dependent(regulator->rdev);
>>   
>>>   	ret = _regulator_set_suspend_voltage(regulator, min_uV,
>>>   					     max_uV, state);
>>   
>>> -	regulator_unlock_supply(regulator->rdev);
>>> +	regulator_unlock_dependent(regulator->rdev);
>>   
>>>   	return ret;
>>   }
>> @@ -3612,11 +3641,11 @@ int regulator_get_voltage(struct regulator *regulator)
>>   {
>>>   	int ret;
>>   
>>> -	regulator_lock_supply(regulator->rdev);
>>> +	regulator_lock_dependent(regulator->rdev);
>>   
>>>   	ret = _regulator_get_voltage(regulator->rdev);
>>   
>>> -	regulator_unlock_supply(regulator->rdev);
>>> +	regulator_unlock_dependent(regulator->rdev);
>>   
>>>   	return ret;
>>   }
> 
> 
> 
