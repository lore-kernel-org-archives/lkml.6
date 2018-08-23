Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F31CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB9420684
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB9420684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeHWXqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 19:46:24 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34490 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbeHWXqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 19:46:24 -0400
Received: by mail-ua1-f68.google.com with SMTP id r15-v6so4025088uao.1;
        Thu, 23 Aug 2018 13:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tg7L/KvBOb6HqqKyoePchPFyxqu00W4b2R5FRO7xXPM=;
        b=T8lyGbmrwWI6vkDXI4lbUD3LolSy2oEETkRuW/0k3MuDEMtTWZJROvh83wjHA3D6G+
         ITd8SVsNlY5qkKOM2EjdJ+D3aQ3V/OWhBqpyy/s+DYrSTv4IDE5MDOsGjxVhr/0Jv4f1
         +DtVFhpJy0gBVLXCohngLJ71wuSMXtBBfrhqf9huvLwie5v14bYTipXZMYTTBNA8r6ui
         X0mKaU3Rlyv8pDf2dCgMrw+6Ufo1EpHPck9gJzlRZPnhnUw3j/D10MNOpIz1QI36043r
         lQcRogaRNS+ACb4iun0OcGnFg4i6M9v666QVbr+L1S3BIsLhxEJr82NNRR3dpjdEkj8C
         n96Q==
X-Gm-Message-State: AOUpUlHL0crzOkJD7oYsso4/4aPfhR6WJnOV/KGnLFdBTZpuKayOybUi
        W6HlvWghqyCMiWOottjCmMozC6Dn/du0d8U/0IU8Z6q8
X-Google-Smtp-Source: AA+uWPyPhuhh0ZLBVvTA1UbhgDTJNqfWvcop/P1oP2HKjFlkUCiI14TEpfqSJhuiMHPCCERfZxYd6c0rDmD1LFgmbnQ=
X-Received: by 2002:ab0:48a4:: with SMTP id x33-v6mr40510536uac.138.1535055306048;
 Thu, 23 Aug 2018 13:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180817095425.2630974-1-arnd@arndb.de>
In-Reply-To: <20180817095425.2630974-1-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Aug 2018 22:14:54 +0200
Message-ID: <CAMuHMdVLRRjoA-6jfLfO9g+nkN7RyVahFiTe_T=rSEEmCPCBpA@mail.gmail.com>
Subject: Re: [PATCH] media: camss: mark PM functions as __maybe_unused
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Todor Tomov <todor.tomov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        hansverk@cisco.com,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 11:54 AM Arnd Bergmann <arnd@arndb.de> wrote:
> The empty suspend/resume functions cause a build warning
> when they are unused:
>
> drivers/media/platform/qcom/camss/camss.c:1001:12: error: 'camss_runtime_resume' defined but not used [-Werror=unused-function]
> drivers/media/platform/qcom/camss/camss.c:996:12: error: 'camss_runtime_suspend' defined but not used [-Werror=unused-function]
>
> Mark them as __maybe_unused so the compiler can silently drop them.
>
> Fixes: 02afa816dbbf ("media: camss: Add basic runtime PM support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
