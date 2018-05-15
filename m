Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeEOIbF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:31:05 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:55691 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752139AbeEOIbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:31:03 -0400
Subject: Re: [RFC PATCH 5/5] media: platform: Add Chrome OS EC CEC driver
To: Neil Armstrong <narmstrong@baylibre.com>, airlied@linux.ie,
        hans.verkuil@cisco.com, lee.jones@linaro.org, olof@lixom.net,
        seanpaul@google.com
Cc: sadolfsson@google.com, felixe@google.com, bleung@google.com,
        darekm@google.com, marcheu@chromium.org, fparent@baylibre.com,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1526337639-3568-1-git-send-email-narmstrong@baylibre.com>
 <1526337639-3568-6-git-send-email-narmstrong@baylibre.com>
 <f76d52b1-77bc-49dd-483c-43058d38da04@xs4all.nl>
 <ee591542-c481-3009-b3b5-725695ea9bfd@baylibre.com>
 <331d45a4-e496-d0f0-5a0b-ead2cc66da6f@xs4all.nl>
 <43b84663-da56-25fd-8e16-ba67f5a7c762@baylibre.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <809adc05-90a1-03f4-d0d6-23cd47f0da1a@xs4all.nl>
Date: Tue, 15 May 2018 10:30:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <43b84663-da56-25fd-8e16-ba67f5a7c762@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKQ7IuwhtIBn7TL45/rIezhmkwaVFRfN1TkCXwblD/A/Igy4fvULP6Mdoo+mpKcEbLP7sFEl33E0G7gJNzF8wytb5YQjx9IUWwwtTOjxoh5LbSHwk5a5
 XF3/GGJIdAJBSjJ3urxzdI+5omnCY175L6q86SLALE519VgO/g9s7cR0zfLKoT5eC8DBkPbFSjS8hjb6gPRtzTQYOB+CVCjRi32Qhg32Fp/VbBfzAWvrzHGQ
 UyH6VuVG5k8FmzqnTFK4LVJCdHVUOHgPdZnwBIXxP37QHhfK9ilStXal32s5WbSNoUqCiTitRHrzde2o0yuw2U2kVLcG7pVziLOIzaPUJDglDQEUR1jIirA/
 xyPfEz4EjvVkORB1ab7uVDrL9KQqpRy2WumyJypiWfowpIgf/IMI/RvsY/RKRcytYGly4XN7sh8lJs139o++Q0aKyFdM0Ff/HVC8OPpBbosDD3+Es9o5k8pG
 5W7wjsK8PtSPpBPp6gDoPIZ9hSH4excYqjSCPRfpfL2TEVAP1SVrXVZ5UWBALRDP8UYXL2FhhFGIXHUYnyRDoVZCcbWDxSD9m3kz/4hl9opCa+zltEz6K05G
 NKA6dPwP4c8a/sj8eOpNV1KxwK9wLB3bDynbgQQ7ZX+X1M11l/ym5+/CHwYfkJMtNhG5Db7L4FAkhUy/DuehyhaUCU4GJFt+b1QutXzc+sgYEhfKeFfDDWNX
 WX2G8mYv7srONoCTwH1kdC3ZC8vNYdG6wZLh4SyGOMUxo3SS/+tHPZuhkB7MJkkc8SSMX8QXcWhUy6Zl5JqxJGMvbuj2axILpXgANwruEmR2mDgAvaWMEQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/18 10:28, Neil Armstrong wrote:
>>>>> +	int ret;
>>>>> +
>>>>> +	cros_ec_cec = devm_kzalloc(&pdev->dev, sizeof(*cros_ec_cec),
>>>>> +				   GFP_KERNEL);
>>>>> +	if (!cros_ec_cec)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	platform_set_drvdata(pdev, cros_ec_cec);
>>>>> +	cros_ec_cec->cros_ec = cros_ec;
>>>>> +
>>>>> +	ret = cros_ec_cec_get_notifier(&cros_ec_cec->notify);
>>>>> +	if (ret) {
>>>>> +		dev_warn(&pdev->dev, "no CEC notifier available\n");
>>>>> +		cec_caps |= CEC_CAP_PHYS_ADDR;
>>>>
>>>> Can this happen? What hardware has this? I am strongly opposed to CEC drivers
>>>> using this capability unless there is no other option. It's a pain for userspace.
>>>
>>> It's in case an HW having a CEC capable FW but not in the cec_dmi_match_table, in this case
>>> it won't fail but still enable the CEC interface without a notifier.
>>
>> I don't think that's a good idea. CAP_PHYS_ADDR should *only* be used in situations
>> where it is truly impossible to tell which output is connected to the CEC adapter.
>> That's the case with e.g. USB CEC dongles where you have no idea how the user
>> connected the HDMI cables.
>>
>> But I assume that in this case it just means that the cec_dmi_match_table needs
>> to be updated, i.e. it is a driver bug.
> 
> Yep, maybe a dev_warn should be added to notify this bug ?

Yes, a dev_warn and then return -ENODEV.

> 
>>
>> Another thing: this driver assumes that there is only one CEC adapter for only
>> one HDMI output. But what if there are more HDMI outputs? Will there be one
>> CEC adapter for each output? Or does the hardware have no provisions for that?
> 
> The current EC interface only exposes a single CEC interface for now, there is no
> plan yet for multiple HDMI outputs handling.
> 
>>
>> Something should be mentioned about this in a comment.
> 
> Ok

Thanks!

	Hans
