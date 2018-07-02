Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F99C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B2625B92
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g2m52wPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B2625B92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965029AbeGBIq2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:46:28 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:41331 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754308AbeGBIqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:46:22 -0400
Received: by mail-io0-f196.google.com with SMTP id q9-v6so3309263ioj.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 01:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y9t15OAu6H/ZV+XZJL+b5GiX1/4LSw6e0Ci2AU9QfIM=;
        b=g2m52wPZ0+DjttImqBBhRgpMKmQ8LKOkZyNsMj5Ae+ytuv2/a6j3YmICwJJymfHUvx
         rjxCU1bXzU1Om62AygoYsSqqAZadfGnb/WuQk/pKgZwJKWAbJQ79nZs8NdYvTZ2HW2VM
         Ggv99nCAKB/0q2cQqeHl5Otc9ubduCAqPcfNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y9t15OAu6H/ZV+XZJL+b5GiX1/4LSw6e0Ci2AU9QfIM=;
        b=eTNTmvDexMPuRekT4bushQ/6PunW3laBiJbgF8PaH/sA21QO4Id6nyqVmIQboM/EiU
         DOH9bi9TARH9FuWj8JwajKf7kdes//a9L3avzDo4POWDC6Bi6imQW6xZmp0cG+VxNi/5
         MkMqCQVwob54iARZO2hx8+8lKFlFlBdw95LZLY/ac0fp+Ewnqo23ttqTd7IjrUN8UTT1
         ZmZTev2TJ6PouYz0L9yyvENUlau6neRb8S+KvsKk8n5zrGWx0+hZj1CtVwdegFJSmLnJ
         vbIlikPixVF1CDKhW5m1MXYOTLlBdMJBTMGCrwAU8yWqdc2Z1yO+z1wT/xgHghK10EXY
         YeWA==
X-Gm-Message-State: APt69E2gTR/ib4sN4Tj8WCNhWi7NgB+8SfqT9vhPWuTRfcwsDCEbFuU0
        W6bFSw/GclIaI17aZz5BPrNxZ4jxVUY=
X-Google-Smtp-Source: AAOMgpd2q8ZltN8XuGGiFYyAL16ysj8XGs8mdBD+IpYXeT+Ifaw+Ib7H5KbI7qdXsL+kCG1kE5aJWg==
X-Received: by 2002:a6b:2c4b:: with SMTP id s72-v6mr13085808ios.195.1530521181676;
        Mon, 02 Jul 2018 01:46:21 -0700 (PDT)
Received: from mail-it0-f47.google.com (mail-it0-f47.google.com. [209.85.214.47])
        by smtp.gmail.com with ESMTPSA id e14-v6sm1811180ioe.11.2018.07.02.01.46.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 01:46:21 -0700 (PDT)
Received: by mail-it0-f47.google.com with SMTP id a195-v6so11061288itd.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 01:46:20 -0700 (PDT)
X-Received: by 2002:a24:5e0b:: with SMTP id h11-v6mr3075504itb.80.1530521180300;
 Mon, 02 Jul 2018 01:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org> <20180627152725.9783-25-stanimir.varbanov@linaro.org>
In-Reply-To: <20180627152725.9783-25-stanimir.varbanov@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 2 Jul 2018 17:46:09 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVPrparfoAMaVwsDrwPO1K8cnWb24WdZFGeU5aoEqDt5w@mail.gmail.com>
Message-ID: <CAPBb6MVPrparfoAMaVwsDrwPO1K8cnWb24WdZFGeU5aoEqDt5w@mail.gmail.com>
Subject: Re: [PATCH v4 24/27] venus: helpers: move frame size calculations on
 common place
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 12:28 AM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> This move the calculations of raw and compressed buffer sizes
> on common helper and make it identical for encoder and decoder.
>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c | 98 +++++++++++++++++++++++++++++
>  drivers/media/platform/qcom/venus/helpers.h |  2 +
>  drivers/media/platform/qcom/venus/vdec.c    | 54 ++++------------
>  drivers/media/platform/qcom/venus/venc.c    | 56 ++++-------------
>  4 files changed, 126 insertions(+), 84 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index 6b31c91528ed..a342472ae2f0 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -452,6 +452,104 @@ int venus_helper_get_bufreq(struct venus_inst *inst, u32 type,
>  }
>  EXPORT_SYMBOL_GPL(venus_helper_get_bufreq);
>
> +static u32 get_framesize_raw_nv12(u32 width, u32 height)
> +{
> +       u32 y_stride, uv_stride, y_plane;
> +       u32 y_sclines, uv_sclines, uv_plane;
> +       u32 size;
> +
> +       y_stride = ALIGN(width, 128);
> +       uv_stride = ALIGN(width, 128);
> +       y_sclines = ALIGN(height, 32);
> +       uv_sclines = ALIGN(((height + 1) >> 1), 16);
> +
> +       y_plane = y_stride * y_sclines;
> +       uv_plane = uv_stride * uv_sclines + SZ_4K;
> +       size = y_plane + uv_plane + SZ_8K;

Do you know the reason for this extra 8K at the end?
