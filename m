Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54B7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D672081B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AYvhMbte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfBTUS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:18:56 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34204 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfBTUSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:18:53 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1KK8e4A087617;
        Wed, 20 Feb 2019 20:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=iYIXYGyjPcBp7iJxj6+nN/3XpB73yvjLQ8ym2bw5tbg=;
 b=AYvhMbteyxJvtoiOMPGOViJorIFJPB6mXFoMYiKUbafbIQheKd7FpUBfsK4SlnKXyiS4
 i4dFSFuY7cIw1GKBOEm9sf9RFMRkROvnDt0dccoeJJKfSdJmKlTdRenYpvYXbzadhLRO
 XJoPgpBVnCXwKDHGaUxBIKHYNWav9EDSrW+Kk+EbPiuGkkpmfx3u1KdxMpb6InCSZEP1
 HO1+A/7b4Oj7cmvigaa9l1P8rejO4qUjtlJCieWDySZrQST0IMGZN66QUv9TFe0YeLIo
 x6JO/z8E4QVssuoeZNl2PAhHRFY8gzD1ehbG6wRy/E4tKv5hD+m3nwLSO1tGfjparKa5 Wg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qp81ec3ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:35 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKIYfZ020176
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 20:18:34 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1KKIYDq010078;
        Wed, 20 Feb 2019 20:18:34 GMT
