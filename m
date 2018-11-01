Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379AFC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D537F2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2wN0dg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D537F2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbeKBAGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:06:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53309 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbeKBAGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:06:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id v24-v6so1674637wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 08:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e0iYSht8hSFv2C0qPTuUkTgt8vgA/0rOFTt/hulLcZI=;
        b=k2wN0dg6nq7yCE9KmnjO6B3KOt4rAIRaBb7Fc6BmwL5kbTWC6x/SbFR56LJogcC4id
         Q7FKn/Tr5O9shHA2IxUo6Li3W/wlXHTaVhf3ZbgVpqFN4B3QY17saifq8SH5yARG6q4n
         e7oes+AYxLIGf6DUBNEcG3ksKO2iFdrb8098o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e0iYSht8hSFv2C0qPTuUkTgt8vgA/0rOFTt/hulLcZI=;
        b=tAhtvfVwXj70/AK1WkyYq0JQ4cFkO+rQPvlX0PqFEIFrR2NHVgoWZwKkc6Fa2dcR/s
         7yKl10SJcxTiOGK9L896vWkY/EDsxSiLDoB5FibHPong/RzDpsifBlZkmYetxwb3fy0X
         vs7eBajCRDPSwFPNUGd3gllZb7ddVGkLEmTT3KS7LIFCKHfxjmAlqQEAj5AtxG0CRv0y
         uOXBcpCLFDPxIqwQSkPso1RbSE6tuwIZVd5HuQqAjE4jnEAnxkBCV1Zo96vT1zpf+JLV
         zf1HQE043dFKWrGi48sNAiHHPFvgtmra6u5SOgNTTCnni9MFeM+EhaQhmVSsXGH7Qi2l
         OtTQ==
X-Gm-Message-State: AGRZ1gKhL9aWAe6vjH3PPnkGSi+VfJxQATTfK9vPTAcLBONNI8ME9Y6W
        gRTVsUMOPtWKVP/DiQjMH/fHCQ==
X-Google-Smtp-Source: AJdET5cUwz/C9kGKC+9DJY3Gp0VWG++jWFETM6f7IRYg004X92uBYF1bdFpiMpIkGexuDog+Zow0xg==
X-Received: by 2002:a1c:3403:: with SMTP id b3-v6mr5849291wma.108.1541084596023;
        Thu, 01 Nov 2018 08:03:16 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id r1sm7181535wrx.15.2018.11.01.08.03.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 08:03:15 -0700 (PDT)
Subject: Re: [PATCH] media: venus: dynamic handling of bitrate
To:     Tomasz Figa <tfiga@chromium.org>, vgarodia@codeaurora.org
Cc:     mgottam@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        linux-media-owner@vger.kernel.org
References: <1540971728-26789-1-git-send-email-mgottam@codeaurora.org>
 <3ff2c3dd-434d-960b-6806-f4bb8ec0d954@linaro.org>
 <3364115421e89c7710725c06b820f8c6@codeaurora.org>
 <CAAFQd5A+9GWmn4aD4D2JMf1e1m-6Dtc3xUdMZsf8fPtgi34QVQ@mail.gmail.com>
 <ba1453b6868e97b96e0345129153b819@codeaurora.org>
 <CAAFQd5DuEqTiJbp5wR=_V0zVkVXTJPuMxDaJoTYFvVYfUA8U8g@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <19a08bd3-4e4c-56d2-6df2-54c3d91af4f3@linaro.org>
Date:   Thu, 1 Nov 2018 17:03:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5DuEqTiJbp5wR=_V0zVkVXTJPuMxDaJoTYFvVYfUA8U8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/1/18 4:31 PM, Tomasz Figa wrote:
> On Thu, Nov 1, 2018 at 11:23 PM Vikash Garodia <vgarodia@codeaurora.org> wrote:
>>
>> On 2018-11-01 19:23, Tomasz Figa wrote:
>>> On Thu, Nov 1, 2018 at 10:01 PM <mgottam@codeaurora.org> wrote:
>>>>
>>>> On 2018-11-01 17:48, Stanimir Varbanov wrote:
>>>>> Hi Malathi,
>>>>>
>>>>> Thanks for the patch!
>>>>>
>>>>> On 10/31/18 9:42 AM, Malathi Gottam wrote:
>>>>>> Any request for a change in bitrate after both planes
>>>>>> are streamed on is handled by setting the target bitrate
>>>>>> property to hardware.
>>>>>>
>>>>>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>>>>>> ---
>>>>>>  drivers/media/platform/qcom/venus/venc_ctrls.c | 11 +++++++++++
>>>>>>  1 file changed, 11 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c
>>>>>> b/drivers/media/platform/qcom/venus/venc_ctrls.c
>>>>>> index 45910172..54f310c 100644
>>>>>> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
>>>>>> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
>>>>>> @@ -79,7 +79,9 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>>>>>  {
>>>>>>      struct venus_inst *inst = ctrl_to_inst(ctrl);
>>>>>>      struct venc_controls *ctr = &inst->controls.enc;
>>>>>> +    struct hfi_bitrate brate;
>>>>>>      u32 bframes;
>>>>>> +    u32 ptype;
>>>>>>      int ret;
>>>>>>
>>>>>>      switch (ctrl->id) {
>>>>>> @@ -88,6 +90,15 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>>>>>              break;
>>>>>>      case V4L2_CID_MPEG_VIDEO_BITRATE:
>>>>>>              ctr->bitrate = ctrl->val;
>>>>>> +            if (inst->streamon_out && inst->streamon_cap) {
>>>>>
>>>>> Hmm, hfi_session_set_property already checks the instance state so I
>>>>> don't think those checks are needed. Another thing is that we need to
>>>>> take the instance mutex to check the instance state.
>>>>
>>>> Yes Stan, "hfi_session_set_property" this property check the instance
>>>> state,
>>>> but returns EINVAL if this is set at UNINIT instance state.
>>>>
>>>> Controls initialization happens much earlier than session init and
>>>> instance init.
>>>> So the instance is still in UNINIT state which causes failure while
>>>> setting.
>>>>
>>>> Through this patch we try to meet the client request of changing
>>>> bitrate
>>>> only
>>>> when both planes are streamed on.
>>>
>>> Where does this requirement come from? It should be possible to set
>>> the control at any time and it should apply to any encoding happening
>>> after the control is set.
>>>
>> With the patch, now video driver will set the control whenever client
>> sets
>> and will apply to encoder.
> 
> That's good, thanks for clarifying. I guess I misunderstood Malathi's comment.

OK, just wonder about locking when we check streamon_out/cap flags?

-- 
regards,
Stan
