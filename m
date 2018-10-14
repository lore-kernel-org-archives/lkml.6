Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F18C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 10:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460A920652
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 10:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460A920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbeJNSgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 14:36:11 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37640 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbeJNSgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 14:36:11 -0400
Received: by mail-vs1-f66.google.com with SMTP id r83so14689599vsc.4;
        Sun, 14 Oct 2018 03:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vxu1fH6HeyY/jFeli4p/cSj5HJKl5bFHT5W2pM+gbXg=;
        b=beEW7LDCDDvE42sW/ZsUg3tlGwwI8lRFXU5OnxG3hRsi02yOaT+Kk80AuIfAXyeoFg
         SMBDfve7XG/FohiDYL40P8Umi2kLigawjM2vqNL1jGZdZL4alvU1hjZ9s+mXfTermzRM
         2lBG/dcLM8/NYMzSbkSf+hZbryE7y1/0ztfLlzVjGZ+4KKubmcd1O526wrUoa+FQHTBU
         3smwBtzUEs5el2j2Pn32L/U6H17GvQfODMgd9gkaDxFOjf1UCtHUhQUizEJS1T6p+9X+
         kCSl6S9Aslus8pu2mqzDxZfyWJMLDP9IiNSgoiNXRhygz8F7+52G2NhHm/cLbc+BRVQ0
         NoZA==
X-Gm-Message-State: ABuFfojq2BiiyZmYLXq2Ld95iIUK11gslqgIn9pCPkIg8IUNHePzkfyz
        f+khtk21SYkOBCwghY5/jreBrhYsWFGoQc/6wuk=
X-Google-Smtp-Source: ACcGV61rgIC/oscH+kA88IMy7y4Dautr8Tn3hMc00TCGR/7jhcF2oIqUtzcrt+oljNA3OyK0vJYELBp1Y6uelEXUinU=
X-Received: by 2002:a67:f3cc:: with SMTP id j12mr4404940vsn.96.1539514533263;
 Sun, 14 Oct 2018 03:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539497520.git.fthain@telegraphics.com.au> <022a8c581d228f3f01dfa783aadd183a53169daa.1539497520.git.fthain@telegraphics.com.au>
In-Reply-To: <022a8c581d228f3f01dfa783aadd183a53169daa.1539497520.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 14 Oct 2018 12:55:21 +0200
Message-ID: <CAMuHMdUNyfq00ugz-LifqmKwA4Mau6Vi-z5wCX_a=_jq1yZT_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] zorro_esp: Limit DMA transfers to 65535 bytes
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        scsi <linux-scsi@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Sun, Oct 14, 2018 at 8:36 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> The core driver, esp_scsi, does not use the ESP_CONFIG2_FENAB bit, so
> the chip's Transfer Counter register is only 16 bits wide (not 24).
> A larger transfer cannot work and will theoretically result in a failed
> command and a "DMA length is zero" error.

Thanks for your patch!

> Fixes: 3109e5ae0311

Fixes: 3109e5ae0311 ("scsi: zorro_esp: New driver for Amiga Zorro
NCR53C9x boards")

$ git help fixes
'fixes' is aliased to 'show --format='Fixes: %h ("%s")' -s'

BTW, if you use vim, add

    noremap ;gs "zyiw:exe "new \| setlocal buftype=nofile
bufhidden=hide noswapfile syntax=git \| 0r ! git show ".@z."" \|
:0<CR><CR>

to .vimrc, and type ";gs" when the cursor is positioned on a commit ID.

> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Tested-by: Michael Schmitz <schmitzmic@gmail.com>

> --- a/drivers/scsi/zorro_esp.c
> +++ b/drivers/scsi/zorro_esp.c
> @@ -245,7 +245,7 @@ static int fastlane_esp_irq_pending(struct esp *esp)
>  static u32 zorro_esp_dma_length_limit(struct esp *esp, u32 dma_addr,
>                                         u32 dma_len)
>  {
> -       return dma_len > 0xFFFFFF ? 0xFFFFFF : dma_len;
> +       return dma_len > 0xFFFF ? 0xFFFF : dma_len;
>  }
>
>  static void zorro_esp_reset_dma(struct esp *esp)
> @@ -484,7 +484,6 @@ static void zorro_esp_send_blz1230_dma_cmd(struct esp *esp, u32 addr,
>         scsi_esp_cmd(esp, ESP_CMD_DMA);
>         zorro_esp_write8(esp, (esp_count >> 0) & 0xff, ESP_TCLOW);
>         zorro_esp_write8(esp, (esp_count >> 8) & 0xff, ESP_TCMED);
> -       zorro_esp_write8(esp, (esp_count >> 16) & 0xff, ESP_TCHI);

Since all these sub-drivers seem to support 24-bit transfers, perhaps this is
something to be fixed in the esp_scsi core?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
