Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbeDIK4R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:56:17 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:49919 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbeDIK4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:56:16 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Martin Brandenburg <martin@omnibond.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: filemap: provide dummy filemap_page_mkwrite() for NOMMU
Date: Mon,  9 Apr 2018 12:55:42 +0200
Message-Id: <20180409105555.2439976-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:EE+VmxhzKgdjnpRie/TEj6xGj9g/nXlmPg4Cj+fvdxnPjQQrXjq
 89s8+LQpDk8+811FGozGNAA4OZmGmFFbpBRrxABMXWD/GYTOnS6WWJzLBH7A+iOUGYAwK5S
 sPzI+2OEs0CgHgBg7NH563zdJNbNv8pDID0PItXKmS2AxMFaZoHrvmZwW3czHDyaZAi57Sj
 dVGKjTNjGghkVTAqn5iWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dDIBhw359d0=:8X4yPQ7mEBpenIUFFyczLb
 s/CSJYKglFROCVCReeGDtbXQgEL9sVXySikso3wtNX6grO+il+nEkvq6zLfTtE7yJghpAXhmG
 Njma9kLLjkd1pL0jnuGb6Yxq3Bob8IKxigUHR0K1BB9duyFPuTMDR+eYX9iVJiPaHRpWGBqWE
 SZk+BYppXjQKe+7gdL+URBsoLrvsOWjEalW1uuPc3ro5joUWY2nUYqveARcbtvQKRXIUeoZaf
 7S3HlM8PeCl155ZQ3qICcl6eH7eCRtwQwagUYIG03g0/ChKfbxpFWZ2uAqGTCNWBfW953EhmR
 CYr3wfilDB7TmRKz3ZKbZAJZ3opb1cEXorXRHeMkoJAXHy1THPwZ+Wxg09g4Gm2DPAQ5QJebv
 amNw4PUv+nO6T+YYAv3D97TtLm46vdTcKSzu1zVFzGFp+ZRPOK6Y7M4kF/1pnsbIO3NIxm6iK
 1s3FDJheOMyuVg7ZGWm1bq2FfST2MjdvTlHkrruvGNNIOZA+tPSdWF4mUzHN1eayFRt8787hM
 7zv0lozKcNuEmP6wrTg+RLB3apFDuNhSTG/rhZBsiJarFTyBb7XoCsJ6a0aBNF7ahnEtg0gkR
 u3/Q/iRznt7uftKXaRJOJrhURGGWO2T0lWunUPMSG3dRXaMyAnBqlH8v8kLSglcN/SN92hxBS
 xGRl37ukGh9ukLtS1N6ZraWoDny4QTjWCKsiLytxeTTMknhhzef7fMdcfaVMK4R5hFgwUqiou
 diL2h/q3DNy5aeLN0txBcjCrK6oaEBSJCPbSaQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building orangefs on MMU-less machines now results in a link error because
of the newly introduced use of the filemap_page_mkwrite() function:

ERROR: "filemap_page_mkwrite" [fs/orangefs/orangefs.ko] undefined!

This adds a dummy version for it, similar to the existing
generic_file_mmap and generic_file_readonly_mmap stubs in the same file,
to avoid the link error without adding #ifdefs in each file system that
uses these.

Cc: Martin Brandenburg <martin@omnibond.com>
Cc: Mike Marshall <hubcap@omnibond.com>
Fixes: a5135eeab2e5 ("orangefs: implement vm_ops->fault")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/filemap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ab77e19ab09c..9276bdb2343c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2719,7 +2719,6 @@ int filemap_page_mkwrite(struct vm_fault *vmf)
 	sb_end_pagefault(inode->i_sb);
 	return ret;
 }
-EXPORT_SYMBOL(filemap_page_mkwrite);
 
 const struct vm_operations_struct generic_file_vm_ops = {
 	.fault		= filemap_fault,
@@ -2750,6 +2749,10 @@ int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
 	return generic_file_mmap(file, vma);
 }
 #else
+int filemap_page_mkwrite(struct vm_fault *vmf)
+{
+	return -ENOSYS;
+}
 int generic_file_mmap(struct file * file, struct vm_area_struct * vma)
 {
 	return -ENOSYS;
@@ -2760,6 +2763,7 @@ int generic_file_readonly_mmap(struct file * file, struct vm_area_struct * vma)
 }
 #endif /* CONFIG_MMU */
 
+EXPORT_SYMBOL(filemap_page_mkwrite);
 EXPORT_SYMBOL(generic_file_mmap);
 EXPORT_SYMBOL(generic_file_readonly_mmap);
 
-- 
2.9.0
