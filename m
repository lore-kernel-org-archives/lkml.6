Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADBCC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4B1218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UlrcON8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbfAaLQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:16:26 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:49257 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAaLQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:16:25 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190131111623epoutp0341cb0da68183715d0093f458a985021f~_6rSZH-n61320613206epoutp03Y
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:16:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190131111623epoutp0341cb0da68183715d0093f458a985021f~_6rSZH-n61320613206epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548933383;
        bh=sfhf/3UFMfCGoHn3PDwcDBqr4pz2R+DUybbdViHJq3Y=;
        h=From:To:Cc:Subject:Date:References:From;
        b=UlrcON8WteywX9SV0cST7Pz3uS8hnU33QcDZVPzXs6RXRmGwuV4MlmI/gNN42WNyv
         pNzal8mstnJ3ZD1gIHnuJTqCgyNn00Its7n6Hw1c/u3ozDM5MKbBX8RyF8OPzguaMW
         IZaJD1j1nll2X2ik1GPpxl4iuyFdAFhaYgHOkq0A=
Received: from epsmges5p1new.samsung.com (unknown [182.195.40.195]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20190131111620epcas5p3127aebc4d57a357500b1e130ac85dbf4~_6rPzP9I11712617126epcas5p3l;
        Thu, 31 Jan 2019 11:16:20 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.B8.04135.409D25C5; Thu, 31 Jan 2019 20:16:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20190131095437epcas5p1501775cdfb469235c6ab9f6f9ab67898~_5j5h1jpy1325413254epcas5p1b;
        Thu, 31 Jan 2019 09:54:37 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190131095437epsmtrp20708cbdbb692501b955dd36a4c4fc0bc~_5j5g1Yg32810228102epsmtrp2o;
        Thu, 31 Jan 2019 09:54:37 +0000 (GMT)
X-AuditID: b6c32a49-bafff70000001027-cc-5c52d90485d4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.64.03601.DD5C25C5; Thu, 31 Jan 2019 18:54:37 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.92.210]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190131095436epsmtip1428b350fe18add3069b315323acd8722~_5j4Renry0856108561epsmtip1h;
        Thu, 31 Jan 2019 09:54:35 +0000 (GMT)
From:   Ayush Mittal <ayush.m@samsung.com>
To:     gregkh@linuxfoundation.org, tj@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     pankaj.m@samsung.com, a.sahrawat@samsung.com, v.narang@samsung.com,
        Ayush Mittal <ayush.m@samsung.com>
Subject: [PATCH 1/1] kernfs: Allocating memory for kernfs_iattrs with
 kmem_cache.
