Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6F5C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214092086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762609;
	bh=iMGxbaSNxhfj8C0uGUQMcmvzb6nsTHzX7D5uvJDCaZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A8twJnJEfGwhCwS/26m3RKp1JafjC+nOqsg3/1pcklg0bRqyf2GpXa4zC/CSm7erV
	 GtivrC3yciJWSkI46i8f7Y+Nnjl75p6fCKmD/oBc5CZbFE58GPqsDHDibDfgtriE8t
	 DjQSSAzsUHAUYlQwdfRyOwqtC3hZpGpQGE3raJXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbfA2LuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:50:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:41220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731587AbfA2LuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:50:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C7ED20882;
        Tue, 29 Jan 2019 11:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762604;
        bh=iMGxbaSNxhfj8C0uGUQMcmvzb6nsTHzX7D5uvJDCaZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v8527RumNxkqCbo5X4uzJQVJUwp3B/CUpBmiANhiW7OfrMi6uFWScQjWbio31AMU3
         Mjcc3nLQorPJeCfxVZzoWQBUndHhMKdkDZcKbaqAgZyK9ak9jxF3EHWZOD+UZsHjzy
         IOm/WpEDHbvdXRtLh2hhZKwjEAwwTzswpo09bD/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joao Martins <joao.m.martins@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 4.14 63/68] x86/xen/time: setup vcpu 0 time info page
Date:   Tue, 29 Jan 2019 12:36:25 +0100
Message-Id: <20190129113137.717817976@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joao Martins <joao.m.martins@oracle.com>

commit 2229f70b5bbb025e1394b61007938a68060afbfb upstream.

In order to support pvclock vdso on xen we need to setup the time
info page for vcpu 0 and register the page with Xen using the
VCPUOP_register_vcpu_time_memory_area hypercall. This hypercall
will also forcefully update the pvti which will set some of the
necessary flags for vdso. Afterwards we check if it supports the
PVCLOCK_TSC_STABLE_BIT flag which is mandatory for having
vdso/vsyscall support. And if so, it will set the cpu 0 pvti that
will be later on used when mapping the vdso image.

The xen headers are also updated to include the new hypercall for
registering the secondary vcpu_time_info struct.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/suspend.c       |    4 +
 arch/x86/xen/time.c          |   90 ++++++++++++++++++++++++++++++++++++++++++-
 arch/x86/xen/xen-ops.h       |    2 
 include/xen/interface/vcpu.h |   42 ++++++++++++++++++++
 4 files changed, 137 insertions(+), 1 deletion(-)

--- a/arch/x86/xen/suspend.c
+++ b/arch/x86/xen/suspend.c
@@ -22,6 +22,8 @@ static DEFINE_PER_CPU(u64, spec_ctrl);
 
 void xen_arch_pre_suspend(void)
 {
+	xen_save_time_memory_area();
+
 	if (xen_pv_domain())
 		xen_pv_pre_suspend();
 }
@@ -32,6 +34,8 @@ void xen_arch_post_suspend(int cancelled
 		xen_pv_post_suspend(cancelled);
 	else
 		xen_hvm_post_suspend(cancelled);
+
+	xen_restore_time_memory_area();
 }
 
 static void xen_vcpu_notify_restore(void *data)
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -371,6 +371,92 @@ static const struct pv_time_ops xen_time
 	.steal_clock = xen_steal_clock,
 };
 
