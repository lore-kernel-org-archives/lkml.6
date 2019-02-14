Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB061C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED3F218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D+VWajgN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393505AbfBNADq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:03:46 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:45832 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393480AbfBNADn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:03:43 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1DNwhvM099390;
        Thu, 14 Feb 2019 00:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2018-07-02;
 bh=1tfiao/L4nkY1/BQ61imQ3duc4RawqVwLZqH4dWuQjI=;
 b=D+VWajgNZnnbCBmJd6hRmQKSxbcltQMbhcmtC6zmq5GAiZd2odC4bM6E90rcz6FYx3g3
 p7y7UNpH69a0nk3zZf710qRnzwfsm4El++cnOGfwCXpBM+jvTdVH6Sf1YTW1mX20YwrC
 xhahrxss9iSQvxnblHxengOYGhfFgrNit8QWBepNbxggligImNFYyOIvecSsajODeFCA
 QYzSeuNjvM9sbPmvcKLqraQPt2jiXMulJIq2+crPTnfNMyeJj3D2nJzTpOUsVOy0xI7m
 BqAYotYlxCLKc5WX7QxIgpOoO3+kFRcKTeD7C15b1QdehKVErxfhN/MX2ZEDG3Kpwb4g ZA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2qhree55n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 00:02:20 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1E02JKR001195
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 00:02:20 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1E02J3c018809;
        Thu, 14 Feb 2019 00:02:19 GMT
Received: from concerto.internal (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 16:02:19 -0800
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de,
        ak@linux.intel.com, torvalds@linux-foundation.org,
        liran.alon@oracle.com, keescook@google.com,
        akpm@linux-foundation.org, mhocko@suse.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jmorris@namei.org,
        konrad.wilk@oracle.com
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        oao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, labbott@redhat.com, luto@kernel.org,
        dave.hansen@intel.com, peterz@infradead.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tycho Andersen <tycho@docker.com>
Subject: [RFC PATCH v8 10/14] lkdtm: Add test for XPFO
Date:   Wed, 13 Feb 2019 17:01:33 -0700
Message-Id: <1af3c61568d36cad4a2b2fece978336620701b86.1550088114.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1550088114.git.khalid.aziz@oracle.com>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1550088114.git.khalid.aziz@oracle.com>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902130157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juerg Haefliger <juerg.haefliger@canonical.com>

This test simply reads from userspace memory via the kernel's linear
map.

v6: * drop an #ifdef, just let the test fail if XPFO is not supported
    * add XPFO_SMP test to try and test the case when one CPU does an xpfo
      unmap of an address, that it can't be used accidentally by other
      CPUs.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Signed-off-by: Tycho Andersen <tycho@docker.com>
Tested-by: Marco Benatto <marco.antonio.780@gmail.com>
[jsteckli@amazon.de: rebased from v4.13 to v4.19]
Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
Tested-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 drivers/misc/lkdtm/Makefile |   1 +
 drivers/misc/lkdtm/core.c   |   3 +
 drivers/misc/lkdtm/lkdtm.h  |   5 +
 drivers/misc/lkdtm/xpfo.c   | 194 ++++++++++++++++++++++++++++++++++++
 4 files changed, 203 insertions(+)
 create mode 100644 drivers/misc/lkdtm/xpfo.c

diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index 951c984de61a..97c6b7818cce 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -9,6 +9,7 @@ lkdtm-$(CONFIG_LKDTM)		+= refcount.o
 lkdtm-$(CONFIG_LKDTM)		+= rodata_objcopy.o
 lkdtm-$(CONFIG_LKDTM)		+= usercopy.o
 lkdtm-$(CONFIG_LKDTM)		+= stackleak.o
+lkdtm-$(CONFIG_LKDTM)		+= xpfo.o
 
 KASAN_SANITIZE_stackleak.o	:= n
 KCOV_INSTRUMENT_rodata.o	:= n
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 2837dc77478e..25f4ab4ebf50 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -185,6 +185,9 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(USERCOPY_KERNEL),
 	CRASHTYPE(USERCOPY_KERNEL_DS),
 	CRASHTYPE(STACKLEAK_ERASING),
+	CRASHTYPE(XPFO_READ_USER),
+	CRASHTYPE(XPFO_READ_USER_HUGE),
+	CRASHTYPE(XPFO_SMP),
 };
 
 
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 3c6fd327e166..6b31ff0c7f8f 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -87,4 +87,9 @@ void lkdtm_USERCOPY_KERNEL_DS(void);
 /* lkdtm_stackleak.c */
 void lkdtm_STACKLEAK_ERASING(void);
 
+/* lkdtm_xpfo.c */
+void lkdtm_XPFO_READ_USER(void);
+void lkdtm_XPFO_READ_USER_HUGE(void);
+void lkdtm_XPFO_SMP(void);
+
 #endif
