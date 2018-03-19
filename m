Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933244AbeCSJ3l (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:29:41 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:52431 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932582AbeCSJ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:29:38 -0400
X-Google-Smtp-Source: AG47ELv29dtde9XBoziWwsvGN2kEEyy3GPh42vwPqB0+qnmNsvHvJGgsdlOQStT2XTwWj0eBnalVWQ==
MIME-Version: 1.0
In-Reply-To: <20ce58ee-879d-78b6-5e68-748317b67d12@mm-sol.com>
References: <20180313091135.145589-1-acourbot@chromium.org> <20ce58ee-879d-78b6-5e68-748317b67d12@mm-sol.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Mon, 19 Mar 2018 18:29:15 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWVnXZaKi4W3DNTXQhwmZm2FNBFPmB83VKGXr9X_0AknQ@mail.gmail.com>
Message-ID: <CAPBb6MWVnXZaKi4W3DNTXQhwmZm2FNBFPmB83VKGXr9X_0AknQ@mail.gmail.com>
Subject: Re: [PATCH] venus: vdec: fix format enumeration
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 6:52 PM, Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
> Hi Alex,
>
> Thanks for the patch!
>
> On 13.03.2018 11:11, Alexandre Courbot wrote:
>> find_format_by_index() stops enumerating formats as soon as the index
>> matches, and returns NULL if venus_helper_check_codec() finds out that
>> the format is not supported. This prevents formats to be properly
>> enumerated if a non-supported format is present, as the enumeration will
>> end with it.
>
> Please add fixes tag,
>
> Fixes: 29f0133ec6 media: venus: use helper function to check supported
> codecs

Sure.

>
>>
>> Fix this by moving the call to venus_helper_check_codec() into the loop,
>> and keep enumerating when it fails.
>
> Good catch!
>
>>
>> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
>>
>> Change-Id: I4ff66e0b85172598efa59a6f01da8cb60597a6a5
>
> You forgot to delete gerrit id.

D'oh, I should know better than send patches from my Chrome OS tree...

>
>> ---
>>   drivers/media/platform/qcom/venus/vdec.c | 13 +++++++------
>>   drivers/media/platform/qcom/venus/venc.c |  9 +++++++--
>>   2 files changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
>> index c9e9576bb08a..3677302cfe43 100644
>> --- a/drivers/media/platform/qcom/venus/vdec.c
>> +++ b/drivers/media/platform/qcom/venus/vdec.c
>> @@ -135,20 +135,21 @@ find_format_by_index(struct venus_inst *inst, unsigned int index, u32 type)
>>               return NULL;
>>
>>       for (i = 0; i < size; i++) {
>> +             bool valid;
>> +
>>               if (fmt[i].type != type)
>>                       continue;
>> -             if (k == index)
>> +             valid = (type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE ||
>> +                      venus_helper_check_codec(inst, fmt[i].pixfmt));
>
> open and close braces are not needed.

Removed them.

>
>> +             if (k == index && valid)
>>                       break;
>> -             k++;
>> +             if (valid)
>> +                     k++;
>>       }
>>
>>       if (i == size)
>>               return NULL;
>>
>> -     if (type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE &&
>> -         !venus_helper_check_codec(inst, fmt[i].pixfmt))
>> -             return NULL;
>> -
>>       return &fmt[i];
>>   }
>>
>> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
>> index e3a10a852cad..5eba4c7cd52e 100644
>> --- a/drivers/media/platform/qcom/venus/venc.c
>> +++ b/drivers/media/platform/qcom/venus/venc.c
>> @@ -120,11 +120,16 @@ find_format_by_index(struct venus_inst *inst, unsigned int index, u32 type)
>>               return NULL;
>>
>>       for (i = 0; i < size; i++) {
>> +             bool valid;
>> +
>>               if (fmt[i].type != type)
>>                       continue;
>> -             if (k == index)
>> +             valid = (type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE ||
>> +                      venus_helper_check_codec(inst, fmt[i].pixfmt));
>> +             if (k == index && valid)
>>                       break;
>> -             k++;
>> +             if (valid)
>> +                     k++;
>>       }
>>
>>       if (i == size)
>
> maybe we should delete the condition:
>
> if (type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE &&
> !venus_helper_check_codec(inst, fmt[i].pixfmt))
>
> as we do for the decoder?

We should indeed, missed that.
