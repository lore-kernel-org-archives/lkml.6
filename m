Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A2BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80B22081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXFBB5FO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80B22081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeK2Vf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:35:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35082 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbeK2Vf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:35:58 -0500
Received: by mail-wm1-f66.google.com with SMTP id c126so1665847wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 02:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qZzxft3Mxby9sQcd2bZckbBCj4ottuk3Pb1sYryFYm4=;
        b=QXFBB5FOdfYGcNnZ68hykP/HCOgtymovxzNmy6ycu5Ed8Ih628XfpD+BvXrBzTkvSU
         +a98EoBOHGgxV37npeAv4V3qXwNs/ZwAxMdqPYM61dyPrJmNXw8l0k4jUrKFW89HYgSO
         XeysATP26FXqcYQ8QV27eg0IoGnddXK98eBCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qZzxft3Mxby9sQcd2bZckbBCj4ottuk3Pb1sYryFYm4=;
        b=mUWg91HF1GZOwxnx4tziExis3Siy7Ibr3Zlh4DoyBk/ecmXFL+lDe4wnk0W+NjnZdM
         bFkQWJxrAn8avLS50YLwYQW9zTci90FkyOskdLACFLFgDLyydGunR6DS9q+C7exp12FZ
         F1lbBVg8c+p8qlnLrZh+a5QZH1C4XpTdNacNJCadH3SFJBzpHDOlN2RPXi2EgqCUMUEv
         Fc5B7sgHuvhhzhi1XpftWahDR9a6Xp5ocsvhH7MuFjILfepEBDKLUuX0RNOCw/BX4S6B
         6wohg/NLym09Z3v0KxCAyNsOnTBzqgPWMAkIGJ7YHpUoJMSnn104UvNwIeQ0HbIvR46R
         ByZw==
X-Gm-Message-State: AA+aEWaVKO0q37lwVfHxEPGO9YA7BYPJfgsbJXIZDBWGas3ubiJvhW3F
        xv/BLpLh5mKpTniSpw46qtb26A==
X-Google-Smtp-Source: AFSGD/VLLH8nj3wXMlj+NqRr6XtPwd/k6u9/412xIsYwe1Zs7nhzAOCJvpKm3bxV5ROuXoFNnBH6gQ==
X-Received: by 2002:a1c:a183:: with SMTP id k125mr1138425wme.25.1543487463750;
        Thu, 29 Nov 2018 02:31:03 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id o81sm2354107wmd.10.2018.11.29.02.31.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 02:31:02 -0800 (PST)
Subject: Re: [PATCH v3] media: venus: add support for key frame
To:     Tomasz Figa <tfiga@chromium.org>, mgottam@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        vgarodia@codeaurora.org
References: <1541163476-23249-1-git-send-email-mgottam@codeaurora.org>
 <CAAFQd5D=hNdkEovonE6GOaYvq9dBbQwSZ=95V9a80e-sLp7cYg@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <4767b56f-420b-dc0c-0ae9-44dbf6dcd0b1@linaro.org>
Date:   Thu, 29 Nov 2018 12:31:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5D=hNdkEovonE6GOaYvq9dBbQwSZ=95V9a80e-sLp7cYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On 11/3/18 5:01 AM, Tomasz Figa wrote:
> Hi Malathi,
> 
> On Fri, Nov 2, 2018 at 9:58 PM Malathi Gottam <mgottam@codeaurora.org> wrote:
>>
>> When client requests for a keyframe, set the property
>> to hardware to generate the sync frame.
>>
>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>> ---
>>  drivers/media/platform/qcom/venus/venc_ctrls.c | 20 +++++++++++++++++++-
>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
>> index 45910172..59fe7fc 100644
>> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
>> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
>> @@ -79,8 +79,10 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>  {
>>         struct venus_inst *inst = ctrl_to_inst(ctrl);
>>         struct venc_controls *ctr = &inst->controls.enc;
>> +       struct hfi_enable en = { .enable = 1 };
>>         u32 bframes;
>>         int ret;
>> +       u32 ptype;
>>
>>         switch (ctrl->id) {
>>         case V4L2_CID_MPEG_VIDEO_BITRATE_MODE:
>> @@ -173,6 +175,19 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>
>>                 ctr->num_b_frames = bframes;
>>                 break;
>> +       case V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME:
>> +               mutex_lock(&inst->lock);
>> +               if (inst->streamon_out && inst->streamon_cap) {
> 
> We had a discussion on this in v2. I don't remember seeing any conclusion.
> 
> Obviously the hardware should generate a keyframe naturally when the
> CAPTURE streaming starts, which is where the encoding starts, but the
> state of the OUTPUT queue should not affect this.
> 
> The application is free to stop and start streaming on the OUTPUT
> queue as it goes and it shouldn't imply any side effects in the
> encoded bitstream (e.g. a keyframe inserted). So:
> - a sequence of STREAMOFF(OUTPUT),
> S_CTRL(V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME), STREAMON(OUTPUT) should
> explicitly generate a keyframe,

I agree with you, but presently we don't follow strictly the stateful
encoder spec. In this spirit I think proposed patch is applicable to the
current state of the encoder driver, and your comment should be
addressed in the follow-up patches where we have to re-factor a bit
start/stop_streaming according to the encoder documentation.

But until then we have to get that patch.

> - a sequence of STREAMOFF(OUTPUT), STREAMON(OUTPUT) should _not_
> explicitly generate a keyframe (the hardware may generate one, if the
> periodic keyframe counter is active or a scene detection algorithm
> decides so).
> 
> Please refer to the specification (v2 is the latest for the time being
> -> https://lore.kernel.org/patchwork/patch/1002476/) for further
> details and feel free to leave any comment for it.
> 
> Best regards,
> Tomasz
> 

-- 
regards,
Stan
