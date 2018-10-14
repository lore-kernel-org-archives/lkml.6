Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04245C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 10:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C850020652
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 10:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C850020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbeJNSgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 14:36:47 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46181 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbeJNSgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 14:36:47 -0400
Received: by mail-ua1-f67.google.com with SMTP id z8so1050548uap.13;
        Sun, 14 Oct 2018 03:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQDPYU/0Cqsidu70UdEZWefFWPhLvDn9unEpQ0D6SX0=;
        b=ggzSOmD+pVIw9w+YNEK2M55rCoWCLtP8Bfhw0JAqw8LpR1lI8zwv8Mgi3QFg9poWCh
         9FTyzLQf0Xe6SW8A4NbE8GqyrnqNeezDgi7IzS2y8q5S3pbb0D2oz8dprbhcUN/8QEDs
         67SqEQZ58culPyDdwY1sY6VhJ1blG219mcirVji0wQszBVYxpymtxD+CDMNMlvg59a38
         v2grpoAj5Pnb/PtwP7Tpb9Z6HiMfjuQQ++FJiaGOmCfSZCs1wRfdtiFpUbiO/NGWHCIz
         0Th6SCr14ZQAgPqKhUug2m9YL+YKLLMLgBgnDu6zLKAN6SjEkBiSHld4LBjUpkaSd5M5
         9IVw==
X-Gm-Message-State: ABuFfohjeFJpO6EofWHwaO/RVp+H6gQv6T5zW39ZnLUtbfrZCXyNOWvF
        Gg8qR3ReM0qa47882xSSkTDPa9mV0cxlNzdCTi8=
X-Google-Smtp-Source: ACcGV62jVE1EnVbgyuO/v35JcgVhGwa3E9dNDSzYGEBznDSlLJJFwwhTuvGi4edNofRN2MOKLSac5QosIr55DyXm+F0=
X-Received: by 2002:a9f:31e2:: with SMTP id w31mr5834623uad.0.1539514569646;
 Sun, 14 Oct 2018 03:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539497520.git.fthain@telegraphics.com.au> <d5fe773ea8c922631836dad2ef2dbb952672c7c7.1539497520.git.fthain@telegraphics.com.au>
In-Reply-To: <d5fe773ea8c922631836dad2ef2dbb952672c7c7.1539497520.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 14 Oct 2018 12:55:57 +0200
Message-ID: <CAMuHMdV6cuXngfmCBbqPsyAZDcFo9sO=F-TYy+OyS5vEOou0eQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] esp_scsi: De-duplicate PIO routines
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

On Sun, Oct 14, 2018 at 8:35 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> As a temporary measure, the code to implement PIO transfers was
> duplicated in zorro_esp and mac_esp. Now that it has stabilized
> move the common code into the core driver but don't build it unless
> needed.
>
> This replaces the inline assembler with more portable writesb() calls.
> Optimizing the m68k writesb() implementation is a separate patch.
>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Tested-by: Michael Schmitz <schmitzmic@gmail.com>

Thanks for your patch!

> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -42,6 +42,10 @@ config SCSI_DMA
>         bool
>         default n
>
> +config SCSI_ESP_PIO
> +       bool
> +       default n

"default n" is the default, so please drop this line.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
