Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C686C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 10:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D11720652
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 10:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D11720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeJNSgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 14:36:33 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36860 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbeJNSgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 14:36:33 -0400
Received: by mail-ua1-f67.google.com with SMTP id b3so1047895uak.3;
        Sun, 14 Oct 2018 03:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=12uVaPeoGXRWZptPmz/62EhI1PnN0nL5+4L/vlGvM0o=;
        b=YZy4ctXA5Qv7Y3kcfAn6+peo1j11lEHlKZPURtXiqJzjNWnnc+Wo5CZA8eChmm9TiZ
         o8xRSlHNBSarSoXaUaAes9D0TeXe5XTQRYKFkFI7C+CX8kk/6xzL7+AF8pvLC4qDuhNa
         ehV51L9X7lhi5YglMUSbrFONypOZFWI9XZSAltlbZl26qTi1v65ZZOVg5PktEclphoyM
         ZtOzX7A1dmfasXl/DwfoeQJMiXmCB4pad1UOQk75iiQ1dbYAHTEBv4ej/rFTx9xUH8Tb
         oqiSeOPx8jIgl1dy92FD9GNFLc4wiJYt6BuNBxPcA/MaB16tXGfEDddpcEmtS3xDtPFJ
         YOHQ==
X-Gm-Message-State: ABuFfoiST5CqIkOm0m1J7/+3m3gNLnDFwWNch5BmOy36OiJ7qraTscua
        2JqXysYo1ohHoWCKJ+JHZI7EbMQ/2dMVi5L6n00=
X-Google-Smtp-Source: ACcGV60tZByi2aJUo2vsYVlbDvnYWhctnWqg2WOZVOmWMqUG+AxfsRxQqNiqx4Dj4Eqy04RYOvHNfa0YzCcZaqylPQ0=
X-Received: by 2002:ab0:47ed:: with SMTP id w45mr5171273uac.78.1539514555183;
 Sun, 14 Oct 2018 03:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539497520.git.fthain@telegraphics.com.au> <11a3a80e74a006040460fa051747e6a79c6382ce.1539497520.git.fthain@telegraphics.com.au>
In-Reply-To: <11a3a80e74a006040460fa051747e6a79c6382ce.1539497520.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 14 Oct 2018 12:55:43 +0200
Message-ID: <CAMuHMdV-VUCeO_uOwOtF2Cu-eXria2n-wEaj1qMMnnFWcOSFeg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] esp_scsi: Track residual for PIO transfers
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
> If a target disconnects during a PIO data transfer the command may
> fail when the target reconnects:
>
> scsi host1: DMA length is zero!
> scsi host1: cur adr[04380000] len[00000000]
>
> The scsi bus is then reset. This happens because the residual reached
> zero before the transfer was completed.
>
> The usual residual calculation relies on the Transfer Count registers
> which works for DMA transfers but not for PIO transfers. Fix the problem
> by storing the PIO transfer residual and using that to correctly
> calculate bytes_sent.

Thanks for yur patch!

> Fixes: 6fe07aaffbf0

Fixes: 6fe07aaffbf0 ("[SCSI] m68k: new mac_esp scsi driver")

> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Tested-by: Michael Schmitz <schmitzmic@gmail.com>

> --- a/drivers/scsi/esp_scsi.h
> +++ b/drivers/scsi/esp_scsi.h
> @@ -540,6 +540,8 @@ struct esp {
>
>         void                    *dma;
>         int                     dmarev;
> +
> +       int                     send_cmd_residual;

unsigned int?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