Date:   Thu, 31 Jan 2019 15:13:05 +0530
Message-Id: <1548927785-40397-1-git-send-email-ayush.m@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLKsWRmVeSWpSXmKPExsWy7bCmli7LzaAYg+2HJC0u7k61uPJ7P7tF
        8+L1bBaXd81hs7j3ZiuTxa/lRxktDp2cy+jA7rFpVSebx/65a9g9+rasYvT4vEkugCUqxyYj
        NTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AAlhbLEnFKg
        UEBicbGSvp1NUX5pSapCRn5xia1SakFKToGhUYFecWJucWleul5yfq6VoYGBkSlQZUJOxopX
        L9kLtktWTGyfzdTAuEWki5GTQ0LARGLew07mLkYuDiGB3YwSrxt/skA4nxglmlddZYRwvjFK
        3N95kxmm5cW590wQib2MEg0/tkL1f2GUWNywFqyKTUBD4sCqqSwgtoiAt8TxC4/ZQGxmgRyJ
        29vvgtnCAsES0/cuYQKxWQRUJWZcPAfUy8HBK+AsceEaD8QyOYmTxyazgsyXEPjLKvH+1DJG
        iISLxJs126FsYYlXx7ewQ9hSEp/f7WWDaGhmlHh4uZEJwulhlFg/8wRUh73EgxtH2UG2MQto
        SqzfpQ8RlpWYemodE8ShfBK9v58wQcR5JXbMg7EVJVatOAc1Rlyi+0sX1GIPif0bJoI9LCQQ
        KzH33m2mCYyysxA2LGBkXMUomVpQnJueWmxaYJiXWo4cVZsYwUlLy3MH46xzPocYBTgYlXh4
        H6wNjBFiTSwrrsw9xCjBwawkwst/PShGiDclsbIqtSg/vqg0J7X4EKMpMAQnMkuJJucDE2pe
        SbyhqZGZmYGlgamxhZmhkjjvXNm50UIC6YklqdmpqQWpRTB9TBycUg2MjMJX/p9//eAeQ1z9
        j//z/Wqfsm7YaqK39cuqa0aXS6KCfrPJpO02k2fJveAtVufG8CVt17QIbe55W+dK78n0eLzw
        5qUpjyaLHJQ4uzdLT8T1s+Wyfdn2zMelM3vPuac+uxb0badQ4TnLK7u+Ga97pPF+5pEO0z6V
        K8J5E5smWyi0z5MW+JyZq8RSnJFoqMVcVJwIAOQ5uRBwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmluLIzCtJLcpLzFFi42LZdlhJTvfu0aAYg1l9khYXd6daXPm9n92i
        efF6NovLu+awWdx7s5XJ4tfyo4wWh07OZXRg99i0qpPNY//cNewefVtWMXp83iQXwBLFZZOS
        mpNZllqkb5fAlbHi1Uv2gu2SFRPbZzM1MG4R6WLk5JAQMJF4ce49UxcjF4eQwG5Gib1PV7FD
        JMQlmo9fZYawhSVW/nvODlH0iVHiRudNNpAEm4CGxIFVU1m6GDk4RAT8JW6tKQAJMwsUSGz9
        +QYsLCwQKLH4uC5ImEVAVWLGxXPMIGFeAWeJC9d4IKbLSZw8Npl1AiPPAkaGVYySqQXFuem5
        xYYFRnmp5XrFibnFpXnpesn5uZsYwUGjpbWD8cSJ+EOMAhyMSjy8D9YGxgixJpYVV+YeYpTg
        YFYS4f20JyhGiDclsbIqtSg/vqg0J7X4EKM0B4uSOK98/rFIIYH0xJLU7NTUgtQimCwTB6dU
        A2OY09/T7BJ3OjmPanzh2aZa/dr+6JvO18cYfjx3sTzrtkve+n5nU+3RZ8e27Z9Y8TTgxa/Z
        R1fm3dPUkDx1ZtJT/uvsm6feNzx1cV/OmzXi9cuYeNKnFcvnvnqWdeXVrfbFRyc0vJ02+bgw
        F+fHw+scAvdfOxCm3P+P9fYfI8GMGO3S9IIZ7u3OSizFGYmGWsxFxYkA27FWkxYCAAA=
X-CMS-MailID: 20190131095437epcas5p1501775cdfb469235c6ab9f6f9ab67898
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190131095437epcas5p1501775cdfb469235c6ab9f6f9ab67898
References: <CGME20190131095437epcas5p1501775cdfb469235c6ab9f6f9ab67898@epcas5p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates a new cache for kernfs_iattrs.
Currently, memory is allocated with kzalloc() which always gives aligned memory.
On ARM, this is 64 aligned.
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

All testing has been done on ARM taregt.

Signed-off-by: Ayush Mittal <ayush.m@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
---
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
index ff2716f..e2ff694 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -20,7 +20,7 @@
 
 #include "kernfs-internal.h"
 
-struct kmem_cache *kernfs_node_cache;
+struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
 
 static int kernfs_sop_remount_fs(struct super_block *sb, int *flags, char *data)
 {
@@ -414,4 +414,9 @@ void __init kernfs_init(void)
 					      0,
 					      SLAB_PANIC | SLAB_TYPESAFE_BY_RCU,
 					      NULL);
+	kernfs_iattrs_cache  = kmem_cache_create("kernfs_iattrs_cache",
+					      sizeof(struct kernfs_iattrs),
+					      0,
+					      SLAB_PANIC | SLAB_TYPESAFE_BY_RCU,
+					      NULL);
 }
-- 
1.9.1

