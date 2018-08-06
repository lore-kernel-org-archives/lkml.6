Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67642C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDE121A51
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDE121A51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733075AbeHFSJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:09:23 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:37685 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733018AbeHFSJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:09:22 -0400
X-IronPort-AV: E=Sophos;i="5.51,452,1526342400"; 
   d="scan'208";a="77237251"
Date:   Mon, 6 Aug 2018 17:58:52 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Juergen Gross <jgross@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <konrad.wilk@oracle.com>,
        <axboe@kernel.dk>, <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 1/4] xen/blkback: don't keep persistent grants too long
Message-ID: <20180806155852.7jvudjpzzq6fdp33@mac>
References: <20180806113403.24728-1-jgross@suse.com>
 <20180806113403.24728-2-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180806113403.24728-2-jgross@suse.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 01:33:59PM +0200, Juergen Gross wrote:
> Persistent grants are allocated until a threshold per ring is being
> reached. Those grants won't be freed until the ring is being destroyed
> meaning there will be resources kept busy which might no longer be
> used.
> 
> Instead of freeing only persistent grants until the threshold is
> reached add a timestamp and remove all persistent grants not having
> been in use for a minute.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  drivers/block/xen-blkback/blkback.c | 77 +++++++++++++++++++++++--------------
>  drivers/block/xen-blkback/common.h  |  1 +
>  2 files changed, 50 insertions(+), 28 deletions(-)

You should document this new parameter in
Documentation/ABI/testing/sysfs-driver-xen-blkback.

> 
> diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
> index b55b245e8052..485e3ecab144 100644
> --- a/drivers/block/xen-blkback/blkback.c
> +++ b/drivers/block/xen-blkback/blkback.c
> @@ -84,6 +84,18 @@ MODULE_PARM_DESC(max_persistent_grants,
>                   "Maximum number of grants to map persistently");
>  
>  /*
> + * How long a persistent grant is allowed to remain allocated without being in
> + * use. The time is in seconds, 0 means indefinitely long.
> + */
> +
> +unsigned int xen_blkif_pgrant_timeout = 60;
> +module_param_named(persistent_grant_unused_seconds, xen_blkif_pgrant_timeout,
> +		   uint, 0644);
> +MODULE_PARM_DESC(persistent_grant_unused_seconds,
> +		 "Time in seconds an unused persistent grant is allowed to "
> +		 "remain allocated. Default is 60, 0 means unlimited.");
> +
> +/*
>   * Maximum number of rings/queues blkback supports, allow as many queues as there
>   * are CPUs if user has not specified a value.
>   */
> @@ -123,6 +135,13 @@ module_param(log_stats, int, 0644);
>  /* Number of free pages to remove on each call to gnttab_free_pages */
>  #define NUM_BATCH_FREE_PAGES 10
>  
> +static inline bool persistent_gnt_timeout(struct persistent_gnt *persistent_gnt)
> +{
> +	return xen_blkif_pgrant_timeout &&
> +	       (jiffies - persistent_gnt->last_used >=
> +		HZ * xen_blkif_pgrant_timeout);
> +}
> +
>  static inline int get_free_page(struct xen_blkif_ring *ring, struct page **page)
>  {
>  	unsigned long flags;
> @@ -278,6 +297,7 @@ static void put_persistent_gnt(struct xen_blkif_ring *ring,
>  {
>  	if(!test_bit(PERSISTENT_GNT_ACTIVE, persistent_gnt->flags))
>  		pr_alert_ratelimited("freeing a grant already unused\n");
> +	persistent_gnt->last_used = jiffies;
>  	set_bit(PERSISTENT_GNT_WAS_ACTIVE, persistent_gnt->flags);
>  	clear_bit(PERSISTENT_GNT_ACTIVE, persistent_gnt->flags);
>  	atomic_dec(&ring->persistent_gnt_in_use);
> @@ -374,23 +394,23 @@ static void purge_persistent_gnt(struct xen_blkif_ring *ring)
>  	bool scan_used = false, clean_used = false;
>  	struct rb_root *root;
>  
> -	if (ring->persistent_gnt_c < xen_blkif_max_pgrants ||
> -	    (ring->persistent_gnt_c == xen_blkif_max_pgrants &&
> -	    !ring->blkif->vbd.overflow_max_grants)) {
> -		goto out;
> -	}
> -
>  	if (work_busy(&ring->persistent_purge_work)) {
>  		pr_alert_ratelimited("Scheduled work from previous purge is still busy, cannot purge list\n");
>  		goto out;
>  	}
>  
> -	num_clean = (xen_blkif_max_pgrants / 100) * LRU_PERCENT_CLEAN;
> -	num_clean = ring->persistent_gnt_c - xen_blkif_max_pgrants + num_clean;
> -	num_clean = min(ring->persistent_gnt_c, num_clean);
> -	if ((num_clean == 0) ||
> -	    (num_clean > (ring->persistent_gnt_c - atomic_read(&ring->persistent_gnt_in_use))))
> -		goto out;
> +	if (ring->persistent_gnt_c < xen_blkif_max_pgrants ||
> +	    (ring->persistent_gnt_c == xen_blkif_max_pgrants &&
> +	    !ring->blkif->vbd.overflow_max_grants)) {
> +		num_clean = 0;
> +	} else {
> +		num_clean = (xen_blkif_max_pgrants / 100) * LRU_PERCENT_CLEAN;
> +		num_clean = ring->persistent_gnt_c - xen_blkif_max_pgrants +
> +			    num_clean;
> +		num_clean = min(ring->persistent_gnt_c, num_clean);
> +		pr_debug("Going to purge at least %u persistent grants\n",
> +			 num_clean);
> +	}
>  
>  	/*
>  	 * At this point, we can assure that there will be no calls
> @@ -401,9 +421,7 @@ static void purge_persistent_gnt(struct xen_blkif_ring *ring)
>           * number of grants.
>  	 */
>  
> -	total = num_clean;
> -
> -	pr_debug("Going to purge %u persistent grants\n", num_clean);
> +	total = 0;
>  
>  	BUG_ON(!list_empty(&ring->persistent_purge_list));
>  	root = &ring->persistent_gnts;
> @@ -419,39 +437,42 @@ static void purge_persistent_gnt(struct xen_blkif_ring *ring)
>  
>  		if (test_bit(PERSISTENT_GNT_ACTIVE, persistent_gnt->flags))
>  			continue;
> -		if (!scan_used &&
> +		if (!scan_used && !persistent_gnt_timeout(persistent_gnt) &&
>  		    (test_bit(PERSISTENT_GNT_WAS_ACTIVE, persistent_gnt->flags)))

If you store the jiffies of the time when the grant was last used it
seems like we could get rid of the PERSISTENT_GNT_WAS_ACTIVE flag and
instead use the per-grant jiffies and the jiffies from the last scan
in order to decide which grants to remove?

Thanks, Roger.
