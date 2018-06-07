Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ATkeLykHGVs4SAAAmS7hNA
	; Thu, 07 Jun 2018 10:21:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id ADFD8607E7; Thu,  7 Jun 2018 10:21:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C51C2602FC;
	Thu,  7 Jun 2018 10:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C51C2602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932580AbeFGKV0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 06:21:26 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:14126 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932183AbeFGKVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 06:21:25 -0400
X-IronPort-AV: E=Sophos;i="5.49,486,1520899200";
   d="scan'208";a="56620869"
From: Paul Durrant <paul.durrant@citrix.com>
To: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
CC: Paul Durrant <paul.durrant@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] xen/privcmd: fix static checker warning
Date: Thu, 7 Jun 2018 11:21:13 +0100
Message-ID: <1528366873-25430-1-git-send-email-paul.durrant@citrix.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3ad0876554ca ("xen/privcmd: add IOCTL_PRIVCMD_MMAP_RESOURCE")
introduced a static checker warning:

  drivers/xen/privcmd.c:827 privcmd_ioctl_mmap_resource()
  warn: passing casted pointer 'pfns' to 'xen_remap_domain_mfn_array()'
        64 vs 32.

caused by this cast:

   827  num = xen_remap_domain_mfn_array(vma,
   828                                   kdata.addr & PAGE_MASK,
   829                                   pfns, kdata.num, (int *)pfns,
                                                          ^^^^^^^^^^^

The reason for the cast is that xen_remap_domain_mfn_array() requires an
array of ints to store error codes. It is actually safe to re-use the
pfns array for this purpose but it does look odd (as well as leading to
the warning). It would also be easy for a future implementation change
to make this re-use unsafe so this patch modifies privcmd to use a
separately allocated array for error codes.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/xen/privcmd.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 8ae0349..8507c13 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -822,11 +822,18 @@ static long privcmd_ioctl_mmap_resource(struct file *file, void __user *udata)
 		unsigned int domid =
 			(xdata.flags & XENMEM_rsrc_acq_caller_owned) ?
 			DOMID_SELF : kdata.dom;
+		int *errs;
 		int num;
 
+		errs = kcalloc(kdata.num, sizeof(*errs), GFP_KERNEL);
+		if (!errs) {
+			rc = -ENOMEM;
+			goto out;
+		}
+
 		num = xen_remap_domain_mfn_array(vma,
 						 kdata.addr & PAGE_MASK,
-						 pfns, kdata.num, (int *)pfns,
+						 pfns, kdata.num, errs,
 						 vma->vm_page_prot,
 						 domid,
 						 vma->vm_private_data);
@@ -836,12 +843,14 @@ static long privcmd_ioctl_mmap_resource(struct file *file, void __user *udata)
 			unsigned int i;
 
 			for (i = 0; i < num; i++) {
-				rc = pfns[i];
+				rc = errs[i];
 				if (rc < 0)
 					break;
 			}
 		} else
 			rc = 0;
+
+		kfree(errs);
 	}
 
 out:
-- 
2.1.4
