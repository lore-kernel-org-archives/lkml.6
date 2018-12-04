Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DC8C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429F32082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eeLzNH08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429F32082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbeLDJjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:39:18 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47060 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbeLDJjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:39:18 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181204093917euoutp02fbf44f247b7eb97e140e8b3c406feb64~tF785VfOJ1127011270euoutp02v
        for <linux-kernel@vger.kernel.org>; Tue,  4 Dec 2018 09:39:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181204093917euoutp02fbf44f247b7eb97e140e8b3c406feb64~tF785VfOJ1127011270euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543916357;
        bh=C8IBKV9+nMmxFxhmNUDLidx1UPSncRAX3HQbcV0+l6M=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=eeLzNH08lllc00+0MInxCoQTOcxawFFH5000iTCM600mKepD/gxuTG53hlAOFZ8sQ
         caUsSlnI6kF0ziKx6e4YRgRLJac8GoihY2WJwqDoyJ62ZJfjzUbvBkVE/44J1YbrP9
         QtqTpmuCgicuKvRI75PkCdkP3oD0tgVMoHef5Cvg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181204093916eucas1p21984ecd86d3ff6b99699c90570af9034~tF77xghcB2456524565eucas1p2r;
        Tue,  4 Dec 2018 09:39:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D7.12.04806.34B460C5; Tue,  4
        Dec 2018 09:39:15 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181204093915eucas1p240fb2571fce0b0cd226ca096d077b449~tF768HLm-2434424344eucas1p25;
        Tue,  4 Dec 2018 09:39:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181204093914eusmtrp2630c1d5f94eff1802e7ab0d2d658123e~tF76sCBWf0442304423eusmtrp2d;
        Tue,  4 Dec 2018 09:39:14 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-aa-5c064b430b88
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1F.2B.04284.24B460C5; Tue,  4
        Dec 2018 09:39:14 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181204093913eusmtip17e5df4b724e70f45bb461ba845e5f603~tF75t2xR62932329323eusmtip1E;
        Tue,  4 Dec 2018 09:39:13 +0000 (GMT)
Subject: Re: [PATCH v2 2/5] devfreq: add support for suspend/resume of a
 devfreq device
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, rjw@rjwysocki.net, len.brown@intel.com,
        pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <f88c4bda-d2d4-0f5c-67ea-eecf32c2fe4c@partner.samsung.com>
