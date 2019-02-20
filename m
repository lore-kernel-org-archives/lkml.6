Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DB2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519632146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fkNNkExh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfBTUSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:18:10 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33442 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbfBTUSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:18:09 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8VnE087431;
        Wed, 20 Feb 2019 20:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Q7ek5QGqUVAsNrW8yhTeyoULt5uKOYECFtZLQ9l/1ho=;
 b=fkNNkExhVsWOCn+cW2Vbb1Z1v8D4qYjbf8P+te0V44dWN4Y0hLDXs1/d3mLjVYtofmmD
 CQjjw4g6xYExMumH484CoTDUMSomlsUplIYUFUDafOCSKlu1R+VgNdczG+BBw7bmlqAB
 L1ilXPc6z91hd9Li9rE3PCIAgQwLl1OKuTroxfrUNdaMW6eKDwgk2lQ/dJ5fDzEPt55M
 uuQ2eT29Gsy0yTF0rlJO0coPgCSTAW2mVetS7UCnbdAWHLqvaRLMss143y0cLQ9pPHXU
 /7EN3cUIIe6jn3Pbe/Rl99WP74EnCFT+riUfEuKhpXIRA94lxJAlkhfXWI6RoVnIZhQu JA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qp81ec3by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:01 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKHtvi027093
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:17:55 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1KKHtjM015587;
        Wed, 20 Feb 2019 20:17:55 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:17:54 -0800
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
Subject: [PATCH RFC 19/39] xen/xenbus: xenbus uninit support
Date:   Wed, 20 Feb 2019 20:15:49 +0000
Message-Id: <20190220201609.28290-20-joao.m.martins@oracle.com>
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

This allows reinitialization of xenbus which is useful for
xen_shim_domain() support. Cleaning xenbus state means cancelling
pending watch events, and deleting all watches, closing xenstore event
channel and finally stopping xenbus/xenwatch kthreads alongside
unregistering /proc/xen.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/xen/xenbus/xenbus.h        |  2 ++
 drivers/xen/xenbus/xenbus_client.c |  5 ++++
 drivers/xen/xenbus/xenbus_probe.c  | 51 +++++++++++++++++++++++++++++++++++---
 drivers/xen/xenbus/xenbus_xs.c     | 38 ++++++++++++++++++++++++++++
 4 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus.h b/drivers/xen/xenbus/xenbus.h
index 092981171df1..e0e586d81d48 100644
--- a/drivers/xen/xenbus/xenbus.h
+++ b/drivers/xen/xenbus/xenbus.h
@@ -96,6 +96,7 @@ extern wait_queue_head_t xb_waitq;
 extern struct mutex xb_write_mutex;
 
 int xs_init(void);
+void xs_deinit(void);
 int xb_init_comms(void);
 void xb_deinit_comms(void);
 int xs_watch_msg(struct xs_watch_event *event);
@@ -129,6 +130,7 @@ int xenbus_read_otherend_details(struct xenbus_device *xendev,
 				 char *id_node, char *path_node);
 
 void xenbus_ring_ops_init(void);
+void xenbus_ring_ops_deinit(void);
 
 int xenbus_dev_request_and_reply(struct xsd_sockmsg *msg, void *par);
 void xenbus_dev_queue_reply(struct xb_req_data *req);
diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index e17ca8156171..ada1c9aa6525 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -935,3 +935,8 @@ void __init xenbus_ring_ops_init(void)
 #endif
 		ring_ops = &ring_ops_hvm;
 }
+
+void xenbus_ring_ops_deinit(void)
+{
+	ring_ops = NULL;
+}
diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 5b471889d723..2e0ed46b05e7 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -741,6 +741,21 @@ static int __init xenstored_local_init(void)
 	return err;
 }
 
