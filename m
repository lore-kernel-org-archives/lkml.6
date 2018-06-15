Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 99DB8C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3A2208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gDXfP9Lp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3A2208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756011AbeFOILw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 04:11:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33507 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755926AbeFOILv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 04:11:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id z6-v6so5869995wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 01:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eFYvz2j7D4PoU424XpAGE2JQ9+cjNZn6Zw+9Avx2ZlU=;
        b=gDXfP9LpjO3Mbop72XFD9fd+YduBIWTaR+QnpiRDQe0Dg6i6qID4QlKvgtYeL+Yd2l
         nFmcTq8rL0CU/w0hfrqZlvG5yBCK8HVSFnC2xpoA3lxOdy/0xnf3rXJQ059l2lKbitMD
         tCxj2Q73I5eIifcxUALBj2p2/Oft3OPkgL0Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eFYvz2j7D4PoU424XpAGE2JQ9+cjNZn6Zw+9Avx2ZlU=;
        b=A6Ffbw/Cf1jYmCaMyGIXovuHE/MbH6roXLYToRcpy5RZmWKi60UGUM3fBixb2qjpy6
         tk5vnaXWOrH/T4rK+QdoJ7pSfzN9DexpDtbs4Qe1sYg0Bpwt9kIydQWSmbbC0sVEGtpx
         hTnOYqb1Gr0ryW/NFGAXl0NnX21Dz6LHton9SezA9zuryFH1YtQw4+mlayuhaIF9shbS
         1BrtVS4TvtkoH/qgCs5BtRQkpOHEkA5cigOEQOPFnAaq2UYoNPxehY9qE/lwIAWi7fpf
         L6aw7cqzI0t4XAz7ptourkHiFQwAALzjUh8+eH2ekMBXtjY8i7cGaBJqgHJjbP7ABbj/
         PPzg==
X-Gm-Message-State: APt69E0sTwE+p9+duimBbx4kFUZFC2l8ZrZUToztq//fVa4bbfibgbCG
        ypC90GVcWCpYb7UK70o+MglkyuMahF8=
X-Google-Smtp-Source: ADUXVKIoCxhBVeATCd7DR7cZGZILgBXMxgSSr2yXb8sFN5kZad4eKa9JdrvcTZVMRnCasjFU5oUjsQ==
X-Received: by 2002:a1c:d106:: with SMTP id i6-v6mr392985wmg.1.1529050309909;
        Fri, 15 Jun 2018 01:11:49 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id j13-v6sm9303841wre.38.2018.06.15.01.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 01:11:49 -0700 (PDT)
Subject: Re: [PATCH] media: venus: keep resolution when adjusting format
To:     Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180605045046.200011-1-acourbot@chromium.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <b8ccddbe-7ff8-8098-2406-db8447c998f9@linaro.org>
Date:   Fri, 15 Jun 2018 11:11:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180605045046.200011-1-acourbot@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Thanks for the patch!

On 06/05/2018 07:50 AM, Alexandre Courbot wrote:
> When checking a format for validity, the resolution is reset to 1280x720
> whenever the pixel format is not supported. This behavior can mislead
> user-space into believing that this is the only resolution supported,
> and looks strange considering that if we try/set the same format with
> just the pixel format changed to a valid one, the call will this time
> succeed without altering the resolution.
> 
> Resolution is managed independently of the pixel format, so remove this
> reset.
> 
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> ---
>  drivers/media/platform/qcom/venus/vdec.c | 2 --
>  drivers/media/platform/qcom/venus/venc.c | 2 --
>  2 files changed, 4 deletions(-)

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

-- 
regards,
Stan
