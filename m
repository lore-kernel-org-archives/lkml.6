Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68054C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290A52146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="byZj9a47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfBTUTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:19:50 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36676 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbfBTUTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:19:02 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8X0E087279;
        Wed, 20 Feb 2019 20:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=laSsJtG6e1YDxSFuHMs6Owotdsw5hc2nXFNlpfsUZKg=;
 b=byZj9a47q2n/BwPkweTGZr/L+IzWXktfnCkaa6NZ8O/u6MhAitnLTVVtso3MyhvndhX7
 e7qETlpjAcaVPoxXw3zLVOZbCfv3RftZ57K9ByYd/fLxPSrdGWENst96VeJUDYJ9K2lL
 43q3jfKzXkqIJnHP9yS3XONUwgOuIZrmrxDDiR5OOJP1LlyTUc7JxwVso3nYxGONuvKj
 OyfhmJR9QNbIqGsjvYq9FDOgHK6hCnW0vR1aSFes+ENFxCX5wEoo3glfLIsF84SzyJqh
 yQh11jsEE4k/ak6ecBWWBTd2YQn/XN+9muPvRd2ZjfNIzzSnTBGZBxC8ieWx88QlpEV3 5w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2qpb5rktxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:57 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKIp34030809
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:51 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKIpvb010277;
        Wed, 20 Feb 2019 20:18:51 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:18:51 -0800
From:   Joao Martins <joao.m.martins@oracle.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Wei Liu <wei.liu2@citrix.com>,
        Paul Durrant <paul.durrant@citrix.com>
Subject: [PATCH RFC 37/39] xen-netback: xen_shim_domain() support
Date:   Wed, 20 Feb 2019 20:16:07 +0000
Message-Id: <20190220201609.28290-38-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


GNTTABOP_map_grant_ref treats host_address as an OUT parameter for
xen_shim_domain(). After doing gnttab_map_refs, we check each map op
struct and replace the page passed with the page returned by the
hypercall.

Note that mmap_pages is just a placeholder when netback runs in
xen_shim_domain() mode.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/net/xen-netback/netback.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index 80aae3a32c2a..a5dd6de6d3e6 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -324,6 +324,9 @@ struct xenvif_tx_cb {
 
 #define XENVIF_TX_CB(skb) ((struct xenvif_tx_cb *)(skb)->cb)
 
+/* Selects host map only if on native Xen */
+#define GNTTAB_host_map (xen_shim_domain() ? 0 : GNTMAP_host_map)
+
 static inline void xenvif_tx_create_map_op(struct xenvif_queue *queue,
 					   u16 pending_idx,
 					   struct xen_netif_tx_request *txp,
@@ -332,9 +335,12 @@ static inline void xenvif_tx_create_map_op(struct xenvif_queue *queue,
 {
 	queue->pages_to_map[mop-queue->tx_map_ops] = queue->mmap_pages[pending_idx];
 	gnttab_set_map_op(mop, idx_to_kaddr(queue, pending_idx),
-			  GNTMAP_host_map | GNTMAP_readonly,
+			  GNTTAB_host_map | GNTMAP_readonly,
 			  txp->gref, queue->vif->domid);
 
+	if (xen_shim_domain())
+		mop->host_addr = 0;
+
 	memcpy(&queue->pending_tx_info[pending_idx].req, txp,
 	       sizeof(*txp));
 	queue->pending_tx_info[pending_idx].extra_count = extra_count;
@@ -405,6 +411,12 @@ static struct gnttab_map_grant_ref *xenvif_get_requests(struct xenvif_queue *que
 	return gop;
 }
 
+static inline void xenvif_grant_replace_page(struct xenvif_queue *queue,
+					     u16 pending_idx, u32 mapping_idx)
+{
+	queue->mmap_pages[pending_idx] = queue->pages_to_map[mapping_idx];
+}
+
 static inline void xenvif_grant_handle_set(struct xenvif_queue *queue,
 					   u16 pending_idx,
 					   grant_handle_t handle)
@@ -481,6 +493,10 @@ static int xenvif_tx_check_gop(struct xenvif_queue *queue,
 			xenvif_grant_handle_set(queue,
 						pending_idx,
 						gop_map->handle);
+
+			if (!err && xen_shim_domain())
+				xenvif_grant_replace_page(queue, pending_idx,
+						    gop_map - queue->tx_map_ops);
 			/* Had a previous error? Invalidate this fragment. */
 			if (unlikely(err)) {
 				xenvif_idx_unmap(queue, pending_idx);
@@ -1268,7 +1284,7 @@ static inline void xenvif_tx_dealloc_action(struct xenvif_queue *queue)
 				queue->mmap_pages[pending_idx];
 			gnttab_set_unmap_op(gop,
 					    idx_to_kaddr(queue, pending_idx),
-					    GNTMAP_host_map,
+					    GNTTAB_host_map,
 					    queue->grant_tx_handle[pending_idx]);
 			xenvif_grant_handle_reset(queue, pending_idx);
 			++gop;
@@ -1394,7 +1410,7 @@ void xenvif_idx_unmap(struct xenvif_queue *queue, u16 pending_idx)
 
 	gnttab_set_unmap_op(&tx_unmap_op,
 			    idx_to_kaddr(queue, pending_idx),
-			    GNTMAP_host_map,
+			    GNTTAB_host_map,
 			    queue->grant_tx_handle[pending_idx]);
 	xenvif_grant_handle_reset(queue, pending_idx);
 
@@ -1622,7 +1638,7 @@ static int __init netback_init(void)
 {
 	int rc = 0;
 
-	if (!xen_domain())
+	if (!xen_domain() && !xen_shim_domain_get())
 		return -ENODEV;
 
 	/* Allow as many queues as there are CPUs but max. 8 if user has not
@@ -1663,6 +1679,7 @@ static void __exit netback_fini(void)
 	debugfs_remove_recursive(xen_netback_dbg_root);
 #endif /* CONFIG_DEBUG_FS */
 	xenvif_xenbus_fini();
+	xen_shim_domain_put();
 }
 module_exit(netback_fini);
 
-- 
2.11.0

