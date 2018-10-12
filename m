Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7422BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F43D2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQfoTxm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F43D2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeJLPIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:08:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33031 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbeJLPIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 11:08:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id y140-v6so17410198wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 00:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cq7vkrDR75GAEBC63mtwrmw2ClBWgIct7xprWj9j0JQ=;
        b=DQfoTxm4pqak686AuwSbZBYqCzePG+H/Qi3GUnnmggr+w6di1d+7IgPNF3uFhCB8wy
         OJCLfdDudTZ/HwU5AMon5+9EyeYl6tXUS9tPu+pwh/wJkP2VU17m25lllZN2ANqjM69p
         /ff451FFCYAVCJrMDHihgPYRbU/+snZrfB1UM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cq7vkrDR75GAEBC63mtwrmw2ClBWgIct7xprWj9j0JQ=;
        b=Hu0wxJXIqIC4HY/9EPdmjs363Mp+T78jjpTfgwzwnQMNiZQYlB25HwEHZNfFW7gY/u
         DXk252VwBoMKeEsfmtMqNsAhF4JrAWNqaZQ/Ind5YyFC1gsTGwFDDOPFi+M1S/Iw1yK1
         aqo+7NVg1Yncg9va6zpfsDJ7jVMEYNFC6OnDM002YNkmtx/NapMDCTW29EnNLwghM/UY
         s8zIWsN7rayNcX/W84pXxGJphTUIRgL7SXRsshM5ZNk28dnLeRF3Q899BcRyAzyHxNbd
         bVDVjvXgz3/u46U8bq61qgq4pSgb5OmUY6ssffnNw9/DtxhLLcy0DovR7U89xR0JXzUl
         Fgpg==
X-Gm-Message-State: ABuFfoh/KxmHXQVYr4wL9FrUIddPSk3tA7FVGp3VBPGnWwO/Wilyq0gI
        uoLpV4wODuwiNLtdPmTRlvUV8A==
X-Google-Smtp-Source: ACcGV62aj57LLnTS+iZktjMuTuSDdGQ2xDVJao1vJNYZt7KDeY1ufRIfPiGLofvKQ7uKlj9uf3VidQ==
X-Received: by 2002:a1c:cb05:: with SMTP id b5-v6mr4086557wmg.44.1539329853764;
        Fri, 12 Oct 2018 00:37:33 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id j9-v6sm368861wrt.32.2018.10.12.00.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 00:37:33 -0700 (PDT)
Subject: Re: [PATCH] media: venus: add support for key frame
To:     Alexandre Courbot <acourbot@chromium.org>, mgottam@codeaurora.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org
References: <1539071634-1644-1-git-send-email-mgottam@codeaurora.org>
 <CAPBb6MUt_V4zEKGcRYXRXNRVdjF2uspOvEj0T-dH6dBZ9ya9CA@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <f1bb2ead-fe8e-af6a-1b96-9460a7b01f29@linaro.org>
Date:   Fri, 12 Oct 2018 10:37:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPBb6MUt_V4zEKGcRYXRXNRVdjF2uspOvEj0T-dH6dBZ9ya9CA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 10/12/2018 08:26 AM, Alexandre Courbot wrote:
> On Tue, Oct 9, 2018 at 4:54 PM Malathi Gottam <mgottam@codeaurora.org> wrote:
>>
>> When client requests for a keyframe, set the property
>> to hardware to generate the sync frame.
>>
>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>> ---
>>  drivers/media/platform/qcom/venus/venc_ctrls.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
>> index 45910172..f332c8e 100644
>> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
>> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
>> @@ -81,6 +81,8 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>         struct venc_controls *ctr = &inst->controls.enc;
>>         u32 bframes;
>>         int ret;
>> +       void *ptr;
>> +       u32 ptype;
>>
>>         switch (ctrl->id) {
>>         case V4L2_CID_MPEG_VIDEO_BITRATE_MODE:
>> @@ -173,6 +175,14 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>
>>                 ctr->num_b_frames = bframes;
>>                 break;
>> +       case V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME:
>> +               ptype = HFI_PROPERTY_CONFIG_VENC_REQUEST_SYNC_FRAME;
>> +               ret = hfi_session_set_property(inst, ptype, ptr);
> 
> The test bot already said it, but ptr is passed to
> hfi_session_set_property() uninitialized. And as can be expected the
> call returns -EINVAL on my board.
> 
> Looking at other uses of HFI_PROPERTY_CONFIG_VENC_REQUEST_SYNC_FRAME I
> see that the packet sent to the firmware does not have room for an
> argument, so I tried to pass NULL but got the same result.

yes, because pdata cannot be NULL. I'd suggest to make a pointer to
struct hfi_enable and pass it to the set_property function.

-- 
regards,
Stan
