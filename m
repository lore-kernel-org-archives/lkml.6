Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25ADC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E6125680
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BZJDaCPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E6125680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752556AbeGBMfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:35:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38665 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752431AbeGBMfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:35:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so8524803wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 05:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y5Ebiqtv3lr2XOvYfMxgZdCGxipmLmOF4JK9zh05O3k=;
        b=BZJDaCPx1nMfYygx7dq6sQRucvRnzSEDZvpC3ikoD9POkXa1khkwr8exqxT13Wn2mK
         JWqLG/AUd/lT2Q3wJFIrEFRXD6pU4ElVKuG3AWwyns/ZwYcxzmTXp2nA7nNDtk6xGvxA
         zv5CCz1AEXLznJjWlQZyUhEYIlpYR+R1mi1KA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y5Ebiqtv3lr2XOvYfMxgZdCGxipmLmOF4JK9zh05O3k=;
        b=R90Q64c8n3eNeRinRO8oXCc87Mm2WVTszUp3D7insdV3GcNrGRXb+MgO4eFJGyxGvR
         eK1U82myDVfl5ZHVOC291PcO7laEBHAVce4EuzX8/pEtqyKLZmP4DBBvFXRPTjeW7Twj
         +mSLMN7PHNJPJPekV3PAut9BNpqMuOnNJ81C8LV1vEPkmNzd7MpZIRJPPGT0cD24WQfq
         IGYgnj3384aDUx04dRRqHDyYdJLXlPg6KFzSlPo8yddfwW4is4BB/TuvgaWJk7wrCxjw
         OOGS0hhpgoah4eDvt619/FztIo3CodzxP1qaQ7L4iIOCNRQorhyaB3OYRKb0lYjgCrJA
         rbsw==
X-Gm-Message-State: APt69E12YokSxeg84Y4mqjmSiOCibtwAQ8BPf9/Q6jo9GbO4BirPunKz
        qR0eCMWfw1sTLSd9vBm1ruNfhQ==
X-Google-Smtp-Source: AAOMgpfZa7NXfWLxSLQHFu14iJtGF1U8wtV6xHQUYmADg7mN0UnxFuvm500zp6gL7dXaOBhyiOc+Cw==
X-Received: by 2002:a1c:5f82:: with SMTP id t124-v6mr8286973wmb.14.1530534949234;
        Mon, 02 Jul 2018 05:35:49 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id w2-v6sm13045837wme.45.2018.07.02.05.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 05:35:48 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: Re: [PATCH v4 02/27] venus: hfi: preparation to support venus 4xx
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org,
        Tomasz Figa <tfiga@chromium.org>
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
 <20180627152725.9783-3-stanimir.varbanov@linaro.org>
 <CAPBb6MVST50MfDbs_GydCBDAA_fsVTYVVU9iCGiaCnMxPBRBPg@mail.gmail.com>
Message-ID: <22e415b0-fe3c-0584-e5ee-f0de94937234@linaro.org>
Date:   Mon, 2 Jul 2018 15:35:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPBb6MVST50MfDbs_GydCBDAA_fsVTYVVU9iCGiaCnMxPBRBPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Thanks for the comments!

On 07/02/2018 11:45 AM, Alexandre Courbot wrote:
> On Thu, Jun 28, 2018 at 12:35 AM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
>>
>> This covers the differences between 1xx,3xx and 4xx.
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  drivers/media/platform/qcom/venus/core.h         |  4 ++
>>  drivers/media/platform/qcom/venus/helpers.c      | 37 +++++++----
>>  drivers/media/platform/qcom/venus/hfi_helper.h   | 84 ++++++++++++++++++++++--
>>  drivers/media/platform/qcom/venus/hfi_venus_io.h |  7 ++
>>  drivers/media/platform/qcom/venus/vdec.c         |  5 +-
>>  drivers/media/platform/qcom/venus/venc.c         |  5 +-
>>  6 files changed, 120 insertions(+), 22 deletions(-)
>>

<snip>

