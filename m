Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB60C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E151420989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="g4nfZppK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E151420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbeLFTzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:55:14 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38315 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeLFTzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:55:13 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181206195510euoutp023fefd593c11d6c36d87b7903fa39daab~t1oRFqDz81167611676euoutp02f
        for <linux-kernel@vger.kernel.org>; Thu,  6 Dec 2018 19:55:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181206195510euoutp023fefd593c11d6c36d87b7903fa39daab~t1oRFqDz81167611676euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544126110;
        bh=s+vIBKm3zah1KNi6qdZ7micu10JKc38SiTPFQ1YrEBA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g4nfZppKnuI2bD2vZdxbh9TC+6jo83dIQ4k+8CxBiD0Fj3Hi/XJ1RxK+cipCcPt1/
         Gw5BIGsXgq6catlUXt1zTLcJsT3g9wQQm4GPLjLyWrFe8E7kWe1A/OJmuGlY0t+Wa3
         gVExm/6qGXBymHqckj9XmE3RH7Lr/yPIv0wYCdnw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181206195509eucas1p241ed156a8d361ac5f7aadbd143a68128~t1oPjO3jX0342703427eucas1p2Y;
        Thu,  6 Dec 2018 19:55:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D8.D9.04441.C9E790C5; Thu,  6
        Dec 2018 19:55:08 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181206195507eucas1p1c47750cb4d12a0876873209f638e9467~t1oN-JYuH3132231322eucas1p1S;
        Thu,  6 Dec 2018 19:55:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181206195507eusmtrp1df046db5c6b92276aa6b3fec7249b177~t1oNwemEU0729607296eusmtrp1M;
        Thu,  6 Dec 2018 19:55:07 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-42-5c097e9c3af2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E4.C7.04284.A9E790C5; Thu,  6
        Dec 2018 19:55:06 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181206195506eusmtip2f7a152e99efd55c02c25e3d30411e171~t1oM9fu560500705007eusmtip24;
        Thu,  6 Dec 2018 19:55:06 +0000 (GMT)
Subject: Re: [PATCH v2 02/11] thermal: add irq-mode configuration for trip
 point
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
        krzk@kernel.org
