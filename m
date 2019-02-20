Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD822C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8887921908
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fEydcBYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfBTUT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:19:58 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54318 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfBTUT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:19:57 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8qDU081939;
        Wed, 20 Feb 2019 20:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=NTxOcurqJlQlCOmdT9Cg4RcY8w77Z669tNvu7Rl2B6U=;
 b=fEydcBYmCx/tjgu15N7dbOIE0EU5eFtRpT5j0YjNrZqPj9jXx1LM7r10/PRHAjlttaSR
 5An38nBBVf8/StS0LCjeqK+02rd6CDpvXSotOc0vKrdsrzPi5ksKquLfk4+BhcUCNwYr
 /RVsNmR5Tq31CMgw7SfXxaW3yro+vFz6A/f+NhhL31hlk8gd0tMFWwRj9mLtnjUi3VDl
 /dLFHluxBLAdd1zj8lMnNwT8wykSPFpRyiRWqMQxFZWai/WoYGuOjfyWAnNx3UkyYFhu
 epq4+VLpxoogmD/SfiZeCkdpeSAxU/f0D/nrRi3odnGNr9Qnws6MJCzDDjIlr88+80pm 0w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qp9xu3xnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:39 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKIcSo025549
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:39 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKIbUF012376;
        Wed, 20 Feb 2019 20:18:38 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:18:37 -0800
From:   Joao Martins <joao.m.martins@oracle.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH RFC 32/39] xen/balloon: xen_shim_domain() support
Date:   Wed, 20 Feb 2019 20:16:02 +0000
Message-Id: <20190220201609.28290-33-joao.m.martins@oracle.com>
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

Xen ballooning uses hollow struct pages (with the underlying PFNs being
populated/unpopulated via hypercalls) which are used by the grant logic
to map grants from other domains.

For purposes of a KVM based xen-shim, this model is not useful --
mapping is unnecessary since all guest memory is already mapped in the
KVM host. The simplest option is to just translate grant references to
GPAs (essentially a get_page() on the appropriate GPA.)

This patch provides an alternate balloon allocation mechanism where in
the allocation path we just provide a constant struct page
(corresponding to page 0.) This allows the calling code -- which does a
page_to_pfn() on the returned struct page -- to remain unchanged before
doing the grant operation (which in this case would fill in the real
struct page.)

Co-developed-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/kvm/xen-shim.c | 31 +++++++++++++++++++++++++++++++
 drivers/xen/balloon.c   | 15 ++++++++++++++-
 include/xen/balloon.h   |  7 +++++++
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/xen-shim.c b/arch/x86/kvm/xen-shim.c
index 61fdceb63ec2..4086d92a4bfb 100644
--- a/arch/x86/kvm/xen-shim.c
+++ b/arch/x86/kvm/xen-shim.c
@@ -13,11 +13,40 @@
 #include <xen/xen-ops.h>
 #include <xen/events.h>
 #include <xen/xenbus.h>
+#include <xen/balloon.h>
 
 #define BITS_PER_EVTCHN_WORD (sizeof(xen_ulong_t)*8)
 
 static struct kvm_xen shim = { .domid = XEN_SHIM_DOMID };
 
+static int shim_alloc_pages(int nr_pages, struct page **pages)
+{
+	int i;
+
+	/*
+	 * We provide page 0 instead of NULL because we'll effectively
+	 * do the inverse operation while deriving the pfn to pass to
+	 * xen for mapping.
+	 */
+	for (i = 0; i < nr_pages; i++)
+		pages[i] = pfn_to_page(0);
+
+	return 0;
+}
+
+static void shim_free_pages(int nr_pages, struct page **pages)
+{
+	int i;
+
+	for (i = 0; i < nr_pages; i++)
+		pages[i] = NULL;
+}
+
+static struct xen_balloon_ops shim_balloon_ops = {
+	.alloc_pages = shim_alloc_pages,
+	.free_pages = shim_free_pages,
+};
+
 static void shim_evtchn_setup(struct shared_info *s)
 {
 	int cpu;
@@ -65,6 +94,7 @@ static int __init shim_register(void)
 	mutex_init(&shim.xen_lock);
 
 	kvm_xen_register_lcall(&shim);
+	xen_balloon_ops = &shim_balloon_ops;
 
 	/* We can handle hypercalls after this point */
 	xen_shim_domain = 1;
@@ -94,6 +124,7 @@ static void __exit shim_exit(void)
 	xen_shim_domain = 0;
 
 	kvm_xen_unregister_lcall();
+	xen_balloon_ops = NULL;
 	HYPERVISOR_shared_info = NULL;
 	free_page((unsigned long) shim.shinfo);
 	shim.shinfo = NULL;
diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index ceb5048de9a7..00375fa6c122 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -138,7 +138,7 @@ enum bp_state {
 
 static DEFINE_MUTEX(balloon_mutex);
 
-struct balloon_stats balloon_stats;
+struct balloon_stats balloon_stats __read_mostly;
 EXPORT_SYMBOL_GPL(balloon_stats);
 
 /* We increase/decrease in batches which fit in a page */
@@ -158,6 +158,9 @@ static DECLARE_DELAYED_WORK(balloon_worker, balloon_process);
 #define GFP_BALLOON \
 	(GFP_HIGHUSER | __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC)
 
+struct xen_balloon_ops *xen_balloon_ops;
+EXPORT_SYMBOL(xen_balloon_ops);
+
 /* balloon_append: add the given page to the balloon. */
 static void __balloon_append(struct page *page)
 {
@@ -589,6 +592,11 @@ int alloc_xenballooned_pages(int nr_pages, struct page **pages)
 	struct page *page;
 	int ret;
 
+	if (xen_shim_domain() && xen_balloon_ops)
+		return xen_balloon_ops->alloc_pages(nr_pages, pages);
+
+	WARN_ON_ONCE(xen_shim_domain());
+
 	mutex_lock(&balloon_mutex);
 
 	balloon_stats.target_unpopulated += nr_pages;
@@ -634,6 +642,11 @@ void free_xenballooned_pages(int nr_pages, struct page **pages)
 {
 	int i;
 
+	if (xen_shim_domain() && xen_balloon_ops)
+		return xen_balloon_ops->free_pages(nr_pages, pages);
+
+	WARN_ON_ONCE(xen_shim_domain());
+
 	mutex_lock(&balloon_mutex);
 
 	for (i = 0; i < nr_pages; i++) {
diff --git a/include/xen/balloon.h b/include/xen/balloon.h
index 4914b93a23f2..9ba6a7e91d5e 100644
--- a/include/xen/balloon.h
+++ b/include/xen/balloon.h
@@ -22,6 +22,13 @@ struct balloon_stats {
 
 extern struct balloon_stats balloon_stats;
 
+struct xen_balloon_ops {
+	int (*alloc_pages)(int nr_pages, struct page **pages);
+	void (*free_pages)(int nr_pages, struct page **pages);
+};
+
+extern struct xen_balloon_ops *xen_balloon_ops;
+
 void balloon_set_new_target(unsigned long target);
 
 int alloc_xenballooned_pages(int nr_pages, struct page **pages);
-- 
2.11.0