+static void xenstored_local_deinit(void)
+{
+	struct evtchn_close close;
+	void *page = NULL;
+
+	page = gfn_to_virt(xen_store_gfn);
+	free_page((unsigned long)page);
+
+	close.port = xen_store_evtchn;
+
+	HYPERVISOR_event_channel_op(EVTCHNOP_close, &close);
+
+	xen_store_evtchn = 0;
+}
+
 static int xenbus_resume_cb(struct notifier_block *nb,
 			    unsigned long action, void *data)
 {
@@ -765,7 +780,11 @@ static struct notifier_block xenbus_resume_nb = {
 	.notifier_call = xenbus_resume_cb,
 };
 
-static int __init xenbus_init(void)
+#ifdef CONFIG_XEN_COMPAT_XENFS
+struct proc_dir_entry *xen_procfs;
+#endif
+
+int xenbus_init(void)
 {
 	int err = 0;
 	uint64_t v = 0;
@@ -833,13 +852,39 @@ static int __init xenbus_init(void)
 	 * Create xenfs mountpoint in /proc for compatibility with
 	 * utilities that expect to find "xenbus" under "/proc/xen".
 	 */
-	proc_create_mount_point("xen");
+	xen_procfs = proc_create_mount_point("xen");
 #endif
 
 out_error:
 	return err;
 }
-
+EXPORT_SYMBOL_GPL(xenbus_init);
 postcore_initcall(xenbus_init);
 
+void xenbus_deinit(void)
+{
+	if (!xen_domain())
+		return;
+
+#ifdef CONFIG_XEN_COMPAT_XENFS
+	proc_remove(xen_procfs);
+	xen_procfs = NULL;
+#endif
+
+	xs_deinit();
+	xenstored_ready = 0;
+
+	switch (xen_store_domain_type) {
+	case XS_LOCAL:
+		xenstored_local_deinit();
+		xen_store_interface = NULL;
+		break;
+	default:
+		pr_warn("Xenstore state unknown\n");
+		break;
+	}
+	xenbus_ring_ops_deinit();
+}
+EXPORT_SYMBOL_GPL(xenbus_deinit);
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 49a3874ae6bb..bd6db3703972 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -866,6 +866,7 @@ static int xenwatch_thread(void *unused)
 
 	for (;;) {
 		wait_event_interruptible(watch_events_waitq,
+					 kthread_should_stop() ||
 					 !list_empty(&watch_events));
 
 		if (kthread_should_stop())
@@ -917,6 +918,8 @@ static struct notifier_block xs_reboot_nb = {
 	.notifier_call = xs_reboot_notify,
 };
 
+static struct task_struct *xenwatch_task;
+
 int xs_init(void)
 {
 	int err;
@@ -932,9 +935,44 @@ int xs_init(void)
 	task = kthread_run(xenwatch_thread, NULL, "xenwatch");
 	if (IS_ERR(task))
 		return PTR_ERR(task);
+	xenwatch_task = task;
 
 	/* shutdown watches for kexec boot */
 	xs_reset_watches();
 
 	return 0;
 }
+
+void cancel_watches(void)
+{
+	struct xs_watch_event *event, *tmp;
+
+	/* Cancel pending watch events. */
+	spin_lock(&watch_events_lock);
+	list_for_each_entry_safe(event, tmp, &watch_events, list) {
+		list_del(&event->list);
+		kfree(event);
+	}
+	spin_unlock(&watch_events_lock);
+}
+
+void delete_watches(void)
+{
+	struct xenbus_watch *watch, *tmp;
+
+	spin_lock(&watches_lock);
+	list_for_each_entry_safe(watch, tmp, &watches, list) {
+		list_del(&watch->list);
+	}
+	spin_unlock(&watches_lock);
+}
+
+void xs_deinit(void)
+{
+	kthread_stop(xenwatch_task);
+	xenwatch_task = NULL;
+	xb_deinit_comms();
+	unregister_reboot_notifier(&xs_reboot_nb);
+	cancel_watches();
+	delete_watches();
+}
-- 
2.11.0

