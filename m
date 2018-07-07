Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AFAC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 12:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF0C21E25
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 12:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UJExPvpb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF0C21E25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754145AbeGGM0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 08:26:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37551 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbeGGM0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 08:26:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id q10-v6so6517222wrd.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 05:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rkTrTCC9225uuwkhDpCuDmfSWEcGwOABPeLV3ei5SRQ=;
        b=UJExPvpbSpTZ1lGHmdXJiyawajBHGkOqLfZN1atB1E3MOHVmE1rhQx8DxnVoKn3I1q
         a9sB034KI38aa8AsryIrT5YNtgLY5vVAxz0000oBPo5PbT8JadWTRPmJl8CO9BHRFNPy
         ZVQdOXuLYxJbcFi9RvBFtd4vBqRuLHOYrdEwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rkTrTCC9225uuwkhDpCuDmfSWEcGwOABPeLV3ei5SRQ=;
        b=LikVPC+m3Tmh9xtnUZ86wOg3sr9WRtwutCprEg611M6Yqv66WS1Qabrb/DGTn5iESA
         kSKnOyjza3iJ8IQSb7BMqiqgM9FitOQEDV0KxYJQyXNbt3JI3MIVyzsdyZCza35BxHnq
         m2X4B8Kk2o5aaP72wmHcsq9pkfMHO/Ai8x6ixB/gJQ2am0//05uGwxlvAUyMQOYAd6oG
         FkJ3BoBHDu/sl5m87Kqe47eDPQLzEgZe6hIpz5swqTKGqotiGZ28JiHtdIvLQY0RBnmO
         sGWOfwax1dM5n73fNdMRXajkg9ppyO2Ssa58Q3NpePwDlQsUbrN6nqakAaMWtNFEbjMu
         zOLw==
X-Gm-Message-State: APt69E11M0Jpx1nHY/NbdudeHRJhBPNnBxUk7KlscL2t8JYFso4gUiR0
        Rh5VWdcx+N8IRR6vjyhBIm8IEQ==
X-Google-Smtp-Source: AAOMgpfmcuZhhDjuu1nen7YP7Rf5NFu9n2IBz+oaMVZ7Wv+qyriYWyJmx+E5DxZo6+6HxSBsicyIOg==
X-Received: by 2002:a5d:4210:: with SMTP id n16-v6mr9494863wrq.55.1530966401382;
        Sat, 07 Jul 2018 05:26:41 -0700 (PDT)
Received: from [192.168.1.8] (hst-221-57.medicom.bg. [84.238.221.57])
        by smtp.googlemail.com with ESMTPSA id n8-v6sm16541862wmg.27.2018.07.07.05.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 05:26:40 -0700 (PDT)
Subject: Re: [PATCH] venus: vdec: fix decoded data size
To:     Vikash Garodia <vgarodia@codeaurora.org>,
        stanimir.varbanov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, acourbot@chromium.org
References: <1530517447-29296-1-git-send-email-vgarodia@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <cd1c231b-1db1-6e61-8611-51eab9248842@linaro.org>
Date:   Sat, 7 Jul 2018 15:26:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530517447-29296-1-git-send-email-vgarodia@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vikash,

On  2.07.2018 10:44, Vikash Garodia wrote:
> Exisiting code returns the max of the decoded
> size and buffer size. It turns out that buffer
> size is always greater due to hardware alignment
> requirement. As a result, payload size given to
> client is incorrect. This change ensures that
> the bytesused is assigned to actual payload size.
> 
> Change-Id: Ie6f3429c0cb23f682544748d181fa4fa63ca2e28
> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> ---
>   drivers/media/platform/qcom/venus/vdec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index d079aeb..ada1d2f 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -890,7 +890,7 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
>   
>   		vb = &vbuf->vb2_buf;
>   		vb->planes[0].bytesused =
> -			max_t(unsigned int, opb_sz, bytesused);
> +			min_t(unsigned int, opb_sz, bytesused);

I cannot remember the exact reason to make it this way, might be an 
issue with vp8 or some mpeg2/4 on v1 which I workaround by this way. 
I'll test the patch on v1 & v3 and come back.

regards,
Stan

