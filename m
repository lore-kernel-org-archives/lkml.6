Return-Path: <maran.wilson@oracle.com>
X-Google-Smtp-Source: AIpwx49xUkaiCjCQ3Q0C0BQoRmOKFyd/YAvp7WDDzkcoWcM760d1qakehXGtF+pgiATzboTKh/Cs
ARC-Seal: i=1; a=rsa-sha256; t=1522873922; cv=none;
        d=google.com; s=arc-20160816;
        b=wYZRhOZ9X3k7hc8sfMvUZrUliwCzEkO5GzfyufvLTXXJMVN07OXNmxS/W6+JPu+d8J
         QB23x1SRF5G16fLPfigsdOfL6LhFb2LM0d36Li6qcGzEhqLAHzSOnL2fHvgY2hmHmI/C
         CWiZnRYM2xGsarpfYVMw5SDKgLZ+xp+ifoXQkj7gwPpX9qAzisVeUWNkYD6BbTJ5WELO
         g2c8JyJLURoQT7dnFNQ/H6wd+G3vxJwtTvOAQDJ03vhXHkew0AS5m3HcQg4wlXvEKnQ2
         a4iRAxtdBUeDa4nZSpSgG9z6NspLvPhm4S/bIC2Kk1gSxu0hY93MblqvA2oB1rCDOrZP
         1YeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=IVmfDqQz06KsdsoIi2L75gar3ZvEEMgeQb4mGnjAVHA=;
        b=HKC/NqUAGkT5nyX43W2JoZYnXoZXe7f4j96II+tiII2mZF0Xx3OeykkhpML3BcAn3x
         ZfwZzN/1fep7s+rKXzpom/y6CF08MdCoNrQhyZQDYJWhhEFMlQKzpBA0HYukeaxEbjN9
         1w2QA7hu/Qq8BjK6uz6cbDhBOxpLiqhq2YFUgVp6ufx/QZ70m4V/X3h1stFU37ZXVfWZ
         LoJw12wlSFAGbQLe3a/NBi0MdNhXzTIHusEUQJaEG7A2u/NKpFkG1C5nlrEIYj3n1GSx
         RTl7O5mn3ve9sQIpoaARPV7beM+9N9UJvR2xKsFS4PbNC38uMsNKSKdJUvPshF3ML7j8
         rH/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=gMpkMBnr;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=gMpkMBnr;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
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
Subject: [PATCH v6 2/7] xen/pvh: Move PVH entry code out of Xen specific tree
Date: Wed,  4 Apr 2018 13:31:30 -0700
Message-Id: <1522873890-18005-1-git-send-email-maran.wilson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1522873659-17572-1-git-send-email-maran.wilson@oracle.com>
References: <1522873659-17572-1-git-send-email-maran.wilson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8853 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804040198
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596849045801507905?=
X-GMAIL-MSGID: =?utf-8?q?1596849045801507905?=
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
index 65ab509e4a42..52afae73beab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15189,6 +15189,7 @@ L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
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
