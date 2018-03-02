Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427530AbeCBMVl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:21:41 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:60989 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1427501AbeCBMVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:21:22 -0500
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kexec@lists.infradead.org
Cc: davem@davemloft.net, ebiederm@xmission.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, ganeshgr@chelsio.com,
        nirranjan@chelsio.com, indranil@chelsio.com,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Subject: [RFC 1/2] kernel/crash_core: add API to collect hardware dump in kernel panic
Date: Fri,  2 Mar 2018 17:49:57 +0530
Message-Id: <f8bf42cd79cbca694df805e78cc690573eb6d237.1519911559.git.rahul.lakkireddy@chelsio.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <cover.1519911559.git.rahul.lakkireddy@chelsio.com>
References: <cover.1519911559.git.rahul.lakkireddy@chelsio.com>
In-Reply-To: <cover.1519911559.git.rahul.lakkireddy@chelsio.com>
References: <cover.1519911559.git.rahul.lakkireddy@chelsio.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add API to allow drivers to register callback to collect device
specific hardware/firmware dump during kernel panic. The registered
callbacks will be invoked during kernel panic before moving to second
kernel. Also save the dump location and size in vmcore info.

The dump can be extracted using crash:

crash> help -D | grep DRIVERDUMP
DRIVERDUMP=(cxgb4_0000:02:00.4, ffffb131090bd000, 37782968)

crash> rd ffffb131090bd000 37782968 -r hardware.log
37782968 bytes copied from 0xffffb131090bd000 to hardware.log

Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
---
 include/linux/crash_core.h | 33 ++++++++++++++++++
 kernel/crash_core.c        | 83 +++++++++++++++++++++++++++++++++++++++++++++-
 kernel/kexec_core.c        |  1 +
 3 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index b511f6d24b42..d9cc6b3346c7 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -59,6 +59,9 @@ phys_addr_t paddr_vmcoreinfo_note(void);
 	vmcoreinfo_append_str("NUMBER(%s)=%ld\n", #name, (long)name)
 #define VMCOREINFO_CONFIG(name) \
 	vmcoreinfo_append_str("CONFIG_%s=y\n", #name)
+#define VMCOREINFO_DRIVER_DUMP(name, buf, size) \
+	vmcoreinfo_append_str("DRIVERDUMP=(%s, %lx, %lu)\n", \
+			      name, (unsigned long)buf, (unsigned long)size)
 
 extern u32 *vmcoreinfo_note;
 
@@ -73,4 +76,34 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+/* Driver dump collection */
+#define CRASH_DRIVER_DUMP_NAME_LENGTH 32
+
+struct crash_driver_dump_node {
+	struct crash_driver_dump_node __rcu *next;
+	struct crash_driver_dump *data;
+	struct notifier_block *nb;
+};
+
+struct crash_driver_dump_head {
+	struct crash_driver_dump_node __rcu *head;
+};
+
+#define CRASH_DRIVER_DUMP_INIT(name) { \
+	.head = NULL \
+}
+
+#define CRASH_DRIVER_DUMP_HEAD(name) \
+	struct crash_driver_dump_head name = CRASH_DRIVER_DUMP_INIT(name) \
+
+struct crash_driver_dump {
+	char name[CRASH_DRIVER_DUMP_NAME_LENGTH];
+	void *buf;
+	unsigned long size;
+};
+
+void crash_driver_dump_call_handlers(void);
+int crash_driver_dump_register(struct crash_driver_dump *data,
+			       struct notifier_block *nb);
+int crash_driver_dump_unregister(struct crash_driver_dump *data);
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 4f63597c824d..ff62713f597e 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -21,6 +21,64 @@ u32 *vmcoreinfo_note;
 /* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
 static unsigned char *vmcoreinfo_data_safecopy;
 
+/* List of driver registered callbacks to collect dumps */
+CRASH_DRIVER_DUMP_HEAD(crash_driver_dump_list);
+ATOMIC_NOTIFIER_HEAD(crash_driver_dump_notifier_list);
+
+static int driver_dump_callback_register(struct crash_driver_dump_head *dh,
+					 struct crash_driver_dump *data,
+					 struct notifier_block *nb)
+{
+	struct crash_driver_dump_node *d, **dl;
+
+	d = vzalloc(sizeof(*d));
+	if (!d)
+		return -ENOMEM;
+
+	atomic_notifier_chain_register(&crash_driver_dump_notifier_list, nb);
+	d->nb = nb;
+	d->data = data;
+
+	dl = &dh->head;
+	while (*dl)
+		dl = &((*dl)->next);
+	d->next = *dl;
+	rcu_assign_pointer(*dl, d);
+	return 0;
+}
+
+static int driver_dump_callback_unregister(struct crash_driver_dump_head *dh,
+					   struct crash_driver_dump *data)
+{
+	struct atomic_notifier_head *ah = &crash_driver_dump_notifier_list;
+	struct crash_driver_dump_node **dl;
+
+	dl = &dh->head;
+	while (*dl) {
+		if ((*dl)->data == data) {
+			atomic_notifier_chain_unregister(ah, (*dl)->nb);
+			rcu_assign_pointer((*dl), (*dl)->next);
+			vfree(*dl);
+			return 0;
+		}
+		dl = &((*dl)->next);
+	}
+	return -ENOENT;
+}
+
+int crash_driver_dump_register(struct crash_driver_dump *data,
+			       struct notifier_block *nb)
+{
+	return driver_dump_callback_register(&crash_driver_dump_list, data, nb);
+}
+EXPORT_SYMBOL(crash_driver_dump_register);
+
+int crash_driver_dump_unregister(struct crash_driver_dump *data)
+{
+	return driver_dump_callback_unregister(&crash_driver_dump_list, data);
+}
+EXPORT_SYMBOL(crash_driver_dump_unregister);
+
 /*
  * parsing the "crashkernel" commandline
  *
@@ -365,6 +423,30 @@ void vmcoreinfo_append_str(const char *fmt, ...)
 	vmcoreinfo_size += r;
 }
 
+void crash_driver_dump_call_handlers(void)
+{
+	static char driver_dump_buf[1024];
+	struct crash_driver_dump_node *dl;
+
+	dl = crash_driver_dump_list.head;
+	if (dl) {
+		atomic_notifier_call_chain(&crash_driver_dump_notifier_list, 0,
+					   driver_dump_buf);
+
+		/* Append to safe copy if available */
+		if (vmcoreinfo_data_safecopy)
+			vmcoreinfo_data = vmcoreinfo_data_safecopy;
+
+		while (dl) {
+			VMCOREINFO_DRIVER_DUMP(dl->data->name, dl->data->buf,
+					       dl->data->size);
+			dl = dl->next;
+		}
+
+		update_vmcoreinfo_note();
+	}
+}
+
 /*
  * provide an empty default implementation here -- architecture
  * code may override this
@@ -462,7 +544,6 @@ static int __init crash_save_vmcoreinfo_init(void)
 #ifdef CONFIG_HUGETLB_PAGE
 	VMCOREINFO_NUMBER(HUGETLB_PAGE_DTOR);
 #endif
-
 	arch_crash_save_vmcoreinfo();
 	update_vmcoreinfo_note();
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 20fef1a38602..b86ffe24fe09 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -938,6 +938,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
 		if (kexec_crash_image) {
 			struct pt_regs fixed_regs;
 
+			crash_driver_dump_call_handlers();
 			crash_setup_regs(&fixed_regs, regs);
 			crash_save_vmcoreinfo();
 			machine_crash_shutdown(&fixed_regs);
-- 
2.14.1
