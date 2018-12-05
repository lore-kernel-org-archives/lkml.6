Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E03C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AE620850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FVa4LV7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4AE620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeLELHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:07:48 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44401 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeLELHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:07:43 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181205110741euoutp0102419b205d306b500e071c49eb4fb520~taybg1whj1464914649euoutp01r
        for <linux-kernel@vger.kernel.org>; Wed,  5 Dec 2018 11:07:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181205110741euoutp0102419b205d306b500e071c49eb4fb520~taybg1whj1464914649euoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544008062;
        bh=VBrP7BJueTxcWjpr5GWuBeTYkYFPmHLtaAhVTLQ7FMU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FVa4LV7Pb3qWhhHFFihVBPwJ1KdfXix899cIHE7QB46UTDXL+LuOgeRFdZxMBoLrE
         gJKVk1ZIuCqG5+yKJqjNu6b0EPAMjTUeIVZKsrHrlcN9ZdUvoH6Dbs7hUCxVeYimx8
         5SpHDUDsOjGEmTLcHHuBVxECC1bO2FypLliELvqs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181205110740eucas1p210a192d21b8ee4a3d555bb1a948c20f2~tayaa7Ato1209512095eucas1p2v;
        Wed,  5 Dec 2018 11:07:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 46.5A.04294.C71B70C5; Wed,  5
        Dec 2018 11:07:40 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181205110739eucas1p17a395bdc62e3b6ea7fd0bc52825c0a18~tayZp6RvC3198331983eucas1p1k;
        Wed,  5 Dec 2018 11:07:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181205110739eusmtrp22e6ac4b9f5b5f58f7b0c87e1735d7bdf~tayZaQTur2749527495eusmtrp2I;
        Wed,  5 Dec 2018 11:07:39 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-1a-5c07b17cf19f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 51.A2.04128.B71B70C5; Wed,  5
        Dec 2018 11:07:39 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181205110738eusmtip2944626cdd02fb2795af88f7b5264eda4~tayYgy3hi1996919969eusmtip2a;
        Wed,  5 Dec 2018 11:07:38 +0000 (GMT)
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
Message-ID: <60b64304-2aa9-2831-d94f-610be31b4e8e@partner.samsung.com>
Date:   Wed, 5 Dec 2018 12:07:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5C071740.7090000@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa1BMYRju23Otsc1pk95xd4ZxG+U25nO/jMsx/Wn8ITIszlSjLfYot5Bb
        1oqWMcqWwkbNllltW7IkVjSVVBRmkxrCoIyU28Ri96zRv+d93+eZ53m++VhClU0PZmPitona
        OHUsT/uRpfd/PJyUVMRETtYdH4nvlIzHRRkWCl8r+krhp71vKZxT+ZDCB00WGj84psFprz4Q
        uL7+KoPrDnQy2Hi6XIGtr55Q+LE9i8Y9xysRzqi/pcBXKlsZfOlpowK37M+ncWvNvb/62kcU
        PlxeyeCUgk8U7mx4QS4IFkpvlFJCYXYhEjKTG0nBkPYZCaab7xSC1XyUFirOFTJCce4+wXWf
        EWzNR0jhhM2MhPyCb4zQYx0erlztN2eTGBuTKGpD5633i642F1BbnLN26PqKyWRkCdUjlgVu
        OmTZZ+qRH6vi8hH0fT5JyUMvgh5HNS0PPQi67S8VeuTrUbTbbiL5kIeg93Kzl9WFoKntFuVm
        BXIRUGN6TbgPA7laBBUVDg+L4A4T4Ppko93uNBcCZeatboGSWwp9h2o8YpIbDbcbyj12Qdwq
        0LUV0DInAKrPdpBu7MtNBGdbuodDcMHg7Mjx4hFwsCTTYwzccxaKM/WEnHsx/L5xjJRxILyv
        sjEyHgq/r+d4u0lQpzPTMk6CI9VlXs5suFvVSLkzE9x4sNhD5fVCsFysVcgP6Q/PugLkCP5w
        qjSdkNdK0KWoZPY4sKU2eI0GQV7hGcaAeGO/YsZ+ZYz9yhj/+55HpBkFiwmSJkqUpsaJ20Mk
        tUZKiIsK2RivsaK/v7bWVdVbhuw/NzgQxyJ+gBJO05EqSp0o7dQ4ELAEP1CZP4eJVCk3qXfu
        ErXx67QJsaLkQENYkg9W7vZpX6PiotTbxM2iuEXU/rsqWN/ByWj5qjIipJw2rbSmdfksa5n2
        1b9ldnfYlLVDNRG7jR3RplF8GE7GdHZn+/z1uV8mEnuu2FO7LxjOPzoZVB/OxyZu/+5ylgS9
        X5LarN87Y2yrwkmNCx9tSP/1ZsL3ql1ZZxfV5foc2rxnbpMU83FY0grbsDEpHYEBR+v4j2Ep
        hvh1TS6elKLVUyYQWkn9B/9UCw6xAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+e0+DQe3qfnD6MGwKKVr85E/RSOC4lJE0gPSDFt6cdUetjst
        S8gyNbXSQkjnK3ykzKm5+aJSy5ahptOsDKWHaIiPQrKXGdLmDPzve873+zmHA4fGJGbCgz6t
        1vFatVwpJVfhPYsvPmy7VE9FbjelbkJPG7ei+rw6AjXX/yTQ0PcJApVY+giUUlZHopdZKpQ9
        No0hq/UBhXqvzlBIn9sqQqaxtwQafFhIormbFoDyrG0iVGN5T6GKoQERGrlSRaL33c9tfM8r
        AqW2WiiUVj1LoJn+D/gud67pURPBGYuNgCtIHsC5nOxvgCt7PCniTIYMkmsvMlKcufwyt9hJ
        cQ1v0nHuVoMBcFXVvyhuzrQ+TBzBhmg18Tp+o0Ij6EKlx2XIl5UFIdbXP4iV+QWeCPYNkPrs
        DInhlacTeK3PzpOsostQTcQNB1+4vmDGk0GdTyZwoiHjDz81PAaZYBUtYSoAnC2fEzmMNfBO
        WzPl0C7w79tM0hGaBjBtwoLZDRcmHHaXfcbshivTA2CutVtkLzAmFYOTX0qX5xZicKpAb3No
        mmRY2GI4Z6fFzF64cK2bsGuc8YRP+luXVrsxx2DvZC1wZFbDrvxx3K6dGG84/PHuUgZjdsBi
        8yjm0O5weLxkub8BpjQWYDlAol+B61cg+hWIfgVyD+AG4MrHC6pYleDLCnKVEK+OZaM1KhOw
        PUxT53xDC8j8ergDMDSQOothLhkpIeQJQqKqA0Aak7qKq0KoSIk4Rp54kddqorTxSl7oAAG2
        425jHm7RGtv7qXVRsgBZIAqSBfoF+u1AUnexdXtihISJlev4szwfx2v/cyLaySMZEEVbfhQf
        qM7vKO33c+4c7S9US6j52oR0b87Qrq96F3ZkrSl7356BjMSKiGdpjbXr8mn5Zs/wyrLXKLry
        xnmFS+/BZyXrs5/EJPDnjMpk/NDwn7w2Mss79L7HaNTu9qSjU5oa1yRgXPjb5zW455SFDf09
        rxBh5v27ZkZAl+GMUooLCrnMC9MK8n/N6y19RgMAAA==
