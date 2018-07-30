Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D306BC46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871B320892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871B320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeG3I5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 04:57:18 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:41985 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeG3I5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 04:57:18 -0400
Received: by mail-ua0-f195.google.com with SMTP id w7-v6so7174006uan.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 00:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bUck8hi3z50N+4daRnE0/+pJG9u+ecDlGbxpxP06Unc=;
        b=Dd6WscYoMw+OVLKO6BQhZ0aRXKJlE/o8ToJB28/yycrRQ9fmhx36HV6IMVoQ/8eXtx
         y8dS6Vb+mUrGjNb5wZGDFsgSV+FMWZODeHIxzihvhBL+2/kHleN9DLT+Xb6jp0TAImA6
         AUOo6E8PPZTM8hEuLXOfkv2RUaPIpTG6D/9qs4t0SU51ME0Z+XE4uM2IHuTsLT/eNbCr
         8ygg++mau2FzSiHlgLaz6lwWkOZdjxBtpnJYJuKuMovoLN9tftOd3CBKBZptLWk5aF2U
         0pmMH0brNvUMTwTAgNHj3w9CSUidc4HjSkUWbXxv5KMPFp/Q6Sf3JNcUUgYMqcD7S3Yd
         ELmw==
X-Gm-Message-State: AOUpUlEkJuHHQrjxSLn66p4mBElyW4nJ9JYhYKx7Gzmpj0sAJtuy+UYr
        IMoetb4ShHr3eEivBCmlX9muwqXDl+3DGJ0Y8Hf/W0Zs
X-Google-Smtp-Source: AAOMgpemMQyK1NDTQkCjBWql6Xt0XHgjm3qjJq+7n/cZdeflSlDpOEU9dG5OzdEAxGnVqMHMqRkU0Q78lbTOxZ3SI8g=
X-Received: by 2002:ab0:72d1:: with SMTP id g17-v6mr12056184uap.33.1532935421341;
 Mon, 30 Jul 2018 00:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1530519301.git.fthain@telegraphics.com.au> <3923d42d8e3a5e3ae3382d3354744fb6648d03a8.1530519301.git.fthain@telegraphics.com.au>
In-Reply-To: <3923d42d8e3a5e3ae3382d3354744fb6648d03a8.1530519301.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 Jul 2018 09:23:29 +0200
Message-ID: <CAMuHMdVLLyF=F7ArbXxmPioQF4F2qDq8Sis629BL_B0HrN4=Xg@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] macintosh/via-pmu68k: Don't load driver on
 unsupported hardware
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 10:21 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> Don't load the via-pmu68k driver on early PowerBooks. The M50753 PMU
> device found in those models was never supported by this driver.
> Attempting to load the driver usually causes a boot hang.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
