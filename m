Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbeDROoY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:44:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:24161 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750872AbeDROoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:44:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,465,1517904000";
   d="scan'208";a="221413639"
Date: Wed, 18 Apr 2018 08:45:25 -0600
From: Keith Busch <keith.busch@intel.com>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: fix the suspicious RCU usage warning in
 nvme_mpath_clear_current_path
Message-ID: <20180418144524.GL11513@localhost.localdomain>
References: <1524036767-3701-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524036767-3701-1-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 03:32:47PM +0800, Jianchao Wang wrote:
> With lockdep enabled, when trigger nvme_remove, suspicious RCU
> usage warning will be printed out.
> Fix it with adding srcu_read_lock/unlock in it.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  drivers/nvme/host/nvme.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 061fecf..d326c23 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -446,9 +446,14 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head);
>  static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
>  {
>  	struct nvme_ns_head *head = ns->head;
> +	int srcu_idx;
>  
> -	if (head && ns == srcu_dereference(head->current_path, &head->srcu))
> -		rcu_assign_pointer(head->current_path, NULL);
> +	if (head) {
> +		srcu_idx = srcu_read_lock(&head->srcu);
> +		if (ns == srcu_dereference(head->current_path, &head->srcu))
> +			rcu_assign_pointer(head->current_path, NULL);
> +		srcu_read_unlock(&head->srcu, srcu_idx);
> +	}
>  }
>  struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);

Nothing against this patch. This just doesn't look correct even from
before since nvme_find_path can set head->current_path right back to
this namespace that we're trying to clear.

Christoph, am I missing something here or does this need additional
checks/synchronization?