diff --git a/drivers/misc/lkdtm/xpfo.c b/drivers/misc/lkdtm/xpfo.c
new file mode 100644
index 000000000000..d903063bdd0b
--- /dev/null
+++ b/drivers/misc/lkdtm/xpfo.c
@@ -0,0 +1,194 @@
+/*
+ * This is for all the tests related to XPFO (eXclusive Page Frame Ownership).
+ */
+
+#include "lkdtm.h"
+
+#include <linux/cpumask.h>
+#include <linux/mman.h>
+#include <linux/uaccess.h>
+#include <linux/xpfo.h>
+#include <linux/kthread.h>
+
+#include <linux/delay.h>
+#include <linux/sched/task.h>
+
+#define XPFO_DATA 0xdeadbeef
+
+static unsigned long do_map(unsigned long flags)
+{
+	unsigned long user_addr, user_data = XPFO_DATA;
+
+	user_addr = vm_mmap(NULL, 0, PAGE_SIZE,
+			    PROT_READ | PROT_WRITE | PROT_EXEC,
+			    flags, 0);
+	if (user_addr >= TASK_SIZE) {
+		pr_warn("Failed to allocate user memory\n");
+		return 0;
+	}
+
+	if (copy_to_user((void __user *)user_addr, &user_data,
+			 sizeof(user_data))) {
+		pr_warn("copy_to_user failed\n");
+		goto free_user;
+	}
+
+	return user_addr;
+
+free_user:
+	vm_munmap(user_addr, PAGE_SIZE);
+	return 0;
+}
+
+static unsigned long *user_to_kernel(unsigned long user_addr)
+{
+	phys_addr_t phys_addr;
+	void *virt_addr;
+
+	phys_addr = user_virt_to_phys(user_addr);
+	if (!phys_addr) {
+		pr_warn("Failed to get physical address of user memory\n");
+		return NULL;
+	}
+
+	virt_addr = phys_to_virt(phys_addr);
+	if (phys_addr != virt_to_phys(virt_addr)) {
+		pr_warn("Physical address of user memory seems incorrect\n");
+		return NULL;
+	}
+
+	return virt_addr;
+}
+
+static void read_map(unsigned long *virt_addr)
+{
+	pr_info("Attempting bad read from kernel address %p\n", virt_addr);
+	if (*(unsigned long *)virt_addr == XPFO_DATA)
+		pr_err("FAIL: Bad read succeeded?!\n");
+	else
+		pr_err("FAIL: Bad read didn't fail but data is incorrect?!\n");
+}
+
+static void read_user_with_flags(unsigned long flags)
+{
+	unsigned long user_addr, *kernel;
+
+	user_addr = do_map(flags);
+	if (!user_addr) {
+		pr_err("FAIL: map failed\n");
+		return;
+	}
+
+	kernel = user_to_kernel(user_addr);
+	if (!kernel) {
+		pr_err("FAIL: user to kernel conversion failed\n");
+		goto free_user;
+	}
+
+	read_map(kernel);
+
+free_user:
+	vm_munmap(user_addr, PAGE_SIZE);
+}
+
+/* Read from userspace via the kernel's linear map. */
+void lkdtm_XPFO_READ_USER(void)
+{
+	read_user_with_flags(MAP_PRIVATE | MAP_ANONYMOUS);
+}
+
+void lkdtm_XPFO_READ_USER_HUGE(void)
+{
+	read_user_with_flags(MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB);
+}
+
+struct smp_arg {
+	unsigned long *virt_addr;
+	unsigned int cpu;
+};
+
+static int smp_reader(void *parg)
+{
+	struct smp_arg *arg = parg;
+	unsigned long *virt_addr;
+
+	if (arg->cpu != smp_processor_id()) {
+		pr_err("FAIL: scheduled on wrong CPU?\n");
+		return 0;
+	}
+
+	virt_addr = smp_cond_load_acquire(&arg->virt_addr, VAL != NULL);
+	read_map(virt_addr);
+
+	return 0;
+}
+
+#ifdef CONFIG_X86
+#define XPFO_SMP_KILLED SIGKILL
+#elif CONFIG_ARM64
+#define XPFO_SMP_KILLED SIGSEGV
+#else
+#error unsupported arch
+#endif
+
+/* The idea here is to read from the kernel's map on a different thread than
+ * did the mapping (and thus the TLB flushing), to make sure that the page
+ * faults on other cores too.
+ */
+void lkdtm_XPFO_SMP(void)
+{
+	unsigned long user_addr, *virt_addr;
+	struct task_struct *thread;
+	int ret;
+	struct smp_arg arg;
+
+	if (num_online_cpus() < 2) {
+		pr_err("not enough to do a multi cpu test\n");
+		return;
+	}
+
+	arg.virt_addr = NULL;
+	arg.cpu = (smp_processor_id() + 1) % num_online_cpus();
+	thread = kthread_create(smp_reader, &arg, "lkdtm_xpfo_test");
+	if (IS_ERR(thread)) {
+		pr_err("couldn't create kthread? %ld\n", PTR_ERR(thread));
+		return;
+	}
+
+	kthread_bind(thread, arg.cpu);
+	get_task_struct(thread);
+	wake_up_process(thread);
+
+	user_addr = do_map(MAP_PRIVATE | MAP_ANONYMOUS);
+	if (!user_addr)
+		goto kill_thread;
+
+	virt_addr = user_to_kernel(user_addr);
+	if (!virt_addr) {
+		/*
+		 * let's store something that will fail, so we can unblock the
+		 * thread
+		 */
+		smp_store_release(&arg.virt_addr, &arg);
+		goto free_user;
+	}
+
+	smp_store_release(&arg.virt_addr, virt_addr);
+
+	/* there must be a better way to do this. */
+	while (1) {
+		if (thread->exit_state)
+			break;
+		msleep_interruptible(100);
+	}
+
+free_user:
+	if (user_addr)
+		vm_munmap(user_addr, PAGE_SIZE);
+
+kill_thread:
+	ret = kthread_stop(thread);
+	if (ret != XPFO_SMP_KILLED)
+		pr_err("FAIL: thread wasn't killed: %d\n", ret);
+	put_task_struct(thread);
+}
-- 
2.17.1

