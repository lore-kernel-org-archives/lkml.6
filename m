Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EAFC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A19E218D4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="koMvkKQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfBFGcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 01:32:39 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:37915 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfBFGcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 01:32:39 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190206063236epoutp03b8e32118629112ff2cb01836328e6c76~AsrOQzb0e0332903329epoutp038
        for <linux-kernel@vger.kernel.org>; Wed,  6 Feb 2019 06:32:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190206063236epoutp03b8e32118629112ff2cb01836328e6c76~AsrOQzb0e0332903329epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549434756;
        bh=vVZTdYXbwHE4w8IuhSziQbRjiHLfEdyagazLnYef0mY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=koMvkKQmqa5NiO+paBaeGwQqBhsM8CW3wnvyGA2xkv1GLMi8jscad2lmsaZMTSUJx
         T5N2hhNz9Sv353hTvVHKqKePuJBfJmIQsSBweWNPnBarya2Dq08OX5Y+xRO9IG9uQJ
         YBzhuwUd6sZmKYvDbYVzpMJVFTIpPC31XQV3BeNs=
Received: from epsmges5p1new.samsung.com (unknown [182.195.40.198]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20190206063233epcas5p360744b2df63976c5a7d7175ae159fdf9~AsrML-cbi2582125821epcas5p3G;
        Wed,  6 Feb 2019 06:32:33 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.B3.04135.18F7A5C5; Wed,  6 Feb 2019 15:32:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20190206050507epcas5p30ea6ad0f13693aeacbf41088d2c380a5~Are2Zag7N2666926669epcas5p3Z;
        Wed,  6 Feb 2019 05:05:07 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190206050507epsmtrp16d6693155a03e67e16621d77993ead9a~Are2YbaE11312913129epsmtrp1m;
        Wed,  6 Feb 2019 05:05:07 +0000 (GMT)
X-AuditID: b6c32a49-bafff70000001027-c4-5c5a7f81f47c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.A0.03601.30B6A5C5; Wed,  6 Feb 2019 14:05:07 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.92.210]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190206050506epsmtip261f288c96467bb0baf78a5971cb92ba3~Are08Vxf90547805478epsmtip2Q;
        Wed,  6 Feb 2019 05:05:06 +0000 (GMT)
From:   Ayush Mittal <ayush.m@samsung.com>
To:     gregkh@linuxfoundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     pankaj.m@samsung.com, a.sahrawat@samsung.com, v.narang@samsung.com,
        Ayush Mittal <ayush.m@samsung.com>
Subject: [PATCH v2] kernfs: Allocating memory for kernfs_iattrs with
 kmem_cache.
Date:   Wed,  6 Feb 2019 10:25:42 +0530
Message-Id: <1549428942-5466-1-git-send-email-ayush.m@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDKsWRmVeSWpSXmKPExsWy7bCmhm5jfVSMQcMjY4uLu1Mtrvzez27R
        vHg9m8XlXXPYLO692cpk8Wv5UUaLQyfnMjqwe2xa1cnmsX/uGnaPvi2rGD0+b5ILYInKsclI
        TUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOkBJoSwxpxQo
        FJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BoVKBXnJhbXJqXrpecn2tlaGBgZApUmZCTcbnL
        sOC5ZMWa19PYGxifiXQxcnJICJhIXPxylKWLkYtDSGA3o8TPzdPZIJxPjBJbD35gh3C+MUps
        nvScFaZl+tdrUC17GSXmndrMBOF8YZRYc2kBG0gVm4CGxIFVU1lAbBEBb4njFx6DxZkFciRu
        b78LZgsLBEls3X+KGcRmEVCV+Hl1FROIzSvgJHGnfw8LxDY5iZPHJrOCLJAQ+MkqsXXfXjaI
        hIvE+eV3mSFsYYlXx7ewQ9hSEi/729ghGpoZJR5ebmSCcHoYJdbPPMEIUWUv8eDGUaAqDqCT
        NCXW79KHCMtKTD21jgniUj6J3t9PmCDivBI75sHYihKrVpyDGiMu0f2lC2qxh8Ti70cZQUYK
        CcRK/HpQOIFRdhbCggWMjKsYJVMLinPTU4tNCwzzUsuRY2oTIzhlaXnuYJx1zucQowAHoxIP
        r0Z3ZIwQa2JZcWXuIUYJDmYlEd6msqgYId6UxMqq1KL8+KLSnNTiQ4ymwBCcyCwlmpwPTKd5
        JfGGpkZmZgaWBqbGFmaGSuK8c2XnRgsJpCeWpGanphakFsH0MXFwSjUwLuzMYhV/u9kx+cKE
        7QaCx1+dbJi4dueGlkscvwSOWx/UevTkSGKSYJtEZc+T0keGxY6sevazYz6prTRk7w/wPasi
        3bVd8vT96vZYxR26R0q6NieGFxqJbvW/m+fy68Yx86nbIoPnG18xv71NdaXd+aKLD9Lb9D75
        P3laU3C9rz7Kh9NOZ6G2EktxRqKhFnNRcSIArb492W8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphluLIzCtJLcpLzFFi42LZdlhJXpc5OyrGYPVCPYuLu1Mtrvzez27R
        vHg9m8XlXXPYLO692cpk8Wv5UUaLQyfnMjqwe2xa1cnmsX/uGnaPvi2rGD0+b5ILYInisklJ
        zcksSy3St0vgyrjcZVjwXLJizetp7A2Mz0S6GDk5JARMJKZ/vcbSxcjFISSwm1GiccJCRoiE
        uETz8avMELawxMp/z9khij4xStxb84QNJMEmoCFxYNVUoG4ODhEBf4lbawpAwswCBRJbf75h
        AbGFBQIkZvS+ALNZBFQlfl5dxQRi8wo4Sdzp38MCMV9O4uSxyawTGHkWMDKsYpRMLSjOTc8t
        Niwwykst1ytOzC0uzUvXS87P3cQIDhstrR2MJ07EH2IU4GBU4uG90BEZI8SaWFZcmXuIUYKD
        WUmEt9EpKkaINyWxsiq1KD++qDQntfgQozQHi5I4r3z+sUghgfTEktTs1NSC1CKYLBMHp1QD
        o6p0wq2COANfXr0Ix+9SEW96y6y22Dw8Kbd4bcK8XB62VKeTi777fs640qqj/brxCO+1Z9NO
        FOVdcNCfmqYy/+upeYpzJB7IPH35/mvSohznum9N73MONpt6vZt4j8uU8elu1y2L9I8/tLVy
        Yc5cFrFgwnMXNa9Jj4xfdAY6qLx/dWX3pa01e5VYijMSDbWYi4oTAUGkP7sXAgAA
