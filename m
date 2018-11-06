Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAD9C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABAF120869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rucFVYYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABAF120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389183AbeKGBhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:37:23 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54332 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389146AbeKGBhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:37:22 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181106161127euoutp019d0859e18b0311243c27fe79b9cba0db~klOXFjszx3198431984euoutp01I
        for <linux-kernel@vger.kernel.org>; Tue,  6 Nov 2018 16:11:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181106161127euoutp019d0859e18b0311243c27fe79b9cba0db~klOXFjszx3198431984euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1541520687;
        bh=hjPQ4cW2Mdsigk4ROsD6Qnmni/Fhuh35zTnxNIHe1zo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rucFVYYcvhgQwp/QGOMQTmxtwrVSnruQZ0v9MZLpdOWWaidhOo69V0wW/6Syo0tv/
         Qe75ND7JXPCQPkyru+0/oO8vAsu+uuYP2ZMrVL4zgC21cln9ez+dYmO16svD3nu1fB
         QjS99gvlCmzwKFweHlAIm945869ug3Qpt0vdrr5k=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181106161125eucas1p13cf70f550c5e38afdd32522f92aab8b2~klOV70Nce2666226662eucas1p1g;
        Tue,  6 Nov 2018 16:11:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C5.E7.04806.D2DB1EB5; Tue,  6
        Nov 2018 16:11:25 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181106161124eucas1p25b9be654095bc0628d301164553bc631~klOVC8u-v2861428614eucas1p2V;
        Tue,  6 Nov 2018 16:11:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181106161124eusmtrp20e357d9efc635af92dd870512abe9588~klOUxlpcb1300813008eusmtrp2X;
        Tue,  6 Nov 2018 16:11:24 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-e0-5be1bd2df575
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4C.CE.04284.C2DB1EB5; Tue,  6
        Nov 2018 16:11:24 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181106161123eusmtip2e1304ffcc17c9d9820687d1842be2efb~klOUD3u110665406654eusmtip2T;
        Tue,  6 Nov 2018 16:11:23 +0000 (GMT)
Subject: Re: [PATCH v2 01/17] thermal: add thermal_zone_set_mode() helper
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Amit kucheria <amit.kucheria@linaro.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Keerthy <j-keerthy@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <a126af62-cbea-a737-94b0-71cb5a4bebef@samsung.com>
Date:   Tue, 6 Nov 2018 17:11:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1541491911.2124.91.camel@intel.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se1BMcRTH++29e7vt2ObXig5FY8cw3hqM33iNR39cw4w0TI3+YHEnRqXZ
        2yLMSFmybJ4zsRpJocci2WqLaJIWPUgPEWrNMsojunlsmtLureG/c77nc875npnDUqpu+Vh2
        e0wcr43RRKkZBV1U5aybMaPMHjH7jjiGJCVkysgH0YbIdeNDmqQ3NstJ+cEGRAbefZKTJ8WJ
        MnLIdJkmWQ67J2koTWOIaKxEJO1rqydx2FMY8tHiRwqyWxjiLL1Ik7K3IlrqwyV2VTGcqa2W
        4UpMbzy5wlfzuMy7HTKuIPcow71uvstwxqSvDFfcfJHiHqX+ojlbS7GMEwvGh4zYoFi0lY/a
        vovXzlqySbHtmvGNLNYyYU9aVxGdgCr8DciLBTwX8g+mMwakYFU4G4He8oyWkh4E3fldQxUR
        gTXznudwS7u5E0mFawi+GeuGqC4ENxJfIBc1Eq+Eh3Xf5QbEsr54FVjMrIuhcA4NZ9vK3JMY
        vABOHcl180q8BFob02hXTOOJkHGszN07CofDiZrJEuIDj8873IgXDgKDo94dUzgQkgovUK75
        gDNYKE9uoiSnwdBnakZSPBI6bZahCwJgoCRdJjWkIvjce4WWkpsIzDVVMolaCA9s9W4XFJ4C
        N0tnSfIyqEx4SrtkwN7Q8sVHMuENp4tSKUlWQvJhlURPgvyr+czwWkNJzpA1Dqoqq6mTaILp
        v9NM/51j+rf3EqJykR+vE6IjeWFODL97pqCJFnQxkTO37IwuQIOfWN1v+2FF9/o2VyDMIvUI
        5bNCe4RKrtklxEdXIGApta+yOm9QUm7VxO/ltTs3anVRvFCB/Fla7afc59EeocKRmjh+B8/H
        8trhqoz1GpuA5jelrN2gIgcCw8SgcetzRJXgeBkaN9B6ZBqXd+t3oM5jdDi1xmnQrmPai5/T
        1sPrHmVlJ/tnn+u9r3T2TFcIa/6I5t+9vsvZ17UBv8iZqCxbf561tMPXekWvD3tafjvE3k02
        /lzhDAq54/W+Bwvpx+v1LzWLQ3XB+1d/plquqmlhmyZoKqUVNH8BfgWDNYUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsVy+t/xe7o6ex9GG8xer2DR3LCYyeLZ5+OM
        Fmt7j7JYzL9yjdXiQONlRov/j16zWpza3sRk0TJrEYvFkicP2S0u75rDZvG59wijxZx3t9kt
        njzsY7N4sUXcYtOKG2wWP3fNY7HYe+8zo4OgR9P7Y2wes+6fZfPYOesuu8fWW6Yei/e8ZPLY
        tKqTzePOtT1sHr3N79g8tl+bx+xxYvp3Fo/jN7YzeXzeJBfAE6VnU5RfWpKqkJFfXGKrFG1o
        YaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXsbz3LlPBFsWKOe+3sTQwHpLuYuTk
        kBAwkXiw5hVjFyMXh5DAUkaJQ7+Xs3cxcgAlZCSOry+DqBGW+HOtiw2i5i2jxKljb9lAEsIC
        nhJHz31kBakXEfCW2LKGA6KmgUmi89AXFhCHWWA1i8TsD0+ZQBrYBKwkJravYgSxeQXsJG5f
        mcMCYrMIqEgs7N7LCmKLCkRI3HrYwQJRIyhxcuYTMJtTwFCi68lFMJtZQF3iz7xLzBC2vETz
        1tnMExgFZyFpmYWkbBaSsgWMzKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECY33bsZ+bdzBe
        2hh8iFGAg1GJh1djx8NoIdbEsuLK3EOMEhzMSiK8p1cDhXhTEiurUovy44tKc1KLDzGaAj0x
        kVlKNDkfmIbySuINTQ3NLSwNzY3Njc0slMR5zxtURgkJpCeWpGanphakFsH0MXFwSjUwMn/n
        FahLdzxSd/RF/yQ+1uDjPPm/H3985vT1upHXd63SgnlRfyZV/dot269Rznct1O500+rV7Psy
        vUT37Gvp2cnwrDLtusxEvbL6+Njgj7nMMl+OXdHgbFg4u8Ml6HfjSe0pZcHZ10/nfFM2kvl7
        V0iZc9ExRY1ARsn8xKZPdxfOXXC7Z1qAEktxRqKhFnNRcSIAOhFc0AsDAAA=
X-CMS-MailID: 20181106161124eucas1p25b9be654095bc0628d301164553bc631
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181017155320epcas2p439b713149d94aa485b3c2ffba063ea03
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181017155320epcas2p439b713149d94aa485b3c2ffba063ea03
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155320epcas2p439b713149d94aa485b3c2ffba063ea03@epcas2p4.samsung.com>
        <1539791563-5959-2-git-send-email-b.zolnierkie@samsung.com>
        <1541491911.2124.91.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/06/2018 09:11 AM, Zhang Rui wrote:
