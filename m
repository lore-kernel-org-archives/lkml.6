Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EC1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6721422419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CAWiLF/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6721422419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732371AbeKMUnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:43:53 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52468 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732220AbeKMUnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:43:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id r11-v6so11373116wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 02:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uN4SdezITLVsisVTjnYSyX6Hrfw55ybm3Qh2dQp+NcU=;
        b=CAWiLF/fW2jicGP9h/r00J17rkMcBi0W7l4b+/1MyWWGQMQMoW2CFLtX/ErdlyPHMW
         JQvqb+AYY+KqLxvyxYZndfhCv71LabISVMmlyEJFlGWs0kB+6NL0y1nMJ44iPAdgGujs
         aaTlzUM0OVQbpRK4NW1QSoaQXs5FVxmr5OchE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uN4SdezITLVsisVTjnYSyX6Hrfw55ybm3Qh2dQp+NcU=;
        b=sk/OsgRl6STwBCT3c/XZh381UaaoXzA48c7QRzGPHmVKogPH/zO+g8YPNoejzQVR1d
         kOzlMa2DzzCuZ0HdA4WlCFPegz2N5HfGHC3RSXHK9r1gvab9XalcDG3szTDyZRRE1B9l
         1hHaPQOxZWiYqmueQzF3X7L+6nh3P2QIkTrwnN4gzjdNGsqCdqK8HklaqkwGEerXkc8p
         NlofC8iLXSIsGiOf60wfRW0PRqmVlDFVkqjXLlHV1izKhEmVw9/hK4vBj8jHw9PPUA0u
         OAfpXeUZBe029j0DwXyq3DHIu7R4acF5XZJUbgnYQuJKkCVnQ+lRsXO8LKh3nRHX87+M
         /E7A==
X-Gm-Message-State: AGRZ1gIP4NKuIwjCwgsKdoCqkBshicdB5y3A4vyYc+vdlhyaxQDSveRa
        T/i7E9IItQFm/kfsIwAadU+Jcg==
X-Google-Smtp-Source: AJdET5eBumnlc6AJ5W5/xpAwSWFvrMlQDRjHAuey90hKVwRerRLdBfbbodRLnTrh7F3WWB5XFQL0CQ==
X-Received: by 2002:a1c:e701:: with SMTP id e1mr2741465wmh.21.1542105979040;
        Tue, 13 Nov 2018 02:46:19 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id 125-v6sm13754788wmm.25.2018.11.13.02.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 02:46:18 -0800 (PST)
Subject: Re: [PATCH] media: venus: amend buffer size for bitstream plane
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     mgottam@codeaurora.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        vgarodia@codeaurora.org
References: <1539071530-1441-1-git-send-email-mgottam@codeaurora.org>
 <CAAFQd5BcFr11Hpngpn6hNL91OibAxUv25yh2qMohgfxsKusACw@mail.gmail.com>
 <8fe1d205-c5e7-01a0-9569-d3268911cddd@linaro.org>
 <38dfc098517b3ddb5d96195f2e27429d@codeaurora.org>
 <86714c89-20ec-07c8-2569-65e78e8d584d@linaro.org>
 <CAAFQd5DXWUCB7HvsLyVYU+h=2j6y1v3kcsTtHfNZYjfbHEgWGw@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <da2e7cef-5ade-7d43-92c1-f728644e61c9@linaro.org>
