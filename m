Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753384AbeCNHAX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 03:00:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39384 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeCNHAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 03:00:21 -0400
Subject: Re: [PATCH] scsi: iscsi_tcp: set BDI_CAP_STABLE_WRITES when data
 digest enabled
To: lduncan@suse.com, cleech@redhat.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc: open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1520425743-1923-1-git-send-email-jianchao.w.wang@oracle.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <91cacdf3-ae5c-c12c-9fe4-695ba6ac7c21@oracle.com>
Date: Wed, 14 Mar 2018 15:00:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520425743-1923-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8831 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803140081
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would anyone please take a review at this patch ?

Thanks in advace
Jianchao

On 03/07/2018 08:29 PM, Jianchao Wang wrote:
> iscsi tcp will first send out data, then calculate and send data
> digest. If we don't have BDI_CAP_STABLE_WRITES, the page cache will
> be written in spite of the on going writeback. Consequently, wrong
> digest will be got and sent to target.
> 
> To fix this, set BDI_CAP_STABLE_WRITES when data digest is enabled
> in iscsi_tcp .slave_configure callback.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  drivers/scsi/iscsi_tcp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
> index 6198559..261c686 100644
> --- a/drivers/scsi/iscsi_tcp.c
> +++ b/drivers/scsi/iscsi_tcp.c
> @@ -37,6 +37,7 @@
>  #include <linux/kfifo.h>
>  #include <linux/scatterlist.h>
>  #include <linux/module.h>
> +#include <linux/backing-dev.h>
>  #include <net/tcp.h>
>  #include <scsi/scsi_cmnd.h>
>  #include <scsi/scsi_device.h>
> @@ -954,6 +955,12 @@ static int iscsi_sw_tcp_slave_alloc(struct scsi_device *sdev)
>  
>  static int iscsi_sw_tcp_slave_configure(struct scsi_device *sdev)
>  {
> +	struct iscsi_sw_tcp_host *tcp_sw_host = iscsi_host_priv(sdev->host);
> +	struct iscsi_session *session = tcp_sw_host->session;
> +	struct iscsi_conn *conn = session->leadconn;
> +
> +	if (conn->datadgst_en)
> +		sdev->request_queue->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
>  	blk_queue_bounce_limit(sdev->request_queue, BLK_BOUNCE_ANY);
>  	blk_queue_dma_alignment(sdev->request_queue, 0);
>  	return 0;
> 
