Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0603C71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7016020842
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7016020842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeJOVsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:48:36 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:6549 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeJOVsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:48:36 -0400
X-IronPort-AV: E=Sophos;i="5.54,384,1534809600"; 
   d="scan'208";a="80446795"
Date:   Mon, 15 Oct 2018 16:02:01 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Vasilis Liaskovitis <vliaskovitis@suse.com>
CC:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <jgross@suse.com>,
        <boris.ostrovsky@oracle.com>, <konrad.wilk@oracle.com>,
        <axboe@kernel.dk>
Subject: Re: [PATCH v2] xen/blkfront: avoid NULL blkfront_info dereference on
 device removal
Message-ID: <20181015140201.elir7ettk7sz4aix@mac.bytemobile.com>
References: <20181015132508.23293-1-vliaskovitis@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181015132508.23293-1-vliaskovitis@suse.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 03:25:08PM +0200, Vasilis Liaskovitis wrote:
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

Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>

Thanks.

I guess this is a candidate for backporting?
