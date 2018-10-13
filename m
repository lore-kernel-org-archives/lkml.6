Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E52EC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5F32098A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE5F32098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbeJMLot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 07:44:49 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48054 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeJMLot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 07:44:49 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 41FD929F7F;
        Sat, 13 Oct 2018 00:09:11 -0400 (EDT)
Date:   Sat, 13 Oct 2018 15:09:12 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] esp_scsi: Optimize PIO loops
In-Reply-To: <3ba0d49c-57ce-40df-b406-98afc183275e@gmail.com>
Message-ID: <alpine.LNX.2.21.1810131505230.375@nippy.intranet>
References: <cover.1539391876.git.fthain@telegraphics.com.au> <3a2534bff570653de6897afa081017e2a359747e.1539391876.git.fthain@telegraphics.com.au> <3ba0d49c-57ce-40df-b406-98afc183275e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Oct 2018, Michael Schmitz wrote:

> Hi Finn,
> 
> Am 13.10.2018 um 13:51 schrieb Finn Thain:
> > Avoid function calls in the inner PIO loops. On a Centris 660av this
> > improves throughput for sequential read transfers by about 40% and
> > sequential write by about 10%.
> > 
> > Unfortunately it is not possible to have method calls like esp_write8()
> > placed inline so this is always going to be slow (even with LTO).
> > 
> > Tested-by: Stan Johnson <userm57@yahoo.com>
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> > ---
> >  drivers/scsi/esp_scsi.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
> > index 646701fc22a4..9f0e68cd0e99 100644
> > --- a/drivers/scsi/esp_scsi.c
> > +++ b/drivers/scsi/esp_scsi.c
> > @@ -2788,7 +2788,7 @@ static inline unsigned int esp_wait_for_fifo(struct
> > esp *esp)
> >  		if (fbytes)
> >  			return fbytes;
> > 
> > -		udelay(2);
> > +		udelay(1);
> >  	} while (--i);
> > 
> >  	pr_err("FIFO is empty (sreg %02x)\n", esp_read8(ESP_STATUS));
> > @@ -2804,7 +2804,7 @@ static inline int esp_wait_for_intr(struct esp *esp)
> >  		if (esp->sreg & ESP_STAT_INTR)
> >  			return 0;
> > 
> > -		udelay(2);
> > +		udelay(1);
> >  	} while (--i);
> > 
> >  	pr_err("IRQ timeout (sreg %02x)\n", esp->sreg);
> > @@ -2831,7 +2831,7 @@ void esp_send_pio_cmd(struct esp *esp, u32 addr, u32
> > esp_count,
> >  			if (!esp_wait_for_fifo(esp))
> >  				break;
> > 
> > -			*dst++ = esp_read8(ESP_FDATA);
> > +			*dst++ = readb(esp->fifo_reg);
> >  			--esp_count;
> > 
> >  			if (!esp_count)
> > @@ -2852,15 +2852,15 @@ void esp_send_pio_cmd(struct esp *esp, u32 addr, u32
> > esp_count,
> >  			}
> > 
> >  			if (phase == ESP_MIP)
> > -				scsi_esp_cmd(esp, ESP_CMD_MOK);
> > +				esp_write8(ESP_CMD_MOK, ESP_CMD);
> 
> You're no longer logging this command with this patch. (That'll be the reason
> for the speedup you saw ...)
> 
> > 
> > -			scsi_esp_cmd(esp, ESP_CMD_TI);
> > +			esp_write8(ESP_CMD_TI, ESP_CMD);
> 
> Same here..
> 
> >  		}
> >  	} else {
> >  		unsigned int n = ESP_FIFO_SIZE;
> >  		u8 *src = (u8 *)addr;
> > 
> > -		scsi_esp_cmd(esp, ESP_CMD_FLUSH);
> > +		esp_write8(ESP_CMD_FLUSH, ESP_CMD);
> 
> here..
> 
> > 
> >  		if (n > esp_count)
> >  			n = esp_count;
> > @@ -2894,7 +2894,7 @@ void esp_send_pio_cmd(struct esp *esp, u32 addr, u32
> > esp_count,
> >  			src += n;
> >  			esp_count -= n;
> > 
> > -			scsi_esp_cmd(esp, ESP_CMD_TI);
> > +			esp_write8(ESP_CMD_TI, ESP_CMD);
> 
> and here.
> 

Yes, it's deliberate.

> The burst of ESP_CMD_TI's in the log was quite useful to spot what went 
> wrong during PIO.

I don't think it's as useful as you seem to think. Compare 
mac_esp_send_pdma_cmd().

> Maybe mention in the changelog that commands during PIO are no longer 
> logged? Or introduce a new ESP_EVENT_PIO and log that at the start of 
> PIO?
> 

Yes, and I did leave a scsi_esp_cmd(esp, cmd) call at the start of PIO. 

That should be sufficient, right?

-- 

> Cheers,
> 
> 	Michael
> 
> 
> 
> >  		}
> >  	}
> > 
> > 
> 
