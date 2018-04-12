Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbeDLJAW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 05:00:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46264 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751583AbeDLJAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 05:00:21 -0400
Subject: Re: [PATCH] scsi: qla2xxx: reduce the time granularity of
 qla2x00_eh_wait_on_command
To: qla2xxx-upstream@qlogic.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523350115-4026-1-git-send-email-jianchao.w.wang@oracle.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <69351cce-2d2f-11d6-27b6-01d0d90a2e59@oracle.com>
Date: Thu, 12 Apr 2018 17:00:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523350115-4026-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8860 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804120092
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would anyone please take a review on this ?

Thanks in advance
Jianchao

On 04/10/2018 04:48 PM, Jianchao Wang wrote:
> If the cmd has not be returned after aborted by qla2x00_eh_abort,
> we have to wait for it. However, the time is 1000ms at least currently.
> If there are a lot cmds need to be aborted, the delay could be long
> enough to lead to panic due to such as hung task, ocfs2 heartbeat,
> etc, just before scsi recovery works.
> Change the granularity to 1ms, even though more context switches
> would be introduced, but it should be ok as it is not hot path.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  drivers/scsi/qla2xxx/qla_os.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
> index 5c5dcca4..9f52ad9 100644
> --- a/drivers/scsi/qla2xxx/qla_os.c
> +++ b/drivers/scsi/qla2xxx/qla_os.c
> @@ -1072,7 +1072,7 @@ qla2xxx_mqueuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd,
>  static int
>  qla2x00_eh_wait_on_command(struct scsi_cmnd *cmd)
>  {
> -#define ABORT_POLLING_PERIOD	1000
> +#define ABORT_POLLING_PERIOD	1
>  #define ABORT_WAIT_ITER		((2 * 1000) / (ABORT_POLLING_PERIOD))
>  	unsigned long wait_iter = ABORT_WAIT_ITER;
>  	scsi_qla_host_t *vha = shost_priv(cmd->device->host);
> 