X-CMS-MailID: 20190206050507epcas5p30ea6ad0f13693aeacbf41088d2c380a5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190206050507epcas5p30ea6ad0f13693aeacbf41088d2c380a5
References: <CGME20190206050507epcas5p30ea6ad0f13693aeacbf41088d2c380a5@epcas5p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creating a new cache for kernfs_iattrs.
Currently, memory is allocated with kzalloc() which
always gives aligned memory. On ARM, this is 64 byte aligned.
To avoid the wastage of memory in aligning the size requested,
a new cache for kernfs_iattrs is created.

Size of struct kernfs_iattrs is 80 Bytes.
On ARM, it will come in kmalloc-128 slab.
and it will come in kmalloc-192 slab if debug info is enabled.
Extra bytes taken 48 bytes.

Total number of objects created : 4096
Total saving = 48*4096 = 192 KB

After creating new slab(When debug info is enabled) :
sh-3.2# cat /proc/slabinfo
...
kernfs_iattrs_cache   4069   4096    128   32    1 : tunables    0    0    0 : slabdata    128    128      0
...

All testing has been done on ARM target.

Signed-off-by: Ayush Mittal <ayush.m@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
---
v1 -> v2: Changed slab creation flag.

 fs/kernfs/dir.c             | 2 +-
 fs/kernfs/inode.c           | 2 +-
 fs/kernfs/kernfs-internal.h | 2 +-
 fs/kernfs/mount.c           | 7 ++++++-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 4ca0b5c..b84d635 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -536,8 +536,8 @@ void kernfs_put(struct kernfs_node *kn)
 			security_release_secctx(kn->iattr->ia_secdata,
 						kn->iattr->ia_secdata_len);
 		simple_xattrs_free(&kn->iattr->xattrs);
+		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
 	}
-	kfree(kn->iattr);
 	spin_lock(&kernfs_idr_lock);
 	idr_remove(&root->ino_idr, kn->id.ino);
 	spin_unlock(&kernfs_idr_lock);
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 80cebcd..0c1fd94 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -42,7 +42,7 @@ static struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn)
 	if (kn->iattr)
 		goto out_unlock;
 
-	kn->iattr = kzalloc(sizeof(struct kernfs_iattrs), GFP_KERNEL);
+	kn->iattr = kmem_cache_zalloc(kernfs_iattrs_cache, GFP_KERNEL);
 	if (!kn->iattr)
 		goto out_unlock;
 	iattrs = &kn->iattr->ia_iattr;
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 3d83b11..dba810c 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -78,7 +78,7 @@ static inline struct kernfs_node *kernfs_dentry_node(struct dentry *dentry)
 }
 
 extern const struct super_operations kernfs_sops;
-extern struct kmem_cache *kernfs_node_cache;
+extern struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
 
 /*
  * inode.c
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index fdf527b..450eb38 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -20,7 +20,7 @@
 
 #include "kernfs-internal.h"
 
-struct kmem_cache *kernfs_node_cache;
+struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
 
 static int kernfs_sop_remount_fs(struct super_block *sb, int *flags, char *data)
 {
@@ -417,4 +417,9 @@ void __init kernfs_init(void)
 					      0,
 					      SLAB_PANIC | SLAB_TYPESAFE_BY_RCU,
 					      NULL);
+
+	/* Creates slab cache for kernfs inode attributes */
+	kernfs_iattrs_cache  = kmem_cache_create("kernfs_iattrs_cache",
+					      sizeof(struct kernfs_iattrs),
+					      0, SLAB_PANIC, NULL);
 }
-- 
1.9.1