Message-ID: <3314da31-1b8b-ec19-4aee-38d98aa8adbf@partner.samsung.com>
Date:   Thu, 6 Dec 2018 20:55:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <2ac425fc-7c32-6e2f-7086-c14f85b0bbfd@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3Z2zs5Gk8+p7c0uxiqoSCtQOGRIkdSJwMLKSs1cedDI606a
        dqe8NWxEwso5t2qasSxrmplY5CVtRNoy1FaWpXQjE1sjpIicZ5L/Pe/z/j6e94GPJhROMpA+
        kH6I06SrU1WUTNzQMd4VbDwhjV/ZdTWMuXOplmSGHxUhxuSax5jbu0jG/LKXZLq7b0sY29CE
        ulJYKWZ6mowU4zrXjpiqPoeIKXjQLmGG3+uotXK2xlSD2PuGAQlraf4iYm3WsxT7preZYusq
        T7IWXSnJ6uqtiHXZ5m+VxsrWJHGpB3I4zYqIRFmK9tw1KtMckWus6qNOoc5QLZLSgEOhxWEX
        aZGMVuDrCPTu597hJ4Iei54UBheC0Yq34qknj0t+eKlqBFXmj95hBIHl7yfCQ/nhaHjd76a0
        iKYpHAKN1iyP7Y+bEXT/Wu7hCVyOQFtdIfIs5HgD6L574qS0GC+C008KJnUA3gXF725QAuML
        9rLhySukeCOYPusnswisBOewWSToIDhzt5zwBAAel4DxWyUlnB0JN50mJGg/+NpZLxH0XHha
        WuKtxsOzYquXPwZF9kYvEw5tnQ7SU4bAS6G2aYVgr4P+jjaJxwbsA/0jvsIJPnCh4SIh2HIo
        LlQI9BKoL3kuEvQsqK7RS84jlWFaMcO0MoZpZQz/cy8jsRUpuWw+LZnjV6Vzh0N4dRqfnZ4c
        sj8jzYYmftzTv50/GpH7xb5WhGmkminPXSuNV5DqHD4vrRUBTaj85YpjE5Y8SZ13hNNk7NVk
        p3J8K5pDi1VK+dEZg3EKnKw+xB3kuExOM7UV0dLAU8jsjN5xryViaHGgfbssKf9hYZArpFdZ
        KovxHwjvfRd1bzx8dez6/J6ogqETxpMJVYNZ8ZS7zJ5vrW9QjmZuG9z9J2XRpksdBQGNt27s
        3XJWI800vqojrllm9y10HN+zKXHBL0VOzIddkbYXfJlsc8LY2G9H9MGOvlnBeHT+zjAyI04l
        5lPUq5YRGl79D5gas6BtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsVy+t/xe7qz6jhjDL59sbDYOGM9q8WTA+2M
        FvM+y1rMP3KO1WL+lWusFufPb2C32PQYyFrYtoTF4vKuOWwWn3uPMFosvX6RyaJ17xF2iycP
        +9gceD3WzFvD6LFz1l12j8V7XjJ5bFrVyeZx59oeNo/NS+o9FvdNZvXo27KK0ePzJrkAzig9
        m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jK7eZWwF
        8+0q5iy9ztbAeNyki5GTQ0LAROJozyemLkYuDiGBpYwS97adYYdIiElM2rcdyhaW+HOtiw2i
        6DWjxLNHLWwgCWGBIInbN74C2RwcbAJ6EjtWFYKERQT2MEo8Wq0JUs8sMJtR4sOro1AbDjNJ
        7Gu5zAxSxSvgJtH3bhoriM0ioCLRdKIVzBYViJA4+3IdI0SNoMTJmU9YQGxOAXeJeS+mgfUy
        C5hJzNv8EMoWl7j1ZD4ThC0v0bx1NvMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nziw31
        ihNzi0vz0vWS83M3MQLjetuxn5t3MF7aGHyIUYCDUYmHt8KBM0aINbGsuDL3EKMEB7OSCK9Q
        DVCINyWxsiq1KD++qDQntfgQoynQcxOZpUST84EpJ68k3tDU0NzC0tDc2NzYzEJJnPe8QWWU
        kEB6YklqdmpqQWoRTB8TB6dUA6PDscT/uwJdnuYf05rg5SnRVFAhKs92uWVJRIyW9J8dv1yc
        /UxiDafwv29/Feu3buoe9b+TNiacrEmQ+Gv4NqnqeHa/8t+Ljk5Pmx7evhV0ISrpz1SdaKZJ
        fVbsjTsKF13gmn/N8/D85AS3dyoR93hLAqfpaf839GFXfXK2/fHcJWrrm6QVJiixFGckGmox
        FxUnAgCUpcRhAQMAAA==
X-CMS-MailID: 20181206195507eucas1p1c47750cb4d12a0876873209f638e9467
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181107171036eucas1p13253d56b463c8f888ab8f8e418635297
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181107171036eucas1p13253d56b463c8f888ab8f8e418635297
References: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181107171036eucas1p13253d56b463c8f888ab8f8e418635297@eucas1p1.samsung.com>
        <1541610593-28542-3-git-send-email-l.luba@partner.samsung.com>
        <1544022595.2841.45.camel@intel.com>
        <2ac425fc-7c32-6e2f-7086-c14f85b0bbfd@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/18 8:18 PM, Lukasz Luba wrote:
