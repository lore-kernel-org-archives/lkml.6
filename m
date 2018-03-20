Return-Path: <maran.wilson@oracle.com>
X-Google-Smtp-Source: AG47ELuWZYkBWyS2C3sxsV9jenJNOy/9bGrvAaGupGbgLnzWJXrrbE6JwSdypkFrh8oIXTvHhkE1
ARC-Seal: i=1; a=rsa-sha256; t=1521573583; cv=none;
        d=google.com; s=arc-20160816;
        b=cGRGPD6qqK8EpZkhJSHoZgYPgKoNEbITysEzg313Te4iMP1luvMWyq19bO3nGJfG9Z
         fwfQYqFFWuc1I9Ow/3xcLwXceKcf1YnxNA7DxRMZJrJmjZmghBC8aEgm//KQXXM+5gki
         5Q0MZfyErR/iaE6cYpJGfC4dAOepy800GilZptVRxj0nPK9l8n1IJfRMuL+OlS2CShfP
         /6fqc7rXItNRoisEmKW+0FPbM9diaWQZmvwzjQ57mF6WQeVP0sLr+U6ykBsxJFLumqF+
         WbuE3Pt8VWViMyCdhDGceuxJSRNKNJ8Ho9oWwREtNlP4DNWtGJ1lBJFhVcVTUD2rvU3X
         Z+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=h1giV71u09hqPVuHgYXA6LO+pZSIAQQuYSal9cT9DNM=;
        b=WiPOqk9OyQXa1T+FPMSLcB6V6LVuWfLcUr9KCBY3QtEuLCEk6+qDuvvU7w57D295CX
         qheTldCiI4vcovzafGcRjhhBMa+P+xgJsb5/pgi0xxKTZyQnGuKeXOYgig9liPayeLyY
         7nTmmDVJ9A87jO1AhXIZPTva63RQ3MN9R+qSLhm9pqHfp2qEU/H4YOQ2gUNmhoCWGKPR
         gPaLnqLncCco+8cqWuArokn92VPbnsH4tSecbHRO+jozDDP0XVPhipb11ApNnwQ8BA9O
         sqYHzR9ML60u3grGTlSpg7Y5eJw/NEOp3OsGwYBwx+TFGWi4o0IdfR9m5kuAYnlImAIC
         AMLA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=CFoPQU9I;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=CFoPQU9I;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Maran Wilson <maran.wilson@oracle.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, jgross@suse.com
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        boris.ostrovsky@oracle.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, mchehab@kernel.org,
        linus.walleij@linaro.org, rdunlap@infradead.org, roger.pau@citrix.com,
        rkrcmar@redhat.com, maran.wilson@oracle.com
Subject: [PATCH v5 2/7] xen/pvh: Move PVH entry code out of Xen specific tree
Date: Tue, 20 Mar 2018 12:18:54 -0700
Message-Id: <1521573534-17382-1-git-send-email-maran.wilson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1521573369-17216-1-git-send-email-maran.wilson@oracle.com>
References: <1521573369-17216-1-git-send-email-maran.wilson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8838 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595485541993170929?=
X-GMAIL-MSGID: =?utf-8?q?1595485541993170929?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Once hypervisors other than Xen start using the PVH entry point for
starting VMs, we would like the option of being able to compile PVH entry
capable kernels without enabling CONFIG_XEN and all the code that comes
along with that. To allow that, we are moving the PVH code out of Xen and
into files sitting at a higher level in the tree.

This patch is not introducing any code or functional changes, just moving
files from one location to another.

Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 MAINTAINERS                                                | 1 +
 arch/x86/Kbuild                                            | 2 ++
 arch/x86/platform/pvh/Makefile                             | 5 +++++
 arch/x86/{xen/enlighten_pvh.c => platform/pvh/enlighten.c} | 0
 arch/x86/{xen/xen-pvh.S => platform/pvh/head.S}            | 0
 arch/x86/xen/Makefile                                      | 3 ---
 6 files changed, 8 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/platform/pvh/Makefile
 rename arch/x86/{xen/enlighten_pvh.c => platform/pvh/enlighten.c} (100%)
 rename arch/x86/{xen/xen-pvh.S => platform/pvh/head.S} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93a12af4f180..58a836f39ad4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15210,6 +15210,7 @@ L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 S:	Supported
 F:	arch/x86/xen/
+F:	arch/x86/platform/pvh/
 F:	drivers/*/xen-*front.c
 F:	drivers/xen/
 F:	arch/x86/include/asm/xen/
diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index 0038a2d10a7a..2089e4414300 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -7,6 +7,8 @@ obj-$(CONFIG_KVM) += kvm/
 # Xen paravirtualization support
 obj-$(CONFIG_XEN) += xen/
 
+obj-$(CONFIG_XEN_PVH) += platform/pvh/
+
 # Hyper-V paravirtualization support
 obj-$(subst m,y,$(CONFIG_HYPERV)) += hyperv/
 
diff --git a/arch/x86/platform/pvh/Makefile b/arch/x86/platform/pvh/Makefile
new file mode 100644
index 000000000000..9fd25efcd2a3
--- /dev/null
+++ b/arch/x86/platform/pvh/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+OBJECT_FILES_NON_STANDARD_head.o := y
+
+obj-$(CONFIG_XEN_PVH) += enlighten.o
+obj-$(CONFIG_XEN_PVH) += head.o
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/platform/pvh/enlighten.c
similarity index 100%
rename from arch/x86/xen/enlighten_pvh.c
rename to arch/x86/platform/pvh/enlighten.c
diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/platform/pvh/head.S
similarity index 100%
rename from arch/x86/xen/xen-pvh.S
rename to arch/x86/platform/pvh/head.S
diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index d83cb5478f54..f1b850607212 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD_xen-asm_$(BITS).o := y
-OBJECT_FILES_NON_STANDARD_xen-pvh.o := y
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not profile debug and lowlevel utilities
@@ -21,7 +20,6 @@ obj-y		:= enlighten.o multicalls.o mmu.o irq.o \
 obj-$(CONFIG_XEN_PVHVM)		+= enlighten_hvm.o mmu_hvm.o suspend_hvm.o
 obj-$(CONFIG_XEN_PV)			+= setup.o apic.o pmu.o suspend_pv.o \
 						p2m.o enlighten_pv.o mmu_pv.o
-obj-$(CONFIG_XEN_PVH)			+= enlighten_pvh.o
 
 obj-$(CONFIG_EVENT_TRACING) += trace.o
 
@@ -33,4 +31,3 @@ obj-$(CONFIG_XEN_DEBUG_FS)	+= debugfs.o
 obj-$(CONFIG_XEN_DOM0)		+= vga.o
 obj-$(CONFIG_SWIOTLB_XEN)	+= pci-swiotlb-xen.o
 obj-$(CONFIG_XEN_EFI)		+= efi.o
-obj-$(CONFIG_XEN_PVH)	 	+= xen-pvh.o
-- 
2.16.1
