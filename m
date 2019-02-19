Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DEDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFFB20818
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfBSKcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:32:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726969AbfBSKcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:32:35 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1JAOQ42112381
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 05:32:34 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qrd5tj95r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 05:32:33 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <maier@linux.ibm.com>;
        Tue, 19 Feb 2019 10:32:29 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Feb 2019 10:32:26 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1JAWPHN55181366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Feb 2019 10:32:25 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8A4BA405F;
        Tue, 19 Feb 2019 10:32:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59E76A4054;
        Tue, 19 Feb 2019 10:32:25 +0000 (GMT)
Received: from oc4120165700.ibm.com (unknown [9.152.99.189])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Feb 2019 10:32:25 +0000 (GMT)
Subject: Re: [RFC PATCH] scsi: fix oops in scsi_uninit_cmd()
To:     Jason Yan <yanaijie@huawei.com>, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hare@suse.com, dan.j.williams@intel.com, jthumshirn@suse.de,
        hch@lst.de
References: <20190219072743.13606-1-yanaijie@huawei.com>
From:   Steffen Maier <maier@linux.ibm.com>
Date:   Tue, 19 Feb 2019 11:32:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190219072743.13606-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19021910-0012-0000-0000-000002F778F7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021910-0013-0000-0000-0000212F054D
Message-Id: <ca0a03a1-6b36-2626-cb16-113cbc01f4bc@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902190078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/19/2019 08:27 AM, Jason Yan wrote:
> If we remove the scsi disk when running io with fio, oops occured with
> the following condition.
> 
> [scsi_eh_0]                              [fio]
> scsi_end_request
>    ->blk_update_request
>      ->end_bio(io returned to userspace)
>                                           close
>                                             ->sd_release
>                                                ->scsi_disk_put
>                                                   ->scsi_disk_release
>                                                       ->disk->private_data = NULL;
> 
>    ->scsi_mq_uninit_cmd
>      ->scsi_uninit_cmd
>        ->scsi_cmd_to_driver
>      ->drv is NULL, Oops
> 
> There is a small window between blk_update_request() and
> scsi_mq_uninit_cmd() that scsi disk may have been released. This will
> cause a oops like below:

> To fix this, get a refcount of scsi_disk in sd_init_command() to ensure
> it will not be released before sd_uninit_command().
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>   drivers/scsi/sd.c | 46 +++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 35 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 5464d467e23e..6bdb8fbb570f 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -1249,42 +1249,64 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
>   static blk_status_t sd_init_command(struct scsi_cmnd *cmd)
>   {
>   	struct request *rq = cmd->request;
> +	struct scsi_disk *sdkp = NULL;

This pre-init with NULL kinda prevents static compile warnings on uninitialized 
use?

> +	blk_status_t ret;
> 
>   	switch (req_op(rq)) {

>   	}
> +
> +	if (!ret) {
> +		sdkp = scsi_disk(rq->rq_disk);
> +		get_device(&sdkp->dev);
> +	}
> +
> +	return ret;
>   }
> 
>   static void sd_uninit_command(struct scsi_cmnd *SCpnt)
>   {
>   	struct request *rq = SCpnt->request;
>   	u8 *cmnd;
> +	struct scsi_disk *sdkp = NULL;

dito

> 
>   	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD)
>   		mempool_free(rq->special_vec.bv_page, sd_page_pool);
> @@ -1295,6 +1317,8 @@ static void sd_uninit_command(struct scsi_cmnd *SCpnt)
>   		SCpnt->cmd_len = 0;
>   		mempool_free(cmnd, sd_cdb_pool);
>   	}
> +	sdkp = scsi_disk(rq->rq_disk);
> +	put_device(&sdkp->dev);
>   }
> 
>   /**
> 


-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z Development

https://www.ibm.com/privacy/us/en/
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

