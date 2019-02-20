Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288C1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14EB21848
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="x4g9//Af"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfBTUTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:19:05 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36674 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbfBTUTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:19:02 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8X0D087279;
        Wed, 20 Feb 2019 20:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=0lg03zJLVaBGqwjLBLKs78/Wx7pcPDjqBK/bhI6FzTQ=;
 b=x4g9//AfL0MpMsu69Y6hq7AoBMds9YX5yL1OhI5AxZL/LQXRuWBUi0oC4WuGIcn1XAo1
 UZns63sifFX/x0nuectoMd9FXjqfvTC8ozgAr0Q68jx9AFgpHOnECikWTYfRBePPglHG
 0C197uIL8dwHMxhbal2FpqPbVplGnTrBs//LyMSWvmZZe9mdUNSTEKaQQwM/ayVgYgo8
 E0oCP3+cQ/zk05FJF+QnUwbeAetFfXBnj/6/lwHrO1Yob5VTAG8PXdlOXAYgGQD0gT6k
 tIVFF0B2imyafuvg3fytEkSIOc/oWqE5udrUbeFcZ9U7C2e8mgm4kaZ/pbS+YiTKOqN4 0Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2qpb5rktxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:55 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKIsgM030964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:54 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKIs1D010292;
        Wed, 20 Feb 2019 20:18:54 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:18:53 -0800
From:   Joao Martins <joao.m.martins@oracle.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Subject: [PATCH RFC 38/39] xen-blkback: xen_shim_domain() support
Date:   Wed, 20 Feb 2019 20:16:08 +0000
Message-Id: <20190220201609.28290-39-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=810 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With xen_shim_domain() enabled, the struct pages used for grant mappings
are only valid in the interval between GNTTABOP_map_grant_ref and
GNTTABOP_unmap_grant_ref.

Ensure that we do not cache the struct page outside that duration.

Also, update the struct page for the segment after
GNTTABOP_map_grant_ref, for the subsequent tracking or when doing IO.

In addition, we disable persistent grants for this configuration, since
the map/unmap overhead is fairly small (in the fast path, page lookup,
get_page() and put_page().) This reduces the memory usage in
blkback/blkfront.

Co-developed-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 drivers/block/xen-blkback/blkback.c | 19 ++++++++++++++++---
 drivers/block/xen-blkback/xenbus.c  |  5 +++--
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index d51d88be88e1..20c15e6787b1 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -167,6 +167,15 @@ static inline void put_free_pages(struct xen_blkif_ring *ring, struct page **pag
 	unsigned long flags;
 	int i;
 
+	/*
+	 * We don't own the struct page after unmap has been called.
+	 * Reallocation is cheap anyway for the shim domain case, so free it.
+	 */
+	if (xen_shim_domain()) {
+		gnttab_free_pages(num, page);
+		return;
+	}
+
 	spin_lock_irqsave(&ring->free_pages_lock, flags);
 	for (i = 0; i < num; i++)
 		list_add(&page[i]->lru, &ring->free_pages);
@@ -825,7 +834,7 @@ static int xen_blkbk_map(struct xen_blkif_ring *ring,
 	 */
 again:
 	for (i = map_until; i < num; i++) {
-		uint32_t flags;
+		uint32_t flags = 0;
 
 		if (use_persistent_gnts) {
 			persistent_gnt = get_persistent_gnt(
@@ -846,7 +855,8 @@ static int xen_blkbk_map(struct xen_blkif_ring *ring,
 			addr = vaddr(pages[i]->page);
 			pages_to_gnt[segs_to_map] = pages[i]->page;
 			pages[i]->persistent_gnt = NULL;
-			flags = GNTMAP_host_map;
+			if (!xen_shim_domain())
+				flags = GNTMAP_host_map;
 			if (!use_persistent_gnts && ro)
 				flags |= GNTMAP_readonly;
 			gnttab_set_map_op(&map[segs_to_map++], addr,
@@ -880,6 +890,8 @@ static int xen_blkbk_map(struct xen_blkif_ring *ring,
 				goto next;
 			}
 			pages[seg_idx]->handle = map[new_map_idx].handle;
+			if (xen_shim_domain())
+				pages[seg_idx]->page = pages_to_gnt[new_map_idx];
 		} else {
 			continue;
 		}
@@ -1478,7 +1490,7 @@ static int __init xen_blkif_init(void)
 {
 	int rc = 0;
 
-	if (!xen_domain())
+	if (!xen_domain() && !xen_shim_domain_get())
 		return -ENODEV;
 
 	if (xen_blkif_max_ring_order > XENBUS_MAX_RING_GRANT_ORDER) {
@@ -1508,6 +1520,7 @@ static void __exit xen_blkif_exit(void)
 {
 	xen_blkif_interface_exit();
 	xen_blkif_xenbus_exit();
+	xen_shim_domain_put();
 }
 
 module_exit(xen_blkif_exit);
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 424e2efebe85..11be0c052b77 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -871,7 +871,8 @@ static void connect(struct backend_info *be)
 
 	xen_blkbk_barrier(xbt, be, be->blkif->vbd.flush_support);
 
-	err = xenbus_printf(xbt, dev->nodename, "feature-persistent", "%u", 1);
+	err = xenbus_printf(xbt, dev->nodename, "feature-persistent", "%u",
+			    !xen_shim_domain());
 	if (err) {
 		xenbus_dev_fatal(dev, err, "writing %s/feature-persistent",
 				 dev->nodename);
@@ -1059,7 +1060,7 @@ static int connect_ring(struct backend_info *be)
 	}
 	pers_grants = xenbus_read_unsigned(dev->otherend, "feature-persistent",
 					   0);
-	be->blkif->vbd.feature_gnt_persistent = pers_grants;
+	be->blkif->vbd.feature_gnt_persistent = pers_grants && !xen_shim_domain();
 	be->blkif->vbd.overflow_max_grants = 0;
 
 	/*
-- 
2.11.0

