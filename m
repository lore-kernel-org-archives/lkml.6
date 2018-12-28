Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0253CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCE520869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387829AbeL1Ter (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:34:47 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:34776 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729398AbeL1Ter (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 14:34:47 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id ABB1114F033E3;
        Fri, 28 Dec 2018 11:34:46 -0800 (PST)
Date:   Fri, 28 Dec 2018 11:34:44 -0800 (PST)
Message-Id: <20181228.113444.2162917443074434767.davem@davemloft.net>
To:     jasowang@redhat.com
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 3/3] vhost: access vq metadata through kernel
 virtual address
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181228075537.21402-4-jasowang@redhat.com>
References: <20181228075537.21402-1-jasowang@redhat.com>
        <20181228075537.21402-4-jasowang@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 28 Dec 2018 11:34:46 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Dec 2018 15:55:37 +0800

> +static int vhost_invalidate_vmap(struct vhost_virtqueue *vq,
> +				 struct vhost_vmap *map,
> +				 unsigned long uaddr,
> +				 unsigned long start,
> +				 unsigned long end,
> +				 bool blockable)
> +{
> +	if (start < uaddr && end >= uaddr) {
> +		if (!blockable)
> +			return -EAGAIN;
> +		mutex_lock(&vq->mutex);
> +		if (map->addr)
> +			vunmap(map->unmap_addr);
> +		map->addr = NULL;
> +		map->unmap_addr = NULL;
> +		mutex_unlock(&vq->mutex);
> +	}
> +
> +	return 0;
> +}

What are the rules for these invalidate operations?

Can there be partial overlaps?  If so, wouldn't you need some way of
keeping track of the partially overlapping unmaps so that once all of
the invalidates covering the range occur you properly cleanup and do
the vunmap()?
