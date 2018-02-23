Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeBWP7q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:59:46 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:46869 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751477AbeBWP7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:59:10 -0500
X-Google-Smtp-Source: AG47ELtf7tq5jDwPyxxS7N5rNzVA9SJ/a9UhMNoc6pmokO6n8KHG9ESi5gzHsS+1UU6/ePEUpFhozTXdM+q7VQTU+h4=
MIME-Version: 1.0
In-Reply-To: <20180223153700.2186058-1-arnd@arndb.de>
References: <20180223153700.2186058-1-arnd@arndb.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Feb 2018 17:59:08 +0200
Message-ID: <CAHp75VdAsEQNKRnTRKnpY+X2Ph=B17dNQ_1==2OkRKcs7ma5KA@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: use memcpy_toio instead of writeq
To: Arnd Bergmann <arnd@arndb.de>
Cc: James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 5:36 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 32-bit architectures generally cannot use writeq(), so we now get a build
> failure for the lpfc driver:
>
> drivers/scsi/lpfc/lpfc_sli.c: In function 'lpfc_sli4_wq_put':
> drivers/scsi/lpfc/lpfc_sli.c:145:4: error: implicit declaration of function 'writeq'; did you mean 'writeb'? [-Werror=implicit-function-declaration]
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

IIRC memcpy_toio() doesn't increment the destination address.

lo_hi or hi_lo helpers sound better.

> Fixes: 1351e69fc6db ("scsi: lpfc: Add push-to-adapter support to sli4")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

> @@ -115,7 +115,6 @@ lpfc_sli4_wq_put(struct lpfc_queue *q, union lpfc_wqe *wqe)
>         struct lpfc_register doorbell;
>         uint32_t host_index;
>         uint32_t idx;
> -       uint32_t i = 0;
>         uint8_t *tmp;
>
>         /* sanity check on queue memory */
> @@ -138,12 +137,10 @@ lpfc_sli4_wq_put(struct lpfc_queue *q, union lpfc_wqe *wqe)
>         if (q->phba->sli3_options & LPFC_SLI4_PHWQ_ENABLED)
>                 bf_set(wqe_wqid, &wqe->generic.wqe_com, q->queue_id);
>         lpfc_sli_pcimem_bcopy(wqe, temp_wqe, q->entry_size);
> -       if (q->dpp_enable && q->phba->cfg_enable_dpp) {
> +       if (q->dpp_enable && q->phba->cfg_enable_dpp)
>                 /* write to DPP aperture taking advatage of Combined Writes */
> -               tmp = (uint8_t *)wqe;
> -               for (i = 0; i < q->entry_size; i += sizeof(uint64_t))
> -                       writeq(*((uint64_t *)(tmp + i)), q->dpp_regaddr + i);
> -       }
> +               memcpy_toio(tmp, q->dpp_regaddr, q->entry_size);
> +
>         /* ensure WQE bcopy and DPP flushed before doorbell write */
>         wmb();
>
> --
> 2.9.0
>



-- 
With Best Regards,
Andy Shevchenko
