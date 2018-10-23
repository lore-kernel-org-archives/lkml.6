Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D76AC004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66595207E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nRYzCnfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66595207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeJWLLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 07:11:49 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38635 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJWLLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 07:11:49 -0400
Received: by mail-yw1-f66.google.com with SMTP id d126-v6so16861758ywa.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 19:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XpEk9WqPSLRm54OUqhYbkEJ6XpGG2Pg7YSfRWv1HfuY=;
        b=nRYzCnfoMQ/XKqGe4idDQwAIgf6rrhRFWBCPgdl3GbbMrVpAjVea+9tmz5eTxTz2Gp
         udud39+6vFWtnq80vkrsiAEpKaUAUC0X6YkDZ6V8hmRMVPiydFNJgu33sZVz/1xLdRHj
         EZ/q/EZHoyluxVVaPMqD7FAantFsUJGhhg8Sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XpEk9WqPSLRm54OUqhYbkEJ6XpGG2Pg7YSfRWv1HfuY=;
        b=bC86DOopIKdvT3hgrFeQirxK9skg92c/rBNNcBbntMsHvdJ1WhOLGxzQ9pKFo1+mjq
         WOfRDB2DcjLYgXZRPhs1j8TeYlwsNuOFef9XhSyyKN4ykDJwFAOOAGGKJSC5Er0zr1tH
         whhkr7LwSS7HWUHlJBXlGJoLYsiytvC7OPeCHred+QT7jVmoicC8Q+BYUuRfeV5LnYb3
         l8Cap4U6tK1ZFtXbrCKMorD4SPmHwRdh6jQtDMfNoC80KCQBHPMbGhq+Hpbt2Rdvbd7t
         zPO7YMzSqX42K0VZ+ZdBR+4Ril7yv2/DPYIwOwXu1O/t2eZAZ0OflrQGWfYkbNKjkljC
         SBow==
X-Gm-Message-State: ABuFfoh09NCSvOn40WUwDOl2lqYQkFTdQdPHXqqL+8AH0jTfYvDPz8kP
        HyxvK/Xs5DXWqqoCF2FYnozuGnoPRbnCyQ==
X-Google-Smtp-Source: ACcGV604nXjMMD/CGjzNq7sxpJSfKvhJ+o7xZcjPXoMBZ7WJKmHIkrBNtieCRD/1VcNO1xzbWDkQZA==
X-Received: by 2002:a81:9e43:: with SMTP id v64-v6mr6975333ywg.481.1540263030435;
        Mon, 22 Oct 2018 19:50:30 -0700 (PDT)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id i82-v6sm8773565ywc.102.2018.10.22.19.50.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 19:50:29 -0700 (PDT)
Received: by mail-yw1-f51.google.com with SMTP id v1-v6so16854084ywv.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 19:50:29 -0700 (PDT)
X-Received: by 2002:a81:4757:: with SMTP id u84-v6mr35769117ywa.164.1540263028678;
 Mon, 22 Oct 2018 19:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <1539071530-1441-1-git-send-email-mgottam@codeaurora.org>
In-Reply-To: <1539071530-1441-1-git-send-email-mgottam@codeaurora.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 23 Oct 2018 11:50:17 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BcFr11Hpngpn6hNL91OibAxUv25yh2qMohgfxsKusACw@mail.gmail.com>
Message-ID: <CAAFQd5BcFr11Hpngpn6hNL91OibAxUv25yh2qMohgfxsKusACw@mail.gmail.com>
Subject: Re: [PATCH] media: venus: amend buffer size for bitstream plane
To:     mgottam@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Malathi,

On Tue, Oct 9, 2018 at 4:58 PM Malathi Gottam <mgottam@codeaurora.org> wrote:
>
> For lower resolutions, incase of encoder, the compressed
> frame size is more than half of the corresponding input
> YUV. Keep the size as same as YUV considering worst case.
>
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index 2679adb..05c5423 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -649,7 +649,7 @@ u32 venus_helper_get_framesz(u32 v4l2_fmt, u32 width, u32 height)
>         }
>
>         if (compressed) {
> -               sz = ALIGN(height, 32) * ALIGN(width, 32) * 3 / 2 / 2;
> +               sz = ALIGN(height, 32) * ALIGN(width, 32) * 3 / 2;
>                 return ALIGN(sz, SZ_4K);
>         }

Note that the driver should not enforce one particular buffer size for
bitstream buffers unless it's a workaround for broken firmware or
hardware. The userspace should be able to select the desired size.

Best regards,
Tomasz
