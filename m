Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4837C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31C321726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SULFRfbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfAWGKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 01:10:03 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35460 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfAWGKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 01:10:02 -0500
Received: by mail-oi1-f195.google.com with SMTP id v6so914696oif.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 22:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lHXlxDfNlpNjJvv/OMM++tH5o4Pfult/U1ow0P6kxpI=;
        b=SULFRfbJBl/8cnJPlUO3lm3ZHB78AkhChBDukLbxkYmB13Q/t+lromtPtZK7E54VW1
         TKBbe603xTPu8eL6NjWfbpH6d0Bl2H/bk1Z8cVnemZ1izADLmcApO9/zRqGSMO8RCM1M
         HFrBItU/u0M45AisTawY1GErxuK3DWdDtC89E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHXlxDfNlpNjJvv/OMM++tH5o4Pfult/U1ow0P6kxpI=;
        b=RVV+Gs475cFM9zEd7abgOcUpBtnCQ8aCx+x3IvyhMl9awC6y5W6bWWLg1N57zlooSu
         Ri+12/cJ6XFUuuYGCSEK1S6POFyD/R0OEvpW0DYSx1UGXsjetxQx6Wo+1JCQQlNIzv2x
         ZoaCLBheZZu3rppioJDgxPfkdQYcAae9q/BXGNHfJifXToC2tZUL2UGLWr0cJEmzwYlB
         1lM1DajbdbVRV/TfJFETEEvo4pdsG1IknNzqHDwWHXuEMqAfg8kT/pADaDpPmnIExYGb
         PTvCzNv63sBLoqoY/eWScB3pBHflINSmYDJy5woXfZK+zJMFLVg9+gEegAFWWwDbMQ6E
         BtHg==
X-Gm-Message-State: AJcUukewS0XybvVqPnAfBVLqRVpms7RQl4Fpu1EohxiuTDwuppAA/Cll
        DjaFDkpWWahYKHgP0oey4EtaPb9nHVL/nA==
X-Google-Smtp-Source: ALg8bN5IROW43DLG0XT/rG8K/yOL+on2hpO6L0tRN17zc4yRoTz1tVYMPIARADEuXOllHUc3Dhewyg==
X-Received: by 2002:aca:308c:: with SMTP id w134mr620022oiw.81.1548223801451;
        Tue, 22 Jan 2019 22:10:01 -0800 (PST)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id n3sm9790346oia.3.2019.01.22.22.09.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 22:10:00 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id j21so881285oii.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 22:09:59 -0800 (PST)
X-Received: by 2002:a54:4486:: with SMTP id v6mr604286oiv.233.1548223799474;
 Tue, 22 Jan 2019 22:09:59 -0800 (PST)
MIME-Version: 1.0
References: <20190109084616.17162-1-stanimir.varbanov@linaro.org> <20190109084616.17162-3-stanimir.varbanov@linaro.org>
In-Reply-To: <20190109084616.17162-3-stanimir.varbanov@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Wed, 23 Jan 2019 15:09:48 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVXOLfD7psYMEGeGTQwku6=wH4RPkfS-oG8DrHO2Rf0Eg@mail.gmail.com>
Message-ID: <CAPBb6MVXOLfD7psYMEGeGTQwku6=wH4RPkfS-oG8DrHO2Rf0Eg@mail.gmail.com>
Subject: Re: [PATCH 2/4] venus: core: corect maximum hardware load for sdm845
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Malathi Gottam <mgottam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 5:46 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> This corects maximum hardware load constant in per SoC resources

s/corect/correct. Same typo is present in patch title.


> for sdm845 aka Venus v4.
>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index cb411eb85ee4..d95185ea32c3 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -455,7 +455,7 @@ static const struct venus_resources msm8996_res = {
>         .reg_tbl_size = ARRAY_SIZE(msm8996_reg_preset),
>         .clks = {"core", "iface", "bus", "mbus" },
>         .clks_num = 4,
> -       .max_load = 2563200,
> +       .max_load = 3110400,    /* 4096x2160@90 */
>         .hfi_version = HFI_VERSION_3XX,
>         .vmem_id = VIDC_RESOURCE_NONE,
>         .vmem_size = 0,
> --
> 2.17.1
>
