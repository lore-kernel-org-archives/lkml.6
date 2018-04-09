Return-Path: <htejun@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523311782; cv=none;
        d=google.com; s=arc-20160816;
        b=TG/QC095ehc3FcNDDRTM4bvKSl36MqWd51gfWfl6llGr7shJZoM5xyA2/iIARfzN6r
         P9OwDFZMPDJmqQK2RVJjpp+v1WDJcPSANGp+e5ljNBiL1DHwMVIFzsLOZlSnAe1SS7nS
         qT5bkqRB09VTNhniZW1m10umQcjDrtYe+VSu+EF8x1wIX6pn1HxVBheqyuZ3HO3dtdrO
         9ZGKICKSnM+yLrdT6dPpHaan4qM9wXI/V0bRzxferg79NRzvBQjiPa93AuF+wYyicNyK
         /16xgkRLjZwakUtYsQaV0nuyFP2HuOVLT3YfwNv/iPd7TSa2wLcXVM2HfN0XGXRMhD1B
         5jIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=LhLNyhzXx7j/lV5qQ52D5ZqKvxI/qzFrxTHlHbSdOfA=;
        b=nvSON09sYGzd9VseZOcrKaek/fHIs9g94sjwK0KjrbPT4vIE3BP8kZftCVtCq5dj5l
         8ceb464XgPYL6AG84HmXMNQaAPXxlVJowDRHahUe0KrXPdebeWjkm6PdHwfW2kZdPFJ0
         IjqQAHRfwr8nU/FF+CwXv6nflkZ/3cCHUQEq8Qsz7At/R5kVq3vUE0yRbW7ZBdMptLSx
         bXHVACODZAhqLAvB32YQG3M/1wZHNio9CZVZfBC62p3vh4wVkkAmq8olIJk5RaXVfgoD
         7smRlZ5SPKfRzGNQnlLfKnVpPO+LcklkNlBppN7JVKjWn9QEHIv6a5RPZUfvI470uQUQ
         /oew==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=atA9IBoI;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=htejun@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=atA9IBoI;
       spf=pass (google.com: domain of htejun@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AIpwx48vif6LXpSd6ARp9Z128ZnOkdsc3SCcR+wTO8t6tkqRIhXP0ysY7H5N0nxizffIhuX0wuT/rQ==
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 9 Apr 2018 15:09:38 -0700
From: Tejun Heo <tj@kernel.org>
To: Alexandru Moise <00moses.alexander00@gmail.com>
Cc: axboe@kernel.dk, shli@fb.com, nborisov@suse.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
Message-ID: <20180409220938.GI3126663@devbig577.frc2.facebook.com>
References: <20180407102148.GA9729@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180407102148.GA9729@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597082451728716242?=
X-GMAIL-MSGID: =?utf-8?q?1597308175216445623?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

(cc'ing Joseph as he worked on the area recently, hi!)

Hello,

On Sat, Apr 07, 2018 at 12:21:48PM +0200, Alexandru Moise wrote:
> The q->id is used as an index within the blkg_tree radix tree.
> 
> If the entry is not released before reclaiming the blk_queue_ida's id
> blkcg_init_queue() within a different driver from which this id
> was originally for can fail due to the entry at that index within
> the radix tree already existing.
> 
> Signed-off-by: Alexandru Moise <00moses.alexander00@gmail.com>
> ---
> v2: Added no-op for !CONFIG_BLK_CGROUP
> 
>  block/blk-cgroup.c         | 2 +-
>  block/blk-sysfs.c          | 4 ++++
>  include/linux/blk-cgroup.h | 3 +++
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 1c16694ae145..224e937dbb59 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -369,7 +369,7 @@ static void blkg_destroy(struct blkcg_gq *blkg)
>   *
>   * Destroy all blkgs associated with @q.
>   */
> -static void blkg_destroy_all(struct request_queue *q)
> +void blkg_destroy_all(struct request_queue *q)
>  {
>  	struct blkcg_gq *blkg, *n;
>  
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index d00d1b0ec109..a72866458f22 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -816,6 +816,10 @@ static void __blk_release_queue(struct work_struct *work)
>  	if (q->bio_split)
>  		bioset_free(q->bio_split);
>  
> +	spin_lock_irq(q->queue_lock);
> +	blkg_destroy_all(q);
> +	spin_unlock_irq(q->queue_lock);
> +
>  	ida_simple_remove(&blk_queue_ida, q->id);
>  	call_rcu(&q->rcu_head, blk_free_queue_rcu);

But we already do this through calling blkcg_exit_queue() from
__blk_release_queue().  What's missing?

Thanks.

-- 
tejun
