Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932426AbeCOSFc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:05:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751488AbeCOSFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:05:30 -0400
Date: Thu, 15 Mar 2018 11:05:27 -0700
From: Chris Leech <cleech@redhat.com>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: lduncan@suse.com, jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: iscsi_tcp: set BDI_CAP_STABLE_WRITES when data
 digest enabled
Message-ID: <20180315180527.GC32176@straylight.hirudinean.org>
Mail-Followup-To: Chris Leech <cleech@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>, lduncan@suse.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1520425743-1923-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520425743-1923-1-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 08:29:03PM +0800, Jianchao Wang wrote:
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
> -- 

Thanks for fixing this issue with data digests!

Signed-off-by: Chris Leech <cleech@redhat.com>
