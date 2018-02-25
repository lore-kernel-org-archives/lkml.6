Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751667AbeBYKCZ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 05:02:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:41217 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750987AbeBYKCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 05:02:20 -0500
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: lpfc: use memcpy_toio instead of writeq
References: <20180223153700.2186058-1-arnd@arndb.de>
Date: Sun, 25 Feb 2018 11:02:16 +0100
In-Reply-To: <20180223153700.2186058-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Fri, 23 Feb 2018 16:36:49 +0100")
Message-ID: <mqdsh9p9yl3.fsf@linux-x5ow.site>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:
> 32-bit architectures generally cannot use writeq(), so we now get a build
> failure for the lpfc driver:
>
> drivers/scsi/lpfc/lpfc_sli.c: In function 'lpfc_sli4_wq_put':
> drivers/scsi/lpfc/lpfc_sli.c:145:4: error: implicit declaration of function 'writeq'; did you mean 'writeb'? [-Werror=implicit-function-declaration]
Hi Arnd,
why can't we use the writeq() from 'io-64-nonatomic-lo-hi.h'? I always
thought these are compat versions for 32 Bit archs and even asked James
to do so, what's why he did the change in the first place.

My apologies for this James.

Thanks,
        Johannes


>
> Another problem here is that writing out actual data (unlike accessing
> mmio registers) means we must write the data with the same endianess
> that we have read from memory, but writeq() will perform byte swaps
> and add barriers inbetween accesses as we do for registers.
>
> Using memcpy_toio() should do the right thing here, using register
> sized stores with correct endianess conversion and barriers (i.e. none),
> but on some architectures might fall back to byte-size access.
>
> Side note: shouldn't the driver use ioremap_wc() instead of ioremap()
> to get a write-combining mapping on all architectures that support this?
>
> Fixes: 1351e69fc6db ("scsi: lpfc: Add push-to-adapter support to sli4")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/scsi/lpfc/lpfc_sli.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
> index 4ce3ca6f4b79..6749d41753b4 100644
> --- a/drivers/scsi/lpfc/lpfc_sli.c
> +++ b/drivers/scsi/lpfc/lpfc_sli.c
> @@ -115,7 +115,6 @@ lpfc_sli4_wq_put(struct lpfc_queue *q, union lpfc_wqe *wqe)
>  	struct lpfc_register doorbell;
>  	uint32_t host_index;
>  	uint32_t idx;
> -	uint32_t i = 0;
>  	uint8_t *tmp;
>  
>  	/* sanity check on queue memory */
> @@ -138,12 +137,10 @@ lpfc_sli4_wq_put(struct lpfc_queue *q, union lpfc_wqe *wqe)
>  	if (q->phba->sli3_options & LPFC_SLI4_PHWQ_ENABLED)
>  		bf_set(wqe_wqid, &wqe->generic.wqe_com, q->queue_id);
>  	lpfc_sli_pcimem_bcopy(wqe, temp_wqe, q->entry_size);
> -	if (q->dpp_enable && q->phba->cfg_enable_dpp) {
> +	if (q->dpp_enable && q->phba->cfg_enable_dpp)
>  		/* write to DPP aperture taking advatage of Combined Writes */
> -		tmp = (uint8_t *)wqe;
> -		for (i = 0; i < q->entry_size; i += sizeof(uint64_t))
> -			writeq(*((uint64_t *)(tmp + i)), q->dpp_regaddr + i);
> -	}
> +		memcpy_toio(tmp, q->dpp_regaddr, q->entry_size);
> +
>  	/* ensure WQE bcopy and DPP flushed before doorbell write */
>  	wmb();

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
