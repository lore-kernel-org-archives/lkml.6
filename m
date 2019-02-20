Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4653C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B48E2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L7GnQZKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfBTUTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:19:04 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34258 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfBTUSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:18:54 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8VMo087440;
        Wed, 20 Feb 2019 20:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=nEoaALBLcsNsxHnJFDNeJyCL6A1vZHWL3Ev7hoUXOR8=;
 b=L7GnQZKkBuiZR6S84VaVdAO/PMf0RxkH2Ijy80O0lmcjcqbkn3ABj626knGXcZaDVUIF
 BDZWhrJlcEoHOpGhhTwFiolKxI76K9L/u8TuTNtXXnddgsuZUbCMZDdVop3NkH9ofrmZ
 6s56Y77lgri2vfCxVvz0a9Dye5kPNQzpcJ+7/517VfOVDd4yOxmFEaxPUbYVY3C4pc94
 xGbzKEQoKeN4W693bFRat7J9Eqs6C4ISUQgwDNHL6AFYDk7o8HXyVPGhtXBDTQZnhsqA
 eZJDc/2CZtc9oB5sx3xpxHM+YLbrEsYV8Z5ID7iqZkzZaXRt0LFOc7rBUc+ouprS+exQ Lg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qp81ec3f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:47 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKIkdD020684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:46 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1KKIkfj019110;
        Wed, 20 Feb 2019 20:18:46 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:18:45 -0800
From:   Joao Martins <joao.m.martins@oracle.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH RFC 35/39] xen/xenbus: xen_shim_domain() support
Date:   Wed, 20 Feb 2019 20:16:05 +0000
Message-Id: <20190220201609.28290-36-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ankur Arora <ankur.a.arora@oracle.com>

Fixup the gnttab unmap_ops (and other data structures) to handle
host_addr as an OUT parameter from the call to GNTTABOP_map_grant_ref.

Also, allow xenstored to be hosted in XS_LOCAL mode for
xen_shim_domain() -- this means that it does not need to acquire
xenstore evtchn and pfn externally.

Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/xen/xenbus/xenbus_client.c       | 23 +++++++++++++++++------
 drivers/xen/xenbus/xenbus_dev_backend.c  |  4 ++--
 drivers/xen/xenbus/xenbus_dev_frontend.c |  4 ++--
 drivers/xen/xenbus/xenbus_probe.c        |  8 ++++----
 4 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index ada1c9aa6525..b22149a789d4 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -487,8 +487,11 @@ static int __xenbus_map_ring(struct xenbus_device *dev,
 					 "mapping in shared page %d from domain %d",
 					 gnt_refs[i], dev->otherend_id);
 			goto fail;
-		} else
+		} else {
 			handles[i] = map[i].handle;
+			if (xen_shim_domain())
+				addrs[i] = map[i].host_addr;
+		}
 	}
 
 	return GNTST_okay;
@@ -498,7 +501,8 @@ static int __xenbus_map_ring(struct xenbus_device *dev,
 		if (handles[i] != INVALID_GRANT_HANDLE) {
 			memset(&unmap[j], 0, sizeof(unmap[j]));
 			gnttab_set_unmap_op(&unmap[j], (phys_addr_t)addrs[i],
-					    GNTMAP_host_map, handles[i]);
+					    !xen_shim_domain()?GNTMAP_host_map:0,
+					    handles[i]);
 			j++;
 		}
 	}
