Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF819ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E49D2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E49D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbeGRVNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:13:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbeGRVNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:13:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 702715F73D;
        Wed, 18 Jul 2018 20:33:37 +0000 (UTC)
Received: from t450s.home (ovpn-116-29.phx2.redhat.com [10.3.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3ABB819485;
        Wed, 18 Jul 2018 20:33:37 +0000 (UTC)
Date:   Wed, 18 Jul 2018 14:33:36 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: Fix potential Spectre v1
Message-ID: <20180718143336.103279e1@t450s.home>
In-Reply-To: <20180717173900.GA24627@embeddedor.com>
References: <20180717173900.GA24627@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 18 Jul 2018 20:33:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018 12:39:00 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> info.index can be indirectly controlled by user-space, hence leading
> to a potential exploitation of the Spectre variant 1 vulnerability.
> 
> This issue was detected with the help of Smatch:
> 
> drivers/vfio/pci/vfio_pci.c:734 vfio_pci_ioctl()
> warn: potential spectre issue 'vdev->region'
> 
> Fix this by sanitizing info.index before indirectly using it to index
> vdev->region
> 
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
> 
> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/vfio/pci/vfio_pci.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied to vfio for-linus branch for v4.18.  Thanks!

Alex


> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index b423a30..125b58e 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -28,6 +28,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/vfio.h>
>  #include <linux/vgaarb.h>
> +#include <linux/nospec.h>
>  
>  #include "vfio_pci_private.h"
>  
> @@ -727,6 +728,9 @@ static long vfio_pci_ioctl(void *device_data,
>  			if (info.index >=
>  			    VFIO_PCI_NUM_REGIONS + vdev->num_regions)
>  				return -EINVAL;
> +			info.index = array_index_nospec(info.index,
> +							VFIO_PCI_NUM_REGIONS +
> +							vdev->num_regions);
>  
>  			i = info.index - VFIO_PCI_NUM_REGIONS;
>  

