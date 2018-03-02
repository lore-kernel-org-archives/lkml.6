Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163733AbeCBBoW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 20:44:22 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55588 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163100AbeCBBoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 20:44:18 -0500
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        Bart.VanAssche@wdc.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2] scsi: core: use blk_mq_requeue_request in __scsi_queue_insert
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1519808113-2863-1-git-send-email-jianchao.w.wang@oracle.com>
Date: Thu, 01 Mar 2018 20:44:10 -0500
In-Reply-To: <1519808113-2863-1-git-send-email-jianchao.w.wang@oracle.com>
        (Jianchao Wang's message of "Wed, 28 Feb 2018 16:55:13 +0800")
Message-ID: <yq1371jz1xx.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803020014
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jianchao,

> In scsi core, __scsi_queue_insert should just put request back on the
> queue and retry using the same command as before. However, for blk-mq,
> scsi_mq_requeue_cmd is employed here which will unprepare the
> request. To align with the semantics of __scsi_queue_insert, use
> blk_mq_requeue_request with kick_requeue_list == true and put the
> reference of scsi_device.
>
> V1 -> V2:
>  - add put_device on scsi_device->sdev_gendev

Also, please put changelog after the --- delimiter.

> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  drivers/scsi/scsi_lib.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index a86df9c..6fa7b0c 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -191,7 +191,8 @@ static void __scsi_queue_insert(struct scsi_cmnd *cmd, int reason, bool unbusy)
>  	 */
>  	cmd->result = 0;
>  	if (q->mq_ops) {
> -		scsi_mq_requeue_cmd(cmd);
> +		blk_mq_requeue_request(cmd->request, true);
> +		put_device(&device->sdev_gendev);
>  		return;
>  	}
>  	spin_lock_irqsave(q->queue_lock, flags);

-- 
Martin K. Petersen	Oracle Linux Engineering