@@ -546,7 +550,7 @@ static int xenbus_map_ring_valloc_hvm(struct xenbus_device *dev,
 				      void **vaddr)
 {
 	struct xenbus_map_node *node;
-	int err;
+	int i, err;
 	void *addr;
 	bool leaked = false;
 	struct map_ring_valloc_hvm info = {
@@ -572,9 +576,16 @@ static int xenbus_map_ring_valloc_hvm(struct xenbus_device *dev,
 			     &info);
 
 	err = __xenbus_map_ring(dev, gnt_ref, nr_grefs, node->handles,
-				info.phys_addrs, GNTMAP_host_map, &leaked);
+				info.phys_addrs,
+				!xen_shim_domain() ? GNTMAP_host_map : 0,
+				&leaked);
 	node->nr_handles = nr_grefs;
 
+	if (xen_shim_domain()) {
+		for (i = 0; i < nr_grefs; i++)
+			node->hvm.pages[i] = virt_to_page(info.phys_addrs[i]);
+	}
+
 	if (err)
 		goto out_free_ballooned_pages;
 
@@ -882,7 +893,7 @@ int xenbus_unmap_ring(struct xenbus_device *dev,
 
 	for (i = 0; i < nr_handles; i++)
 		gnttab_set_unmap_op(&unmap[i], vaddrs[i],
-				    GNTMAP_host_map, handles[i]);
+				    !xen_shim_domain()?GNTMAP_host_map:0, handles[i]);
 
 	if (HYPERVISOR_grant_table_op(GNTTABOP_unmap_grant_ref, unmap, i))
 		BUG();
@@ -926,7 +937,7 @@ static const struct xenbus_ring_ops ring_ops_hvm = {
 	.unmap = xenbus_unmap_ring_vfree_hvm,
 };
 
-void __init xenbus_ring_ops_init(void)
+void xenbus_ring_ops_init(void)
 {
 #ifdef CONFIG_XEN_PV
 	if (!xen_feature(XENFEAT_auto_translated_physmap))
diff --git a/drivers/xen/xenbus/xenbus_dev_backend.c b/drivers/xen/xenbus/xenbus_dev_backend.c
index edba5fecde4d..b605c87bff76 100644
--- a/drivers/xen/xenbus/xenbus_dev_backend.c
+++ b/drivers/xen/xenbus/xenbus_dev_backend.c
@@ -119,11 +119,11 @@ static struct miscdevice xenbus_backend_dev = {
 	.fops = &xenbus_backend_fops,
 };
 
-static int __init xenbus_backend_init(void)
+int xenbus_backend_init(void)
 {
 	int err;
 
-	if (!xen_initial_domain())
+	if (!xen_initial_domain() && !xen_shim_domain())
 		return -ENODEV;
 
 	err = misc_register(&xenbus_backend_dev);
diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c b/drivers/xen/xenbus/xenbus_dev_frontend.c
index a4080d04a01c..c6fca6cca6c8 100644
--- a/drivers/xen/xenbus/xenbus_dev_frontend.c
+++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
@@ -680,11 +680,11 @@ static struct miscdevice xenbus_dev = {
 	.fops = &xen_xenbus_fops,
 };
 
-static int __init xenbus_frontend_init(void)
+static int xenbus_frontend_init(void)
 {
 	int err;
 
-	if (!xen_domain())
+	if (!xen_domain() && !xen_shim_domain())
 		return -ENODEV;
 
 	err = misc_register(&xenbus_dev);
diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 2e0ed46b05e7..bbc405cd01ef 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -693,7 +693,7 @@ EXPORT_SYMBOL_GPL(xenbus_probe);
 
 static int __init xenbus_probe_initcall(void)
 {
-	if (!xen_domain())
+	if (!xen_domain() && !xen_shim_domain())
 		return -ENODEV;
 
 	if (xen_initial_domain() || xen_hvm_domain())
@@ -790,7 +790,7 @@ int xenbus_init(void)
 	uint64_t v = 0;
 	xen_store_domain_type = XS_UNKNOWN;
 
-	if (!xen_domain())
+	if (!xen_domain() && !xen_shim_domain())
 		return -ENODEV;
 
 	xenbus_ring_ops_init();
@@ -799,7 +799,7 @@ int xenbus_init(void)
 		xen_store_domain_type = XS_PV;
 	if (xen_hvm_domain())
 		xen_store_domain_type = XS_HVM;
-	if (xen_hvm_domain() && xen_initial_domain())
+	if ((xen_hvm_domain() && xen_initial_domain()) || xen_shim_domain())
 		xen_store_domain_type = XS_LOCAL;
 	if (xen_pv_domain() && !xen_start_info->store_evtchn)
 		xen_store_domain_type = XS_LOCAL;
@@ -863,7 +863,7 @@ postcore_initcall(xenbus_init);
 
 void xenbus_deinit(void)
 {
-	if (!xen_domain())
+	if (!xen_domain() && !xen_shim_domain())
 		return;
 
 #ifdef CONFIG_XEN_COMPAT_XENFS
-- 
2.11.0

