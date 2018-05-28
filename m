Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939341AbeE1OXm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:23:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161901AbeE1KeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:34:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 180/329] ia64/err-inject: Use get_user_pages_fast()
Date: Mon, 28 May 2018 12:01:49 +0200
Message-Id: <20180528100257.326176426@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Davidlohr Bueso <dave@stgolabs.net>

[ Upstream commit 69c907022a7d9325cdc5c9dd064571e445df9a47 ]

At the point of sysfs callback, the call to gup is
done without mmap_sem (or any lock for that matter).
This is racy. As such, use the get_user_pages_fast()
alternative and safely avoid taking the lock, if possible.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/ia64/kernel/err_inject.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/ia64/kernel/err_inject.c
+++ b/arch/ia64/kernel/err_inject.c
@@ -142,7 +142,7 @@ store_virtual_to_phys(struct device *dev
 	u64 virt_addr=simple_strtoull(buf, NULL, 16);
 	int ret;
 
-	ret = get_user_pages(virt_addr, 1, FOLL_WRITE, NULL, NULL);
+	ret = get_user_pages_fast(virt_addr, 1, FOLL_WRITE, NULL);
 	if (ret<=0) {
 #ifdef ERR_INJ_DEBUG
 		printk("Virtual address %lx is not existing.\n",virt_addr);
