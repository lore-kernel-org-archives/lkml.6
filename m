Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DABC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7885216E5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RTfP4tqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7885216E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752865AbeGBMnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:43:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53498 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752821AbeGBMnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:43:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id b188-v6so8937696wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 05:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3C9Hbozwd2iD5W5EGq4fiHKrokDeKbXtaZ2aA2LJYWU=;
        b=RTfP4tqQb+Cg7e23mF1T01C3Iy3tx2TendDCFz4maIPDCewGoVQ8tf/a+Agw3AOqQ+
         4JISPLyXCtdaJdMKOsV+Tro0QUrJHRjPglQiGcb5hPFgmNqtiF5ZU8SOAXSoSbcS51GI
         g+4wT6F4xhC8nDk+EqXUtHeaAeUWbseNtl0rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3C9Hbozwd2iD5W5EGq4fiHKrokDeKbXtaZ2aA2LJYWU=;
        b=gsAI5iVXT1ia3KImJGBWVz2AshFI6hkCdLKFTW2fT4nhYl4ebwd52/VRSmhkbXTynW
         5dl+Rdw1Fcx46zZjTOnPhHlMje9O7JUTeBH2Pekmuw/hb51oz1YZhi5p9uS6vqOyWrpV
         QCvxXQr1KZYS4aVByXyjbKyDOELvhdKTipJkljuWz/7Wfgudnj0QHxe1e+jH4I5l/TtH
         djIH+WGi/E3aTNVz9Jr4rcElaW8DRpTl2LmvaSjmQIAV6koibNEhHYdeMkbNEVLnD/Xx
         QGN15Udalnbqi7O7ThhXjDgjM9pH5VTfScsrY8Fq1IJjG8NAS6ulofAhkGeCf9JnLIpz
         OnOA==
X-Gm-Message-State: APt69E0hDw8Gu7nNtJNGx5FdRyaj+DWLMBjvAIODNyDUTIWBBtATEYEn
        EDFjFVWV6FYNKBnaIHUko3reNg==
X-Google-Smtp-Source: AAOMgpfvo9IiNUgztxf5ZWW8t4AusMAPJelmkkrGcz/nRRU1xJdNm3URwLum8GOogmvRIxNe951k6A==
X-Received: by 2002:a1c:108b:: with SMTP id 133-v6mr8962039wmq.136.1530535429200;
        Mon, 02 Jul 2018 05:43:49 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id u13-v6sm7909770wri.72.2018.07.02.05.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 05:43:48 -0700 (PDT)
Subject: Re: [PATCH v2 27/29] venus: implementing multi-stream support
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        vgarodia@codeaurora.org
References: <20180515075859.17217-1-stanimir.varbanov@linaro.org>
 <20180515075859.17217-28-stanimir.varbanov@linaro.org>
 <CAAFQd5Cyk2=YG+LVGt0qEcrRGdarpHJDJ73AzG1iWBbyhr+nAA@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <394e5547-9b85-604f-ee9e-fdb5ea2f4237@linaro.org>
