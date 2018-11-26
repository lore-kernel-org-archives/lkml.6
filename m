Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE0BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A060620850
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YIdtoT5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A060620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbeKZUjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:39:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39207 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeKZUjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:39:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id n133so813546wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 01:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vVxREeXO+PAlp7en4AnUo35LnPzIhiArPtqKtPDTvQc=;
        b=YIdtoT5qxffMjqezeD+Erf10INMxb/Y8bIepQl+prGVEzL+FXcp8PCkzuWQSAq7dIb
         pL+nbQITf2TUwHcMHHE2psXf9GcLrNtxwokeqmFW0J6p6huaayvVZIb9ikQffDkKzPFz
         I8PWg/E1rWnATTqJyK9z29ORDIGXJbfY+SPoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vVxREeXO+PAlp7en4AnUo35LnPzIhiArPtqKtPDTvQc=;
        b=PJpGrZnEIme3QwtR01WZhFNhgnSb7TgkLKodelOtI9gj/Ez2pMg0DetMJ2vF9AGP11
         ukh3EtJIoYJok5LpUdeBdYIE9QMUAih+0PlOuZDbr7uS8N04pOQyQaS7AT2DpuYm3gXj
         pkR1dXTD4ZN4Frv/ruMYAjiyYYyWK1y2hD4Mc9guRRqf/Qt2X42LznTPRIM+6+dURsyR
         iHcpNyp2nOKH7utnCvD7WTfR1SROf3f8UK3KUXVb2RytrRu6nyizFMazdZDGmBfSXreS
         f8edMb5JpdMfWGOIp8AqAUjw9GRUy5ZEJ0YIkXHNI970M8+2e3pNzStyG8zYjVT4sZ/i
         nvCA==
X-Gm-Message-State: AA+aEWY70dldrhs+09VoCN17wgr6fKsnvuImzXhCHyrYn4N1E52zAXWb
        nDTJRMHv0RoYxqK/g6EsFVEmVdnAihg=
X-Google-Smtp-Source: AJdET5fJk35Jn2bIqJLVaC9F2Y9IodjHc5ZTbyXC005yeMuaTpAQgScU1mlSQgo6R5KVYvcGqyNU7g==
X-Received: by 2002:a1c:cb84:: with SMTP id b126mr20859030wmg.64.1543225548499;
        Mon, 26 Nov 2018 01:45:48 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id h131sm378209wmd.17.2018.11.26.01.45.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 01:45:47 -0800 (PST)
Subject: Re: [PATCH] media: venus: fix reported size of 0-length buffers
To:     Alexandre Courbot <acourbot@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181113093048.236201-1-acourbot@chromium.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <a56320a4-c74f-54c2-a340-fa3c2c19a2a1@linaro.org>
Date:   Mon, 26 Nov 2018 11:45:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181113093048.236201-1-acourbot@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Thanks for the patch!

On 11/13/18 11:30 AM, Alexandre Courbot wrote:
> The last buffer is often signaled by an empty buffer with the
> V4L2_BUF_FLAG_LAST flag set. Such buffers were returned with the
> bytesused field set to the full size of the OPB, which leads
> user-space to believe that the buffer actually contains useful data. Fix
> this by passing the number of bytes reported used by the firmware.
> 
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> ---
>  drivers/media/platform/qcom/venus/vdec.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

> 
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 189ec975c6bb..282de21cf2e1 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -885,10 +885,8 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
>  	vbuf->field = V4L2_FIELD_NONE;
>  
>  	if (type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
> -		unsigned int opb_sz = venus_helper_get_opb_size(inst);
> -
>  		vb = &vbuf->vb2_buf;
> -		vb2_set_plane_payload(vb, 0, bytesused ? : opb_sz);
> +		vb2_set_plane_payload(vb, 0, bytesused);
>  		vb->planes[0].data_offset = data_offset;
>  		vb->timestamp = timestamp_us * NSEC_PER_USEC;
>  		vbuf->sequence = inst->sequence_cap++;
> 

-- 
regards,
Stan