Received: from paddy.lan (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 12:18:33 -0800
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
Subject: [PATCH RFC 31/39] xen-shim: introduce shim domain driver
Date:   Wed, 20 Feb 2019 20:16:01 +0000
Message-Id: <20190220201609.28290-32-joao.m.martins@oracle.com>
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

xen-shim.ko sets up and tears down state needed to support Xen
backends. The underlying primitives that are exposed are interdomain
event-channels and grant-table map/unmap/copy.

We setup the following:

  * Initialize shared_info and vcpu_info pages, essentially setting
    up event-channel state.
  * Set up features (this allows xen_feature() to work)
  * Initialize event-channel subsystem (select event ops and related
    setup.)
  * Initialize xenbus and tear it down on module exit.

This functionality would be used by the backend drivers (e.g. netback,
scsiback, blkback etc) in order to drive guest I/O.

Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 arch/x86/include/asm/kvm_host.h          |   2 +
 arch/x86/kvm/Kconfig                     |  10 +++
 arch/x86/kvm/Makefile                    |   1 +
 arch/x86/kvm/xen-shim.c                  | 107 +++++++++++++++++++++++++++++++
 arch/x86/xen/enlighten.c                 |  45 +++++++++++++
 drivers/xen/events/events_2l.c           |   2 +-
 drivers/xen/events/events_base.c         |   6 +-
 drivers/xen/features.c                   |   1 +
 drivers/xen/xenbus/xenbus_dev_frontend.c |   4 +-
 include/xen/xen.h                        |   5 ++
 include/xen/xenbus.h                     |   3 +
 11 files changed, 182 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/kvm/xen-shim.c

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 55609e919e14..6bdae8649d56 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -896,6 +896,8 @@ struct kvm_grant_table {
 /* Xen emulation context */
 struct kvm_xen {
 	u64 xen_hypercall;
+
+#define XEN_SHIM_DOMID	0
 	domid_t domid;
 
 	gfn_t shinfo_addr;
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 72fa955f4a15..47347df282dc 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -96,6 +96,16 @@ config KVM_MMU_AUDIT
 	 This option adds a R/W kVM module parameter 'mmu_audit', which allows
 	 auditing of KVM MMU events at runtime.
 
+config XEN_SHIM
+       tristate "Xen hypercall emulation shim"
+       depends on KVM
+       depends on XEN
+       default m
+       help
+	Shim to support Xen hypercalls on non-Xen hosts. It intercepts grant
+	table and event channels hypercalls same way as Xen hypervisor. This is
+	useful for having Xen backend drivers work on KVM.
+
 # OK, it's a little counter-intuitive to do this, but it puts it neatly under
 # the virtualization menu.
 source "drivers/vhost/Kconfig"
diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index c1eaabbd0a54..a96a96a002a7 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -18,3 +18,4 @@ kvm-amd-y		+= svm.o pmu_amd.o
 obj-$(CONFIG_KVM)	+= kvm.o
 obj-$(CONFIG_KVM_INTEL)	+= kvm-intel.o
 obj-$(CONFIG_KVM_AMD)	+= kvm-amd.o
+obj-$(CONFIG_XEN_SHIM)  += xen-shim.o
diff --git a/arch/x86/kvm/xen-shim.c b/arch/x86/kvm/xen-shim.c
new file mode 100644
index 000000000000..61fdceb63ec2
--- /dev/null
+++ b/arch/x86/kvm/xen-shim.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 Oracle and/or its affiliates. All rights reserved.
+ *
+ * Xen hypercall emulation shim
+ */
+
+#define pr_fmt(fmt) "KVM:" KBUILD_MODNAME ": " fmt
+
+#include <asm/kvm_host.h>
+
+#include <xen/xen.h>
+#include <xen/xen-ops.h>
+#include <xen/events.h>
+#include <xen/xenbus.h>
+
+#define BITS_PER_EVTCHN_WORD (sizeof(xen_ulong_t)*8)
+
+static struct kvm_xen shim = { .domid = XEN_SHIM_DOMID };
+
+static void shim_evtchn_setup(struct shared_info *s)
+{
+	int cpu;
+
+	/* Point Xen's shared_info to the domain's sinfo page */
+	HYPERVISOR_shared_info = s;
+
+	/* Evtchns will be marked pending on allocation */
+	memset(s->evtchn_pending, 0, sizeof(s->evtchn_pending));
+	/* ... but we do mask all of -- dom0 expect it. */
+	memset(s->evtchn_mask, 1, sizeof(s->evtchn_mask));
+
+	for_each_possible_cpu(cpu) {
+		struct vcpu_info *vcpu_info;
+		int i;
+
+		/* Direct CPU mapping as far as dom0 is concerned */
+		per_cpu(xen_vcpu_id, cpu) = cpu;
+
+		vcpu_info = &per_cpu(xen_vcpu_info, cpu);
+		memset(vcpu_info, 0, sizeof(*vcpu_info));
+
+		vcpu_info->evtchn_upcall_mask = 0;
+
+		vcpu_info->evtchn_upcall_pending = 0;
+		for (i = 0; i < BITS_PER_EVTCHN_WORD; i++)
+			clear_bit(i, &vcpu_info->evtchn_pending_sel);
+
+		per_cpu(xen_vcpu, cpu) = vcpu_info;
+	}
+}
+
+static int __init shim_register(void)
+{
+	struct shared_info *shinfo;
+
+	shinfo = (struct shared_info *)get_zeroed_page(GFP_KERNEL);
+	if (!shinfo) {
+		pr_err("Failed to allocate shared_info page\n");
+		return -ENOMEM;
+	}
+	shim.shinfo = shinfo;
+
+	idr_init(&shim.port_to_evt);
+	mutex_init(&shim.xen_lock);
+
+	kvm_xen_register_lcall(&shim);
+
+	/* We can handle hypercalls after this point */
+	xen_shim_domain = 1;
+
+	shim_evtchn_setup(shim.shinfo);
+
+	xen_setup_features();
+
+	xen_init_IRQ();
+
+	xenbus_init();
+
+	return 0;
+}
+
+static int __init shim_init(void)
+{
+	if (xen_domain())
+		return -ENODEV;
+
+	return shim_register();
+}
+
+static void __exit shim_exit(void)
+{
+	xenbus_deinit();
+	xen_shim_domain = 0;
+
+	kvm_xen_unregister_lcall();
+	HYPERVISOR_shared_info = NULL;
+	free_page((unsigned long) shim.shinfo);
+	shim.shinfo = NULL;
+}
+
+module_init(shim_init);
+module_exit(shim_exit)
+
+MODULE_AUTHOR("Ankur Arora <ankur.a.arora@oracle.com>,"
+	      "Joao Martins <joao.m.martins@oracle.com>");
+MODULE_LICENSE("GPL");
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index b36a10e6b5d7..8d9e93b6eb09 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -57,6 +57,9 @@ EXPORT_PER_CPU_SYMBOL(xen_vcpu_info);
 enum xen_domain_type xen_domain_type = XEN_NATIVE;
 EXPORT_SYMBOL_GPL(xen_domain_type);
 
+int xen_shim_domain;
+EXPORT_SYMBOL_GPL(xen_shim_domain);
+
 unsigned long *machine_to_phys_mapping = (void *)MACH2PHYS_VIRT_START;
 EXPORT_SYMBOL(machine_to_phys_mapping);
 unsigned long  machine_to_phys_nr;
@@ -349,3 +352,45 @@ void xen_arch_unregister_cpu(int num)
 }
 EXPORT_SYMBOL(xen_arch_unregister_cpu);
 #endif
+
+static struct module *find_module_shim(void)
+{
+	static const char name[] = "xen_shim";
+	struct module *module;
+
+	mutex_lock(&module_mutex);
+	module = find_module(name);
+	mutex_unlock(&module_mutex);
+
+	return module;
+}
+
+bool xen_shim_domain_get(void)
+{
+	struct module *shim;
+
+	if (!xen_shim_domain())
+		return false;
+
+	shim = find_module_shim();
+	if (!shim)
+		return false;
+
+	return try_module_get(shim);
+}
+EXPORT_SYMBOL(xen_shim_domain_get);
+
+void xen_shim_domain_put(void)
+{
+	struct module *shim;
+
+	if (!xen_shim_domain())
+		return;
+
+	shim = find_module_shim();
+	if (!shim)
+		return;
+
+	module_put(shim);
+}
+EXPORT_SYMBOL(xen_shim_domain_put);
diff --git a/drivers/xen/events/events_2l.c b/drivers/xen/events/events_2l.c
index b5acf4b09971..f08d13a033c1 100644
--- a/drivers/xen/events/events_2l.c
+++ b/drivers/xen/events/events_2l.c
@@ -89,7 +89,7 @@ static void evtchn_2l_unmask(unsigned port)
 	unsigned int cpu = get_cpu();
 	int do_hypercall = 0, evtchn_pending = 0;
 
-	BUG_ON(!irqs_disabled());
+	WARN_ON(!irqs_disabled());
 
 	if (unlikely((cpu != cpu_from_evtchn(port))))
 		do_hypercall = 1;
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 117e76b2f939..a2087287c3b6 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1665,7 +1665,7 @@ void xen_callback_vector(void) {}
 static bool fifo_events = true;
 module_param(fifo_events, bool, 0);
 
-void __init xen_init_IRQ(void)
+void xen_init_IRQ(void)
 {
 	int ret = -EINVAL;
 	unsigned int evtchn;
@@ -1683,6 +1683,9 @@ void __init xen_init_IRQ(void)
 	for (evtchn = 0; evtchn < xen_evtchn_nr_channels(); evtchn++)
 		mask_evtchn(evtchn);
 
+	if (xen_shim_domain())
+		return;
+
 	pirq_needs_eoi = pirq_needs_eoi_flag;
 
 #ifdef CONFIG_X86
@@ -1714,3 +1717,4 @@ void __init xen_init_IRQ(void)
 	}
 #endif
 }
+EXPORT_SYMBOL_GPL(xen_init_IRQ);
diff --git a/drivers/xen/features.c b/drivers/xen/features.c
index d7d34fdfc993..1518c3b6f004 100644
--- a/drivers/xen/features.c
+++ b/drivers/xen/features.c
@@ -31,3 +31,4 @@ void xen_setup_features(void)
 			xen_features[i * 32 + j] = !!(fi.submap & 1<<j);
 	}
 }
