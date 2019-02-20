Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD9BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB502146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3d3E4nAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfBTUT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:19:59 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36402 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbfBTUSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:18:48 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8q7r087687;
        Wed, 20 Feb 2019 20:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Q0vNiEu8C1xVftpLfrPYy6je6m9dd4hOUd4QG/a02TY=;
 b=3d3E4nAra5kn7VEKjXGgHnWDCQ+AoVXbep3lcjzOtPqjQNiphlNJ33AzrOvGcnJPGa9N
 a1Gbz0HKCfxI12qxxuynWPVPIAnvJdCN6Br5n26ypxXHVFaTk37eNjty8K4hGzZZOrIf
 ar8KoBAw3dZbdIZC/W2zEOoAAFI2UVoPX81Ssfy+83vLPNfsfM+jcypDcIQTfd7I7Ztq
 jvyGT0EzU/GQwoOI9fAnjHHnDiu6slHzL59kfnQq10ArrVMNGDOh7W5vdxExjDgy4hZL
 dZoNTjd747JtABjMse/G8ac5a2B48IcExQE6TK06LfBCVfriqUMW9+S3WwxXiiOu7n8Q PA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2qpb5rktvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:41 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKIeNX025682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:41 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKIeWm010196;
        Wed, 20 Feb 2019 20:18:40 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:18:40 -0800
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
Subject: [PATCH RFC 33/39] xen/grant-table: xen_shim_domain() support
Date:   Wed, 20 Feb 2019 20:16:03 +0000
Message-Id: <20190220201609.28290-34-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190220201609.28290-1-joao.m.martins@oracle.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=952 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902200138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With xen-shim, allocate_xenballooned_pages() only allocates a
place-holder page (pfn 0) expecting a subsequent map_grant_ref to fix
it up.

However, this means that, until the grant operation
(GNTTABOP_map_grant_ref) provides a valid page, we cannot set
PagePrivate or save any state.

This patch elides the setting of that state if xen_shim_domain(). In
addition, gnttab_map_refs() now fills in the appropriate page returned
from the grant operation.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/xen/grant-table.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 7ea6fb6a2e5d..ab05b70d98bb 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -804,7 +804,7 @@ int gnttab_alloc_pages(int nr_pages, struct page **pages)
 	int ret;
 
 	ret = alloc_xenballooned_pages(nr_pages, pages);
-	if (ret < 0)
+	if (ret < 0 || xen_shim_domain())
 		return ret;
 
 	ret = gnttab_pages_set_private(nr_pages, pages);
@@ -1045,6 +1045,11 @@ int gnttab_map_refs(struct gnttab_map_grant_ref *map_ops,
 		{
 			struct xen_page_foreign *foreign;
 
+			if (xen_shim_domain()) {
+				pages[i] = virt_to_page(map_ops[i].host_addr);
+				continue;
+			}
+
 			SetPageForeign(pages[i]);
 			foreign = xen_page_foreign(pages[i]);
 			foreign->domid = map_ops[i].dom;
@@ -1085,8 +1090,10 @@ int gnttab_unmap_refs(struct gnttab_unmap_grant_ref *unmap_ops,
 	if (ret)
 		return ret;
 
-	for (i = 0; i < count; i++)
-		ClearPageForeign(pages[i]);
+	for (i = 0; i < count; i++) {
+		if (!xen_shim_domain())
+			ClearPageForeign(pages[i]);
+	}
 
 	return clear_foreign_p2m_mapping(unmap_ops, kunmap_ops, pages, count);
 }
@@ -1113,7 +1120,7 @@ static void __gnttab_unmap_refs_async(struct gntab_unmap_queue_data* item)
 	int pc;
 
 	for (pc = 0; pc < item->count; pc++) {
-		if (page_count(item->pages[pc]) > 1) {
+		if (page_count(item->pages[pc]) > 1 && !xen_shim_domain()) {
 			unsigned long delay = GNTTAB_UNMAP_REFS_DELAY * (item->age + 1);
 			schedule_delayed_work(&item->gnttab_work,
 					      msecs_to_jiffies(delay));
-- 
2.11.0

