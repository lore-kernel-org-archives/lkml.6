Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972B0C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4759322CB2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gTJs9fP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4759322CB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932429AbeGFPMf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:12:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52511 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932706AbeGFPMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:12:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id w16-v6so15153876wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 08:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IUPnPlDDFNhhIvXYPJdk3tn90Laq3eptpT3RwEsiAKY=;
        b=gTJs9fP6jD95rQKike7EepRB1iIAnfNBTVuSAonHbWBPkjs3D6w9/yHcjyb6/p/jg/
         ddMV1DxeaszM845qV9WkHJPppSeadPHSERcdLfoswMrouqFru4pqS0eEWOxECOGbidcf
         fLLGywof82KA12RBl6OJrcwj/TkCQQwqBLbC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IUPnPlDDFNhhIvXYPJdk3tn90Laq3eptpT3RwEsiAKY=;
        b=unWeAPO+yQB65JySq5hQmDzutqqcKvTgp6KkzvcXV9Jbz0+Otbw7s//tg6a2pRG7d2
         v/ztrjjuq7xe3ml4WSW7i+abnEAcGKDswB6bYdTBklUaG9OnPrhbZV5Ml9tq5wbqVo5Z
         ZcmamsdWIQqjZgHSG4zfvLs0oasMpZhVkLrgioMcozpZdf57wMJRbkLrqahaH0a6YvSy
         iihUCLRVtLPTuZzmNGJ32Sl5YxpIOjK4Md9x9QkwWZFXhwiw5jc5MalhB9R4lZa1eWQu
         DTMsExnM933UcnSQTdIAQHq28Y69Ip3jsKryaGVpJQEA1DP11Ji8MUw7fyfK9Yfg/Epk
         rzcw==
X-Gm-Message-State: APt69E3xVCMb6RiNB6l79SJpXtq3k7UnUwG+qGAqc7XM5RD2WjIU/T6S
        wSQ0/JxUiKoucVf4jbpchBJbHmZqEQs=
X-Google-Smtp-Source: AAOMgpdZi8lDwOSs9RrvO3JsQZIpYHV2f2fbTmh0xqZxvc69FaqEL9m8xH8CZkGkan8eFLpdGMBEyQ==
X-Received: by 2002:a1c:8b0d:: with SMTP id n13-v6mr6319223wmd.46.1530889951557;
        Fri, 06 Jul 2018 08:12:31 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id 72-v6sm16245718wmo.26.2018.07.06.08.12.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 08:12:30 -0700 (PDT)
Subject: Re: [PATCH] venus: vdec: fix decoded data size
To:     Alexandre Courbot <acourbot@chromium.org>, vgarodia@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <1530517447-29296-1-git-send-email-vgarodia@codeaurora.org>
 <CAPBb6MUBi+Dn5v4PKngxztFgKd6CA7bC1pKvWd1GMY9NJFoyZQ@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <b26cb8df-fac3-5941-9941-a6b3ca8af62e@linaro.org>
Date:   Fri, 6 Jul 2018 18:12:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPBb6MUBi+Dn5v4PKngxztFgKd6CA7bC1pKvWd1GMY9NJFoyZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 07/02/2018 11:51 AM, Alexandre Courbot wrote:
> On Mon, Jul 2, 2018 at 4:44 PM Vikash Garodia <vgarodia@codeaurora.org> wrote:
>>
>> Exisiting code returns the max of the decoded
> 
> s/Exisiting/Existing
> 
> Also the lines of your commit message look pretty short - I think the
> standard for kernel log messges is 72 chars?
> 
>> size and buffer size. It turns out that buffer
>> size is always greater due to hardware alignment
>> requirement. As a result, payload size given to
>> client is incorrect. This change ensures that
>> the bytesused is assigned to actual payload size.
>>
>> Change-Id: Ie6f3429c0cb23f682544748d181fa4fa63ca2e28
>> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
>> ---
>>  drivers/media/platform/qcom/venus/vdec.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
>> index d079aeb..ada1d2f 100644
>> --- a/drivers/media/platform/qcom/venus/vdec.c
>> +++ b/drivers/media/platform/qcom/venus/vdec.c
>> @@ -890,7 +890,7 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
>>
>>                 vb = &vbuf->vb2_buf;
>>                 vb->planes[0].bytesused =
>> -                       max_t(unsigned int, opb_sz, bytesused);
>> +                       min_t(unsigned int, opb_sz, bytesused);
> 
> Reviewed-by: Alexandre Courbot <acourbot@chromium.org>
> Tested-by: Alexandre Courbot <acourbot@chromium.org>
> 
> This indeed reports the correct size to the client. If bytesused were
> larger than the size of the buffer we would be having some trouble
> anyway.
> 
> Actually in my tree I was using the following patch:
> 
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -924,13 +924,12 @@ static void vdec_buf_done(struct venus_inst
> *inst, unsigned int buf_type,
> 
>                vb = &vbuf->vb2_buf;
>                vb->planes[0].bytesused =
> -                       max_t(unsigned int, opb_sz, bytesused);
> +                       min_t(unsigned int, opb_sz, bytesused);
>                vb->planes[0].data_offset = data_offset;
>                vb->timestamp = timestamp_us * NSEC_PER_USEC;
>                vbuf->sequence = inst->sequence_cap++;
>                if (vbuf->flags & V4L2_BUF_FLAG_LAST) {
>                        const struct v4l2_event ev = { .type = V4L2_EVENT_EOS };
> -                       vb->planes[0].bytesused = bytesused;

Actually this line doesn't exist in mainline driver. And I don't see a
reason why to set bytesused twice.

>                        v4l2_event_queue_fh(&inst->fh, &ev);
> 
> Given that we are now taking the minimum of these two values, it seems
> to me that we don't need to set bytesused again in case we are dealing
> with the last buffer? Stanimir, what do you think?
> 

-- 
regards,
Stan
