Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751132AbeECPaK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 11:30:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:8193 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750954AbeECPaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 11:30:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,359,1520924400";
   d="scan'208";a="42814580"
Date: Thu, 3 May 2018 09:31:42 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvmet: switch loopback target state to connecting when
 resetting
Message-ID: <20180503153142.GN5938@localhost.localdomain>
References: <20180503150035.13918-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503150035.13918-1-jthumshirn@suse.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 05:00:35PM +0200, Johannes Thumshirn wrote:
> After commit bb06ec31452f ("nvme: expand nvmf_check_if_ready checks")
> resetting of the loopback nvme target failed as we forgot to switch
> it's state to NVME_CTRL_CONNECTING before we reconnect the admin
> queues. Therefore the checks in nvmf_check_if_ready() choose to go to
> the reject_io case and thus we couldn't sent out an identify
> controller command to reconnect.
> 
> Change the controller state to NVME_CTRL_CONNECTING after tearing down
> the old connection and before re-establishing the connection.
> 
> Fixes: bb06ec31452f ("nvme: expand nvmf_check_if_ready checks")
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/nvme/target/loop.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index 31fdfba556a8..27a8561c0cb9 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -469,6 +469,12 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
>  	nvme_stop_ctrl(&ctrl->ctrl);
>  	nvme_loop_shutdown_ctrl(ctrl);
>  
> +	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
> +		/* state change failure should never happen */
> +		WARN_ON_ONCE(1);
> +		return;
> +	}
> +
>  	ret = nvme_loop_configure_admin_queue(ctrl);
>  	if (ret)
>  		goto out_disable;
> -- 
> 2.16.3

Thanks, applied to the 4.17 nvme branch.
