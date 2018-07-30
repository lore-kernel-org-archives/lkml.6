Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7055713F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A90C20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A90C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeG3Keo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:34:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:59482 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726505AbeG3Keo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:34:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B1231AD8F;
        Mon, 30 Jul 2018 09:00:42 +0000 (UTC)
Date:   Mon, 30 Jul 2018 11:00:41 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        mst@redhat.com, akpm@linux-foundation.org
Subject: Re: [PATCH v2 2/2] virtio_balloon: replace oom notifier with shrinker
Message-ID: <20180730090041.GC24267@dhcp22.suse.cz>
References: <1532683495-31974-1-git-send-email-wei.w.wang@intel.com>
 <1532683495-31974-3-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532683495-31974-3-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 27-07-18 17:24:55, Wei Wang wrote:
> The OOM notifier is getting deprecated to use for the reasons mentioned
> here by Michal Hocko: https://lkml.org/lkml/2018/7/12/314
> 
> This patch replaces the virtio-balloon oom notifier with a shrinker
> to release balloon pages on memory pressure.

It would be great to document the replacement. This is not a small
change...

> In addition, the bug in the replaced virtballoon_oom_notify that only
> VIRTIO_BALLOON_ARRAY_PFNS_MAX (i.e 256) balloon pages can be freed
> though the user has specified more than that number is fixed in the
> shrinker_scan function.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  drivers/virtio/virtio_balloon.c | 115 +++++++++++++++++++++++-----------------
>  1 file changed, 65 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 9356a1a..6b2229b 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -27,7 +27,6 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/balloon_compaction.h>
> -#include <linux/oom.h>
>  #include <linux/wait.h>
>  #include <linux/mm.h>
>  #include <linux/mount.h>
> @@ -40,12 +39,12 @@
>   */
>  #define VIRTIO_BALLOON_PAGES_PER_PAGE (unsigned)(PAGE_SIZE >> VIRTIO_BALLOON_PFN_SHIFT)
>  #define VIRTIO_BALLOON_ARRAY_PFNS_MAX 256
> -#define OOM_VBALLOON_DEFAULT_PAGES 256
> +#define DEFAULT_BALLOON_PAGES_TO_SHRINK 256
>  #define VIRTBALLOON_OOM_NOTIFY_PRIORITY 80
>  
> -static int oom_pages = OOM_VBALLOON_DEFAULT_PAGES;
> -module_param(oom_pages, int, S_IRUSR | S_IWUSR);
> -MODULE_PARM_DESC(oom_pages, "pages to free on OOM");
> +static unsigned long balloon_pages_to_shrink = DEFAULT_BALLOON_PAGES_TO_SHRINK;
> +module_param(balloon_pages_to_shrink, ulong, 0600);
> +MODULE_PARM_DESC(balloon_pages_to_shrink, "pages to free on memory presure");
>  
>  #ifdef CONFIG_BALLOON_COMPACTION
>  static struct vfsmount *balloon_mnt;
> @@ -86,8 +85,8 @@ struct virtio_balloon {
>  	/* Memory statistics */
>  	struct virtio_balloon_stat stats[VIRTIO_BALLOON_S_NR];
>  
> -	/* To register callback in oom notifier call chain */
> -	struct notifier_block nb;
> +	/* To register a shrinker to shrink memory upon memory pressure */
> +	struct shrinker shrinker;
>  };
>  
>  static struct virtio_device_id id_table[] = {
> @@ -365,38 +364,6 @@ static void update_balloon_size(struct virtio_balloon *vb)
>  		      &actual);
>  }
>  
> -/*
> - * virtballoon_oom_notify - release pages when system is under severe
> - *			    memory pressure (called from out_of_memory())
> - * @self : notifier block struct
> - * @dummy: not used
> - * @parm : returned - number of freed pages
> - *
> - * The balancing of memory by use of the virtio balloon should not cause
> - * the termination of processes while there are pages in the balloon.
> - * If virtio balloon manages to release some memory, it will make the
> - * system return and retry the allocation that forced the OOM killer
> - * to run.
> - */
> -static int virtballoon_oom_notify(struct notifier_block *self,
> -				  unsigned long dummy, void *parm)
> -{
> -	struct virtio_balloon *vb;
> -	unsigned long *freed;
> -	unsigned num_freed_pages;
> -
> -	vb = container_of(self, struct virtio_balloon, nb);
> -	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> -		return NOTIFY_OK;
> -
> -	freed = parm;
> -	num_freed_pages = leak_balloon(vb, oom_pages);
> -	update_balloon_size(vb);
> -	*freed += num_freed_pages;
> -
> -	return NOTIFY_OK;
> -}
> -
>  static void update_balloon_stats_func(struct work_struct *work)
>  {
>  	struct virtio_balloon *vb;
> @@ -548,6 +515,54 @@ static struct file_system_type balloon_fs = {
>  
>  #endif /* CONFIG_BALLOON_COMPACTION */
>  
> +static unsigned long virtio_balloon_shrinker_scan(struct shrinker *shrinker,
> +						  struct shrink_control *sc)
> +{
> +	unsigned long pages_to_free = balloon_pages_to_shrink,
> +		      pages_freed = 0;
> +	struct virtio_balloon *vb = container_of(shrinker,
> +					struct virtio_balloon, shrinker);
> +
> +	/*
> +	 * One invocation of leak_balloon can deflate at most
> +	 * VIRTIO_BALLOON_ARRAY_PFNS_MAX balloon pages, so we call it
> +	 * multiple times to deflate pages till reaching
> +	 * balloon_pages_to_shrink pages.
> +	 */
> +	while (vb->num_pages && pages_to_free) {
> +		pages_to_free = balloon_pages_to_shrink - pages_freed;
> +		pages_freed += leak_balloon(vb, pages_to_free);
> +	}
> +	update_balloon_size(vb);
> +
> +	return pages_freed / VIRTIO_BALLOON_PAGES_PER_PAGE;
> +}
> +
> +static unsigned long virtio_balloon_shrinker_count(struct shrinker *shrinker,
> +						   struct shrink_control *sc)
> +{
> +	struct virtio_balloon *vb = container_of(shrinker,
> +					struct virtio_balloon, shrinker);
> +
> +	return min_t(unsigned long, vb->num_pages, balloon_pages_to_shrink) /
> +	       VIRTIO_BALLOON_PAGES_PER_PAGE;
> +}
> +
> +static void virtio_balloon_unregister_shrinker(struct virtio_balloon *vb)
> +{
> +	unregister_shrinker(&vb->shrinker);
> +}
> +
> +static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
> +{
> +	vb->shrinker.scan_objects = virtio_balloon_shrinker_scan;
> +	vb->shrinker.count_objects = virtio_balloon_shrinker_count;
> +	vb->shrinker.batch = 0;
> +	vb->shrinker.seeks = DEFAULT_SEEKS;
> +
> +	return register_shrinker(&vb->shrinker);
> +}
> +
>  static int virtballoon_probe(struct virtio_device *vdev)
>  {
>  	struct virtio_balloon *vb;
> @@ -580,17 +595,10 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  	if (err)
>  		goto out_free_vb;
>  
> -	vb->nb.notifier_call = virtballoon_oom_notify;
> -	vb->nb.priority = VIRTBALLOON_OOM_NOTIFY_PRIORITY;
> -	err = register_oom_notifier(&vb->nb);
> -	if (err < 0)
> -		goto out_del_vqs;
> -
>  #ifdef CONFIG_BALLOON_COMPACTION
>  	balloon_mnt = kern_mount(&balloon_fs);
>  	if (IS_ERR(balloon_mnt)) {
>  		err = PTR_ERR(balloon_mnt);
> -		unregister_oom_notifier(&vb->nb);
>  		goto out_del_vqs;
>  	}
>  
> @@ -599,13 +607,20 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  	if (IS_ERR(vb->vb_dev_info.inode)) {
>  		err = PTR_ERR(vb->vb_dev_info.inode);
>  		kern_unmount(balloon_mnt);
> -		unregister_oom_notifier(&vb->nb);
>  		vb->vb_dev_info.inode = NULL;
>  		goto out_del_vqs;
>  	}
>  	vb->vb_dev_info.inode->i_mapping->a_ops = &balloon_aops;
>  #endif
> -
> +	/*
> +	 * We continue to use VIRTIO_BALLOON_F_DEFLATE_ON_OOM to decide if a
> +	 * shrinker needs to be registered to relieve memory pressure.
> +	 */
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM)) {
> +		err = virtio_balloon_register_shrinker(vb);
> +		if (err)
> +			goto out_del_vqs;
> +	}
>  	virtio_device_ready(vdev);
>  
>  	if (towards_target(vb))
> @@ -637,8 +652,8 @@ static void virtballoon_remove(struct virtio_device *vdev)
>  {
>  	struct virtio_balloon *vb = vdev->priv;
>  
> -	unregister_oom_notifier(&vb->nb);
> -
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> +		virtio_balloon_unregister_shrinker(vb);
>  	spin_lock_irq(&vb->stop_update_lock);
>  	vb->stop_update = true;
>  	spin_unlock_irq(&vb->stop_update_lock);
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
