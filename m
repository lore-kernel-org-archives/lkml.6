Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754412AbeBNGai (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 01:30:38 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37588 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754204AbeBNGah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 01:30:37 -0500
X-Google-Smtp-Source: AH8x224Q8fRdPzp5N/UJGG7Dm58EXMafclTz0jrT5DIkc/OGDdrcHwHD820c32AQpldPSEnnjRS3kw==
Date: Wed, 14 Feb 2018 09:30:33 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] proc: faster open/close of files without ->release hook
Message-ID: <20180214063033.GA15579@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The whole point of code in fs/proc/inode.c is to make sure ->release
hook is called either at close() or at rmmod time.

All if it is unnecessary if there is no ->release hook.

Save allocation+list manipulations under spinlock in that case.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/inode.c |   41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -342,31 +342,36 @@ static int proc_reg_open(struct inode *inode, struct file *file)
 	 *
 	 * Save every "struct file" with custom ->release hook.
 	 */
-	pdeo = kmalloc(sizeof(struct pde_opener), GFP_KERNEL);
-	if (!pdeo)
-		return -ENOMEM;
-
-	if (!use_pde(pde)) {
-		kfree(pdeo);
+	if (!use_pde(pde))
 		return -ENOENT;
-	}
-	open = pde->proc_fops->open;
+
 	release = pde->proc_fops->release;
+	if (release) {
+		pdeo = kmalloc(sizeof(struct pde_opener), GFP_KERNEL);
+		if (!pdeo) {
+			rv = -ENOMEM;
+			goto out_unuse;
+		}
+	}
 
+	open = pde->proc_fops->open;
 	if (open)
 		rv = open(inode, file);
 
-	if (rv == 0 && release) {
-		/* To know what to release. */
-		pdeo->file = file;
-		pdeo->closing = false;
-		pdeo->c = NULL;
-		spin_lock(&pde->pde_unload_lock);
-		list_add(&pdeo->lh, &pde->pde_openers);
-		spin_unlock(&pde->pde_unload_lock);
-	} else
-		kfree(pdeo);
+	if (release) {
+		if (rv == 0) {
+			/* To know what to release. */
+			pdeo->file = file;
+			pdeo->closing = false;
+			pdeo->c = NULL;
+			spin_lock(&pde->pde_unload_lock);
+			list_add(&pdeo->lh, &pde->pde_openers);
+			spin_unlock(&pde->pde_unload_lock);
+		} else
+			kfree(pdeo);
+	}
 
+out_unuse:
 	unuse_pde(pde);
 	return rv;
 }
