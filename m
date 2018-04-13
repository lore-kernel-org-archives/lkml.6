Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754384AbeDMLK0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:10:26 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38832 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754143AbeDMLKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:10:24 -0400
X-Google-Smtp-Source: AIpwx48YgHFMy3Wg85fjwNeofIWSms07xftmpwOUFKrlXrKuTzuc2d8joWtMyXYRjLMUp4wA+T0Djg==
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc1
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
References: <1523436077.16235.5.camel@intel.com> <4212243.RcCUWlsaar@amdc3058>
 <3b41052a-233d-9992-223a-d16f48295905@linaro.org>
 <CGME20180413104120epcas1p319b9e78b025cb68f810f047c67a48362@epcas1p3.samsung.com>
 <10298074.ogKH1ypqfx@amdc3058>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <417cb724-2fcf-717f-63bf-9a479cc0d540@linaro.org>
Date: Fri, 13 Apr 2018 13:10:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <10298074.ogKH1ypqfx@amdc3058>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2018 12:41, Bartlomiej Zolnierkiewicz wrote:
> On Friday, April 13, 2018 12:30:04 PM Daniel Lezcano wrote:
>> On 13/04/2018 11:28, Bartlomiej Zolnierkiewicz wrote:
>>
>> [ ... ]
>>
>>>>> It is okay to return 0 because this code-path (the default one) will be
>>>>> never hit by the driver (probe makes sure of it) - the default case is
>>>>> here is just to silence compilation errors..
>>>>
>>>> The init function is making sure cal_type is one or another. Can you fix
>>>> it correctly by replacing the 'switch' by a 'if' instead of adding dead
>>>> branches to please gcc?
>>>>
>>>> if (data->cal_type == TYPE_TWO_POINT_TRIMMING) {
>>>> 	return ...;
>>>> }
>>>>
>>>> return ...;
>>>
>>> I'm not the one that added this switch statement (it has been there since
>>> 2011) and I would be happy to remove it. 
>>
>> Actually the switch statement was fine until the cleanup.
> 
> I don't see how it was fine before as the driver has never used the default
> case (always used TYPE_ONE_POINT_TRIMMING or TYPE_TWO_POINT_TRIMMING).
> 
> Could you please explain this more?

>From commit 480b5bfc16e17ef51ca1c

+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -260,7 +260,7 @@ static int temp_to_code(struct exynos_tmu_data
*data, u8 temp)
                temp_code = temp + data->temp_error1 -
pdata->first_point_trim;
                break;
        default:
-               temp_code = temp + pdata->default_temp_offset;
+               WARN_ON(1);
                break;
        }

@@ -287,7 +287,7 @@ static int code_to_temp(struct exynos_tmu_data
*data, u16 temp_code)
                temp = temp_code - data->temp_error1 +
pdata->first_point_trim;
                break;
        default:
-               temp = temp_code - pdata->default_temp_offset;
+               WARN_ON(1);
                break;
        }

I'm not saying the code path was fine but from the compiler point of
view, it was. By removing the defaulting temp value there is a code path
gcc sees the temp variable as not initialized.

Your cleanups are relevant.


> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