+static struct pvclock_vsyscall_time_info *xen_clock __read_mostly;
+
+void xen_save_time_memory_area(void)
+{
+	struct vcpu_register_time_memory_area t;
+	int ret;
+
+	if (!xen_clock)
+		return;
+
+	t.addr.v = NULL;
+
+	ret = HYPERVISOR_vcpu_op(VCPUOP_register_vcpu_time_memory_area, 0, &t);
+	if (ret != 0)
+		pr_notice("Cannot save secondary vcpu_time_info (err %d)",
+			  ret);
+	else
+		clear_page(xen_clock);
+}
+
+void xen_restore_time_memory_area(void)
+{
+	struct vcpu_register_time_memory_area t;
+	int ret;
+
+	if (!xen_clock)
+		return;
+
+	t.addr.v = &xen_clock->pvti;
+
+	ret = HYPERVISOR_vcpu_op(VCPUOP_register_vcpu_time_memory_area, 0, &t);
+
+	/*
+	 * We don't disable VCLOCK_PVCLOCK entirely if it fails to register the
+	 * secondary time info with Xen or if we migrated to a host without the
+	 * necessary flags. On both of these cases what happens is either
+	 * process seeing a zeroed out pvti or seeing no PVCLOCK_TSC_STABLE_BIT
+	 * bit set. Userspace checks the latter and if 0, it discards the data
+	 * in pvti and fallbacks to a system call for a reliable timestamp.
+	 */
+	if (ret != 0)
+		pr_notice("Cannot restore secondary vcpu_time_info (err %d)",
+			  ret);
+}
+
+static void xen_setup_vsyscall_time_info(void)
+{
+	struct vcpu_register_time_memory_area t;
+	struct pvclock_vsyscall_time_info *ti;
+	int ret;
+
+	ti = (struct pvclock_vsyscall_time_info *)get_zeroed_page(GFP_KERNEL);
+	if (!ti)
+		return;
+
+	t.addr.v = &ti->pvti;
+
+	ret = HYPERVISOR_vcpu_op(VCPUOP_register_vcpu_time_memory_area, 0, &t);
+	if (ret) {
+		pr_notice("xen: VCLOCK_PVCLOCK not supported (err %d)\n", ret);
+		free_page((unsigned long)ti);
+		return;
+	}
+
+	/*
+	 * If primary time info had this bit set, secondary should too since
+	 * it's the same data on both just different memory regions. But we
+	 * still check it in case hypervisor is buggy.
+	 */
+	if (!(ti->pvti.flags & PVCLOCK_TSC_STABLE_BIT)) {
+		t.addr.v = NULL;
+		ret = HYPERVISOR_vcpu_op(VCPUOP_register_vcpu_time_memory_area,
+					 0, &t);
+		if (!ret)
+			free_page((unsigned long)ti);
+
+		pr_notice("xen: VCLOCK_PVCLOCK not supported (tsc unstable)\n");
+		return;
+	}
+
+	xen_clock = ti;
+	pvclock_set_pvti_cpu0_va(xen_clock);
+
+	xen_clocksource.archdata.vclock_mode = VCLOCK_PVCLOCK;
+}
+
 static void __init xen_time_init(void)
 {
 	struct pvclock_vcpu_time_info *pvti;
@@ -402,8 +488,10 @@ static void __init xen_time_init(void)
 	 * bit is supported hence speeding up Xen clocksource.
 	 */
 	pvti = &__this_cpu_read(xen_vcpu)->time;
-	if (pvti->flags & PVCLOCK_TSC_STABLE_BIT)
+	if (pvti->flags & PVCLOCK_TSC_STABLE_BIT) {
 		pvclock_set_flags(PVCLOCK_TSC_STABLE_BIT);
+		xen_setup_vsyscall_time_info();
+	}
 
 	xen_setup_runstate_info(cpu);
 	xen_setup_timer(cpu);
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -70,6 +70,8 @@ void xen_setup_runstate_info(int cpu);
 void xen_teardown_timer(int cpu);
 u64 xen_clocksource_read(void);
 void xen_setup_cpu_clockevents(void);
+void xen_save_time_memory_area(void);
+void xen_restore_time_memory_area(void);
 void __init xen_init_time_ops(void);
 void __init xen_hvm_init_time_ops(void);
 
--- a/include/xen/interface/vcpu.h
+++ b/include/xen/interface/vcpu.h
@@ -178,4 +178,46 @@ DEFINE_GUEST_HANDLE_STRUCT(vcpu_register
 
 /* Send an NMI to the specified VCPU. @extra_arg == NULL. */
 #define VCPUOP_send_nmi             11
+
+/*
+ * Get the physical ID information for a pinned vcpu's underlying physical
+ * processor.  The physical ID informmation is architecture-specific.
+ * On x86: id[31:0]=apic_id, id[63:32]=acpi_id.
+ * This command returns -EINVAL if it is not a valid operation for this VCPU.
+ */
+#define VCPUOP_get_physid           12 /* arg == vcpu_get_physid_t */
+struct vcpu_get_physid {
+	uint64_t phys_id;
+};
+DEFINE_GUEST_HANDLE_STRUCT(vcpu_get_physid);
+#define xen_vcpu_physid_to_x86_apicid(physid) ((uint32_t)(physid))
+#define xen_vcpu_physid_to_x86_acpiid(physid) ((uint32_t)((physid) >> 32))
+
+/*
+ * Register a memory location to get a secondary copy of the vcpu time
+ * parameters.  The master copy still exists as part of the vcpu shared
+ * memory area, and this secondary copy is updated whenever the master copy
+ * is updated (and using the same versioning scheme for synchronisation).
+ *
+ * The intent is that this copy may be mapped (RO) into userspace so
+ * that usermode can compute system time using the time info and the
+ * tsc.  Usermode will see an array of vcpu_time_info structures, one
+ * for each vcpu, and choose the right one by an existing mechanism
+ * which allows it to get the current vcpu number (such as via a
+ * segment limit).  It can then apply the normal algorithm to compute
+ * system time from the tsc.
+ *
+ * @extra_arg == pointer to vcpu_register_time_info_memory_area structure.
+ */
+#define VCPUOP_register_vcpu_time_memory_area   13
+DEFINE_GUEST_HANDLE_STRUCT(vcpu_time_info);
+struct vcpu_register_time_memory_area {
+	union {
+		GUEST_HANDLE(vcpu_time_info) h;
+		struct pvclock_vcpu_time_info *v;
+		uint64_t p;
+	} addr;
+};
+DEFINE_GUEST_HANDLE_STRUCT(vcpu_register_time_memory_area);
+
 #endif /* __XEN_PUBLIC_VCPU_H__ */