X-CMS-MailID: 20181205110739eucas1p17a395bdc62e3b6ea7fd0bc52825c0a18
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181203143131eucas1p217f22ac6d19682a54a57658a06980914
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181203143131eucas1p217f22ac6d19682a54a57658a06980914
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181203143131eucas1p217f22ac6d19682a54a57658a06980914@eucas1p2.samsung.com>
        <1543847475-7600-3-git-send-email-l.luba@partner.samsung.com>
        <5C06124B.5030409@samsung.com> <5C06140E.7010603@samsung.com>
        <5C061A57.7040002@samsung.com>
        <7662d626-5c3e-aec5-05e4-c6cd2e56ef49@partner.samsung.com>
        <5C071740.7090000@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 12/5/18 1:09 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 2018년 12월 04일 18:53, Lukasz Luba wrote:
>> Hi Chanwoo,
>>
>> On 12/4/18 7:10 AM, Chanwoo Choi wrote:
>>> Hi Lukasz,
>>>
>>> I add the comment about 'suspend_count'.
>>>
>>> On 2018년 12월 04일 14:43, Chanwoo Choi wrote:
>>>> Hi,
>>>>
>>>> On 2018년 12월 04일 14:36, Chanwoo Choi wrote:
>>>>> Hi Lukasz,
>>>>>
>>>>> Looks good to me. But, I add the some comments.
>>>>> If you will fix it, feel free to add my tag:
>>>>> Reviewed-by: Chanwoo choi <cw00.choi@samsung.com>
>>>>
>>>> Sorry. Fix typo 'choi' to 'Choi' as following.
>>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>>
>>>>>
>>>>> On 2018년 12월 03일 23:31, Lukasz Luba wrote:
>>>>>> The patch prepares devfreq device for handling suspend/resume
>>>>>> functionality.  The new fields will store needed information during this
>>>>>
>>>>> nitpick. Remove unneeded space. There are two spaces between '.' and 'The new'.
>>>>>
>>>>>> process.  Devfreq framework handles opp-suspend DT entry and there is no
>>>>>
>>>>> ditto.
>>>>>
>>>>>> need of modyfications in the drivers code.  It uses atomic variables to
>>>>>
>>>>> ditto.
>>>>>
>>>>>> make sure no race condition affects the process.
>>>>>>
>>>>>> The patch is based on earlier work by Tobias Jakobi.
>>>>>
>>>>> Please remove it from each patch description.
>>>>>
>>>>>>
>>>>>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>>>>>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>>>>> ---
>>>>>>    drivers/devfreq/devfreq.c | 51 +++++++++++++++++++++++++++++++++++++++--------
>>>>>>    include/linux/devfreq.h   |  7 +++++++
>>>>>>    2 files changed, 50 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>>> index a9fd61b..36bed24 100644
>>>>>> --- a/drivers/devfreq/devfreq.c
>>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>>> @@ -316,6 +316,10 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>>>>>>    			"Couldn't update frequency transition information.\n");
>>>>>>    
>>>>>>    	devfreq->previous_freq = new_freq;
>>>>>> +
>>>>>> +	if (devfreq->suspend_freq)
>>>>>> +		devfreq->resume_freq = cur_freq;
>>>>>> +
>>>>>>    	return err;
>>>>>>    }
>>>>>>    
>>>>>> @@ -667,6 +671,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>>>    	}
>>>>>>    	devfreq->max_freq = devfreq->scaling_max_freq;
>>>>>>    
>>>>>> +	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
>>>>>> +	atomic_set(&devfreq->suspend_count, 0);
>>>>>> +
>>>>>>    	dev_set_name(&devfreq->dev, "devfreq%d",
>>>>>>    				atomic_inc_return(&devfreq_no));
>>>>>>    	err = device_register(&devfreq->dev);
>>>>>> @@ -867,14 +874,28 @@ EXPORT_SYMBOL(devm_devfreq_remove_device);
>>>>>>     */
>>>>>>    int devfreq_suspend_device(struct devfreq *devfreq)
>>>>>>    {
>>>>>> +	int ret;
>>>>>> +
>>>>>>    	if (!devfreq)
>>>>>>    		return -EINVAL;
>>>>>>    
>>>>>> -	if (!devfreq->governor)
>>>>>> -		return 0;
>>>>>> +	if (devfreq->governor) {
>>>>>> +		ret = devfreq->governor->event_handler(devfreq,
>>>>>> +					DEVFREQ_GOV_SUSPEND, NULL);
>>>>>> +		if (ret)
>>>>>> +			return ret;
>>>>>> +	}
>>>>>> +
>>>>>> +	if (devfreq->suspend_freq) {
>>>>>> +		if (atomic_inc_return(&devfreq->suspend_count) > 1)
>>>>>> +			return 0;
>>>>>> +
>>>>>> +		ret = devfreq_set_target(devfreq, devfreq->suspend_freq, 0);
>>>>>> +		if (ret)
>>>>>> +			return ret;
>>>>>> +	}
>>>
>>> In this patch, if some users call 'devfreq_suspend_device' twice,
>>> 'devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_SUSPEND, NULL)'
>>> is called twice but devfreq_set_target() is called only one.
>>> I knew that it is no problem for operation.
>>>
>>> But,
>>> I think that you better to use 'suspend_count' as the reference count
>>> of devfreq_suspend/resume_device(). But, if you use 'suspend_count'
>>> in order to check whether this devfreq is suspended or not,
>>> we can reduce the unneeded redundant call when calling it twice.
>>>
>>> clock and regulator used the 'reference count' method in order to
>>> remove the redundant call.
>>
>> I think I've got the point. I will move the atomic check just
>> after the !devfreq check. Something like the code bellow is what you
>> would like to see?
>> ---8<-----
>> if (!devfreq)
>> 	return -EINVAL;
>> if (atomic_inc_return(&devfreq->suspend_count) > 1)
>> 	return0;
> 
> Looks good to me. I agree.
OK
> 
>>
>> ---->8-------
>>>
>>>
>>>>>>    
>>>>>> -	return devfreq->governor->event_handler(devfreq,
>>>>>> -				DEVFREQ_GOV_SUSPEND, NULL);
>>>>>> +	return 0;
>>>>>>    }
>>>>>>    EXPORT_SYMBOL(devfreq_suspend_device);
>>>>>>    
>>>>>> @@ -888,14 +909,28 @@ EXPORT_SYMBOL(devfreq_suspend_device);
>>>>>>     */
>>>>>>    int devfreq_resume_device(struct devfreq *devfreq)
>>>>>>    {
>>>>>> +	int ret;
>>>>>> +
>>>>>>    	if (!devfreq)
>>>>>>    		return -EINVAL;
>>>>>>    
>>>>>> -	if (!devfreq->governor)
>>>>>> -		return 0;
>>>>>> +	if (devfreq->resume_freq) {
>>>>>> +		if (atomic_dec_return(&devfreq->suspend_count) >= 1)
>>>>>> +			return 0;
>>>
>>> ditto.
>> Same approach here:
>> ---8<-----
>> if (!devfreq)
>> 	return -EINVAL;
>> if (atomic_dec_return(&devfreq->suspend_count) >= 1)
>> 	return 0;
> 
> Looks good to me.
Thank you. The patch set v3 is going to be sent.

Regards,
Lukasz

> 
>> ---->8-------
>>
>> Regards,
>> Lukasz
>>>
>>>>>>    
>>>>>> -	return devfreq->governor->event_handler(devfreq,
>>>>>> -				DEVFREQ_GOV_RESUME, NULL);
>>>>>> +		ret = devfreq_set_target(devfreq, devfreq->resume_freq, 0);
>>>>>> +		if (ret)
>>>>>> +			return ret;
>>>>>> +	}
>>>>>> +
>>>>>> +	if (devfreq->governor) {
>>>>>> +		ret = devfreq->governor->event_handler(devfreq,
>>>>>> +					DEVFREQ_GOV_RESUME, NULL);
>>>>>> +		if (ret)
>>>>>> +			return ret;
>>>>>> +	}
>>>>>> +
>>>>>> +	return 0;
>>>>>>    }
>>>>>>    EXPORT_SYMBOL(devfreq_resume_device);
>>>>>>    
>>>>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>>>>> index e4963b0..d985199 100644
>>>>>> --- a/include/linux/devfreq.h
>>>>>> +++ b/include/linux/devfreq.h
>>>>>> @@ -131,6 +131,9 @@ struct devfreq_dev_profile {
>>>>>>     * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
>>>>>>     * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
>>>>>>     * @stop_polling:	 devfreq polling status of a device.
>>>>>> + * @suspend_freq:	 frequency of a device set during suspend phase.
>>>>>> + * @resume_freq:	 frequency of a device set in resume phase.
>>>>>> + * @suspend_count:	 suspend requests counter for a device.
>>>>>>     * @total_trans:	Number of devfreq transitions
>>>>>>     * @trans_table:	Statistics of devfreq transitions
>>>>>>     * @time_in_state:	Statistics of devfreq states
>>>>>> @@ -167,6 +170,10 @@ struct devfreq {
>>>>>>    	unsigned long scaling_max_freq;
>>>>>>    	bool stop_polling;
>>>>>>    
>>>>>> +	unsigned long suspend_freq;
>>>>>> +	unsigned long resume_freq;
>>>>>> +	atomic_t suspend_count;
>>>>>> +
>>>>>>    	/* information for device frequency transition */
>>>>>>    	unsigned int total_trans;
>>>>>>    	unsigned int *trans_table;
>>>>>>
>>>>>
>>>>>
>>>>
>>>>
>>>
>>>
>>
>>
> 
> 
