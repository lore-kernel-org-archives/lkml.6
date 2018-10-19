Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D383ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C5F214DD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C5F214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeJSWsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:48:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727506AbeJSWsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:48:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 139EA307D868;
        Fri, 19 Oct 2018 14:41:41 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE3F8694C5;
        Fri, 19 Oct 2018 14:41:40 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id C89324BB74;
        Fri, 19 Oct 2018 14:41:40 +0000 (UTC)
Date:   Fri, 19 Oct 2018 10:41:40 -0400 (EDT)
From:   Xiao Ni <xni@redhat.com>
To:     Jack Wang <xjtuwjp@gmail.com>
Cc:     shli@fb.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jack Wang <jinpu.wang@profitbricks.com>
Message-ID: <1488114196.22211692.1539960100628.JavaMail.zimbra@redhat.com>
In-Reply-To: <1539958891-12412-1-git-send-email-jinpuwang@gmail.com>
References: <1539958891-12412-1-git-send-email-jinpuwang@gmail.com>
Subject: Re: [PATCH] md: fix memleak for mempool
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.68.5.41, 10.4.195.6]
Thread-Topic: fix memleak for mempool
Thread-Index: ft/2GsxceYW/w7stcYDvlBEGJffBbw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 19 Oct 2018 14:41:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
> From: "Jack Wang" <xjtuwjp@gmail.com>
> To: shli@fb.com, linux-raid@vger.kernel.org
> Cc: xni@redhat.com, linux-kernel@vger.kernel.org, "Jack Wang" <jinpu.wang@profitbricks.com>
> Sent: Friday, October 19, 2018 10:21:31 PM
> Subject: [PATCH] md: fix memleak for mempool
> 
> From: Jack Wang <jinpu.wang@profitbricks.com>
> 
> I noticed kmemleak report memory leak when run create/stop
> md in a loop, backtrace:
> [<000000001ca975e7>] mempool_create_node+0x86/0xd0
> [<0000000095576bcd>] md_run+0x1057/0x1410 [md_mod]
> [<000000007b45c5fc>] do_md_run+0x15/0x130 [md_mod]
> [<000000001ede9ec0>] md_ioctl+0x1f49/0x25d0 [md_mod]
> [<000000004142cacf>] blkdev_ioctl+0x680/0xd00
> 
> The root cause is we alloc mddev->flush_pool and
> mddev->flush_bio_pool in md_run, but from do_md_stop
> will not call into md_stop but __md_stop, move the
> mempool_destroy to __md_stop fixes the problem for me.
> 
> The bug was introduced in 5a409b4f56d5, the fixes should go to
> 4.18+
> 
> Cc: Xiao Ni <xni@redhat.com>
> Fixes: 5a409b4f56d5 ("MD: fix lock contention for flush bios")
> Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
> ---
>  drivers/md/md.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 4c0f3e0331d5..feb6145097da 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -5904,14 +5904,6 @@ static void __md_stop(struct mddev *mddev)
>  		mddev->to_remove = &md_redundancy_group;
>  	module_put(pers->owner);
>  	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> -}
> -
> -void md_stop(struct mddev *mddev)
> -{
> -	/* stop the array and free an attached data structures.
> -	 * This is called from dm-raid
> -	 */
> -	__md_stop(mddev);
>  	if (mddev->flush_bio_pool) {
>  		mempool_destroy(mddev->flush_bio_pool);
>  		mddev->flush_bio_pool = NULL;
> @@ -5920,6 +5912,14 @@ void md_stop(struct mddev *mddev)
>  		mempool_destroy(mddev->flush_pool);
>  		mddev->flush_pool = NULL;
>  	}
> +}
> +
> +void md_stop(struct mddev *mddev)
> +{
> +	/* stop the array and free an attached data structures.
> +	 * This is called from dm-raid
> +	 */
> +	__md_stop(mddev);
>  	bioset_exit(&mddev->bio_set);
>  	bioset_exit(&mddev->sync_set);
>  }
> --
> 2.7.4
> 
> 

Reviewed-by: Xiao Ni <xni@redhat.com>