> On 三, 2018-10-17 at 17:52 +0200, Bartlomiej Zolnierkiewicz wrote:
>> In order to remove the code duplication and prepare for further
>> changes:
>>
>> * Add thermal_zone_set_mode() helper. Then update core code and
>>   drivers to use it.
>>
>> There should be no functional changes caused by this patch.
>>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> ---
>>  drivers/thermal/hisi_thermal.c     | 14 ++------------
>>  drivers/thermal/of-thermal.c       |  3 ++-
>>  drivers/thermal/rockchip_thermal.c | 26 +++++++++-----------------
>>  drivers/thermal/thermal_helpers.c  | 14 ++++++++++++++
>>  drivers/thermal/thermal_sysfs.c    |  8 +++++---
>>  include/linux/thermal.h            |  5 +++++
>>  6 files changed, 37 insertions(+), 33 deletions(-)
>>
>>  
>>  
>> diff --git a/drivers/thermal/thermal_helpers.c
>> b/drivers/thermal/thermal_helpers.c
>> index 2ba756a..b18cee2 100644
>> --- a/drivers/thermal/thermal_helpers.c
>> +++ b/drivers/thermal/thermal_helpers.c
>> @@ -224,3 +224,17 @@ int thermal_zone_get_offset(struct
>> thermal_zone_device *tz)
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(thermal_zone_get_offset);
>> +
>> +/**
>> + * thermal_zone_set_mode() - sets mode of thermal zone device
>> + * @tz: a valid pointer to a struct thermal_zone_device
>> + * @mode: mode to be set
>> + *
>> + * Return: On success returns 0, an error code otherwise.
>> + */
>> +int thermal_zone_set_mode(struct thermal_zone_device *tz,
>> +			  enum thermal_device_mode mode)
>> +{
>> +	return tz->ops->set_mode(tz, mode);
> 
> better to check tz->ops->set_mode first.

I think that it should be added incrementally later when needed.

We don't do 'defensive coding' in the kernel and in this patchset
thermal_zone_set_mode() is not used in any place which has not used
->set_mode directly previously (actually patches #1-4 should not
cause any functionality changes as noted in patch descriptions).

> thanks,
> rui
>> +}
>> +EXPORT_SYMBOL_GPL(thermal_zone_set_mode);
>> diff --git a/drivers/thermal/thermal_sysfs.c
>> b/drivers/thermal/thermal_sysfs.c
>> index 2241cea..2e9e762 100644
>> --- a/drivers/thermal/thermal_sysfs.c
>> +++ b/drivers/thermal/thermal_sysfs.c
>> @@ -69,17 +69,19 @@
>>  {
>>  	struct thermal_zone_device *tz = to_thermal_zone(dev);
>>  	int result;
>> +	enum thermal_device_mode mode;
>>  
>>  	if (!tz->ops->set_mode)
>>  		return -EPERM;
>>  
>>  	if (!strncmp(buf, "enabled", sizeof("enabled") - 1))
>> -		result = tz->ops->set_mode(tz,
>> THERMAL_DEVICE_ENABLED);
>> +		mode = THERMAL_DEVICE_ENABLED;
>>  	else if (!strncmp(buf, "disabled", sizeof("disabled") - 1))
>> -		result = tz->ops->set_mode(tz,
>> THERMAL_DEVICE_DISABLED);
>> +		mode = THERMAL_DEVICE_DISABLED;
>>  	else
>> -		result = -EINVAL;
>> +		return -EINVAL;
>>  
>> +	result = thermal_zone_set_mode(tz, mode);
>>  	if (result)
>>  		return result;
>>  
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index 5f4705f..9d21fd1 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -452,6 +452,8 @@ struct thermal_cooling_device *
>>  int thermal_zone_get_temp(struct thermal_zone_device *tz, int
>> *temp);
>>  int thermal_zone_get_slope(struct thermal_zone_device *tz);
>>  int thermal_zone_get_offset(struct thermal_zone_device *tz);
>> +int thermal_zone_set_mode(struct thermal_zone_device *tz,
>> +			  enum thermal_device_mode mode);
>>  
>>  int get_tz_trend(struct thermal_zone_device *, int);
>>  struct thermal_instance *get_thermal_instance(struct
>> thermal_zone_device *,
>> @@ -518,6 +520,9 @@ static inline int thermal_zone_get_slope(
>>  static inline int thermal_zone_get_offset(
>>  		struct thermal_zone_device *tz)
>>  { return -ENODEV; }
>> +static inline int thermal_zone_set_mode(
>> +		struct thermal_zone_device *tz, enum
>> thermal_device_mode mode)
>> +{ return -ENODEV; }
>>  static inline int get_tz_trend(struct thermal_zone_device *tz, int
>> trip)
>>  { return -ENODEV; }
>>  static inline struct thermal_instance *

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
