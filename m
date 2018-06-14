Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AE321C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4A1208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4A1208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754858AbeFNI3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:29:49 -0400
Received: from verein.lst.de ([213.95.11.211]:45136 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752882AbeFNI3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:29:47 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id EB74668C4E; Thu, 14 Jun 2018 10:38:06 +0200 (CEST)
Date:   Thu, 14 Jun 2018 10:38:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Anatoliy Glagolev <glagolig@gmail.com>
Cc:     linux-block@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix bsg_unregister and bsg_open race
Message-ID: <20180614083806.GA18966@lst.de>
References: <20180613221417.GA22778@xldev-tmpl.dev.purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613221417.GA22778@xldev-tmpl.dev.purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 04:14:18PM -0600, Anatoliy Glagolev wrote:
> The existing implementation allows races between bsg_unregister and
> bsg_open paths. bsg_ungegister and request_queue cleanup and
> deletion may start and complete right after bsg_get_device (in bsg_open path)
> retrieves bsg_class_device and releases the mutex. Then bsg_open path
> touches freed memory of bsg_class_device and request_queue.
> 
> One possible fix is to hold the mutex all the way through bsg_get_device
> instead of releasing it after bsg_class_device retrieval.

This looks generally fine to me.  Nitpicks below:

> @@ -746,16 +745,18 @@ static struct bsg_device *bsg_get_device(struct inode *inode, struct file *file)
>  	 */
>  	mutex_lock(&bsg_mutex);
>  	bcd = idr_find(&bsg_minor_idr, iminor(inode));
> -	mutex_unlock(&bsg_mutex);
>  
>  	if (!bcd)
>  		return ERR_PTR(-ENODEV);

This needs to unlock the mutex. E.g.

	if (!bcd) {
		bd = ERR_PTR(-ENODEV);
		goto out_unlock;
	}


>  	bd = __bsg_get_device(iminor(inode), bcd->queue);
> +	if (bd) {
> +		mutex_unlock(&bsg_mutex);
>  		return bd;
> +	}
>  
>  	bd = bsg_add_device(inode, bcd->queue, file);
> +	mutex_unlock(&bsg_mutex);
>  
>  	return bd;

I'd simply do:

	bd = __bsg_get_device(iminor(inode), bcd->queue);
	if (!bd)
		bd = bsg_add_device(inode, bcd->queue, file);
out_unlock:
	mutex_unlock(&bsg_mutex);
	return bd;