Date:   Tue, 4 Dec 2018 10:39:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5C06124B.5030409@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0yNcRjH/d57Z057Oy49K2M7M8RU6I/fxtzZOzaXyYQ2Dt5VdJLzVnLZ
        5BIpFEM5RYiV00k63tLtFMfRGXW6uGWIY5hbuSXWcOj0HtN/n+/3eX7P83y3H0dq8pgALiYu
        QTTE6WK1jIqqaOhtnjhnIRMZmu0MxTfKg3BZTimNr5V9p3H7tzc0zrc303hvQSmDmzL0OPPl
        BxK3tFxhsXNPJ4uNx60Etrx8SON71XkM7j5sRzinpY7AJfYOFl9sbyPwk91FDO64c6vvfeNd
        Gqda7SzeX/yZxp2tz6iZ/kJFTQUtmM+YkZCb0kYJWZlfkVBQ+44QLKaDjFB/2swKVy/sEtwN
        rCA/OEAJR2QTEoqKf7BCt2XkEvUq1bQNYmxMkmgImb5WFX2020XFu8Ymv/n+k01BTaPSkQ8H
        fBi4i84S6UjFafgiBG0uJ6mIbwhqqnsoRXQjOGLNIv49yay84S0UIpC78hlFdCEwl19mPF1D
        +JVwp+B1/6yhfCOC+npbfxfJp5Lg/iz3CY5j+GCoNG3xoJqfD9Xpyz1I8aOh5ZrKM2YYHwFp
        z4v7R6p5P7h96hXlYR9+Apx64exnkveHx6/yCYVHwd7yXFI59CkHcskihedCc1WJ1x8C7x0y
        q/AI+FOV7w0mgTPNxCi8Ew7crvT2TIWbjjbacxrJB0FpdYhiz4LS842ExwbeFx51+SkX+MKx
        imxSsdWQtl+jdI8D+VCrd9FwKDSfZLOQ1jggl3FAFuOALMb/e88iyoT8xURJHyVKU+LErcGS
        Ti8lxkUFr9+st6C+P9vodvRUorpf62yI55B2sDpnNh2poXVJ0ja9DQFHaoeqn45hIjXqDbpt
        20XD5jWGxFhRsqFAjtL6q3cMcq3W8FG6BHGTKMaLhn9VgvMJSEGL6kssvc+t5wMXdiwOSpwR
        8TY+MForR1jDbxrbQzeGF15fcf/B+oPRMZ/myZs683aWTbqafMIxk0id13Dm3tqJVfMLWrMm
        //64INz15fqtnhnuJXZzRphfQHJDb/bv11GjL/c2SWuO21xhy4xLWa3jRdLpd4d9z626lFA7
        ndi3smlkT4aWkqJ1k8aTBkn3Fz/SIaOvAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe89daXCat1fpIiOKbst5fS2ViJJTfoku0EXRkSeN3KbnbJJF
        aIlFRs3MyqZdyAIzc82pc11cylLy0lJLo7Q0jVgmiYZd0bZG4Lffw///e+CBh8GlJjKIOajW
        8oJamSGjvImOmbbBNRsTqMSQ1osINdevQKZSI4kspmkS9X/7RKLr9uckyq8wUqjzjArpR8Zw
        5HDcp1HXiS80MpQ8xlDtSB+Jeh+UU2jqrB2gUkcThu7ZB2l0u78bQ2+PV1JosP2py+/oIVHB
        YzuNTt6dINGXF++IDQFcw8MGkqu+Vg24srxugivSTwKu4pET42qrTlOc7Wo1zZlv5XIzrTRX
        9+oUwZ2rqwJc5d3vNDdVu3ibZK88RtDotHxwukbUxsr2KVCoXBGN5KHh0XJFWFTSutAI2dq4
        mFQ+42A2L6yNS5Gnn58aIjKHlh/+NP2bzgOdSwqBFwPZcKhvbCYKgTcjZW8DePZWMeYJ/GFx
        k4X2sA/801dIeUpjALZdtlHuwIfdA9srPuLuwJftALDE0Y65B5wtwKFz/CbwKDMAdjWcctUY
        hmLlsLEqy40SNh4+KNzlRoJdCh0Wb/dOP3Y37HLWADdL2AXw2ZVRws1e7Cp4ZbjrH+NsJLxm
        HsY9HADfjF7HPLwE5teX4UVAapijG+YohjmKYY5yAxBVwJfXiao0laiQi0qVqFOnyfdrVLXA
        9S4NrT/NjaDHtKMFsAyQzZeUbiQTpaQyW8xRtQDI4DJfycAyKlEqSVXmHOEFTbKgy+DFFhDh
        uu08HuS3X+N6PrU2WRGhiELRiqiwqLBIJAuQOEJy9krZNKWWP8Tzmbzw38MYr6A8sGic35ob
        +zT4x2L7L11/zeat/ZUhnT25KRmRu55glyztSmtK70TvQvhD0FvxLPvrnBif+FndhXk1M+XR
        64sCjo0EMrbAAk1I/na9xvghsrvc9sg8kOtcvU+r+1xmthr9k6TPnZOZsyVbrF/v7FT3CS8v
        e6XXbYpblHD0gO19/BYZIaYrFStxQVT+BUoSXWlEAwAA
X-CMS-MailID: 20181204093915eucas1p240fb2571fce0b0cd226ca096d077b449
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181203143131eucas1p217f22ac6d19682a54a57658a06980914
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181203143131eucas1p217f22ac6d19682a54a57658a06980914
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181203143131eucas1p217f22ac6d19682a54a57658a06980914@eucas1p2.samsung.com>
        <1543847475-7600-3-git-send-email-l.luba@partner.samsung.com>
        <5C06124B.5030409@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 12/4/18 6:36 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> Looks good to me. But, I add the some comments.
> If you will fix it, feel free to add my tag:
> Reviewed-by: Chanwoo choi <cw00.choi@samsung.com>
> 
> On 2018년 12월 03일 23:31, Lukasz Luba wrote:
>> The patch prepares devfreq device for handling suspend/resume
>> functionality.  The new fields will store needed information during this
> 
> nitpick. Remove unneeded space. There are two spaces between '.' and 'The new'.
> 
>> process.  Devfreq framework handles opp-suspend DT entry and there is no
> 
> ditto.
> 
>> need of modyfications in the drivers code.  It uses atomic variables to
> 
> ditto.
> 
>> make sure no race condition affects the process.
>>
>> The patch is based on earlier work by Tobias Jakobi.
> 
> Please remove it from each patch description.
> 
Comments addressed in next v3 patch set. Thank you.

