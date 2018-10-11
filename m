Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD235C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BDF21476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BDF21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbeJLACe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:02:34 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:55311 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbeJLACe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:02:34 -0400
X-IronPort-AV: E=Sophos;i="5.54,369,1534809600"; 
   d="scan'208";a="80324648"
Date:   Thu, 11 Oct 2018 18:34:27 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Vasilis Liaskovitis <vliaskovitis@suse.com>
CC:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <jgross@suse.com>,
        <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH] xen/blkfront: avoid NULL blkfront_info
 dereference on device removal
Message-ID: <20181011163427.ilpsl4hxb2y3hcfp@mac.bytemobile.com>
References: <20181011162000.19191-1-vliaskovitis@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181011162000.19191-1-vliaskovitis@suse.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 06:20:00PM +0200, Vasilis Liaskovitis wrote:
> If a block device is hot-added when we are out of grants,
> gnttab_grant_foreign_access fails with -ENOSPC (log message "28
> granting access to ring page") in this code path:
> 
>   talk_to_blkback ->
> 	setup_blkring ->
> 		xenbus_grant_ring ->
> 			gnttab_grant_foreign_access
> 
> and the failing path in talk_to_blkback sets the driver_data to NULL:
> 
>  destroy_blkring:
>         blkif_free(info, 0);
> 
>         mutex_lock(&blkfront_mutex);
>         free_info(info);
>         mutex_unlock(&blkfront_mutex);
> 
>         dev_set_drvdata(&dev->dev, NULL);
> 
> This results in a NULL pointer BUG when blkfront_remove and blkif_free
> try to access the failing device's NULL struct blkfront_info.
> 
> Signed-off-by: Vasilis Liaskovitis <vliaskovitis@suse.com>
> ---
>  drivers/block/xen-blkfront.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index 429d20131c7e..92cc6cb6b078 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -2493,6 +2493,9 @@ static int blkfront_remove(struct xenbus_device *xbdev)
>  
>  	dev_dbg(&xbdev->dev, "%s removed", xbdev->nodename);
>  
> +	if (!info)
> +		goto out;

I don't see the point in adding the 'out' label. Can you just return 0
here?

Thanks, Roger.