> Hi Rui,
> 
> On 12/5/18 4:09 PM, Zhang Rui wrote:
>> On 三, 2018-11-07 at 18:09 +0100, Lukasz Luba wrote:
>>> This patch adds support irq mode in trip point.
>>> When that flag is set in DT, there is no need for polling
>>> in thermal framework. Crossing the trip point will rise an IRQ.
>>> The naming convention for tip point 'type' can be confussing
>>> and 'passive' (whic is passive cooling) might be interpretted
>>> wrongly.
>>>
>>> This mechanism prevents from missue and adds explicit setting
>>> for hardware which support interrupts for pre-configured temperature
>>> threshold.
>>>
>>> Cc: Zhang Rui <rui.zhang@intel.com>
>>> Cc: Eduardo Valentin <edubezval@gmail.com>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>> ---
>>>   drivers/thermal/of-thermal.c   | 17 +++++++++++++++++
>>>   drivers/thermal/thermal_core.c | 10 ++++++++--
>>>   include/linux/thermal.h        |  5 +++++
>>>   3 files changed, 30 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-
>>> thermal.c
>>> index 4bfdb4a..1a75946a 100644
>>> --- a/drivers/thermal/of-thermal.c
>>> +++ b/drivers/thermal/of-thermal.c
>>> @@ -312,6 +312,20 @@ static int of_thermal_get_trip_type(struct
>>> thermal_zone_device *tz, int trip,
>>>       return 0;
>>>   }
>>> +static int
>>> +of_thermal_get_trip_irq_mode(struct thermal_zone_device *tz, int
>>> trip,
>>> +                 bool *mode)
>>> +{
>>> +    struct __thermal_zone *data = tz->devdata;
>>> +
>>> +    if (trip >= data->ntrips || trip < 0)
>>> +        return -EDOM;
>>> +
>>> +    *mode = data->trips[trip].irq_mode;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static int of_thermal_get_trip_temp(struct thermal_zone_device *tz,
>>> int trip,
>>>                       int *temp)
>>>   {
>>> @@ -394,6 +408,7 @@ static struct thermal_zone_device_ops
>>> of_thermal_ops = {
>>>       .set_mode = of_thermal_set_mode,
>>>       .get_trip_type = of_thermal_get_trip_type,
>>> +    .get_trip_irq_mode = of_thermal_get_trip_irq_mode,
>>>       .get_trip_temp = of_thermal_get_trip_temp,
>>>       .set_trip_temp = of_thermal_set_trip_temp,
>>>       .get_trip_hyst = of_thermal_get_trip_hyst,
>>> @@ -827,6 +842,8 @@ static int thermal_of_populate_trip(struct
>>> device_node *np,
>>>           return ret;
>>>       }
>>> +    trip->irq_mode = of_property_read_bool(np, "irq-mode");
>>> +
>>>       /* Required for cooling map matching */
>>>       trip->np = np;
>>>       of_node_get(np);
>>> diff --git a/drivers/thermal/thermal_core.c
>>> b/drivers/thermal/thermal_core.c
>>> index 39fc812..6d41e08 100644
>>> --- a/drivers/thermal/thermal_core.c
>>> +++ b/drivers/thermal/thermal_core.c
>>> @@ -406,6 +406,7 @@ static void handle_critical_trips(struct
>>> thermal_zone_device *tz,
>>>   static void handle_thermal_trip(struct thermal_zone_device *tz, int
>>> trip)
>>>   {
>>>       enum thermal_trip_type type;
>>> +    bool irq_mode = false;
>>>       /* Ignore disabled trip points */
>>>       if (test_bit(trip, &tz->trips_disabled))
>>> @@ -419,9 +420,14 @@ static void handle_thermal_trip(struct
>>> thermal_zone_device *tz, int trip)
>>>           handle_non_critical_trips(tz, trip);
>>>       /*
>>>        * Alright, we handled this trip successfully.
>>> -     * So, start monitoring again.
>>> +     * So, start monitoring in polling mode if
>>> +     * trip is not using irq HW support.
>>>        */
>>> -    monitor_thermal_zone(tz);
>>> +    if (tz->ops->get_trip_irq_mode)
>>> +        tz->ops->get_trip_irq_mode(tz, trip, &irq_mode);
>>> +
>>> +    if (!irq_mode)
>>> +        monitor_thermal_zone(tz);
>>>   }
>> handle_thermal_trip() is called from thermal_zone_device_update(), and
>> it is invoked for every trip points.
>> say, you have a passive trip point 1 that supports irq_mode, and
>> another passive trip point 2 that does not support irq_mode,
>> monitor_thermal_zone() is still called in handle_thermal_trip(tz, 2),
>> and the passive timer will be activated anyway, do I miss something?
> Yes, the passive timer will be activated in your example. It is correct
> behavior and does not break anything.
> case 1: there is 'k' passive trip points which have irq_mode and 1
> additional which does not have 'irq_mode', the framework will start
> polling but skip check for those 'k' trip points.
> case 2: all of the passive trip points have irq_mode set, the framework
> will not register 'scheduled_work' because it will not call 
> 'monitor_thermal_zone()'.
> This is the case of most Exynos platforms, but there is one exception 
> which has 'case 1' with 2 trip points not supporting irq_mode.
Do you suggest to cover the 'case 1'?
It would be possible after adding a new enum THERMAL_FRAMEWORK_POLL, 
then function:
thermal_zone_device_check() will call
thermal_zone_device_update(tz, THERMAL_FRAMEWORK_POLL)
and in handle_thermal_trip() implement something like:
--------------8<----------------
static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
{
	enum thermal_trip_type type;
	bool irq_mode = false;

	/* Ignore disabled trip points */
	if (test_bit(trip, &tz->trips_disabled))
		return;

	if (tz->ops->get_trip_irq_mode)
		tz->ops->get_trip_irq_mode(tz, trip, &irq_mode)

	if (tz->notify_event == THERMAL_FRAMEWORK_POLL && irq_mode)
		return;
...

	if (!irq_mode)
		monitor_thermal_zone(tz);
}

---------->8-----------------------

I could implement it in v3 if you don't see that it add too much of mess 
and agree for this approach.

Regards,
Lukasz

> 
> Regards,
> Lukasz
> 
>>
>> thanks,
>> rui
>>
>>>   static void update_temperature(struct thermal_zone_device *tz)
>>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>>> index 5f4705f..b064565 100644
>>> --- a/include/linux/thermal.h
>>> +++ b/include/linux/thermal.h
>>> @@ -103,6 +103,7 @@ struct thermal_zone_device_ops {
>>>           enum thermal_device_mode);
>>>       int (*get_trip_type) (struct thermal_zone_device *, int,
>>>           enum thermal_trip_type *);
>>> +    int (*get_trip_irq_mode) (struct thermal_zone_device *, int,
>>> bool *);
>>>       int (*get_trip_temp) (struct thermal_zone_device *, int, int
>>> *);
>>>       int (*set_trip_temp) (struct thermal_zone_device *, int,
>>> int);
>>>       int (*get_trip_hyst) (struct thermal_zone_device *, int, int
>>> *);
>>> @@ -196,6 +197,7 @@ struct thermal_zone_device {
>>>       struct thermal_attr *trip_temp_attrs;
>>>       struct thermal_attr *trip_type_attrs;
>>>       struct thermal_attr *trip_hyst_attrs;
>>> +    struct thermal_attr *trip_irq_mode_attrs;
>>>       void *devdata;
>>>       int trips;
>>>       unsigned long trips_disabled;    /* bitmap for disabled
>>> trips */
>>> @@ -364,6 +366,8 @@ struct thermal_zone_of_device_ops {
>>>    * @temperature: temperature value in miliCelsius
>>>    * @hysteresis: relative hysteresis in miliCelsius
>>>    * @type: trip point type
>>> + * @irq_mode: to not use polling in framework set support of HW irq
>>> (which will
>>> + *          be triggered when temperature reaches this level).
>>>    */
>>>   struct thermal_trip {
>>> @@ -371,6 +375,7 @@ struct thermal_trip {
>>>       int temperature;
>>>       int hysteresis;
>>>       enum thermal_trip_type type;
>>> +    bool irq_mode;
>>>   };
>>>   /* Function declarations */
>>
>>
