Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F316C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 22:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E022D20652
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 22:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E022D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbeJOF4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 01:56:49 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:58930 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeJOF4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 01:56:49 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id D86CE22C36;
        Sun, 14 Oct 2018 18:14:20 -0400 (EDT)
Date:   Mon, 15 Oct 2018 09:14:18 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        scsi <linux-scsi@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] esp_scsi: Track residual for PIO transfers
In-Reply-To: <CAMuHMdV-VUCeO_uOwOtF2Cu-eXria2n-wEaj1qMMnnFWcOSFeg@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1810150902430.10@nippy.intranet>
References: <cover.1539497520.git.fthain@telegraphics.com.au> <11a3a80e74a006040460fa051747e6a79c6382ce.1539497520.git.fthain@telegraphics.com.au> <CAMuHMdV-VUCeO_uOwOtF2Cu-eXria2n-wEaj1qMMnnFWcOSFeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Oct 2018, Geert Uytterhoeven wrote:

> 
> > Fixes: 6fe07aaffbf0
> 
> Fixes: 6fe07aaffbf0 ("[SCSI] m68k: new mac_esp scsi driver")
> 

Fixed.

> > Tested-by: Stan Johnson <userm57@yahoo.com>
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> > Tested-by: Michael Schmitz <schmitzmic@gmail.com>
> 
> > --- a/drivers/scsi/esp_scsi.h
> > +++ b/drivers/scsi/esp_scsi.h
> > @@ -540,6 +540,8 @@ struct esp {
> >
> >         void                    *dma;
> >         int                     dmarev;
> > +
> > +       int                     send_cmd_residual;
> 
> unsigned int?
> 

My first thought was to use u32, same as esp_count. But it turns out that 
the end result really is an int --

static int esp_data_bytes_sent(struct esp *esp, struct esp_cmd_entry *ent,
                               struct scsi_cmnd *cmd)
{
        int fifo_cnt, ecount, bytes_sent, flush_fifo;

        ...
        bytes_sent = esp->data_dma_len;
        bytes_sent -= ecount;
        bytes_sent -= esp->send_cmd_residual;
	...
        return bytes_sent;
}

Apparently over/underflow is a real possibility, because there is a test 
for this in esp_process_event().

-- 

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
