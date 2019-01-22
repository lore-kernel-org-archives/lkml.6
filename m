Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC6DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4F22084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548153694;
	bh=26W6JLi+CBciTQ0AB5yoldXsq3ros9o/VRNxLaEWd7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZZVr6XQdnq1tga7VgaCYXHf7Yfn9bafzMAWnRLpK+0PnXxL0xwXwIVXoz5X3QAOFu
	 H58i28dyI3bFmCTi56RbWTVvAAP55+Ea3iiS6SMYg3p6aUuWP6GFucoyEDAE8AmVmS
	 EvBzXI5/YMpG3xxGTp0AIqN+gReN9orvWAxRmgHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfAVKlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:41:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:45778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfAVKlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:41:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25A9121019;
        Tue, 22 Jan 2019 10:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548153691;
        bh=26W6JLi+CBciTQ0AB5yoldXsq3ros9o/VRNxLaEWd7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sQtxZIJLMZdvCdHVQ0chKXg6ONNT2vYIpKleKF3OEtPAncBzB2Urj91v9ALMdHMYe
         tlCBS77ss2sdZBX7alEvC7lNDs0F9FULvSj6mHBGNbF0qpEI9Eu1rmuQc3iSQkUlNu
         6OXVSY7oT2cBAhOyZsLlbze62VVWdSg/6dTRwXiI=
Date:   Tue, 22 Jan 2019 11:41:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>
Subject: Re: [PATCH 2/8] vop: Cast pointers to uintptr_t
Message-ID: <20190122104129.GA29081@kroah.com>
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
 <20190116163253.23780-3-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116163253.23780-3-vincent.whitchurch@axis.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 05:32:47PM +0100, Vincent Whitchurch wrote:
> Fix these on 32-bit:
> 
>  vop_vringh.c:711:13: error: cast from pointer to integer of different
>  size [-Werror=pointer-to-int-cast]
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/misc/mic/vop/vop_main.c   | 8 ++++----
>  drivers/misc/mic/vop/vop_vringh.c | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
> index 6b212c8b78e7..5a366cf68d95 100644
> --- a/drivers/misc/mic/vop/vop_main.c
> +++ b/drivers/misc/mic/vop/vop_main.c
> @@ -497,7 +497,7 @@ static int _vop_add_device(struct mic_device_desc __iomem *d,
>  	vdev->desc = d;
>  	vdev->dc = (void __iomem *)d + _vop_aligned_desc_size(d);
>  	vdev->dnode = dnode;
> -	vdev->vdev.priv = (void *)(u64)dnode;
> +	vdev->vdev.priv = (void *)(uintptr_t)dnode;

As Joe said, use "unsigned long".  uintptr_t is a userspace type, not a
kernel type.

thanks,

greg k-h
