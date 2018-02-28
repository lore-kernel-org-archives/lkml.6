Return-Path: <maran.wilson@oracle.com>
X-Google-Smtp-Source: AG47ELv7yMP8jf+W6RdeneqLWYHdJeMGoAYyLbOFte6uRP76gP3/J1kT6Skku/DUdIKcjrZMgLrQ
ARC-Seal: i=1; a=rsa-sha256; t=1519842559; cv=none;
        d=google.com; s=arc-20160816;
        b=LSAt6bGVEs+/feGDNVzOG1VEhst9hKh0HA+NNxO+IAnsCYvcKnJ5z0Hnbspp3m2Ssw
         xNdjGIqtKHxzSGB7jH/HCLv/KwMyYJhCA0HhKGev7SMzmBCPFw9m5NcZmkqjFw0zmj+5
         6aOXv73ndQnBgg6zDwEyHz74kpw6r0Qny+0mC6pkjq56ahYZKS+pLFvZXR8f5SoJsR1K
         FYLYlAXiPIjbvQTF+YaiQSa821J+6hv4kYA/Gy3SfBiw36aIXG3V6xvNOredsLz1L3fn
         gf8aIMyYUn1tjzbQCCYi9QuWD8/M/76XTrnFTtYSc1GWTtwKNc0nb751K8PzFzBgfB9/
         Vfeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=MqyeKfwxHfDnazrWSZDdHT5l1qtnl35qPidVCAkacdE=;
        b=o7hKh831uuKKBvEwUHnesfYStBuvG/2lZjOG6mGAC57G1bwq4Z00UQv33U/lyMuqX3
         7P4A7Hfh70Mnv8yem5+wmdOOSuCua87NX5lFLaiQ9v73FMNhtisRxRgQa95wvaLz4VKx
         F/UBzSabg051vn4QqG89VT+yTzzUNoPJHTOPFmFLoxXixfx3vw/EXlYUVVC7nz6ydbcE
         K8LBc8Y1XcMqPTFq8v9aOzhj1BGaaDnG/eVr6XMRa63JYj09kJgIz6eayjATes8jEqwB
         OPwqB46YE6/7IffZSyoYAiZz6cpmtbntzpJ1YDU1/vi0sXRmV2uPXwoBCwErtMhkrNuq
         6omQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=iqsxo4FE;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=iqsxo4FE;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Maran Wilson <maran.wilson@oracle.com>
To: pbonzini@redhat.com, jgross@suse.com, boris.ostrovsky@oracle.com,
        roger.pau@citrix.com, andrew.cooper3@citrix.com, hch@infradead.org,
        JBeulich@suse.com, x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rkrcmar@redhat.com,
        jpoimboe@redhat.com, bp@suse.de, kirill.shutemov@linux.intel.com,
        thomas.lendacky@amd.com, luto@kernel.org, maran.wilson@oracle.com,
        dave.hansen@linux.intel.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, mchehab@kernel.org,
        linus.walleij@linaro.org, rdunlap@infradead.org
Subject: [RFC PATCH v4 3/7] xen/pvh: Create a new file for Xen specific PVH code
Date: Wed, 28 Feb 2018 10:27:59 -0800
Message-Id: <1519842483-8887-4-git-send-email-maran.wilson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8818 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280224
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670431890911197?=
X-GMAIL-MSGID: =?utf-8?q?1593670431890911197?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We need to refactor PVH entry code so that support for other hypervisors
like Qemu/KVM can be added more easily.

The first step in that direction is to create a new file that will
eventually hold the Xen specific routines.

Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
---
 arch/x86/pvh.c               |  1 -
 arch/x86/xen/Makefile        |  1 +
 arch/x86/xen/enlighten_pvh.c | 11 +++++++++++
 3 files changed, 12 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/xen/enlighten_pvh.c

diff --git a/arch/x86/pvh.c b/arch/x86/pvh.c
index 436c4f003e17..b56cb5e7d6ac 100644
--- a/arch/x86/pvh.c
+++ b/arch/x86/pvh.c
@@ -19,7 +19,6 @@
  * xen_pvh and pvh_bootparams need to live in data segment since they
  * are used after startup_{32|64}, which clear .bss, are invoked.
  */
-bool xen_pvh __attribute__((section(".data"))) = 0;
 struct boot_params pvh_bootparams __attribute__((section(".data")));
 
 struct hvm_start_info pvh_start_info;
diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index 7e8145b33997..ef6481a83768 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -21,6 +21,7 @@ obj-y		:= enlighten.o multicalls.o mmu.o irq.o \
 obj-$(CONFIG_XEN_PVHVM)		+= enlighten_hvm.o mmu_hvm.o suspend_hvm.o
 obj-$(CONFIG_XEN_PV)			+= setup.o apic.o pmu.o suspend_pv.o \
 						p2m.o enlighten_pv.o mmu_pv.o
+obj-$(CONFIG_XEN_PVH)			+= enlighten_pvh.o
 
 obj-$(CONFIG_EVENT_TRACING) += trace.o
 
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
new file mode 100644
index 000000000000..4b4e9cc78b8a
--- /dev/null
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -0,0 +1,11 @@
+#include <linux/types.h>
+
+/*
+ * PVH variables.
+ *
+ * The variables xen_pvh and pvh_bootparams need to live in the data segment
+ * since they are used after startup_{32|64} is invoked, which will clear the
+ * .bss segment.
+ */
+bool xen_pvh __attribute__((section(".data"))) = 0;
+
-- 
2.16.1
