Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752588AbeBWVCk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 16:02:40 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:39002 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752178AbeBWVCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 16:02:34 -0500
X-Google-Smtp-Source: AG47ELvNOYvV9uvCmnE/WyEZowg/RcPMYUwY3yOyVCy2m1nZxvJ579gKRKacv84rCUfBHgQIV4+Zn3Gma9ww50zhsv8=
MIME-Version: 1.0
In-Reply-To: <20180223153700.2186058-1-arnd@arndb.de>
References: <20180223153700.2186058-1-arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 23 Feb 2018 22:02:33 +0100
X-Google-Sender-Auth: RTVrCPkn0NIshFC2AgEw8O8J3Yc
Message-ID: <CAK8P3a1--4o7piRf1VEr_cTUaE09ATnWoJfezrg=eqFzM64RoA@mail.gmail.com>
Subject: Re: [PATCH] scsi: lpfc: use memcpy_toio instead of writeq
To: James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 4:36 PM, Arnd Bergmann <arnd@arndb.de> wrote:
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

Not sure where we are with the question of whether memcpy_toio
is a good replacement or not, but further build testing showed that
my patch was completely broken in more than one way:

I mixed up the source and destination arguments, and I used
the uninitialized 'tmp' instead of 'wqe'. Don't try this patch.

       Arnd
