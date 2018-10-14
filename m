Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CCDC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 22:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2499420659
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 22:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2499420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbeJOFne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 01:43:34 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:58786 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbeJOFne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 01:43:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 058DF22C36;
        Sun, 14 Oct 2018 18:01:01 -0400 (EDT)
Date:   Mon, 15 Oct 2018 09:00:57 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        scsi <linux-scsi@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] zorro_esp: Limit DMA transfers to 65535 bytes
In-Reply-To: <CAMuHMdUNyfq00ugz-LifqmKwA4Mau6Vi-z5wCX_a=_jq1yZT_g@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1810150840580.10@nippy.intranet>
References: <cover.1539497520.git.fthain@telegraphics.com.au> <022a8c581d228f3f01dfa783aadd183a53169daa.1539497520.git.fthain@telegraphics.com.au> <CAMuHMdUNyfq00ugz-LifqmKwA4Mau6Vi-z5wCX_a=_jq1yZT_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Oct 2018, Geert Uytterhoeven wrote:

> 
> > Fixes: 3109e5ae0311
> 
> Fixes: 3109e5ae0311 ("scsi: zorro_esp: New driver for Amiga Zorro
> NCR53C9x boards")
> 

OK.

> $ git help fixes
> 'fixes' is aliased to 'show --format='Fixes: %h ("%s")' -s'
> 
> BTW, if you use vim, add
> 
>     noremap ;gs "zyiw:exe "new \| setlocal buftype=nofile
> bufhidden=hide noswapfile syntax=git \| 0r ! git show ".@z."" \|
> :0<CR><CR>
> 
> to .vimrc, and type ";gs" when the cursor is positioned on a commit ID.
> 

Thanks.

> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> > Cc: Michael Schmitz <schmitzmic@gmail.com>
> > Tested-by: Michael Schmitz <schmitzmic@gmail.com>
> 
> > --- a/drivers/scsi/zorro_esp.c
> > +++ b/drivers/scsi/zorro_esp.c
> > @@ -245,7 +245,7 @@ static int fastlane_esp_irq_pending(struct esp *esp)
> >  static u32 zorro_esp_dma_length_limit(struct esp *esp, u32 dma_addr,
> >                                         u32 dma_len)
> >  {
> > -       return dma_len > 0xFFFFFF ? 0xFFFFFF : dma_len;
> > +       return dma_len > 0xFFFF ? 0xFFFF : dma_len;
> >  }
> >
> >  static void zorro_esp_reset_dma(struct esp *esp)
> > @@ -484,7 +484,6 @@ static void zorro_esp_send_blz1230_dma_cmd(struct esp *esp, u32 addr,
> >         scsi_esp_cmd(esp, ESP_CMD_DMA);
> >         zorro_esp_write8(esp, (esp_count >> 0) & 0xff, ESP_TCLOW);
> >         zorro_esp_write8(esp, (esp_count >> 8) & 0xff, ESP_TCMED);
> > -       zorro_esp_write8(esp, (esp_count >> 16) & 0xff, ESP_TCHI);
> 
> Since all these sub-drivers seem to support 24-bit transfers, perhaps this is
> something to be fixed in the esp_scsi core?
> 

I don't think there is anything to fix in the esp_scsi core. The fact that 
no-one saw the error indicates that large transfers don't occur in 
practice.

If you said there is an opportunity for an enhancement, I could agree, 
assuming that you also found a way to produce large IO requests. But I 
doubt that such an enhancement would make a measurable improvement.

Even if the benefit was measurable, the fix under review would still be 
needed for stable kernels.

BTW, Michael and I already discussed all this (it probably should have 
happened on the linux-m68k list).

Please see,

$ grep -lr ESP_CONFIG2_FENAB drivers/scsi/
drivers/scsi/am53c974.c
drivers/scsi/esp_scsi.c
drivers/scsi/esp_scsi.h

The authors of am53c974.c obviously decided it wasn't wise to make this 
feature mandatory (which suggests that perhaps it shouldn't go into common 
code).

The comments in esp_scsi.c say that ESP_CONFIG2_FENAB has undesirable 
consequences. There is information in the datasheets on this point but I 
didn't follow it up because I don't see a performance issue.

-- 
