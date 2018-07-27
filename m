Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D5FC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03DD20862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03DD20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbeG0JMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:12:19 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33100 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbeG0JMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:12:17 -0400
Received: by mail-vk0-f68.google.com with SMTP id y70-v6so2041869vkc.0;
        Fri, 27 Jul 2018 00:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+kQXFP4fad6WoHto/R0qAeXsM5dxcG2KfJRqUyDaxh8=;
        b=BW1OWZ8fxBxMUi2zMiN5NmFT0g0iF/t/cDWX33DNYFNK1vQN177O/tFvvI6mLvFAgM
         dZUQsygRse2xFneKC1X7m3PcI5daTlNllvB3jUIIUChqWZ882sSCYW4soItsDoQsz/f4
         jFDIEK98jcLoP5L2zGt5E4O6fHzOZCqsj34k5fd6/wXGGK8HMcJuAkPaPJhdEpBp21i2
         vin4JtiAgxb4BN1r4hHb7SQqzxoV/Y/SuIJl9fsnAhfpwG5SqYc5B92a4UUs20AM3GPO
         2ykwymUZ5JoogSXuw7OHhPi2mGVfxhSh1Wfhrr8yyrmS8DXltRprBgb0dHIWYTn96dzg
         ItQA==
X-Gm-Message-State: AOUpUlHPb0T12IeyTkL9Xzah9kHOPgKKKUjbGUK9A/nP+lKEmq+wr2Te
        VrReHs0fX1SXJpcfe+7StEL2sjgB9xshT9OwrrI=
X-Google-Smtp-Source: AAOMgpcc2tuOSci8ttpwWsfli8kt+qmHnHceaQhAKApnptIEIvz5NAjzZ2gGG9RJWonoZExZiUy3Ym409Fvyb8fNM6E=
X-Received: by 2002:a1f:d507:: with SMTP id m7-v6mr3193099vkg.40.1532677897439;
 Fri, 27 Jul 2018 00:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <1532654046-11901-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1532654046-11901-1-git-send-email-yamada.masahiro@socionext.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 27 Jul 2018 09:51:25 +0200
Message-ID: <CAMuHMdXvbWrt44T4Sr_bDjS1YFfqZ82JHpH7f00FKYBHntyWSg@mail.gmail.com>
Subject: Re: [PATCH] mmc: tmio: allow DMA request hook to return error status
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada-san,

On Fri, Jul 27, 2018 at 3:15 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> dma_request_chan() may return ERR_PTR(-EPROBE_DEFER), but
> tmio_mmc_request_dma() cannot propagate it since it is a
> void function.
>
> Change the return type to int so that the driver can retry
> probing later in case the DMA-engine driver is probed after
> the TMIO MMC driver.
>
> I moved the call for tmio_mmc_request_dma() up because it may
> fail now.  I also removed unneeded clearing of host->chan_{tx,rx}
> because (struct tmio_mmc_host) is allocated by kzalloc().
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks for your patch!

Isn't the idea to fall back to PIO if the DMA-engine driver is not found?

Unfortunately there's no way to distinguish between "DMA-engine hasn't been
probed yet" and "DMA-engine is not available" (e.g. CONFIG_RCAR_DMAC=n).
In both cases, dma_request_chan() will return -EPROBE_DEFER.
So if you treat this as an actual error, and propagate it, the following
will happen:
  - In case 1, the MMC driver will be reprobed successfully later.
  - In case 2,the MMC driver will never succeed.

Or am I missing something?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