+EXPORT_SYMBOL_GPL(xen_setup_features);
diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c b/drivers/xen/xenbus/xenbus_dev_frontend.c
index c3e201025ef0..a4080d04a01c 100644
--- a/drivers/xen/xenbus/xenbus_dev_frontend.c
+++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
@@ -680,7 +680,7 @@ static struct miscdevice xenbus_dev = {
 	.fops = &xen_xenbus_fops,
 };
 
-static int __init xenbus_init(void)
+static int __init xenbus_frontend_init(void)
 {
 	int err;
 
@@ -692,4 +692,4 @@ static int __init xenbus_init(void)
 		pr_err("Could not register xenbus frontend device\n");
 	return err;
 }
-device_initcall(xenbus_init);
+device_initcall(xenbus_frontend_init);
diff --git a/include/xen/xen.h b/include/xen/xen.h
index 0e2156786ad2..04dfa99e67eb 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -10,8 +10,12 @@ enum xen_domain_type {
 
 #ifdef CONFIG_XEN
 extern enum xen_domain_type xen_domain_type;
+extern int xen_shim_domain;
+extern bool xen_shim_domain_get(void);
+extern void xen_shim_domain_put(void);
 #else
 #define xen_domain_type		XEN_NATIVE
+#define xen_shim_domain      0
 #endif
 
 #ifdef CONFIG_XEN_PVH
@@ -24,6 +28,7 @@ extern bool xen_pvh;
 #define xen_pv_domain()		(xen_domain_type == XEN_PV_DOMAIN)
 #define xen_hvm_domain()	(xen_domain_type == XEN_HVM_DOMAIN)
 #define xen_pvh_domain()	(xen_pvh)
+#define xen_shim_domain()	(!xen_domain() && xen_shim_domain)
 
 #include <linux/types.h>
 
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index 869c816d5f8c..d2789e7d2055 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -233,4 +233,7 @@ extern const struct file_operations xen_xenbus_fops;
 extern struct xenstore_domain_interface *xen_store_interface;
 extern int xen_store_evtchn;
 
+int xenbus_init(void);
+void xenbus_deinit(void);
+
 #endif /* _XEN_XENBUS_H */
-- 
2.11.0