Date:   Mon, 2 Jul 2018 15:43:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAAFQd5Cyk2=YG+LVGt0qEcrRGdarpHJDJ73AzG1iWBbyhr+nAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On 05/31/2018 12:51 PM, Tomasz Figa wrote:
> On Tue, May 15, 2018 at 5:00 PM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
>>
>> This is implementing a multi-stream decoder support. The multi
>> stream gives an option to use the secondary decoder output
>> with different raw format (or the same in case of crop).
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  drivers/media/platform/qcom/venus/core.h    |   1 +
>>  drivers/media/platform/qcom/venus/helpers.c | 204 +++++++++++++++++++++++++++-
>>  drivers/media/platform/qcom/venus/helpers.h |   6 +
>>  drivers/media/platform/qcom/venus/vdec.c    |  91 ++++++++++++-
>>  drivers/media/platform/qcom/venus/venc.c    |   1 +
>>  5 files changed, 299 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
>> index 4d6c05f156c4..85e66e2dd672 100644
>> --- a/drivers/media/platform/qcom/venus/core.h
>> +++ b/drivers/media/platform/qcom/venus/core.h
>> @@ -259,6 +259,7 @@ struct venus_inst {
>>         struct list_head list;
>>         struct mutex lock;
>>         struct venus_core *core;
>> +       struct list_head dpbbufs;
>>         struct list_head internalbufs;
>>         struct list_head registeredbufs;
>>         struct list_head delayed_process;
>> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
>> index ed569705ecac..87dcf9973e6f 100644
>> --- a/drivers/media/platform/qcom/venus/helpers.c
>> +++ b/drivers/media/platform/qcom/venus/helpers.c
>> @@ -85,6 +85,112 @@ bool venus_helper_check_codec(struct venus_inst *inst, u32 v4l2_pixfmt)
>>  }
>>  EXPORT_SYMBOL_GPL(venus_helper_check_codec);
>>
>> +static int venus_helper_queue_dpb_bufs(struct venus_inst *inst)
>> +{
>> +       struct intbuf *buf;
>> +       int ret = 0;
>> +
>> +       if (list_empty(&inst->dpbbufs))
>> +               return 0;
> 
> Does this special case give us anything other than few more source lines?

yes, thanks for spotting, will drop above lines here and below.

> 
>> +
>> +       list_for_each_entry(buf, &inst->dpbbufs, list) {
>> +               struct hfi_frame_data fdata;
>> +
>> +               memset(&fdata, 0, sizeof(fdata));
>> +               fdata.alloc_len = buf->size;
>> +               fdata.device_addr = buf->da;
>> +               fdata.buffer_type = buf->type;
>> +
>> +               ret = hfi_session_process_buf(inst, &fdata);
>> +               if (ret)
>> +                       goto fail;
>> +       }
>> +
>> +fail:
>> +       return ret;
>> +}
>> +
>> +int venus_helper_free_dpb_bufs(struct venus_inst *inst)
>> +{
>> +       struct intbuf *buf, *n;
>> +
>> +       if (list_empty(&inst->dpbbufs))
>> +               return 0;
> 
> Ditto.
> 
>> +
>> +       list_for_each_entry_safe(buf, n, &inst->dpbbufs, list) {
>> +               list_del_init(&buf->list);
>> +               dma_free_attrs(inst->core->dev, buf->size, buf->va, buf->da,
>> +                              buf->attrs);
>> +               kfree(buf);
>> +       }
>> +
>> +       INIT_LIST_HEAD(&inst->dpbbufs);
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(venus_helper_free_dpb_bufs);
> [snip]
>> +int venus_helper_get_out_fmts(struct venus_inst *inst, u32 v4l2_fmt,
>> +                             u32 *out_fmt, u32 *out2_fmt, bool ubwc)
>> +{
>> +       struct venus_core *core = inst->core;
>> +       struct venus_caps *caps;
>> +       u32 ubwc_fmt, fmt = to_hfi_raw_fmt(v4l2_fmt);
>> +       bool found, found_ubwc;
>> +
>> +       *out_fmt = *out2_fmt = 0;
>> +
>> +       if (!fmt)
>> +               return -EINVAL;
>> +
>> +       caps = venus_caps_by_codec(core, inst->hfi_codec, inst->session_type);
>> +       if (!caps)
>> +               return -EINVAL;
>> +
>> +       if (ubwc) {
>> +               ubwc_fmt = fmt | HFI_COLOR_FORMAT_UBWC_BASE;
> 
> Does the UBWC base format have to be the same as fmt? Looking at
> HFI_COLOR_FORMAT_* macros, UBWC variants seem to exist only for few
> selected raw formats, for example there is none for NV21.

I think any raw format can have its UBWC variant. And yes we have only
one macro but we are checking against parsed capabilities from firmware
where the supported formats are stored.

-- 
regards,
Stan