Regards,
Lukasz
>>
>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/devfreq/devfreq.c | 51 +++++++++++++++++++++++++++++++++++++++--------
>>   include/linux/devfreq.h   |  7 +++++++
>>   2 files changed, 50 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index a9fd61b..36bed24 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -316,6 +316,10 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>>   			"Couldn't update frequency transition information.\n");
>>   
>>   	devfreq->previous_freq = new_freq;
>> +
>> +	if (devfreq->suspend_freq)
>> +		devfreq->resume_freq = cur_freq;
>> +
>>   	return err;
>>   }
>>   
>> @@ -667,6 +671,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>   	}
>>   	devfreq->max_freq = devfreq->scaling_max_freq;
>>   
>> +	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
>> +	atomic_set(&devfreq->suspend_count, 0);
>> +
>>   	dev_set_name(&devfreq->dev, "devfreq%d",
>>   				atomic_inc_return(&devfreq_no));
>>   	err = device_register(&devfreq->dev);
>> @@ -867,14 +874,28 @@ EXPORT_SYMBOL(devm_devfreq_remove_device);
>>    */
>>   int devfreq_suspend_device(struct devfreq *devfreq)
>>   {
>> +	int ret;
>> +
>>   	if (!devfreq)
>>   		return -EINVAL;
>>   
>> -	if (!devfreq->governor)
>> -		return 0;
>> +	if (devfreq->governor) {
>> +		ret = devfreq->governor->event_handler(devfreq,
>> +					DEVFREQ_GOV_SUSPEND, NULL);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	if (devfreq->suspend_freq) {
>> +		if (atomic_inc_return(&devfreq->suspend_count) > 1)
>> +			return 0;
>> +
>> +		ret = devfreq_set_target(devfreq, devfreq->suspend_freq, 0);
>> +		if (ret)
>> +			return ret;
>> +	}
>>   
>> -	return devfreq->governor->event_handler(devfreq,
>> -				DEVFREQ_GOV_SUSPEND, NULL);
>> +	return 0;
>>   }
>>   EXPORT_SYMBOL(devfreq_suspend_device);
>>   
>> @@ -888,14 +909,28 @@ EXPORT_SYMBOL(devfreq_suspend_device);
>>    */
>>   int devfreq_resume_device(struct devfreq *devfreq)
>>   {
>> +	int ret;
>> +
>>   	if (!devfreq)
>>   		return -EINVAL;
>>   
>> -	if (!devfreq->governor)
>> -		return 0;
>> +	if (devfreq->resume_freq) {
>> +		if (atomic_dec_return(&devfreq->suspend_count) >= 1)
>> +			return 0;
>>   
>> -	return devfreq->governor->event_handler(devfreq,
>> -				DEVFREQ_GOV_RESUME, NULL);
>> +		ret = devfreq_set_target(devfreq, devfreq->resume_freq, 0);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	if (devfreq->governor) {
>> +		ret = devfreq->governor->event_handler(devfreq,
>> +					DEVFREQ_GOV_RESUME, NULL);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>>   }
>>   EXPORT_SYMBOL(devfreq_resume_device);
>>   
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>> index e4963b0..d985199 100644
>> --- a/include/linux/devfreq.h
>> +++ b/include/linux/devfreq.h
>> @@ -131,6 +131,9 @@ struct devfreq_dev_profile {
>>    * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
>>    * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
>>    * @stop_polling:	 devfreq polling status of a device.
>> + * @suspend_freq:	 frequency of a device set during suspend phase.
>> + * @resume_freq:	 frequency of a device set in resume phase.
>> + * @suspend_count:	 suspend requests counter for a device.
>>    * @total_trans:	Number of devfreq transitions
>>    * @trans_table:	Statistics of devfreq transitions
>>    * @time_in_state:	Statistics of devfreq states
>> @@ -167,6 +170,10 @@ struct devfreq {
>>   	unsigned long scaling_max_freq;
>>   	bool stop_polling;
>>   
>> +	unsigned long suspend_freq;
>> +	unsigned long resume_freq;
>> +	atomic_t suspend_count;
>> +
>>   	/* information for device frequency transition */
>>   	unsigned int total_trans;
>>   	unsigned int *trans_table;
>>
> 
> 
