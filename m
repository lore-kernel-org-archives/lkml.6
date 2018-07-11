Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC18C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305EB20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305EB20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733092AbeGKOzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:55:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732321AbeGKOzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:55:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 00DE08182D28;
        Wed, 11 Jul 2018 14:50:27 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.43.2.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FED216876;
        Wed, 11 Jul 2018 14:50:25 +0000 (UTC)
Subject: Re: [PATCH][scsi-next] scsi: lpfc: fix null pointer dereference on
 nvmebuf
To:     Colin King <colin.king@canonical.com>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180711134436.21963-1-colin.king@canonical.com>
From:   Tomas Henzl <thenzl@redhat.com>
Message-ID: <8d54503c-93c4-4e1c-f6dc-6c41e6a3a80a@redhat.com>
Date:   Wed, 11 Jul 2018 16:50:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180711134436.21963-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 11 Jul 2018 14:50:27 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 11 Jul 2018 14:50:27 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'thenzl@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 03:44 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The check of nvmebuf suggests that it can be null, however a recent
> change dereferences it to determine oxid before it is null checked,
> hence there is a potential null deference on the pointer.  Fix this
> by performing the null check first.  Also remove the oxid from the
> debug log message as this is no longer valid.  I considered an early
> fetch of oxid if nvmebuf was valid, however, what oxid should be set
> to if nvembuf is null could lead to an ambiguous logging of an invalid
> oxid, so I thought just removing it from the logging was the least
> confusion solution.

I think that the 'if (!nvmebuf)' test is not needed and it would be better to remove the
tests (it is tested for the second time later in the function).
Tomas

>
> Detected by CoverityScan, CID#1471753 ("Dereference before null check")
>
> Fixes: 68c9b55deea5 ("scsi: lpfc: Fix abort error path for NVMET")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/scsi/lpfc/lpfc_nvmet.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
> index 22f8a204b69f..01652d9ac619 100644
> --- a/drivers/scsi/lpfc/lpfc_nvmet.c
> +++ b/drivers/scsi/lpfc/lpfc_nvmet.c
> @@ -1742,12 +1742,9 @@ lpfc_nvmet_unsol_ls_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
>  	uint32_t *payload;
>  	uint32_t size, oxid, sid, rc;
>  
> -	fc_hdr = (struct fc_frame_header *)(nvmebuf->hbuf.virt);
> -	oxid = be16_to_cpu(fc_hdr->fh_ox_id);
> -
>  	if (!nvmebuf || !phba->targetport) {
>  		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
> -				"6154 LS Drop IO x%x\n", oxid);
> +				"6154 LS Drop IO\n");
>  		oxid = 0;
>  		size = 0;
>  		sid = 0;
> @@ -1755,6 +1752,9 @@ lpfc_nvmet_unsol_ls_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
>  		goto dropit;
>  	}
>  
> +	fc_hdr = (struct fc_frame_header *)(nvmebuf->hbuf.virt);
> +	oxid = be16_to_cpu(fc_hdr->fh_ox_id);
> +
>  	tgtp = (struct lpfc_nvmet_tgtport *)phba->targetport->private;
>  	payload = (uint32_t *)(nvmebuf->dbuf.virt);
>  	size = bf_get(lpfc_rcqe_length,  &nvmebuf->cq_event.cqe.rcqe_cmpl);


