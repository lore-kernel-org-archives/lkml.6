Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F29C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BCE20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AK9Y70OE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfAOBPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 20:15:24 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38690 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfAOBPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 20:15:24 -0500
Received: by mail-ua1-f66.google.com with SMTP id p9so377398uaa.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 17:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPFyLbm95qbQJK09HBWfI6B7PqMW5EesP5fp4MrKt8E=;
        b=AK9Y70OEyiqLnNvjLIgrxd8zoyulNLY7ZUE7sYoeUO1Tl1Djll5NGHRUP0mgwuQyoc
         nQpU95iQyEuljVLkW0wnpJk+XuaatJgG580itilhYb/qSzCMh6nD1XXiQ+0KQrjPrUB7
         3/h45x1ptjLfNKEosLc8Sk7p6G6J0SokRffoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPFyLbm95qbQJK09HBWfI6B7PqMW5EesP5fp4MrKt8E=;
        b=SfztmlRs2K0kiv2vMqaJwd5zVcFK52zrOJT7Kppjw8fU5yyZpd6V3uDM9PFGPf0GiJ
         KLdyKycLDkQromMAR2j7PeDCe13XXfj92acIJl9G+0BV+72y9HGni7bvcRug+LWtGYa2
         dzPwB/+LpFOLzDg3nyssUDAo1AJIfONzW7tnqrUXUs+gNxMl7iFRRzRp2FR6ag29rWHo
         ALSXbTbR4ElXxFcXm73HCNMZMn30Rep+X2dYvzo1LvX0vgwiHiLNJPytUQiBZhQ2Tks/
         XwRskjOT4QPBHxb9b/m5aPRhA8f/MQ9I6U7uDNfAMmZ5wJ+d6nhGefV4uECADQUmuuFO
         +4Vw==
X-Gm-Message-State: AJcUukcmPKs2nU9ZhqCu1jcuxVHRcx92xHYuZZTAkQMwX2aPbO9/nKSU
        wC/Bo2Y6X1JDm9YmLewPmKWaVl+R/Bw=
X-Google-Smtp-Source: ALg8bN5M3Gmyd5olbYC1Zq1ME2crRBRfHOb9sUHMsOz51AQpWQB/qiGAstLE2AVvzD4EeudDmoYxxA==
X-Received: by 2002:ab0:1c7:: with SMTP id 65mr535839ual.125.1547514919739;
        Mon, 14 Jan 2019 17:15:19 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id z70sm271803vsc.15.2019.01.14.17.15.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 17:15:18 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id e16so357853uam.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 17:15:18 -0800 (PST)
X-Received: by 2002:a9f:2709:: with SMTP id a9mr592272uaa.10.1547514917257;
 Mon, 14 Jan 2019 17:15:17 -0800 (PST)
MIME-Version: 1.0
References: <20190112152844.26550-1-w@1wt.eu> <20190112152844.26550-5-w@1wt.eu>
In-Reply-To: <20190112152844.26550-5-w@1wt.eu>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 14 Jan 2019 17:15:05 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKu5br-pB3U+3PDtgcgq_nmt0C7gHLYQXV4tz3pN=S11Q@mail.gmail.com>
Message-ID: <CAGXu5jKu5br-pB3U+3PDtgcgq_nmt0C7gHLYQXV4tz3pN=S11Q@mail.gmail.com>
Subject: Re: [PATCH 5/8] scsi: lpfc: change snprintf to scnprintf for possible overflow
To:     Willy Tarreau <w@1wt.eu>
Cc:     Silvio Cesare <silvio.cesare@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 7:29 AM Willy Tarreau <w@1wt.eu> wrote:
>
> From: Silvio Cesare <silvio.cesare@gmail.com>
>
> Change snprintf to scnprintf. There are generally two cases where using
> snprintf causes problems.
>
> 1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
> In this case, if snprintf would have written more characters than what the
> buffer size (SIZE) is, then size will end up larger than SIZE. In later
> uses of snprintf, SIZE - size will result in a negative number, leading
> to problems. Note that size might already be too large by using
> size = snprintf before the code reaches a case of size += snprintf.
>
> 2) If size is ultimately used as a length parameter for a copy back to user
> space, then it will potentially allow for a buffer overflow and information
> disclosure when size is greater than SIZE. When the size is used to index
> the buffer directly, we can have memory corruption. This also means when
> size = snprintf... is used, it may also cause problems since size may become
> large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
> configuration.
>
> The solution to these issues is to use scnprintf which returns the number of
> characters actually written to the buffer, so the size variable will never
> exceed SIZE.
>
> Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Dick Kennedy <dick.kennedy@broadcom.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Greg KH <greg@kroah.com>
> Signed-off-by: Willy Tarreau <w@1wt.eu>