Date:   Tue, 13 Nov 2018 12:46:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5DXWUCB7HvsLyVYU+h=2j6y1v3kcsTtHfNZYjfbHEgWGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On 11/13/18 11:13 AM, Tomasz Figa wrote:
> On Tue, Nov 13, 2018 at 5:12 PM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
>>
>> Hi Malathi,
>>
>> On 11/13/18 9:28 AM, mgottam@codeaurora.org wrote:
>>> On 2018-11-12 18:04, Stanimir Varbanov wrote:
>>>> Hi Tomasz,
>>>>
>>>> On 10/23/2018 05:50 AM, Tomasz Figa wrote:
>>>>> Hi Malathi,
>>>>>
>>>>> On Tue, Oct 9, 2018 at 4:58 PM Malathi Gottam
>>>>> <mgottam@codeaurora.org> wrote:
>>>>>>
>>>>>> For lower resolutions, incase of encoder, the compressed
>>>>>> frame size is more than half of the corresponding input
>>>>>> YUV. Keep the size as same as YUV considering worst case.
>>>>>>
>>>>>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>>>>>> ---
>>>>>>  drivers/media/platform/qcom/venus/helpers.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/media/platform/qcom/venus/helpers.c
>>>>>> b/drivers/media/platform/qcom/venus/helpers.c
>>>>>> index 2679adb..05c5423 100644
>>>>>> --- a/drivers/media/platform/qcom/venus/helpers.c
>>>>>> +++ b/drivers/media/platform/qcom/venus/helpers.c
>>>>>> @@ -649,7 +649,7 @@ u32 venus_helper_get_framesz(u32 v4l2_fmt, u32
>>>>>> width, u32 height)
>>>>>>         }
>>>>>>
>>>>>>         if (compressed) {
>>>>>> -               sz = ALIGN(height, 32) * ALIGN(width, 32) * 3 / 2 / 2;
>>>>>> +               sz = ALIGN(height, 32) * ALIGN(width, 32) * 3 / 2;
>>>>>>                 return ALIGN(sz, SZ_4K);
>>>>>>         }
>>>>>
>>>>> Note that the driver should not enforce one particular buffer size for
>>>>> bitstream buffers unless it's a workaround for broken firmware or
>>>>> hardware. The userspace should be able to select the desired size.
>>>>
>>>> Good point! Yes, we have to extend set_fmt to allow bigger sizeimage for
>>>> the compressed buffers (not only for encoder).
>>>
>>> So Stan you meant to say that we should allow s_fmt to accept client
>>> specified size?
>>
>> yes but I do expect:
>>
>> new_sizeimage = max(user_sizeimage, venus_helper_get_framesz)
>>
>> and also user_sizeimage should be sanitized.
>>
>>> If so should we set the inst->input_buf_size here in venc_s_fmt?
>>>
>>> @@ -333,10 +333,10 @@static const struct venus_format *
>>> venc_try_fmt_common(struct venus_inst *inst, struct v4l2_format *f)
>>>
>>>         pixmp->num_planes = fmt->num_planes;
>>>         pixmp->flags = 0;
>>> -
>>> -       pfmt[0].sizeimage = venus_helper_get_framesz(pixmp->pixelformat,
>>> -                                                    pixmp->width,
>>> -                                                    pixmp->height);
>>> +       if (!pfmt[0].sizeimage)
>>> +               pfmt[0].sizeimage =
>>> venus_helper_get_framesz(pixmp->pixelformat,
>>> +                                                            pixmp->width,
>>> +
>>> pixmp->height);
>>
>> yes, but please make
>>
>> pfmt[0].sizeimage = max(pfmt[0].sizeimage, venus_helper_get_framesz)
>>
>> and IMO this should be only for CAPTURE queue i.e. inst->output_buf_size
>>
>> I'm still not sure do we need it for OUTPUT encoder queue.
>>
> 
> This would be indeed only for the queues that operate on a coded
> bitstream, i.e. both encoder CAPTURE and decoder OUTPUT.

Thanks for the confirmation.

> 
> For image formats, sizeimage should be calculated by the driver based
> on the bytesperline and height. (Bytesperline may be fixed, if the
> hardware doesn't support flexible strides, but if it does, it's
> strongly recommended to use the bytesperline coming from the
> application as the stride +/- any necessary sanity checks.)

the hw should support stride but I'm not sure is that exposed by the
firmware interface.

-- 
regards,
Stan
