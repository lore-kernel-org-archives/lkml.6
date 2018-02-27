Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeB0RZm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 12:25:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:49122 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750919AbeB0RZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 12:25:41 -0500
Date: Tue, 27 Feb 2018 09:16:09 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org, tony.luck@intel.com, fenghua.yu@intel.com
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] ia64/err-inject: Use get_user_pages_fast()
Message-ID: <20180227171609.jdt73iqx56kmybrl@linux-n805>
References: <20180122172137.26849-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180122172137.26849-1-dave@stgolabs.net>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, if you're ok with the patch below, could it be routed
your way?

Thanks,
Davidlohr

On Mon, 22 Jan 2018, Davidlohr Bueso wrote:

>At the point of sysfs callback, the call to gup is
>done without mmap_sem (or any lock for that matter).
>This is racy. As such, use the get_user_pages_fast()
>alternative and safely avoid taking the lock, if possible.
>
>Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
>---
> arch/ia64/kernel/err_inject.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/ia64/kernel/err_inject.c b/arch/ia64/kernel/err_inject.c
>index 85bba43e7d5d..658a8e06a69b 100644
>--- a/arch/ia64/kernel/err_inject.c
>+++ b/arch/ia64/kernel/err_inject.c
>@@ -142,7 +142,7 @@ store_virtual_to_phys(struct device *dev, struct device_attribute *attr,
> 	u64 virt_addr=simple_strtoull(buf, NULL, 16);
> 	int ret;
>
>-	ret = get_user_pages(virt_addr, 1, FOLL_WRITE, NULL, NULL);
>+	ret = get_user_pages_fast(virt_addr, 1, FOLL_WRITE, NULL);
> 	if (ret<=0) {
> #ifdef ERR_INJ_DEBUG
> 		printk("Virtual address %lx is not existing.\n",virt_addr);
>-- 
>2.13.6
>