I think this needs Cc: stable.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>
> ---
>  drivers/scsi/lpfc/lpfc_debugfs.c | 450 +++++++++++++++----------------
>  1 file changed, 225 insertions(+), 225 deletions(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
> index 34d311a7dbef..218a74b9297a 100644
> --- a/drivers/scsi/lpfc/lpfc_debugfs.c
> +++ b/drivers/scsi/lpfc/lpfc_debugfs.c
> @@ -170,7 +170,7 @@ lpfc_debugfs_disc_trc_data(struct lpfc_vport *vport, char *buf, int size)
>                 snprintf(buffer,
>                         LPFC_DEBUG_TRC_ENTRY_SIZE, "%010d:%010d ms:%s\n",
>                         dtp->seq_cnt, ms, dtp->fmt);
> -               len +=  snprintf(buf+len, size-len, buffer,
> +               len +=  scnprintf(buf+len, size-len, buffer,
>                         dtp->data1, dtp->data2, dtp->data3);
>         }
>         for (i = 0; i < index; i++) {
> @@ -181,7 +181,7 @@ lpfc_debugfs_disc_trc_data(struct lpfc_vport *vport, char *buf, int size)
>                 snprintf(buffer,
>                         LPFC_DEBUG_TRC_ENTRY_SIZE, "%010d:%010d ms:%s\n",
>                         dtp->seq_cnt, ms, dtp->fmt);
> -               len +=  snprintf(buf+len, size-len, buffer,
> +               len +=  scnprintf(buf+len, size-len, buffer,
>                         dtp->data1, dtp->data2, dtp->data3);
>         }
>
> @@ -236,7 +236,7 @@ lpfc_debugfs_slow_ring_trc_data(struct lpfc_hba *phba, char *buf, int size)
>                 snprintf(buffer,
>                         LPFC_DEBUG_TRC_ENTRY_SIZE, "%010d:%010d ms:%s\n",
>                         dtp->seq_cnt, ms, dtp->fmt);
> -               len +=  snprintf(buf+len, size-len, buffer,
> +               len +=  scnprintf(buf+len, size-len, buffer,
>                         dtp->data1, dtp->data2, dtp->data3);
>         }
>         for (i = 0; i < index; i++) {
> @@ -247,7 +247,7 @@ lpfc_debugfs_slow_ring_trc_data(struct lpfc_hba *phba, char *buf, int size)
>                 snprintf(buffer,
>                         LPFC_DEBUG_TRC_ENTRY_SIZE, "%010d:%010d ms:%s\n",
>                         dtp->seq_cnt, ms, dtp->fmt);
> -               len +=  snprintf(buf+len, size-len, buffer,
> +               len +=  scnprintf(buf+len, size-len, buffer,
>                         dtp->data1, dtp->data2, dtp->data3);
>         }
>
> @@ -307,7 +307,7 @@ lpfc_debugfs_hbqinfo_data(struct lpfc_hba *phba, char *buf, int size)
>
>         i = lpfc_debugfs_last_hbq;
>
> -       len +=  snprintf(buf+len, size-len, "HBQ %d Info\n", i);
> +       len +=  scnprintf(buf+len, size-len, "HBQ %d Info\n", i);
>
>         hbqs =  &phba->hbqs[i];
>         posted = 0;
> @@ -315,21 +315,21 @@ lpfc_debugfs_hbqinfo_data(struct lpfc_hba *phba, char *buf, int size)
>                 posted++;
>
>         hip =  lpfc_hbq_defs[i];
> -       len +=  snprintf(buf+len, size-len,
> +       len +=  scnprintf(buf+len, size-len,
>                 "idx:%d prof:%d rn:%d bufcnt:%d icnt:%d acnt:%d posted %d\n",
>                 hip->hbq_index, hip->profile, hip->rn,
>                 hip->buffer_count, hip->init_count, hip->add_count, posted);
>
>         raw_index = phba->hbq_get[i];
>         getidx = le32_to_cpu(raw_index);
> -       len +=  snprintf(buf+len, size-len,
> +       len +=  scnprintf(buf+len, size-len,
>                 "entries:%d bufcnt:%d Put:%d nPut:%d localGet:%d hbaGet:%d\n",
>                 hbqs->entry_count, hbqs->buffer_count, hbqs->hbqPutIdx,
>                 hbqs->next_hbqPutIdx, hbqs->local_hbqGetIdx, getidx);
>
>         hbqe = (struct lpfc_hbq_entry *) phba->hbqs[i].hbq_virt;
>         for (j=0; j<hbqs->entry_count; j++) {
> -               len +=  snprintf(buf+len, size-len,
> +               len +=  scnprintf(buf+len, size-len,
>                         "%03d: %08x %04x %05x ", j,
>                         le32_to_cpu(hbqe->bde.addrLow),
>                         le32_to_cpu(hbqe->bde.tus.w),
> @@ -341,14 +341,14 @@ lpfc_debugfs_hbqinfo_data(struct lpfc_hba *phba, char *buf, int size)
>                 low = hbqs->hbqPutIdx - posted;
>                 if (low >= 0) {
>                         if ((j >= hbqs->hbqPutIdx) || (j < low)) {
> -                               len +=  snprintf(buf+len, size-len, "Unused\n");
> +                               len +=  scnprintf(buf+len, size-len, "Unused\n");
>                                 goto skipit;
>                         }
>                 }
>                 else {
>                         if ((j >= hbqs->hbqPutIdx) &&
>                                 (j < (hbqs->entry_count+low))) {
> -                               len +=  snprintf(buf+len, size-len, "Unused\n");
> +                               len +=  scnprintf(buf+len, size-len, "Unused\n");
>                                 goto skipit;
>                         }
>                 }
> @@ -358,7 +358,7 @@ lpfc_debugfs_hbqinfo_data(struct lpfc_hba *phba, char *buf, int size)
>                         hbq_buf = container_of(d_buf, struct hbq_dmabuf, dbuf);
>                         phys = ((uint64_t)hbq_buf->dbuf.phys & 0xffffffff);
>                         if (phys == le32_to_cpu(hbqe->bde.addrLow)) {
> -                               len +=  snprintf(buf+len, size-len,
> +                               len +=  scnprintf(buf+len, size-len,
>                                         "Buf%d: %p %06x\n", i,
>                                         hbq_buf->dbuf.virt, hbq_buf->tag);
>                                 found = 1;
> @@ -367,7 +367,7 @@ lpfc_debugfs_hbqinfo_data(struct lpfc_hba *phba, char *buf, int size)
>                         i++;
>                 }
>                 if (!found) {
> -                       len +=  snprintf(buf+len, size-len, "No DMAinfo?\n");
> +                       len +=  scnprintf(buf+len, size-len, "No DMAinfo?\n");
>                 }
>  skipit:
>                 hbqe++;
> @@ -413,7 +413,7 @@ lpfc_debugfs_dumpHBASlim_data(struct lpfc_hba *phba, char *buf, int size)
>         off = 0;
>         spin_lock_irq(&phba->hbalock);
>
> -       len +=  snprintf(buf+len, size-len, "HBA SLIM\n");
> +       len +=  scnprintf(buf+len, size-len, "HBA SLIM\n");
>         lpfc_memcpy_from_slim(buffer,
>                 phba->MBslimaddr + lpfc_debugfs_last_hba_slim_off, 1024);
>
> @@ -427,7 +427,7 @@ lpfc_debugfs_dumpHBASlim_data(struct lpfc_hba *phba, char *buf, int size)
>
>         i = 1024;
>         while (i > 0) {
> -               len +=  snprintf(buf+len, size-len,
> +               len +=  scnprintf(buf+len, size-len,
>                 "%08x: %08x %08x %08x %08x %08x %08x %08x %08x\n",
>                 off, *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4),
>                 *(ptr+5), *(ptr+6), *(ptr+7));
> @@ -471,11 +471,11 @@ lpfc_debugfs_dumpHostSlim_data(struct lpfc_hba *phba, char *buf, int size)
>         off = 0;
>         spin_lock_irq(&phba->hbalock);
>
> -       len +=  snprintf(buf+len, size-len, "SLIM Mailbox\n");
> +       len +=  scnprintf(buf+len, size-len, "SLIM Mailbox\n");
>         ptr = (uint32_t *)phba->slim2p.virt;
>         i = sizeof(MAILBOX_t);
>         while (i > 0) {
> -               len +=  snprintf(buf+len, size-len,
> +               len +=  scnprintf(buf+len, size-len,
>                 "%08x: %08x %08x %08x %08x %08x %08x %08x %08x\n",
>                 off, *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4),
>                 *(ptr+5), *(ptr+6), *(ptr+7));
> @@ -484,11 +484,11 @@ lpfc_debugfs_dumpHostSlim_data(struct lpfc_hba *phba, char *buf, int size)
>                 off += (8 * sizeof(uint32_t));
>         }
>
> -       len +=  snprintf(buf+len, size-len, "SLIM PCB\n");
> +       len +=  scnprintf(buf+len, size-len, "SLIM PCB\n");
>         ptr = (uint32_t *)phba->pcb;
>         i = sizeof(PCB_t);
>         while (i > 0) {
> -               len +=  snprintf(buf+len, size-len,
> +               len +=  scnprintf(buf+len, size-len,
>                 "%08x: %08x %08x %08x %08x %08x %08x %08x %08x\n",
>                 off, *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4),
>                 *(ptr+5), *(ptr+6), *(ptr+7));
> @@ -501,7 +501,7 @@ lpfc_debugfs_dumpHostSlim_data(struct lpfc_hba *phba, char *buf, int size)
>                 for (i = 0; i < 4; i++) {
>                         pgpp = &phba->port_gp[i];
>                         pring = &psli->sli3_ring[i];
> -                       len +=  snprintf(buf+len, size-len,
> +                       len +=  scnprintf(buf+len, size-len,
>                                          "Ring %d: CMD GetInx:%d "
>                                          "(Max:%d Next:%d "
>                                          "Local:%d flg:x%x)  "
> @@ -518,7 +518,7 @@ lpfc_debugfs_dumpHostSlim_data(struct lpfc_hba *phba, char *buf, int size)
>                 word1 = readl(phba->CAregaddr);
>                 word2 = readl(phba->HSregaddr);
>                 word3 = readl(phba->HCregaddr);
> -               len +=  snprintf(buf+len, size-len, "HA:%08x CA:%08x HS:%08x "
> +               len +=  scnprintf(buf+len, size-len, "HA:%08x CA:%08x HS:%08x "
>                                  "HC:%08x\n", word0, word1, word2, word3);
>         }
>         spin_unlock_irq(&phba->hbalock);
> @@ -556,12 +556,12 @@ lpfc_debugfs_nodelist_data(struct lpfc_vport *vport, char *buf, int size)
>         cnt = (LPFC_NODELIST_SIZE / LPFC_NODELIST_ENTRY_SIZE);
>         outio = 0;
>
> -       len += snprintf(buf+len, size-len, "\nFCP Nodelist Entries ...\n");
> +       len += scnprintf(buf+len, size-len, "\nFCP Nodelist Entries ...\n");
>         spin_lock_irq(shost->host_lock);
>         list_for_each_entry(ndlp, &vport->fc_nodes, nlp_listp) {
>                 iocnt = 0;
>                 if (!cnt) {
> -                       len +=  snprintf(buf+len, size-len,
> +                       len +=  scnprintf(buf+len, size-len,
>                                 "Missing Nodelist Entries\n");
>                         break;
>                 }
> @@ -599,61 +599,61 @@ lpfc_debugfs_nodelist_data(struct lpfc_vport *vport, char *buf, int size)
>                 default:
>                         statep = "UNKNOWN";
>                 }
> -               len += snprintf(buf+len, size-len, "%s DID:x%06x ",
> +               len += scnprintf(buf+len, size-len, "%s DID:x%06x ",
>                                 statep, ndlp->nlp_DID);
> -               len += snprintf(buf+len, size-len,
> +               len += scnprintf(buf+len, size-len,
>                                 "WWPN x%llx ",
>                                 wwn_to_u64(ndlp->nlp_portname.u.wwn));
> -               len += snprintf(buf+len, size-len,
> +               len += scnprintf(buf+len, size-len,
>                                 "WWNN x%llx ",
>                                 wwn_to_u64(ndlp->nlp_nodename.u.wwn));
>                 if (ndlp->nlp_flag & NLP_RPI_REGISTERED)
> -                       len += snprintf(buf+len, size-len, "RPI:%03d ",
> +                       len += scnprintf(buf+len, size-len, "RPI:%03d ",
>                                         ndlp->nlp_rpi);
>                 else
> -                       len += snprintf(buf+len, size-len, "RPI:none ");
> -               len +=  snprintf(buf+len, size-len, "flag:x%08x ",
> +                       len += scnprintf(buf+len, size-len, "RPI:none ");
> +               len +=  scnprintf(buf+len, size-len, "flag:x%08x ",
>                         ndlp->nlp_flag);
>                 if (!ndlp->nlp_type)
> -                       len += snprintf(buf+len, size-len, "UNKNOWN_TYPE ");
> +                       len += scnprintf(buf+len, size-len, "UNKNOWN_TYPE ");
>                 if (ndlp->nlp_type & NLP_FC_NODE)
> -                       len += snprintf(buf+len, size-len, "FC_NODE ");
> +                       len += scnprintf(buf+len, size-len, "FC_NODE ");
>                 if (ndlp->nlp_type & NLP_FABRIC) {
> -                       len += snprintf(buf+len, size-len, "FABRIC ");
> +                       len += scnprintf(buf+len, size-len, "FABRIC ");
>                         iocnt = 0;
>                 }
>                 if (ndlp->nlp_type & NLP_FCP_TARGET)
> -                       len += snprintf(buf+len, size-len, "FCP_TGT sid:%d ",
> +                       len += scnprintf(buf+len, size-len, "FCP_TGT sid:%d ",
>                                 ndlp->nlp_sid);
>                 if (ndlp->nlp_type & NLP_FCP_INITIATOR)
> -                       len += snprintf(buf+len, size-len, "FCP_INITIATOR ");
> +                       len += scnprintf(buf+len, size-len, "FCP_INITIATOR ");
>                 if (ndlp->nlp_type & NLP_NVME_TARGET)
> -                       len += snprintf(buf + len,
> +                       len += scnprintf(buf + len,
>                                         size - len, "NVME_TGT sid:%d ",
>                                         NLP_NO_SID);
>                 if (ndlp->nlp_type & NLP_NVME_INITIATOR)
> -                       len += snprintf(buf + len,
> +                       len += scnprintf(buf + len,
>                                         size - len, "NVME_INITIATOR ");
> -               len += snprintf(buf+len, size-len, "usgmap:%x ",
> +               len += scnprintf(buf+len, size-len, "usgmap:%x ",
>                         ndlp->nlp_usg_map);
> -               len += snprintf(buf+len, size-len, "refcnt:%x",
> +               len += scnprintf(buf+len, size-len, "refcnt:%x",
>                         kref_read(&ndlp->kref));
>                 if (iocnt) {
>                         i = atomic_read(&ndlp->cmd_pending);
> -                       len += snprintf(buf + len, size - len,
> +                       len += scnprintf(buf + len, size - len,
>                                         " OutIO:x%x Qdepth x%x",
>                                         i, ndlp->cmd_qdepth);
>                         outio += i;
>                 }
> -               len +=  snprintf(buf+len, size-len, "\n");
> +               len +=  scnprintf(buf+len, size-len, "\n");
>         }
>         spin_unlock_irq(shost->host_lock);
>
> -       len += snprintf(buf + len, size - len,
> +       len += scnprintf(buf + len, size - len,
>                         "\nOutstanding IO x%x\n",  outio);
>
>         if (phba->nvmet_support && phba->targetport && (vport == phba->pport)) {
> -               len += snprintf(buf + len, size - len,
> +               len += scnprintf(buf + len, size - len,
>                                 "\nNVME Targetport Entry ...\n");
>
>                 /* Port state is only one of two values for now. */
> @@ -661,18 +661,18 @@ lpfc_debugfs_nodelist_data(struct lpfc_vport *vport, char *buf, int size)
>                         statep = "REGISTERED";
>                 else
>                         statep = "INIT";
> -               len += snprintf(buf + len, size - len,
> +               len += scnprintf(buf + len, size - len,
>                                 "TGT WWNN x%llx WWPN x%llx State %s\n",
>                                 wwn_to_u64(vport->fc_nodename.u.wwn),
>                                 wwn_to_u64(vport->fc_portname.u.wwn),
>                                 statep);
> -               len += snprintf(buf + len, size - len,
> +               len += scnprintf(buf + len, size - len,
>                                 "    Targetport DID x%06x\n",
>                                 phba->targetport->port_id);
>                 goto out_exit;
>         }
>
> -       len += snprintf(buf + len, size - len,
> +       len += scnprintf(buf + len, size - len,
>                                 "\nNVME Lport/Rport Entries ...\n");
>
>         localport = vport->localport;
> @@ -687,11 +687,11 @@ lpfc_debugfs_nodelist_data(struct lpfc_vport *vport, char *buf, int size)
>         else
>                 statep = "UNKNOWN ";
>
> -       len += snprintf(buf + len, size - len,
> +       len += scnprintf(buf + len, size - len,
>                         "Lport DID x%06x PortState %s\n",
>                         localport->port_id, statep);
>
> -       len += snprintf(buf + len, size - len, "\tRport List:\n");
> +       len += scnprintf(buf + len, size - len, "\tRport List:\n");
>         list_for_each_entry(ndlp, &vport->fc_nodes, nlp_listp) {
>                 /* local short-hand pointer. */
>                 spin_lock(&phba->hbalock);
> @@ -718,32 +718,32 @@ lpfc_debugfs_nodelist_data(struct lpfc_vport *vport, char *buf, int size)
>                 }
>
>                 /* Tab in to show lport ownership. */
> -               len += snprintf(buf + len, size - len,
> +               len += scnprintf(buf + len, size - len,
>                                 "\t%s Port ID:x%06x ",
>                                 statep, nrport->port_id);
> -               len += snprintf(buf + len, size - len, "WWPN x%llx ",
> +               len += scnprintf(buf + len, size - len, "WWPN x%llx ",
>                                 nrport->port_name);
> -               len += snprintf(buf + len, size - len, "WWNN x%llx ",
> +               len += scnprintf(buf + len, size - len, "WWNN x%llx ",
>                                 nrport->node_name);
>
>                 /* An NVME rport can have multiple roles. */
>                 if (nrport->port_role & FC_PORT_ROLE_NVME_INITIATOR)
> -                       len +=  snprintf(buf + len, size - len,
> +                       len +=  scnprintf(buf + len, size - len,
>                                          "INITIATOR ");
>                 if (nrport->port_role & FC_PORT_ROLE_NVME_TARGET)
> -                       len +=  snprintf(buf + len, size - len,
> +                       len +=  scnprintf(buf + len, size - len,
>                                          "TARGET ");
>                 if (nrport->port_role & FC_PORT_ROLE_NVME_DISCOVERY)
> -                       len +=  snprintf(buf + len, size - len,
> +                       len +=  scnprintf(buf + len, size - len,
>                                          "DISCSRVC ");
>                 if (nrport->port_role & ~(FC_PORT_ROLE_NVME_INITIATOR |
>                                           FC_PORT_ROLE_NVME_TARGET |
>                                           FC_PORT_ROLE_NVME_DISCOVERY))
> -                       len +=  snprintf(buf + len, size - len,
> +                       len +=  scnprintf(buf + len, size - len,
>                                          "UNKNOWN ROLE x%x",
>                                          nrport->port_role);
>                 /* Terminate the string. */
> -               len +=  snprintf(buf + len, size - len, "\n");
> +               len +=  scnprintf(buf + len, size - len, "\n");
>         }
>
>         spin_unlock_irq(shost->host_lock);
> @@ -782,35 +782,35 @@ lpfc_debugfs_nvmestat_data(struct lpfc_vport *vport, char *buf, int size)
>                 if (!phba->targetport)
>                         return len;
>                 tgtp = (struct lpfc_nvmet_tgtport *)phba->targetport->private;
> -               len += snprintf(buf + len, size - len,
> +               len += scnprintf(buf + len, size - len,
>                                 "\nNVME Targetport Statistics\n");
>
> -               len += snprintf(buf + len, size - len,
> +               len += scnprintf(buf + len, size - len,
>                                 "LS: Rcv %08x Drop %08x Abort %08x\n",
>                                 atomic_read(&tgtp->rcv_ls_req_in),
>                                 atomic_read(&tgtp->rcv_ls_req_drop),
>                                 atomic_read(&tgtp->xmt_ls_abort));
>                 if (atomic_read(&tgtp->rcv_ls_req_in) !=
>                     atomic_read(&tgtp->rcv_ls_req_out)) {
> -                       len += snprintf(buf + len, size - len,
> +                       len += scnprintf(buf + len, size - len,
>                                         "Rcv LS: in %08x != out %08x\n",
>                                         atomic_read(&tgtp->rcv_ls_req_in),
>                                         atomic_read(&tgtp->rcv_ls_req_out));
>                 }
>
> -               len += snprintf(buf + len, size - len,
> +               len += scnprintf(buf + len, size - len,
>                                 "LS: Xmt %08x Drop %08x Cmpl %08x\n",
>                                 atomic_read(&tgtp->xmt_ls_rsp),
>                                 atomic_read(&tgtp->xmt_ls_drop),
>                                 atomic_read(&tgtp->xmt_ls_rsp_cmpl));
>
> -               len += snprintf(buf + len, size - len,
> +               len += scnprintf(buf + len, size - len,
>                                 "LS: RSP Abort %08x xb %08x Err %08x\n",
>                                 atomic_read(&tgtp->xmt_ls_rsp_aborted),
>                                 atomic_read(&tgtp->xmt_ls_rsp_xb_set),
>                                 atomic_read(&tgtp->xmt_ls_rsp_error));
>
> -               len += snprintf(buf + len, size - len,
> +               len += scnprintf(buf + len, size - len,
>                                 "FCP: Rcv %08x Defer %08x Release %08x "
>                                 "Drop %08x\n",
>                                 atomic_read(&tgtp->rcv_fcp_cmd_in),
> @@ -820,13 +820,13 @@ lpfc_debugfs_nvmestat_data(struct lpfc_vport *vport, char *buf, int size)
>
>                 if (atomic_read(&tgtp->rcv_fcp_cmd_in) !=
>                     atomic_read(&tgtp->rcv_fcp_cmd_out)) {
> -                       len += snprintf(buf + len, size - len,
> +                       len += scnprintf(buf + len, size - len,
>                                         "Rcv FCP: in %08x != out %08x\n",
>                                         atomic_read(&tgtp->rcv_fcp_cmd_in),
>                                         atomic_read(&tgtp->rcv_fcp_cmd_out));
>                 }
>
> -               len += snprintf(buf + len, size - len,
> +               len += scnprintf(buf + len, size - len,
>                                 "FCP Rsp: read %08x readrsp %08x "
>                                 "write %08x rsp %08x\n",
>                                 atomic_read(&tgtp->xmt_fcp_read),
> @@ -834,31 +834,31 @@ lpfc_debugfs_nvmestat_data(struct lpfc_vport *vport, char *buf, int size)
>                                 atomic_read(&tgtp->xmt_fcp_write),
>                                 atomic_read(&tgtp->xmt_fcp_rsp));
>
> -               len += snprintf(buf + len, size - len,
> +               len += scnprintf(buf + len, size - len,
>                                 "FCP Rsp Cmpl: %08x err %08x drop %08x\n",
>                                 atomic_read(&tgtp->xmt_fcp_rsp_cmpl),
>                                 atomic_read(&tgtp->xmt_fcp_rsp_error),
>                                 atomic_read(&tgtp->xmt_fcp_rsp_drop));
>
> -               len += snprintf(buf + len, size - len,
> +               len += scnprintf(buf + len, size - len,
>                                 "FCP Rsp Abort: %08x xb %08x xricqe  %08x\n",
>                                 atomic_read(&tgtp->xmt_fcp_rsp_aborted),
>                                 atomic_read(&tgtp->xmt_fcp_rsp_xb_set),
>                                 atomic_read(&tgtp->xmt_fcp_xri_abort_cqe));
>
> -               len += snprintf(buf + len, size - len,
> +               len += scnprintf(buf + len, size - len,
>                                 "ABORT: Xmt %08x Cmpl %08x\n",
>                                 atomic_read(&tgtp->xmt_fcp_abort),
>                                 atomic_read(&tgtp->xmt_fcp_abort_cmpl));
>
> -               len += snprintf(buf + len, size - len,
> +               len += scnprintf(buf + len, size - len,
>                                 "ABORT: Sol %08x  Usol %08x Err %08x Cmpl %08x",
>                                 atomic_read(&tgtp->xmt_abort_sol),
>                                 atomic_read(&tgtp->xmt_abort_unsol),
>                                 atomic_read(&tgtp->xmt_abort_rsp),
>                                 atomic_read(&tgtp->xmt_abort_rsp_error));
>
> -               len +=  snprintf(buf + len, size - len, "\n");
> +               len +=  scnprintf(buf + len, size - len, "\n");
>
>                 cnt = 0;
>                 spin_lock(&phba->sli4_hba.abts_nvme_buf_list_lock);
> @@ -869,7 +869,7 @@ lpfc_debugfs_nvmestat_data(struct lpfc_vport *vport, char *buf, int size)
>                 }
>                 spin_unlock(&phba->sli4_hba.abts_nvme_buf_list_lock);
>                 if (cnt) {
> -                       len += snprintf(buf + len, size - len,
> +                       len += scnprintf(buf + len, size - len,
>                                         "ABORT: %d ctx entries\n", cnt);
>                         spin_lock(&phba->sli4_hba.abts_nvme_buf_list_lock);
>                         list_for_each_entry_safe(ctxp, next_ctxp,
> @@ -877,7 +877,7 @@ lpfc_debugfs_nvmestat_data(struct lpfc_vport *vport, char *buf, int size)
>                                     list) {
>                                 if (len >= (size - LPFC_DEBUG_OUT_LINE_SZ))
>                                         break;
> -                               len += snprintf(buf + len, size - len,
> +                               len += scnprintf(buf + len, size - len,
>                                                 "Entry: oxid %x state %x "
>                                                 "flag %x\n",
>                                                 ctxp->oxid, ctxp->state,
> @@ -891,7 +891,7 @@ lpfc_debugfs_nvmestat_data(struct lpfc_vport *vport, char *buf, int size)
>                 tot += atomic_read(&tgtp->xmt_fcp_release);
>                 tot = atomic_read(&tgtp->rcv_fcp_cmd_in) - tot;
>
> -               len += snprintf(buf + len, size - len,
> +               len += scnprintf(buf + len, size - len,
>                                 "IO_CTX: %08x  WAIT: cur %08x tot %08x\n"
>                                 "CTX Outstanding %08llx\n",
>                                 phba->sli4_hba.nvmet_xri_cnt,
> @@ -909,10 +909,10 @@ lpfc_debugfs_nvmestat_data(struct lpfc_vport *vport, char *buf, int size)
>                 if (!lport)
>                         return len;
>
> -               len += snprintf(buf + len, size - len,
> +               len += scnprintf(buf + len, size - len,
>                                 "\nNVME Lport Statistics\n");
>
> -               len += snprintf(buf + len, size - len,
> +               len += scnprintf(buf + len, size - len,
>                                 "LS: Xmt %016x Cmpl %016x\n",
>                                 atomic_read(&lport->fc4NvmeLsRequests),
>                                 atomic_read(&lport->fc4NvmeLsCmpls));
> @@ -936,20 +936,20 @@ lpfc_debugfs_nvmestat_data(struct lpfc_vport *vport, char *buf, int size)
>                         if (i >= 32)
>                                 continue;
>
> -                       len += snprintf(buf + len, PAGE_SIZE - len,
> +                       len += scnprintf(buf + len, PAGE_SIZE - len,
>                                         "FCP (%d): Rd %016llx Wr %016llx "
>                                         "IO %016llx ",
>                                         i, data1, data2, data3);
> -                       len += snprintf(buf + len, PAGE_SIZE - len,
> +                       len += scnprintf(buf + len, PAGE_SIZE - len,
>                                         "Cmpl %016llx OutIO %016llx\n",
>                                         tot, ((data1 + data2 + data3) - tot));
>                 }
> -               len += snprintf(buf + len, PAGE_SIZE - len,
> +               len += scnprintf(buf + len, PAGE_SIZE - len,
>                                 "Total FCP Cmpl %016llx Issue %016llx "
>                                 "OutIO %016llx\n",
>                                 totin, totout, totout - totin);
>
> -               len += snprintf(buf + len, size - len,
> +               len += scnprintf(buf + len, size - len,
>                                 "LS Xmt Err: Abrt %08x Err %08x  "
>                                 "Cmpl Err: xb %08x Err %08x\n",
>                                 atomic_read(&lport->xmt_ls_abort),
> @@ -957,7 +957,7 @@ lpfc_debugfs_nvmestat_data(struct lpfc_vport *vport, char *buf, int size)
>                                 atomic_read(&lport->cmpl_ls_xb),
>                                 atomic_read(&lport->cmpl_ls_err));
>
> -               len += snprintf(buf + len, size - len,
> +               len += scnprintf(buf + len, size - len,
>                                 "FCP Xmt Err: noxri %06x nondlp %06x "
>                                 "qdepth %06x wqerr %06x err %06x Abrt %06x\n",
>                                 atomic_read(&lport->xmt_fcp_noxri),
> @@ -967,7 +967,7 @@ lpfc_debugfs_nvmestat_data(struct lpfc_vport *vport, char *buf, int size)
>                                 atomic_read(&lport->xmt_fcp_err),
>                                 atomic_read(&lport->xmt_fcp_abort));
>
> -               len += snprintf(buf + len, size - len,
> +               len += scnprintf(buf + len, size - len,
>                                 "FCP Cmpl Err: xb %08x Err %08x\n",
>                                 atomic_read(&lport->cmpl_fcp_xb),
>                                 atomic_read(&lport->cmpl_fcp_err));
> @@ -999,58 +999,58 @@ lpfc_debugfs_nvmektime_data(struct lpfc_vport *vport, char *buf, int size)
>
>         if (phba->nvmet_support == 0) {
>                 /* NVME Initiator */
> -               len += snprintf(buf + len, PAGE_SIZE - len,
> +               len += scnprintf(buf + len, PAGE_SIZE - len,
>                                 "ktime %s: Total Samples: %lld\n",
>                                 (phba->ktime_on ?  "Enabled" : "Disabled"),
>                                 phba->ktime_data_samples);
>                 if (phba->ktime_data_samples == 0)
>                         return len;
>
> -               len += snprintf(
> +               len += scnprintf(
>                         buf + len, PAGE_SIZE - len,
>                         "Segment 1: Last NVME Cmd cmpl "
>                         "done -to- Start of next NVME cnd (in driver)\n");
> -               len += snprintf(
> +               len += scnprintf(
>                         buf + len, PAGE_SIZE - len,
>                         "avg:%08lld min:%08lld max %08lld\n",
>                         div_u64(phba->ktime_seg1_total,
>                                 phba->ktime_data_samples),
>                         phba->ktime_seg1_min,
>                         phba->ktime_seg1_max);
> -               len += snprintf(
> +               len += scnprintf(
>                         buf + len, PAGE_SIZE - len,
>                         "Segment 2: Driver start of NVME cmd "
>                         "-to- Firmware WQ doorbell\n");
> -               len += snprintf(
> +               len += scnprintf(
>                         buf + len, PAGE_SIZE - len,
>                         "avg:%08lld min:%08lld max %08lld\n",
>                         div_u64(phba->ktime_seg2_total,
>                                 phba->ktime_data_samples),
>                         phba->ktime_seg2_min,
>                         phba->ktime_seg2_max);
> -               len += snprintf(
> +               len += scnprintf(
>                         buf + len, PAGE_SIZE - len,
>                         "Segment 3: Firmware WQ doorbell -to- "
>                         "MSI-X ISR cmpl\n");
> -               len += snprintf(
> +               len += scnprintf(
>                         buf + len, PAGE_SIZE - len,
>                         "avg:%08lld min:%08lld max %08lld\n",
>                         div_u64(phba->ktime_seg3_total,
>                                 phba->ktime_data_samples),
>                         phba->ktime_seg3_min,
>                         phba->ktime_seg3_max);
> -               len += snprintf(
> +               len += scnprintf(
>                         buf + len, PAGE_SIZE - len,
>                         "Segment 4: MSI-X ISR cmpl -to- "
>                         "NVME cmpl done\n");
> -               len += snprintf(
> +               len += scnprintf(
>                         buf + len, PAGE_SIZE - len,
>                         "avg:%08lld min:%08lld max %08lld\n",
>                         div_u64(phba->ktime_seg4_total,
>                                 phba->ktime_data_samples),
>                         phba->ktime_seg4_min,
>                         phba->ktime_seg4_max);
> -               len += snprintf(
> +               len += scnprintf(
>                         buf + len, PAGE_SIZE - len,
>                         "Total IO avg time: %08lld\n",
>                         div_u64(phba->ktime_seg1_total +
> @@ -1062,7 +1062,7 @@ lpfc_debugfs_nvmektime_data(struct lpfc_vport *vport, char *buf, int size)
>         }
>
>         /* NVME Target */
> -       len += snprintf(buf + len, PAGE_SIZE-len,
> +       len += scnprintf(buf + len, PAGE_SIZE-len,
>                         "ktime %s: Total Samples: %lld %lld\n",
>                         (phba->ktime_on ? "Enabled" : "Disabled"),
>                         phba->ktime_data_samples,
> @@ -1070,46 +1070,46 @@ lpfc_debugfs_nvmektime_data(struct lpfc_vport *vport, char *buf, int size)
>         if (phba->ktime_data_samples == 0)
>                 return len;
>
> -       len += snprintf(buf + len, PAGE_SIZE-len,
> +       len += scnprintf(buf + len, PAGE_SIZE-len,
>                         "Segment 1: MSI-X ISR Rcv cmd -to- "
>                         "cmd pass to NVME Layer\n");
> -       len += snprintf(buf + len, PAGE_SIZE-len,
> +       len += scnprintf(buf + len, PAGE_SIZE-len,
>                         "avg:%08lld min:%08lld max %08lld\n",
>                         div_u64(phba->ktime_seg1_total,
>                                 phba->ktime_data_samples),
>                         phba->ktime_seg1_min,
>                         phba->ktime_seg1_max);
> -       len += snprintf(buf + len, PAGE_SIZE-len,
> +       len += scnprintf(buf + len, PAGE_SIZE-len,
>                         "Segment 2: cmd pass to NVME Layer- "
>                         "-to- Driver rcv cmd OP (action)\n");
> -       len += snprintf(buf + len, PAGE_SIZE-len,
> +       len += scnprintf(buf + len, PAGE_SIZE-len,
>                         "avg:%08lld min:%08lld max %08lld\n",
>                         div_u64(phba->ktime_seg2_total,
>                                 phba->ktime_data_samples),
>                         phba->ktime_seg2_min,
>                         phba->ktime_seg2_max);
> -       len += snprintf(buf + len, PAGE_SIZE-len,
> +       len += scnprintf(buf + len, PAGE_SIZE-len,
>                         "Segment 3: Driver rcv cmd OP -to- "
>                         "Firmware WQ doorbell: cmd\n");
> -       len += snprintf(buf + len, PAGE_SIZE-len,
> +       len += scnprintf(buf + len, PAGE_SIZE-len,
>                         "avg:%08lld min:%08lld max %08lld\n",
>                         div_u64(phba->ktime_seg3_total,
>                                 phba->ktime_data_samples),
>                         phba->ktime_seg3_min,
>                         phba->ktime_seg3_max);
> -       len += snprintf(buf + len, PAGE_SIZE-len,
> +       len += scnprintf(buf + len, PAGE_SIZE-len,
>                         "Segment 4: Firmware WQ doorbell: cmd "
>                         "-to- MSI-X ISR for cmd cmpl\n");
> -       len += snprintf(buf + len, PAGE_SIZE-len,
> +       len += scnprintf(buf + len, PAGE_SIZE-len,
>                         "avg:%08lld min:%08lld max %08lld\n",
>                         div_u64(phba->ktime_seg4_total,
>                                 phba->ktime_data_samples),
>                         phba->ktime_seg4_min,
>                         phba->ktime_seg4_max);
> -       len += snprintf(buf + len, PAGE_SIZE-len,
> +       len += scnprintf(buf + len, PAGE_SIZE-len,
>                         "Segment 5: MSI-X ISR for cmd cmpl "
>                         "-to- NVME layer passed cmd done\n");
> -       len += snprintf(buf + len, PAGE_SIZE-len,
> +       len += scnprintf(buf + len, PAGE_SIZE-len,
>                         "avg:%08lld min:%08lld max %08lld\n",
>                         div_u64(phba->ktime_seg5_total,
>                                 phba->ktime_data_samples),
> @@ -1117,10 +1117,10 @@ lpfc_debugfs_nvmektime_data(struct lpfc_vport *vport, char *buf, int size)
>                         phba->ktime_seg5_max);
>
>         if (phba->ktime_status_samples == 0) {
> -               len += snprintf(buf + len, PAGE_SIZE-len,
> +               len += scnprintf(buf + len, PAGE_SIZE-len,
>                                 "Total: cmd received by MSI-X ISR "
>                                 "-to- cmd completed on wire\n");
> -               len += snprintf(buf + len, PAGE_SIZE-len,
> +               len += scnprintf(buf + len, PAGE_SIZE-len,
>                                 "avg:%08lld min:%08lld "
>                                 "max %08lld\n",
>                                 div_u64(phba->ktime_seg10_total,
> @@ -1130,46 +1130,46 @@ lpfc_debugfs_nvmektime_data(struct lpfc_vport *vport, char *buf, int size)
>                 return len;
>         }
>
> -       len += snprintf(buf + len, PAGE_SIZE-len,
> +       len += scnprintf(buf + len, PAGE_SIZE-len,
>                         "Segment 6: NVME layer passed cmd done "
>                         "-to- Driver rcv rsp status OP\n");
> -       len += snprintf(buf + len, PAGE_SIZE-len,
> +       len += scnprintf(buf + len, PAGE_SIZE-len,
>                         "avg:%08lld min:%08lld max %08lld\n",
>                         div_u64(phba->ktime_seg6_total,
>                                 phba->ktime_status_samples),
>                         phba->ktime_seg6_min,
>                         phba->ktime_seg6_max);
> -       len += snprintf(buf + len, PAGE_SIZE-len,
> +       len += scnprintf(buf + len, PAGE_SIZE-len,
>                         "Segment 7: Driver rcv rsp status OP "
>                         "-to- Firmware WQ doorbell: status\n");
> -       len += snprintf(buf + len, PAGE_SIZE-len,
> +       len += scnprintf(buf + len, PAGE_SIZE-len,
>                         "avg:%08lld min:%08lld max %08lld\n",
>                         div_u64(phba->ktime_seg7_total,
>                                 phba->ktime_status_samples),
>                         phba->ktime_seg7_min,
>                         phba->ktime_seg7_max);
> -       len += snprintf(buf + len, PAGE_SIZE-len,
> +       len += scnprintf(buf + len, PAGE_SIZE-len,
>                         "Segment 8: Firmware WQ doorbell: status"
>                         " -to- MSI-X ISR for status cmpl\n");
> -       len += snprintf(buf + len, PAGE_SIZE-len,
> +       len += scnprintf(buf + len, PAGE_SIZE-len,
>                         "avg:%08lld min:%08lld max %08lld\n",
>                         div_u64(phba->ktime_seg8_total,
>                                 phba->ktime_status_samples),
>                         phba->ktime_seg8_min,
>                         phba->ktime_seg8_max);
> -       len += snprintf(buf + len, PAGE_SIZE-len,
> +       len += scnprintf(buf + len, PAGE_SIZE-len,
>                         "Segment 9: MSI-X ISR for status cmpl  "
>                         "-to- NVME layer passed status done\n");
> -       len += snprintf(buf + len, PAGE_SIZE-len,
> +       len += scnprintf(buf + len, PAGE_SIZE-len,
>                         "avg:%08lld min:%08lld max %08lld\n",
>                         div_u64(phba->ktime_seg9_total,
>                                 phba->ktime_status_samples),
>                         phba->ktime_seg9_min,
>                         phba->ktime_seg9_max);
> -       len += snprintf(buf + len, PAGE_SIZE-len,
> +       len += scnprintf(buf + len, PAGE_SIZE-len,
>                         "Total: cmd received by MSI-X ISR -to- "
>                         "cmd completed on wire\n");
> -       len += snprintf(buf + len, PAGE_SIZE-len,
> +       len += scnprintf(buf + len, PAGE_SIZE-len,
>                         "avg:%08lld min:%08lld max %08lld\n",
>                         div_u64(phba->ktime_seg10_total,
>                                 phba->ktime_status_samples),
> @@ -1204,7 +1204,7 @@ lpfc_debugfs_nvmeio_trc_data(struct lpfc_hba *phba, char *buf, int size)
>                 (phba->nvmeio_trc_size - 1);
>         skip = phba->nvmeio_trc_output_idx;
>
> -       len += snprintf(buf + len, size - len,
> +       len += scnprintf(buf + len, size - len,
>                         "%s IO Trace %s: next_idx %d skip %d size %d\n",
>                         (phba->nvmet_support ? "NVME" : "NVMET"),
>                         (state ? "Enabled" : "Disabled"),
> @@ -1226,18 +1226,18 @@ lpfc_debugfs_nvmeio_trc_data(struct lpfc_hba *phba, char *buf, int size)
>                 if (!dtp->fmt)
>                         continue;
>
> -               len +=  snprintf(buf + len, size - len, dtp->fmt,
> +               len +=  scnprintf(buf + len, size - len, dtp->fmt,
>                         dtp->data1, dtp->data2, dtp->data3);
>
>                 if (phba->nvmeio_trc_output_idx >= phba->nvmeio_trc_size) {
>                         phba->nvmeio_trc_output_idx = 0;
> -                       len += snprintf(buf + len, size - len,
> +                       len += scnprintf(buf + len, size - len,
>                                         "Trace Complete\n");
>                         goto out;
>                 }
>
>                 if (len >= (size - LPFC_DEBUG_OUT_LINE_SZ)) {
> -                       len += snprintf(buf + len, size - len,
> +                       len += scnprintf(buf + len, size - len,
>                                         "Trace Continue (%d of %d)\n",
>                                         phba->nvmeio_trc_output_idx,
>                                         phba->nvmeio_trc_size);
> @@ -1255,18 +1255,18 @@ lpfc_debugfs_nvmeio_trc_data(struct lpfc_hba *phba, char *buf, int size)
>                 if (!dtp->fmt)
>                         continue;
>
> -               len +=  snprintf(buf + len, size - len, dtp->fmt,
> +               len +=  scnprintf(buf + len, size - len, dtp->fmt,
>                         dtp->data1, dtp->data2, dtp->data3);
>
>                 if (phba->nvmeio_trc_output_idx >= phba->nvmeio_trc_size) {
>                         phba->nvmeio_trc_output_idx = 0;
> -                       len += snprintf(buf + len, size - len,
> +                       len += scnprintf(buf + len, size - len,
>                                         "Trace Complete\n");
>                         goto out;
>                 }
>
>                 if (len >= (size - LPFC_DEBUG_OUT_LINE_SZ)) {
> -                       len += snprintf(buf + len, size - len,
> +                       len += scnprintf(buf + len, size - len,
>                                         "Trace Continue (%d of %d)\n",
>                                         phba->nvmeio_trc_output_idx,
>                                         phba->nvmeio_trc_size);
> @@ -1274,7 +1274,7 @@ lpfc_debugfs_nvmeio_trc_data(struct lpfc_hba *phba, char *buf, int size)
>                 }
>         }
>
> -       len += snprintf(buf + len, size - len,
> +       len += scnprintf(buf + len, size - len,
>                         "Trace Done\n");
>  out:
>         return len;
> @@ -1306,39 +1306,39 @@ lpfc_debugfs_cpucheck_data(struct lpfc_vport *vport, char *buf, int size)
>
>         if (phba->nvmet_support == 0) {
>                 /* NVME Initiator */
> -               len += snprintf(buf + len, PAGE_SIZE - len,
> +               len += scnprintf(buf + len, PAGE_SIZE - len,
>                                 "CPUcheck %s\n",
>                                 (phba->cpucheck_on & LPFC_CHECK_NVME_IO ?
>                                         "Enabled" : "Disabled"));
>                 for (i = 0; i < phba->sli4_hba.num_present_cpu; i++) {
>                         if (i >= LPFC_CHECK_CPU_CNT)
>                                 break;
> -                       len += snprintf(buf + len, PAGE_SIZE - len,
> +                       len += scnprintf(buf + len, PAGE_SIZE - len,
>                                         "%02d: xmit x%08x cmpl x%08x\n",
>                                         i, phba->cpucheck_xmt_io[i],
>                                         phba->cpucheck_cmpl_io[i]);
>                         tot_xmt += phba->cpucheck_xmt_io[i];
>                         tot_cmpl += phba->cpucheck_cmpl_io[i];
>                 }
> -               len += snprintf(buf + len, PAGE_SIZE - len,
> +               len += scnprintf(buf + len, PAGE_SIZE - len,
>                                 "tot:xmit x%08x cmpl x%08x\n",
>                                 tot_xmt, tot_cmpl);
>                 return len;
>         }
>
>         /* NVME Target */
> -       len += snprintf(buf + len, PAGE_SIZE - len,
> +       len += scnprintf(buf + len, PAGE_SIZE - len,
>                         "CPUcheck %s ",
>                         (phba->cpucheck_on & LPFC_CHECK_NVMET_IO ?
>                                 "IO Enabled - " : "IO Disabled - "));
> -       len += snprintf(buf + len, PAGE_SIZE - len,
> +       len += scnprintf(buf + len, PAGE_SIZE - len,
>                         "%s\n",
>                         (phba->cpucheck_on & LPFC_CHECK_NVMET_RCV ?
>                                 "Rcv Enabled\n" : "Rcv Disabled\n"));
>         for (i = 0; i < phba->sli4_hba.num_present_cpu; i++) {
>                 if (i >= LPFC_CHECK_CPU_CNT)
>                         break;
> -               len += snprintf(buf + len, PAGE_SIZE - len,
> +               len += scnprintf(buf + len, PAGE_SIZE - len,
>                                 "%02d: xmit x%08x ccmpl x%08x "
>                                 "cmpl x%08x rcv x%08x\n",
>                                 i, phba->cpucheck_xmt_io[i],
> @@ -1350,7 +1350,7 @@ lpfc_debugfs_cpucheck_data(struct lpfc_vport *vport, char *buf, int size)
>                 tot_cmpl += phba->cpucheck_cmpl_io[i];
>                 tot_ccmpl += phba->cpucheck_ccmpl_io[i];
>         }
> -       len += snprintf(buf + len, PAGE_SIZE - len,
> +       len += scnprintf(buf + len, PAGE_SIZE - len,
>                         "tot:xmit x%08x ccmpl x%08x cmpl x%08x rcv x%08x\n",
>                         tot_xmt, tot_ccmpl, tot_cmpl, tot_rcv);
>         return len;
> @@ -1795,28 +1795,28 @@ lpfc_debugfs_dif_err_read(struct file *file, char __user *buf,
>         int cnt = 0;
>
>         if (dent == phba->debug_writeGuard)
> -               cnt = snprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_wgrd_cnt);
> +               cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_wgrd_cnt);
>         else if (dent == phba->debug_writeApp)
> -               cnt = snprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_wapp_cnt);
> +               cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_wapp_cnt);
>         else if (dent == phba->debug_writeRef)
> -               cnt = snprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_wref_cnt);
> +               cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_wref_cnt);
>         else if (dent == phba->debug_readGuard)
> -               cnt = snprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_rgrd_cnt);
> +               cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_rgrd_cnt);
>         else if (dent == phba->debug_readApp)
> -               cnt = snprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_rapp_cnt);
> +               cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_rapp_cnt);
>         else if (dent == phba->debug_readRef)
> -               cnt = snprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_rref_cnt);
> +               cnt = scnprintf(cbuf, 32, "%u\n", phba->lpfc_injerr_rref_cnt);
>         else if (dent == phba->debug_InjErrNPortID)
> -               cnt = snprintf(cbuf, 32, "0x%06x\n", phba->lpfc_injerr_nportid);
> +               cnt = scnprintf(cbuf, 32, "0x%06x\n", phba->lpfc_injerr_nportid);
>         else if (dent == phba->debug_InjErrWWPN) {
>                 memcpy(&tmp, &phba->lpfc_injerr_wwpn, sizeof(struct lpfc_name));
>                 tmp = cpu_to_be64(tmp);
> -               cnt = snprintf(cbuf, 32, "0x%016llx\n", tmp);
> +               cnt = scnprintf(cbuf, 32, "0x%016llx\n", tmp);
>         } else if (dent == phba->debug_InjErrLBA) {
>                 if (phba->lpfc_injerr_lba == (sector_t)(-1))
> -                       cnt = snprintf(cbuf, 32, "off\n");
> +                       cnt = scnprintf(cbuf, 32, "off\n");
>                 else
> -                       cnt = snprintf(cbuf, 32, "0x%llx\n",
> +                       cnt = scnprintf(cbuf, 32, "0x%llx\n",
>                                  (uint64_t) phba->lpfc_injerr_lba);
>         } else
>                 lpfc_printf_log(phba, KERN_ERR, LOG_INIT,
> @@ -2622,17 +2622,17 @@ lpfc_idiag_pcicfg_read(struct file *file, char __user *buf, size_t nbytes,
>         switch (count) {
>         case SIZE_U8: /* byte (8 bits) */
>                 pci_read_config_byte(pdev, where, &u8val);
> -               len += snprintf(pbuffer+len, LPFC_PCI_CFG_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_PCI_CFG_SIZE-len,
>                                 "%03x: %02x\n", where, u8val);
>                 break;
>         case SIZE_U16: /* word (16 bits) */
>                 pci_read_config_word(pdev, where, &u16val);
> -               len += snprintf(pbuffer+len, LPFC_PCI_CFG_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_PCI_CFG_SIZE-len,
>                                 "%03x: %04x\n", where, u16val);
>                 break;
>         case SIZE_U32: /* double word (32 bits) */
>                 pci_read_config_dword(pdev, where, &u32val);
> -               len += snprintf(pbuffer+len, LPFC_PCI_CFG_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_PCI_CFG_SIZE-len,
>                                 "%03x: %08x\n", where, u32val);
>                 break;
>         case LPFC_PCI_CFG_BROWSE: /* browse all */
> @@ -2652,25 +2652,25 @@ lpfc_idiag_pcicfg_read(struct file *file, char __user *buf, size_t nbytes,
>         offset = offset_label;
>
>         /* Read PCI config space */
> -       len += snprintf(pbuffer+len, LPFC_PCI_CFG_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_PCI_CFG_SIZE-len,
>                         "%03x: ", offset_label);
>         while (index > 0) {
>                 pci_read_config_dword(pdev, offset, &u32val);
> -               len += snprintf(pbuffer+len, LPFC_PCI_CFG_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_PCI_CFG_SIZE-len,
>                                 "%08x ", u32val);
>                 offset += sizeof(uint32_t);
>                 if (offset >= LPFC_PCI_CFG_SIZE) {
> -                       len += snprintf(pbuffer+len,
> +                       len += scnprintf(pbuffer+len,
>                                         LPFC_PCI_CFG_SIZE-len, "\n");
>                         break;
>                 }
>                 index -= sizeof(uint32_t);
>                 if (!index)
> -                       len += snprintf(pbuffer+len, LPFC_PCI_CFG_SIZE-len,
> +                       len += scnprintf(pbuffer+len, LPFC_PCI_CFG_SIZE-len,
>                                         "\n");
>                 else if (!(index % (8 * sizeof(uint32_t)))) {
>                         offset_label += (8 * sizeof(uint32_t));
> -                       len += snprintf(pbuffer+len, LPFC_PCI_CFG_SIZE-len,
> +                       len += scnprintf(pbuffer+len, LPFC_PCI_CFG_SIZE-len,
>                                         "\n%03x: ", offset_label);
>                 }
>         }
> @@ -2941,7 +2941,7 @@ lpfc_idiag_baracc_read(struct file *file, char __user *buf, size_t nbytes,
>         if (acc_range == SINGLE_WORD) {
>                 offset_run = offset;
>                 u32val = readl(mem_mapped_bar + offset_run);
> -               len += snprintf(pbuffer+len, LPFC_PCI_BAR_RD_BUF_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_PCI_BAR_RD_BUF_SIZE-len,
>                                 "%05x: %08x\n", offset_run, u32val);
>         } else
>                 goto baracc_browse;
> @@ -2955,35 +2955,35 @@ lpfc_idiag_baracc_read(struct file *file, char __user *buf, size_t nbytes,
>         offset_run = offset_label;
>
>         /* Read PCI bar memory mapped space */
> -       len += snprintf(pbuffer+len, LPFC_PCI_BAR_RD_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_PCI_BAR_RD_BUF_SIZE-len,
>                         "%05x: ", offset_label);
>         index = LPFC_PCI_BAR_RD_SIZE;
>         while (index > 0) {
>                 u32val = readl(mem_mapped_bar + offset_run);
> -               len += snprintf(pbuffer+len, LPFC_PCI_BAR_RD_BUF_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_PCI_BAR_RD_BUF_SIZE-len,
>                                 "%08x ", u32val);
>                 offset_run += sizeof(uint32_t);
>                 if (acc_range == LPFC_PCI_BAR_BROWSE) {
>                         if (offset_run >= bar_size) {
> -                               len += snprintf(pbuffer+len,
> +                               len += scnprintf(pbuffer+len,
>                                         LPFC_PCI_BAR_RD_BUF_SIZE-len, "\n");
>                                 break;
>                         }
>                 } else {
>                         if (offset_run >= offset +
>                             (acc_range * sizeof(uint32_t))) {
> -                               len += snprintf(pbuffer+len,
> +                               len += scnprintf(pbuffer+len,
>                                         LPFC_PCI_BAR_RD_BUF_SIZE-len, "\n");
>                                 break;
>                         }
>                 }
>                 index -= sizeof(uint32_t);
>                 if (!index)
> -                       len += snprintf(pbuffer+len,
> +                       len += scnprintf(pbuffer+len,
>                                         LPFC_PCI_BAR_RD_BUF_SIZE-len, "\n");
>                 else if (!(index % (8 * sizeof(uint32_t)))) {
>                         offset_label += (8 * sizeof(uint32_t));
> -                       len += snprintf(pbuffer+len,
> +                       len += scnprintf(pbuffer+len,
>                                         LPFC_PCI_BAR_RD_BUF_SIZE-len,
>                                         "\n%05x: ", offset_label);
>                 }
> @@ -3156,19 +3156,19 @@ __lpfc_idiag_print_wq(struct lpfc_queue *qp, char *wqtype,
>         if (!qp)
>                 return len;
>
> -       len += snprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
> +       len += scnprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
>                         "\t\t%s WQ info: ", wqtype);
> -       len += snprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
> +       len += scnprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
>                         "AssocCQID[%04d]: WQ-STAT[oflow:x%x posted:x%llx]\n",
>                         qp->assoc_qid, qp->q_cnt_1,
>                         (unsigned long long)qp->q_cnt_4);
> -       len += snprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
> +       len += scnprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
>                         "\t\tWQID[%02d], QE-CNT[%04d], QE-SZ[%04d], "
>                         "HST-IDX[%04d], PRT-IDX[%04d], PST[%03d]",
>                         qp->queue_id, qp->entry_count,
>                         qp->entry_size, qp->host_index,
>                         qp->hba_index, qp->entry_repost);
> -       len +=  snprintf(pbuffer + len,
> +       len +=  scnprintf(pbuffer + len,
>                         LPFC_QUE_INFO_GET_BUF_SIZE - len, "\n");
>         return len;
>  }
> @@ -3206,21 +3206,21 @@ __lpfc_idiag_print_cq(struct lpfc_queue *qp, char *cqtype,
>         if (!qp)
>                 return len;
>
> -       len += snprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
> +       len += scnprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
>                         "\t%s CQ info: ", cqtype);
> -       len += snprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
> +       len += scnprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
>                         "AssocEQID[%02d]: CQ STAT[max:x%x relw:x%x "
>                         "xabt:x%x wq:x%llx]\n",
>                         qp->assoc_qid, qp->q_cnt_1, qp->q_cnt_2,
>                         qp->q_cnt_3, (unsigned long long)qp->q_cnt_4);
> -       len += snprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
> +       len += scnprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
>                         "\tCQID[%02d], QE-CNT[%04d], QE-SZ[%04d], "
>                         "HST-IDX[%04d], PRT-IDX[%04d], PST[%03d]",
>                         qp->queue_id, qp->entry_count,
>                         qp->entry_size, qp->host_index,
>                         qp->hba_index, qp->entry_repost);
>
> -       len +=  snprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len, "\n");
> +       len +=  scnprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len, "\n");
>
>         return len;
>  }
> @@ -3232,19 +3232,19 @@ __lpfc_idiag_print_rqpair(struct lpfc_queue *qp, struct lpfc_queue *datqp,
>         if (!qp || !datqp)
>                 return len;
>
> -       len += snprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
> +       len += scnprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
>                         "\t\t%s RQ info: ", rqtype);
> -       len += snprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
> +       len += scnprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
>                         "AssocCQID[%02d]: RQ-STAT[nopost:x%x nobuf:x%x "
>                         "posted:x%x rcv:x%llx]\n",
>                         qp->assoc_qid, qp->q_cnt_1, qp->q_cnt_2,
>                         qp->q_cnt_3, (unsigned long long)qp->q_cnt_4);
> -       len += snprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
> +       len += scnprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
>                         "\t\tHQID[%02d], QE-CNT[%04d], QE-SZ[%04d], "
>                         "HST-IDX[%04d], PRT-IDX[%04d], PST[%03d]\n",
>                         qp->queue_id, qp->entry_count, qp->entry_size,
>                         qp->host_index, qp->hba_index, qp->entry_repost);
> -       len += snprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
> +       len += scnprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
>                         "\t\tDQID[%02d], QE-CNT[%04d], QE-SZ[%04d], "
>                         "HST-IDX[%04d], PRT-IDX[%04d], PST[%03d]\n",
>                         datqp->queue_id, datqp->entry_count,
> @@ -3329,17 +3329,17 @@ __lpfc_idiag_print_eq(struct lpfc_queue *qp, char *eqtype,
>         if (!qp)
>                 return len;
>
> -       len += snprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
> +       len += scnprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
>                         "\n%s EQ info: EQ-STAT[max:x%x noE:x%x "
>                         "cqe_proc:x%x eqe_proc:x%llx eqd %d]\n",
>                         eqtype, qp->q_cnt_1, qp->q_cnt_2, qp->q_cnt_3,
>                         (unsigned long long)qp->q_cnt_4, qp->q_mode);
> -       len += snprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
> +       len += scnprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
>                         "EQID[%02d], QE-CNT[%04d], QE-SZ[%04d], "
>                         "HST-IDX[%04d], PRT-IDX[%04d], PST[%03d]",
>                         qp->queue_id, qp->entry_count, qp->entry_size,
>                         qp->host_index, qp->hba_index, qp->entry_repost);
> -       len +=  snprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len, "\n");
> +       len +=  scnprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len, "\n");
>
>         return len;
>  }
> @@ -3397,7 +3397,7 @@ lpfc_idiag_queinfo_read(struct file *file, char __user *buf, size_t nbytes,
>                         if (phba->cfg_fof == 0)
>                                 phba->lpfc_idiag_last_eq = 0;
>
> -               len += snprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
> +               len += scnprintf(pbuffer + len, LPFC_QUE_INFO_GET_BUF_SIZE - len,
>                                         "EQ %d out of %d HBA EQs\n",
>                                         x, phba->io_channel_irqs);
>
> @@ -3510,7 +3510,7 @@ lpfc_idiag_queinfo_read(struct file *file, char __user *buf, size_t nbytes,
>         return simple_read_from_buffer(buf, nbytes, ppos, pbuffer, len);
>
>  too_big:
> -       len +=  snprintf(pbuffer + len,
> +       len +=  scnprintf(pbuffer + len,
>                 LPFC_QUE_INFO_GET_BUF_SIZE - len, "Truncated ...\n");
>  out:
>         spin_unlock_irq(&phba->hbalock);
> @@ -3566,22 +3566,22 @@ lpfc_idiag_queacc_read_qe(char *pbuffer, int len, struct lpfc_queue *pque,
>                 return 0;
>
>         esize = pque->entry_size;
> -       len += snprintf(pbuffer+len, LPFC_QUE_ACC_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_QUE_ACC_BUF_SIZE-len,
>                         "QE-INDEX[%04d]:\n", index);
>
>         offset = 0;
>         pentry = pque->qe[index].address;
>         while (esize > 0) {
> -               len += snprintf(pbuffer+len, LPFC_QUE_ACC_BUF_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_QUE_ACC_BUF_SIZE-len,
>                                 "%08x ", *pentry);
>                 pentry++;
>                 offset += sizeof(uint32_t);
>                 esize -= sizeof(uint32_t);
>                 if (esize > 0 && !(offset % (4 * sizeof(uint32_t))))
> -                       len += snprintf(pbuffer+len,
> +                       len += scnprintf(pbuffer+len,
>                                         LPFC_QUE_ACC_BUF_SIZE-len, "\n");
>         }
> -       len += snprintf(pbuffer+len, LPFC_QUE_ACC_BUF_SIZE-len, "\n");
> +       len += scnprintf(pbuffer+len, LPFC_QUE_ACC_BUF_SIZE-len, "\n");
>
>         return len;
>  }
> @@ -3987,27 +3987,27 @@ lpfc_idiag_drbacc_read_reg(struct lpfc_hba *phba, char *pbuffer,
>
>         switch (drbregid) {
>         case LPFC_DRB_EQ:
> -               len += snprintf(pbuffer + len, LPFC_DRB_ACC_BUF_SIZE-len,
> +               len += scnprintf(pbuffer + len, LPFC_DRB_ACC_BUF_SIZE-len,
>                                 "EQ-DRB-REG: 0x%08x\n",
>                                 readl(phba->sli4_hba.EQDBregaddr));
>                 break;
>         case LPFC_DRB_CQ:
> -               len += snprintf(pbuffer + len, LPFC_DRB_ACC_BUF_SIZE - len,
> +               len += scnprintf(pbuffer + len, LPFC_DRB_ACC_BUF_SIZE - len,
>                                 "CQ-DRB-REG: 0x%08x\n",
>                                 readl(phba->sli4_hba.CQDBregaddr));
>                 break;
>         case LPFC_DRB_MQ:
> -               len += snprintf(pbuffer+len, LPFC_DRB_ACC_BUF_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_DRB_ACC_BUF_SIZE-len,
>                                 "MQ-DRB-REG:   0x%08x\n",
>                                 readl(phba->sli4_hba.MQDBregaddr));
>                 break;
>         case LPFC_DRB_WQ:
> -               len += snprintf(pbuffer+len, LPFC_DRB_ACC_BUF_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_DRB_ACC_BUF_SIZE-len,
>                                 "WQ-DRB-REG:   0x%08x\n",
>                                 readl(phba->sli4_hba.WQDBregaddr));
>                 break;
>         case LPFC_DRB_RQ:
> -               len += snprintf(pbuffer+len, LPFC_DRB_ACC_BUF_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_DRB_ACC_BUF_SIZE-len,
>                                 "RQ-DRB-REG:   0x%08x\n",
>                                 readl(phba->sli4_hba.RQDBregaddr));
>                 break;
> @@ -4197,37 +4197,37 @@ lpfc_idiag_ctlacc_read_reg(struct lpfc_hba *phba, char *pbuffer,
>
>         switch (ctlregid) {
>         case LPFC_CTL_PORT_SEM:
> -               len += snprintf(pbuffer+len, LPFC_CTL_ACC_BUF_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_CTL_ACC_BUF_SIZE-len,
>                                 "Port SemReg:   0x%08x\n",
>                                 readl(phba->sli4_hba.conf_regs_memmap_p +
>                                       LPFC_CTL_PORT_SEM_OFFSET));
>                 break;
>         case LPFC_CTL_PORT_STA:
> -               len += snprintf(pbuffer+len, LPFC_CTL_ACC_BUF_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_CTL_ACC_BUF_SIZE-len,
>                                 "Port StaReg:   0x%08x\n",
>                                 readl(phba->sli4_hba.conf_regs_memmap_p +
>                                       LPFC_CTL_PORT_STA_OFFSET));
>                 break;
>         case LPFC_CTL_PORT_CTL:
> -               len += snprintf(pbuffer+len, LPFC_CTL_ACC_BUF_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_CTL_ACC_BUF_SIZE-len,
>                                 "Port CtlReg:   0x%08x\n",
>                                 readl(phba->sli4_hba.conf_regs_memmap_p +
>                                       LPFC_CTL_PORT_CTL_OFFSET));
>                 break;
>         case LPFC_CTL_PORT_ER1:
> -               len += snprintf(pbuffer+len, LPFC_CTL_ACC_BUF_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_CTL_ACC_BUF_SIZE-len,
>                                 "Port Er1Reg:   0x%08x\n",
>                                 readl(phba->sli4_hba.conf_regs_memmap_p +
>                                       LPFC_CTL_PORT_ER1_OFFSET));
>                 break;
>         case LPFC_CTL_PORT_ER2:
> -               len += snprintf(pbuffer+len, LPFC_CTL_ACC_BUF_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_CTL_ACC_BUF_SIZE-len,
>                                 "Port Er2Reg:   0x%08x\n",
>                                 readl(phba->sli4_hba.conf_regs_memmap_p +
>                                       LPFC_CTL_PORT_ER2_OFFSET));
>                 break;
>         case LPFC_CTL_PDEV_CTL:
> -               len += snprintf(pbuffer+len, LPFC_CTL_ACC_BUF_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_CTL_ACC_BUF_SIZE-len,
>                                 "PDev CtlReg:   0x%08x\n",
>                                 readl(phba->sli4_hba.conf_regs_memmap_p +
>                                       LPFC_CTL_PDEV_CTL_OFFSET));
> @@ -4420,13 +4420,13 @@ lpfc_idiag_mbxacc_get_setup(struct lpfc_hba *phba, char *pbuffer)
>         mbx_dump_cnt = idiag.cmd.data[IDIAG_MBXACC_DPCNT_INDX];
>         mbx_word_cnt = idiag.cmd.data[IDIAG_MBXACC_WDCNT_INDX];
>
> -       len += snprintf(pbuffer+len, LPFC_MBX_ACC_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_MBX_ACC_BUF_SIZE-len,
>                         "mbx_dump_map: 0x%08x\n", mbx_dump_map);
> -       len += snprintf(pbuffer+len, LPFC_MBX_ACC_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_MBX_ACC_BUF_SIZE-len,
>                         "mbx_dump_cnt: %04d\n", mbx_dump_cnt);
> -       len += snprintf(pbuffer+len, LPFC_MBX_ACC_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_MBX_ACC_BUF_SIZE-len,
>                         "mbx_word_cnt: %04d\n", mbx_word_cnt);
> -       len += snprintf(pbuffer+len, LPFC_MBX_ACC_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_MBX_ACC_BUF_SIZE-len,
>                         "mbx_mbox_cmd: 0x%02x\n", mbx_mbox_cmd);
>
>         return len;
> @@ -4575,35 +4575,35 @@ lpfc_idiag_extacc_avail_get(struct lpfc_hba *phba, char *pbuffer, int len)
>  {
>         uint16_t ext_cnt, ext_size;
>
> -       len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                         "\nAvailable Extents Information:\n");
>
> -       len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                         "\tPort Available VPI extents: ");
>         lpfc_sli4_get_avail_extnt_rsrc(phba, LPFC_RSC_TYPE_FCOE_VPI,
>                                        &ext_cnt, &ext_size);
> -       len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                         "Count %3d, Size %3d\n", ext_cnt, ext_size);
>
> -       len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                         "\tPort Available VFI extents: ");
>         lpfc_sli4_get_avail_extnt_rsrc(phba, LPFC_RSC_TYPE_FCOE_VFI,
>                                        &ext_cnt, &ext_size);
> -       len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                         "Count %3d, Size %3d\n", ext_cnt, ext_size);
>
> -       len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                         "\tPort Available RPI extents: ");
>         lpfc_sli4_get_avail_extnt_rsrc(phba, LPFC_RSC_TYPE_FCOE_RPI,
>                                        &ext_cnt, &ext_size);
> -       len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                         "Count %3d, Size %3d\n", ext_cnt, ext_size);
>
> -       len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                         "\tPort Available XRI extents: ");
>         lpfc_sli4_get_avail_extnt_rsrc(phba, LPFC_RSC_TYPE_FCOE_XRI,
>                                        &ext_cnt, &ext_size);
> -       len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                         "Count %3d, Size %3d\n", ext_cnt, ext_size);
>
>         return len;
> @@ -4627,55 +4627,55 @@ lpfc_idiag_extacc_alloc_get(struct lpfc_hba *phba, char *pbuffer, int len)
>         uint16_t ext_cnt, ext_size;
>         int rc;
>
> -       len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                         "\nAllocated Extents Information:\n");
>
> -       len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                         "\tHost Allocated VPI extents: ");
>         rc = lpfc_sli4_get_allocated_extnts(phba, LPFC_RSC_TYPE_FCOE_VPI,
>                                             &ext_cnt, &ext_size);
>         if (!rc)
> -               len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                                 "Port %d Extent %3d, Size %3d\n",
>                                 phba->brd_no, ext_cnt, ext_size);
>         else
> -               len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                                 "N/A\n");
>
> -       len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                         "\tHost Allocated VFI extents: ");
>         rc = lpfc_sli4_get_allocated_extnts(phba, LPFC_RSC_TYPE_FCOE_VFI,
>                                             &ext_cnt, &ext_size);
>         if (!rc)
> -               len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                                 "Port %d Extent %3d, Size %3d\n",
>                                 phba->brd_no, ext_cnt, ext_size);
>         else
> -               len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                                 "N/A\n");
>
> -       len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                         "\tHost Allocated RPI extents: ");
>         rc = lpfc_sli4_get_allocated_extnts(phba, LPFC_RSC_TYPE_FCOE_RPI,
>                                             &ext_cnt, &ext_size);
>         if (!rc)
> -               len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                                 "Port %d Extent %3d, Size %3d\n",
>                                 phba->brd_no, ext_cnt, ext_size);
>         else
> -               len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                                 "N/A\n");
>
> -       len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                         "\tHost Allocated XRI extents: ");
>         rc = lpfc_sli4_get_allocated_extnts(phba, LPFC_RSC_TYPE_FCOE_XRI,
>                                             &ext_cnt, &ext_size);
>         if (!rc)
> -               len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                                 "Port %d Extent %3d, Size %3d\n",
>                                 phba->brd_no, ext_cnt, ext_size);
>         else
> -               len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                                 "N/A\n");
>
>         return len;
> @@ -4699,49 +4699,49 @@ lpfc_idiag_extacc_drivr_get(struct lpfc_hba *phba, char *pbuffer, int len)
>         struct lpfc_rsrc_blks *rsrc_blks;
>         int index;
>
> -       len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                         "\nDriver Extents Information:\n");
>
> -       len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                         "\tVPI extents:\n");
>         index = 0;
>         list_for_each_entry(rsrc_blks, &phba->lpfc_vpi_blk_list, list) {
> -               len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                                 "\t\tBlock %3d: Start %4d, Count %4d\n",
>                                 index, rsrc_blks->rsrc_start,
>                                 rsrc_blks->rsrc_size);
>                 index++;
>         }
> -       len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                         "\tVFI extents:\n");
>         index = 0;
>         list_for_each_entry(rsrc_blks, &phba->sli4_hba.lpfc_vfi_blk_list,
>                             list) {
> -               len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                                 "\t\tBlock %3d: Start %4d, Count %4d\n",
>                                 index, rsrc_blks->rsrc_start,
>                                 rsrc_blks->rsrc_size);
>                 index++;
>         }
>
> -       len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                         "\tRPI extents:\n");
>         index = 0;
>         list_for_each_entry(rsrc_blks, &phba->sli4_hba.lpfc_rpi_blk_list,
>                             list) {
> -               len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                                 "\t\tBlock %3d: Start %4d, Count %4d\n",
>                                 index, rsrc_blks->rsrc_start,
>                                 rsrc_blks->rsrc_size);
>                 index++;
>         }
>
> -       len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +       len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                         "\tXRI extents:\n");
>         index = 0;
>         list_for_each_entry(rsrc_blks, &phba->sli4_hba.lpfc_xri_blk_list,
>                             list) {
> -               len += snprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
> +               len += scnprintf(pbuffer+len, LPFC_EXT_ACC_BUF_SIZE-len,
>                                 "\t\tBlock %3d: Start %4d, Count %4d\n",
>                                 index, rsrc_blks->rsrc_start,
>                                 rsrc_blks->rsrc_size);
> @@ -5135,11 +5135,11 @@ lpfc_idiag_mbxacc_dump_bsg_mbox(struct lpfc_hba *phba, enum nemb_type nemb_tp,
>                                 if (i != 0)
>                                         pr_err("%s\n", line_buf);
>                                 len = 0;
> -                               len += snprintf(line_buf+len,
> +                               len += scnprintf(line_buf+len,
>                                                 LPFC_MBX_ACC_LBUF_SZ-len,
>                                                 "%03d: ", i);
>                         }
> -                       len += snprintf(line_buf+len, LPFC_MBX_ACC_LBUF_SZ-len,
> +                       len += scnprintf(line_buf+len, LPFC_MBX_ACC_LBUF_SZ-len,
>                                         "%08x ", (uint32_t)*pword);
>                         pword++;
>                 }
> @@ -5202,11 +5202,11 @@ lpfc_idiag_mbxacc_dump_issue_mbox(struct lpfc_hba *phba, MAILBOX_t *pmbox)
>                                         pr_err("%s\n", line_buf);
>                                 len = 0;
>                                 memset(line_buf, 0, LPFC_MBX_ACC_LBUF_SZ);
> -                               len += snprintf(line_buf+len,
> +                               len += scnprintf(line_buf+len,
>                                                 LPFC_MBX_ACC_LBUF_SZ-len,
>                                                 "%03d: ", i);
>                         }
> -                       len += snprintf(line_buf+len, LPFC_MBX_ACC_LBUF_SZ-len,
> +                       len += scnprintf(line_buf+len, LPFC_MBX_ACC_LBUF_SZ-len,
>                                         "%08x ",
>                                         ((uint32_t)*pword) & 0xffffffff);
>                         pword++;
> @@ -5225,18 +5225,18 @@ lpfc_idiag_mbxacc_dump_issue_mbox(struct lpfc_hba *phba, MAILBOX_t *pmbox)
>                                         pr_err("%s\n", line_buf);
>                                 len = 0;
>                                 memset(line_buf, 0, LPFC_MBX_ACC_LBUF_SZ);
> -                               len += snprintf(line_buf+len,
> +                               len += scnprintf(line_buf+len,
>                                                 LPFC_MBX_ACC_LBUF_SZ-len,
>                                                 "%03d: ", i);
>                         }
>                         for (j = 0; j < 4; j++) {
> -                               len += snprintf(line_buf+len,
> +                               len += scnprintf(line_buf+len,
>                                                 LPFC_MBX_ACC_LBUF_SZ-len,
>                                                 "%02x",
>                                                 ((uint8_t)*pbyte) & 0xff);
>                                 pbyte++;
>                         }
> -                       len += snprintf(line_buf+len,
> +                       len += scnprintf(line_buf+len,
>                                         LPFC_MBX_ACC_LBUF_SZ-len, " ");
>                 }
>                 if ((i - 1) % 8)
> --
> 2.19.2
>


-- 
Kees Cook
