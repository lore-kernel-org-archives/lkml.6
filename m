Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754122AbeBBSm0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:42:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:60444 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751907AbeBBSmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:42:18 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,450,1511856000";
   d="scan'208";a="200751028"
Date: Fri, 2 Feb 2018 11:46:05 -0700
From: Keith Busch <keith.busch@intel.com>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] nvme-pci: move clearing host mem behind stopping
 queues
Message-ID: <20180202184605.GJ24417@localhost.localdomain>
References: <1517554849-7802-1-git-send-email-jianchao.w.wang@oracle.com>
 <1517554849-7802-2-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517554849-7802-2-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 03:00:44PM +0800, Jianchao Wang wrote:
> Move clearing host mem behind stopping queues. Prepare for
> following patch which will grab all the outstanding requests.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>

This one makes sense, though I would alter the change log to something
like:

  This patch quiecses new IO prior to disabling device HMB access.
  A controller using HMB may be relying on it to efficiently complete
  IO commands.

Reviewed-by: Keith Busch <keith.busch@intel.com>

> ---
>  drivers/nvme/host/pci.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6fe7af0..00cffed 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2186,7 +2186,10 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  	if (!dead) {
>  		if (shutdown)
>  			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
> +	}
> +	nvme_stop_queues(&dev->ctrl);
>  
> +	if (!dead) {
>  		/*
>  		 * If the controller is still alive tell it to stop using the
>  		 * host memory buffer.  In theory the shutdown / reset should
> @@ -2195,11 +2198,6 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  		 */
>  		if (dev->host_mem_descs)
>  			nvme_set_host_mem(dev, 0);
> -
> -	}
> -	nvme_stop_queues(&dev->ctrl);
> -
> -	if (!dead) {
>  		nvme_disable_io_queues(dev);
>  		nvme_disable_admin_queue(dev, shutdown);
>  	}
> -- 
> 2.7.4
