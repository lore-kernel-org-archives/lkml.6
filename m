Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A9AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1643217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J+xr6Z4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbfBLQPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:15:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40514 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbfBLQPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LQqbCr6+qSa5UurWQh3Ch+PbdM/uV+xVqJMof24jEuI=; b=J+xr6Z4hRlmgFDht1Pouz4vD4
        ytU2sSBCkwtqGIW4dq12xe23soI7sOUht4rh3yVsXTF9mA7KOnKaOakGYAHZG3vd5zM55SULOs+Xc
        MlGRIgCyr8E7+rkDVFmkcV706h/QVAVelTsEDi+DTaMvdicQNTyIWrlN8Q0JEH8d/L1kSIBG7FIN2
        rjnk3uEhPs58eXlXq1zUQiYulHCQ/k5F1Cr4hPu9MCmtqbxslYsIBZQBNZjad4R/OBwZ/qKi5+Kza
        PYgaA/SUMiahlZEIFwvvZSBO7X6EvN5HiGi2ZsTssjnUjSmLODga5xY1p1BcaOOrSlX47xHMctGaR
        rFktGMLAA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtaiW-0003DP-NA; Tue, 12 Feb 2019 16:15:28 +0000
Date:   Tue, 12 Feb 2019 08:15:28 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the xarray tree
Message-ID: <20190212161528.GN12668@bombadil.infradead.org>
References: <20190212162003.1aa1ffbd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212162003.1aa1ffbd@canb.auug.org.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 04:20:03PM +1100, Stephen Rothwell wrote:
> Caused by commit
> 
>   a3e4d3f97ec8 ("XArray: Redesign xa_alloc API")
> 
> interacting with commits
> 
>   e59178d895af ("RDMA/devices: Use xarray to store the clients")
>   0df91bb67334 ("RDMA/devices: Use xarray to store the client_data")
> 
> from the rdma tree.
> 
> Its a bit of a pain modifying a published API like this :-(

Yes, it is.  I wasn't expecting people to actually start using it ;-)

Seriously, there are several defects in the published API which do
warrant a change.  The most severe one is that it's really easy to
forget to initialise the start index.  And while I'm making that change,
I should fix smaller things like the errno at the same time.

> I have added the following merge fixup patch for today (I assume some
> of the assignments are also now redundant).

I think the first of these should be using the alloc_cyclic API, like this:

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 283ecc2aee89..d0b56c70a553 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -586,20 +586,8 @@ static int assign_name(struct ib_device *device, const char *name)
 	}
 	strlcpy(device->name, dev_name(&device->dev), IB_DEVICE_NAME_MAX);
 
-	/* Cyclically allocate a user visible ID for the device */
-	device->index = last_id;
-	ret = xa_alloc(&devices, &device->index, device,
-		       XA_LIMIT(last_id, INT_MAX), GFP_KERNEL);
-	if (ret == -ENOSPC) {
-		device->index = 0;
-		ret = xa_alloc(&devices, &device->index, device,
-			       XA_LIMIT(0, INT_MAX), GFP_KERNEL);
-	}
-	if (ret)
-		goto out;
-	last_id = device->index + 1;
-
-	ret = 0;
+	ret = xa_alloc_cyclic(&devices, &device->index, device, xa_limit_31b,
+			&last_id, GFP_KERNEL);
 
 out:
 	up_write(&devices_rwsem);
@@ -750,7 +738,7 @@ int ib_register_device(struct ib_device *device, const char *name)
 	int ret;
 
 	ret = assign_name(device, name);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	ret = setup_device(device);


