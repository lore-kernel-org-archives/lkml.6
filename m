Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77892C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3793020881
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3793020881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388577AbeGXMLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:11:04 -0400
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:37330 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388307AbeGXMLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:11:03 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2001:1bc8:1a6:d3d5::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 3826C634C7F;
        Tue, 24 Jul 2018 14:05:08 +0300 (EEST)
Received: from sakke by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1fhv7s-0008O2-0P; Tue, 24 Jul 2018 14:05:08 +0300
Date:   Tue, 24 Jul 2018 14:05:07 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 14/26] media: Convert entity ID allocation to new IDA API
Message-ID: <20180724110507.idyjc3vbbivwbxtb@valkosipuli.retiisi.org.uk>
References: <20180621212835.5636-1-willy@infradead.org>
 <20180621212835.5636-15-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621212835.5636-15-willy@infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 02:28:23PM -0700, Matthew Wilcox wrote:
> Removes a call to ida_pre_get().
> 
> Signed-off-by: Matthew Wilcox <willy@infradead.org>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> ---
>  drivers/media/media-device.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/media-device.c b/drivers/media/media-device.c
> index ae59c3177555..d51088bcd735 100644
> --- a/drivers/media/media-device.c
> +++ b/drivers/media/media-device.c
> @@ -575,18 +575,12 @@ int __must_check media_device_register_entity(struct media_device *mdev,
>  	entity->num_links = 0;
>  	entity->num_backlinks = 0;
>  
> -	if (!ida_pre_get(&mdev->entity_internal_idx, GFP_KERNEL))
> -		return -ENOMEM;
> -
> -	mutex_lock(&mdev->graph_mutex);
> -
> -	ret = ida_get_new_above(&mdev->entity_internal_idx, 1,
> -				&entity->internal_idx);
> -	if (ret < 0) {
> -		mutex_unlock(&mdev->graph_mutex);
> +	ret = ida_alloc_min(&mdev->entity_internal_idx, 1, GFP_KERNEL);
> +	if (ret < 0)
>  		return ret;
> -	}
> +	entity->internal_idx = ret;
>  
> +	mutex_lock(&mdev->graph_mutex);
>  	mdev->entity_internal_idx_max =
>  		max(mdev->entity_internal_idx_max, entity->internal_idx);
>  
> @@ -632,7 +626,7 @@ static void __media_device_unregister_entity(struct media_entity *entity)
>  	struct media_interface *intf;
>  	unsigned int i;
>  
> -	ida_simple_remove(&mdev->entity_internal_idx, entity->internal_idx);
> +	ida_free(&mdev->entity_internal_idx, entity->internal_idx);
>  
>  	/* Remove all interface links pointing to this entity */
>  	list_for_each_entry(intf, &mdev->interfaces, graph_obj.list) {

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi
