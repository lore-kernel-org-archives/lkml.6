Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00E4C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC1420834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ALEaAy1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC1420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbeJEWZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:25:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45788 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbeJEWZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:25:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id q5-v6so13952635wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 08:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bbzYvj7J5pXIh6yhIFz9wNhr4kk4A3q3/FeRHBp6m2g=;
        b=ALEaAy1uXXgxlD3jJfqSLD7Z4i40qNxT1k6cPmwu2g/FrdeuOyHhCnEHWjYnapkPuP
         6K11mbJ6e9BnA0zUuyfoqrDGXu4Z5PKxfa4DXZ2rGF+ESfttbA5ivHAejsesWjBIJ4V9
         f6zkbMJ/G3nu6hA4F+Xm7ppI5DiIP84Z8jkqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bbzYvj7J5pXIh6yhIFz9wNhr4kk4A3q3/FeRHBp6m2g=;
        b=YlWYaFOd6aYFL+9IteFSIhn1d8vj+rGw8GejSOVKC1fzog6Ou5lPmV6JmrnC4r+F8M
         Js6CKIg8kUUlEH9EmIXY3oB0J3eZl1V9PZ1kkqEXqvMnK1QAiKSzgeZhX/V0CEwjTnCR
         lb/4sfmNbEzDyc1ClacnqnLPLjmvy2ru1bF1Q4xhOnsFWHDW0U+uoHy0ZpZ5OudllYQj
         7V9v35nqDgY4gAgQ0NZBe2/P1NHloFmrlhqb/SiMfKwKoqtUwQZaT4e3wnLAruGi0v5Y
         RQ6OkSRAiEUwk/6BQpljhvEdrvkKYHfPSYmeAP+xstJLKP6rkOaBwbsRA5QDKn+0GsXK
         IO9Q==
X-Gm-Message-State: ABuFfoiFrBMTvcydnNWTrUZbLx5K7Ln4P2CRuFzDGuWsYMSV/7koK/b/
        0rC5RhCVZeFu3wvWGowng6gzPQ==
X-Google-Smtp-Source: ACcGV62KS0DtQjB9A8dSE40y8fif9d3TROUCQvXxkG6msBra+s7EOT4AjIM8emlleH18iUHQRHjBXA==
X-Received: by 2002:a5d:404b:: with SMTP id w11-v6mr8201718wrp.147.1538753174891;
        Fri, 05 Oct 2018 08:26:14 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id 130-v6sm2502383wmn.7.2018.10.05.08.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 08:26:14 -0700 (PDT)
Subject: Re: [PATCH] venus: vdec: fix decoded data size
To:     Vikash Garodia <vgarodia@codeaurora.org>,
        stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org
References: <1538566221-21369-1-git-send-email-vgarodia@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <68f15b8b-3121-3412-2ad1-6647e9afc264@linaro.org>
Date:   Fri, 5 Oct 2018 18:26:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538566221-21369-1-git-send-email-vgarodia@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vikash,

please, increment the version of the patch next time. This one must be v2.

On 10/03/2018 02:30 PM, Vikash Garodia wrote:
> Exisiting code returns the max of the decoded size and buffer size.

s/Exisiting/Existing

> It turns out that buffer size is always greater due to hardware
> alignment requirement. As a result, payload size given to client
> is incorrect. This change ensures that the bytesused is assigned
> to actual payload size, when available.
> 
> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/vdec.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 991e158..189ec97 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -888,8 +888,7 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
>  		unsigned int opb_sz = venus_helper_get_opb_size(inst);
>  
>  		vb = &vbuf->vb2_buf;
> -		vb->planes[0].bytesused =
> -			max_t(unsigned int, opb_sz, bytesused);
> +		vb2_set_plane_payload(vb, 0, bytesused ? : opb_sz);
>  		vb->planes[0].data_offset = data_offset;
>  		vb->timestamp = timestamp_us * NSEC_PER_USEC;
>  		vbuf->sequence = inst->sequence_cap++;
> 

-- 
regards,
Stan
