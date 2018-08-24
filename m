Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F327FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975432157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hw/tV9iQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975432157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeHXLMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:12:38 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36105 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeHXLMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:12:38 -0400
Received: by mail-it0-f68.google.com with SMTP id p16-v6so951359itp.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 00:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7bKnUrXjVkETVXO0+d7RXxxVhP+jlDqw2ImLGT4m4qM=;
        b=Hw/tV9iQdSo/3s8paY2U8aBiv0X/sghV+aqO3Yik5gmE/d8OcOfJ7BptTcGcayCPUC
         pRdT0D2cb6rl0WoJduLLFrHKdeX7w4eNGrj8BtnMCjOUB3N2V/GrQ5TVGdGhdMZeefgn
         DVLyhc3F1lqD059OLD8YE1cAyyc1VBAfNsrY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7bKnUrXjVkETVXO0+d7RXxxVhP+jlDqw2ImLGT4m4qM=;
        b=YniRHYUNDVbiOpTKBguXmMVK5FfgPvpzs3TGXXee8ipy/sI2xuF7Q6r7aifkK/AYxq
         4yaNwlub8r5IGaLl/uc/ZUnHJUozmsq0cRg64G1lqBxEVh5TMYuzuIaw6AbTK99OESVF
         BMLvLZgP7pPgtAlKjCifBb0CsOwzT7eoT62CrkY9U2unJKaP2TIUq4tGPPE+RybbBlUs
         lcnK1hQSSkI76Q6RuleegxWZJu40v0XFKOHGtEflRt0WJmvTZbFQuPb20YAxuQOzJzqi
         EgVK5+d4CIfwBIaNSXqIU4D0JnmLZpcqfKjJ+exAJwAPwMb5uwuKaKY/S+GFMnyeJEUl
         tv+Q==
X-Gm-Message-State: APzg51ARRV1zoCVIphDMSpb6hLFzZ9itOZfPRe2HX4V5Ym9/V4rWKF2R
        rTjMklUmvNBgPTNnLm174qrf4Ie3e2c=
X-Google-Smtp-Source: ANB0VdbQ8wgHjlonUdkBOnau3A4SX6ViExYhlkB6WCdTg1TGgWY7y8uyEKeP9pW7mU3EdY5wTy8hkw==
X-Received: by 2002:a02:8a05:: with SMTP id j5-v6mr366744jak.59.1535096353419;
        Fri, 24 Aug 2018 00:39:13 -0700 (PDT)
Received: from mail-it0-f46.google.com (mail-it0-f46.google.com. [209.85.214.46])
        by smtp.gmail.com with ESMTPSA id c141-v6sm304564itc.42.2018.08.24.00.39.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 00:39:12 -0700 (PDT)
Received: by mail-it0-f46.google.com with SMTP id e14-v6so979933itf.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 00:39:12 -0700 (PDT)
X-Received: by 2002:a02:579a:: with SMTP id b26-v6mr368997jad.107.1535096351882;
 Fri, 24 Aug 2018 00:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <1535034528-11590-1-git-send-email-vgarodia@codeaurora.org> <1535034528-11590-2-git-send-email-vgarodia@codeaurora.org>
In-Reply-To: <1535034528-11590-2-git-send-email-vgarodia@codeaurora.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 24 Aug 2018 16:38:59 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUZawT84Wcrhi+MEyn+zSCWOpn_iOZMMudZz+_Urixsrw@mail.gmail.com>
Message-ID: <CAPBb6MUZawT84Wcrhi+MEyn+zSCWOpn_iOZMMudZz+_Urixsrw@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] venus: firmware: add routine to reset ARM9
To:     vgarodia@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, robh@kernel.org,
        mark.rutland@arm.com, Andy Gross <andy.gross@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, bjorn.andersson@linaro.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 11:29 PM Vikash Garodia <vgarodia@codeaurora.org> wrote:
>
> Add routine to reset the ARM9 and brings it out of reset. Also
> abstract the Venus CPU state handling with a new function. This
> is in preparation to add PIL functionality in venus driver.
>
> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/core.h         |  2 ++
>  drivers/media/platform/qcom/venus/firmware.c     | 33 ++++++++++++++++++++++++
>  drivers/media/platform/qcom/venus/firmware.h     | 11 ++++++++
>  drivers/media/platform/qcom/venus/hfi_venus.c    | 13 +++-------
>  drivers/media/platform/qcom/venus/hfi_venus_io.h |  7 +++++
>  5 files changed, 57 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 2f02365..dfd5c10 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -98,6 +98,7 @@ struct venus_caps {
>   * @dev:               convenience struct device pointer
>   * @dev_dec:   convenience struct device pointer for decoder device
>   * @dev_enc:   convenience struct device pointer for encoder device
> + * @no_tz:     a flag that suggests presence of trustzone
>   * @lock:      a lock for this strucure
>   * @instances: a list_head of all instances
>   * @insts_count:       num of instances
> @@ -129,6 +130,7 @@ struct venus_core {
>         struct device *dev;
>         struct device *dev_dec;
>         struct device *dev_enc;
> +       bool no_tz;
>         struct mutex lock;
>         struct list_head instances;
>         atomic_t insts_count;
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index c4a5778..a9d042e 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -22,10 +22,43 @@
>  #include <linux/sizes.h>
>  #include <linux/soc/qcom/mdt_loader.h>
>
> +#include "core.h"
>  #include "firmware.h"
> +#include "hfi_venus_io.h"
>
>  #define VENUS_PAS_ID                   9
>  #define VENUS_FW_MEM_SIZE              (6 * SZ_1M)

This is making a strong assumption about the size of the FW memory
region, which in practice is not always true (I had to reduce it to
5MB). How about having this as a member of venus_core, which is
initialized in venus_load_fw() from the actual size of the memory
region? You could do this as an extra patch that comes before this
one.