>>
>>  static int intbufs_alloc(struct venus_inst *inst)
>>  {
>> -       unsigned int i;
>> +       size_t arr_sz;
>> +       size_t i;
>>         int ret;
>>
>> -       for (i = 0; i < ARRAY_SIZE(intbuf_types); i++) {
>> -               ret = intbufs_set_buffer(inst, intbuf_types[i]);
>> +       if (IS_V4(inst->core))
>> +               arr_sz = ARRAY_SIZE(intbuf_types_4xx);
>> +       else
>> +               arr_sz = ARRAY_SIZE(intbuf_types_1xx);
>> +
>> +       for (i = 0; i < arr_sz; i++) {
>> +               ret = intbufs_set_buffer(inst,
>> +                           IS_V4(inst->core) ? intbuf_types_4xx[i] :
>> +                                               intbuf_types_1xx[i]);
> 
> I suspect you could simplify this a bit by doing something like:
> 
>     const unsigned int *intbuf;
> 
>     if (IS_V4(inst->core)) {
>         arr_sz = ARRAY_SIZE(intbuf_types_4xx);
>         intbuf = intbuf_types_4xx;
>     } else {
>         arr_sz = ARRAY_SIZE(intbuf_types_1xx);
>         intbuf = intbuf_types_1xx;
>     }
> 
>     for (i = 0; i < arr_sz; i++) {
>         ret = intbufs_set_buffer(inst, intbuf[i]);
>         if (ret)
>             goto error;
>     }

yes, it looks better.

> 
>>                 if (ret)
>>                         goto error;
>>         }
>> @@ -257,12 +273,11 @@ static int load_scale_clocks(struct venus_core *core)
>>
>>  set_freq:
>>
>> -       if (core->res->hfi_version == HFI_VERSION_3XX) {
>> -               ret = clk_set_rate(clk, freq);
>> +       ret = clk_set_rate(clk, freq);
>> +
>> +       if (IS_V3(core) || IS_V4(core)) {
>>                 ret |= clk_set_rate(core->core0_clk, freq);
>>                 ret |= clk_set_rate(core->core1_clk, freq);
>> -       } else {
>> -               ret = clk_set_rate(clk, freq);
>>         }
>>
>>         if (ret) {
>> diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
>> index 55d8eb21403a..1bc5aab1ce6b 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_helper.h
>> +++ b/drivers/media/platform/qcom/venus/hfi_helper.h
>> @@ -121,6 +121,7 @@
>>  #define HFI_EXTRADATA_METADATA_FILLER                  0x7fe00002
>>
>>  #define HFI_INDEX_EXTRADATA_INPUT_CROP                 0x0700000e
>> +#define HFI_INDEX_EXTRADATA_OUTPUT_CROP                        0x0700000f
>>  #define HFI_INDEX_EXTRADATA_DIGITAL_ZOOM               0x07000010
>>  #define HFI_INDEX_EXTRADATA_ASPECT_RATIO               0x7f100003
>>
>> @@ -376,13 +377,18 @@
>>  #define HFI_BUFFER_OUTPUT2                     0x3
>>  #define HFI_BUFFER_INTERNAL_PERSIST            0x4
>>  #define HFI_BUFFER_INTERNAL_PERSIST_1          0x5
>> -#define HFI_BUFFER_INTERNAL_SCRATCH            0x1000001
>> -#define HFI_BUFFER_EXTRADATA_INPUT             0x1000002
>> -#define HFI_BUFFER_EXTRADATA_OUTPUT            0x1000003
>> -#define HFI_BUFFER_EXTRADATA_OUTPUT2           0x1000004
>> -#define HFI_BUFFER_INTERNAL_SCRATCH_1          0x1000005
>> -#define HFI_BUFFER_INTERNAL_SCRATCH_2          0x1000006
>> -
>> +#define HFI_BUFFER_INTERNAL_SCRATCH(ver)       \
>> +       (((ver) == HFI_VERSION_4XX) ? 0x6 : 0x1000001)
>> +#define HFI_BUFFER_INTERNAL_SCRATCH_1(ver)     \
>> +       (((ver) == HFI_VERSION_4XX) ? 0x7 : 0x1000005)
>> +#define HFI_BUFFER_INTERNAL_SCRATCH_2(ver)     \
>> +       (((ver) == HFI_VERSION_4XX) ? 0x8 : 0x1000006)
>> +#define HFI_BUFFER_EXTRADATA_INPUT(ver)                \
>> +       (((ver) == HFI_VERSION_4XX) ? 0xc : 0x1000002)
>> +#define HFI_BUFFER_EXTRADATA_OUTPUT(ver)       \
>> +       (((ver) == HFI_VERSION_4XX) ? 0xa : 0x1000003)
>> +#define HFI_BUFFER_EXTRADATA_OUTPUT2(ver)      \
>> +       (((ver) == HFI_VERSION_4XX) ? 0xb : 0x1000004)
>>  #define HFI_BUFFER_TYPE_MAX                    11
>>
>>  #define HFI_BUFFER_MODE_STATIC                 0x1000001
>> @@ -424,12 +430,14 @@
>>  #define HFI_PROPERTY_PARAM_CODEC_MASK_SUPPORTED                        0x100e
>>  #define HFI_PROPERTY_PARAM_MVC_BUFFER_LAYOUT                   0x100f
>>  #define HFI_PROPERTY_PARAM_MAX_SESSIONS_SUPPORTED              0x1010
>> +#define HFI_PROPERTY_PARAM_WORK_MODE                           0x1015
>>
>>  /*
>>   * HFI_PROPERTY_CONFIG_COMMON_START
>>   * HFI_DOMAIN_BASE_COMMON + HFI_ARCH_COMMON_OFFSET + 0x2000
>>   */
>>  #define HFI_PROPERTY_CONFIG_FRAME_RATE                         0x2001
>> +#define HFI_PROPERTY_CONFIG_VIDEOCORES_USAGE                   0x2002
>>
>>  /*
>>   * HFI_PROPERTY_PARAM_VDEC_COMMON_START
>> @@ -438,6 +446,9 @@
>>  #define HFI_PROPERTY_PARAM_VDEC_MULTI_STREAM                   0x1003001
>>  #define HFI_PROPERTY_PARAM_VDEC_CONCEAL_COLOR                  0x1003002
>>  #define HFI_PROPERTY_PARAM_VDEC_NONCP_OUTPUT2                  0x1003003
>> +#define HFI_PROPERTY_PARAM_VDEC_PIXEL_BITDEPTH                 0x1003007
>> +#define HFI_PROPERTY_PARAM_VDEC_PIC_STRUCT                     0x1003009
>> +#define HFI_PROPERTY_PARAM_VDEC_COLOUR_SPACE                   0x100300a
>>
>>  /*
>>   * HFI_PROPERTY_CONFIG_VDEC_COMMON_START
>> @@ -518,6 +529,7 @@
>>  enum hfi_version {
>>         HFI_VERSION_1XX,
>>         HFI_VERSION_3XX,
>> +       HFI_VERSION_4XX
>>  };
>>
>>  struct hfi_buffer_info {
>> @@ -767,12 +779,56 @@ struct hfi_framesize {
>>         u32 height;
>>  };
>>
>> +#define VIDC_CORE_ID_DEFAULT   0
>> +#define VIDC_CORE_ID_1         1
>> +#define VIDC_CORE_ID_2         2
>> +#define VIDC_CORE_ID_3         3
>> +
>> +struct hfi_videocores_usage_type {
>> +       u32 video_core_enable_mask;
>> +};
>> +
>> +#define VIDC_WORK_MODE_1       1
>> +#define VIDC_WORK_MODE_2       2
>> +
>> +struct hfi_video_work_mode {
>> +       u32 video_work_mode;
>> +};
>> +
>>  struct hfi_h264_vui_timing_info {
>>         u32 enable;
>>         u32 fixed_framerate;
>>         u32 time_scale;
>>  };
>>
>> +struct hfi_bit_depth {
>> +       u32 buffer_type;
>> +       u32 bit_depth;
>> +};
>> +
>> +struct hfi_picture_type {
>> +       u32 is_sync_frame;
>> +       u32 picture_type;
>> +};
>> +
>> +struct hfi_pic_struct {
>> +       u32 progressive_only;
>> +};
>> +
>> +struct hfi_colour_space {
>> +       u32 colour_space;
>> +};
>> +
>> +struct hfi_extradata_input_crop {
>> +       u32 size;
>> +       u32 version;
>> +       u32 port_index;
>> +       u32 left;
>> +       u32 top;
>> +       u32 width;
>> +       u32 height;
>> +};
> 
> These structures are being used in the next patch - wouldn't it make
> more sense to move their declaration there as well?

Ok. I'll move in next patch.

-- 
regards,
Stan
