Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966024AbeBMWbY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 17:31:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:59963 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965900AbeBMWbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 17:31:23 -0500
Date: Tue, 13 Feb 2018 14:22:02 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: tony.luck@intel.com, fenghua.yu@intel.com
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] ia64/err-inject: Use get_user_pages_fast()
Message-ID: <20180213222202.egl4lo3xhj4jr2uv@linux-n805>
References: <20180122172137.26849-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180122172137.26849-1-dave@stgolabs.net>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

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
