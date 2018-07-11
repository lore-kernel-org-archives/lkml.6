Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBFFC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A762087C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A762087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388696AbeGKOkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:40:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388075AbeGKOkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:40:17 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6BEXZw7005669
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 10:35:39 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k5k851rum-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 10:35:38 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.vnet.ibm.com>;
        Wed, 11 Jul 2018 08:35:36 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Jul 2018 08:35:34 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6BEZY7I11993560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jul 2018 07:35:34 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7F5B78060;
        Wed, 11 Jul 2018 08:35:33 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BB347805C;
        Wed, 11 Jul 2018 08:35:32 -0600 (MDT)
Received: from [153.66.254.194] (unknown [9.85.180.20])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jul 2018 08:35:32 -0600 (MDT)
Subject: Re: [PATCH][scsi-next] scsi: lpfc: fix null pointer dereference on
 nvmebuf
From:   James Bottomley <jejb@linux.vnet.ibm.com>
To:     Colin King <colin.king@canonical.com>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 11 Jul 2018 07:35:30 -0700
In-Reply-To: <20180711134436.21963-1-colin.king@canonical.com>
References: <20180711134436.21963-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18071114-0012-0000-0000-0000168A8113
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009350; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059817; UDB=6.00543958; IPR=6.00837737;
 MB=3.00022102; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-11 14:35:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071114-0013-0000-0000-000053A26DB3
Message-Id: <1531319730.3260.1.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807110157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 14:44 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The check of nvmebuf suggests that it can be null, however a recent
> change dereferences it to determine oxid before it is null checked,
> hence there is a potential null deference on the pointer.  Fix this
> by performing the null check first.  Also remove the oxid from the
> debug log message as this is no longer valid.  I considered an early
> fetch of oxid if nvmebuf was valid, however, what oxid should be set
> to if nvembuf is null could lead to an ambiguous logging of an
> invalid
> oxid, so I thought just removing it from the logging was the least
> confusion solution.
> 
> Detected by CoverityScan, CID#1471753 ("Dereference before null
> check")
> 
> Fixes: 68c9b55deea5 ("scsi: lpfc: Fix abort error path for NVMET")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/scsi/lpfc/lpfc_nvmet.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c
> b/drivers/scsi/lpfc/lpfc_nvmet.c
> index 22f8a204b69f..01652d9ac619 100644
> --- a/drivers/scsi/lpfc/lpfc_nvmet.c
> +++ b/drivers/scsi/lpfc/lpfc_nvmet.c
> @@ -1742,12 +1742,9 @@ lpfc_nvmet_unsol_ls_buffer(struct lpfc_hba
> *phba, struct lpfc_sli_ring *pring,
>  	uint32_t *payload;
>  	uint32_t size, oxid, sid, rc;
>  
> -	fc_hdr = (struct fc_frame_header *)(nvmebuf->hbuf.virt);
> -	oxid = be16_to_cpu(fc_hdr->fh_ox_id);
> -
>  	if (!nvmebuf || !phba->targetport) {

The !nvmebuf is a bogus check, isn't it? since nvmebuf is always
obtained from a container_of, it can never be NULL.  This would mean
the rest of the contortions are unnecessary.

James

