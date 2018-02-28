Return-Path: <maran.wilson@oracle.com>
X-Google-Smtp-Source: AG47ELujkZ53YCJyXe4mtvTNS28pxc3N4GLlYy5Jz1OKZ9rbjwbnHIdXB4TFnfA7JUCHRXeYNGT+
ARC-Seal: i=1; a=rsa-sha256; t=1519842602; cv=none;
        d=google.com; s=arc-20160816;
        b=J47wLTgPQs4JFSJWstkPPZ4g6jSwVHKEsw2lYpYeBFPrbtcaipWjt/wYt0hpX0DAui
         +VrB6Vmr/ZEaKPhjkirMxel58bN500s0PnZCmJMTfUYnw7EYxgb18wor/kwCQ+GaQBkJ
         K1cgaPU8E7dlkqpmRUudnSGFIKgI/ZSaFBxBYwyZkmBsv8poPqt6sUIzkPWg6cCxWQIw
         0zp1Vz9qN/yuCx4f+Scf7f5rN//HzC/BIsmetcPBXb7zefbU/tkrMtisveU5TbwO4W69
         ysESLKgX3jMTeu+tsYpO4dJ0sGIpsRKSqpIcSm7bi1ah5XotFqqVVGvnN9C+zzr6c57s
         Q8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=B2ZDVtxRY+D7f4mgpdBLsBmA6WczaMYhBO/mCnrBA1U=;
        b=l5ftO2iCJqm0Qanwtu+ZPrNeqevgdaaCjkXbePSA1hUi/DG89LuluJ9fKmQM7qK7IE
         GZIl0zIrEzfZk1IoyBIOHsTKQNmoUzWMV1/QrqslDMKigbpNrWHkltTynIdVrpXDs7XZ
         TOc9V5DLXb6MxKIEU1tdUxPLe4C8JQOF01vjuzk82Eetu3psEwk7Ae31dlWa8+NPuCLZ
         IW1WMyqzjAfmkbfFKIPbB+kUs6Tsk0PtQGpU7TybQ8BUuftqpg+W8H4rcrAbF8+E/qa0
         6yb1fywRVXs6S8n1i9hTJ8qAeO0PdTwlyq6gSKBs5FlpVpegE85E1OPeBOiq25ZFBs0T
         m0Zw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=TrbPeGi4;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=TrbPeGi4;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
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
Subject: [RFC PATCH v4 2/7] xen/pvh: Move PVH entry code out of Xen specific tree
Date: Wed, 28 Feb 2018 10:27:58 -0800
Message-Id: <1519842483-8887-3-git-send-email-maran.wilson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8818 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280224
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670476619272001?=
X-GMAIL-MSGID: =?utf-8?q?1593670476619272001?=
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
---
 MAINTAINERS                             | 1 +
 arch/x86/Kbuild                         | 3 +++
 arch/x86/{xen/xen-pvh.S => pvh-head.S}  | 0
 arch/x86/{xen/enlighten_pvh.c => pvh.c} | 0
 arch/x86/xen/Makefile                   | 2 --
 5 files changed, 4 insertions(+), 2 deletions(-)
 rename arch/x86/{xen/xen-pvh.S => pvh-head.S} (100%)
 rename arch/x86/{xen/enlighten_pvh.c => pvh.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93a12af4f180..dc89f3a279bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15210,6 +15210,7 @@ L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 S:	Supported
 F:	arch/x86/xen/
+F:	arch/x86/*pvh*
 F:	drivers/*/xen-*front.c
 F:	drivers/xen/
 F:	arch/x86/include/asm/xen/
diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index 0038a2d10a7a..a4e5e3d348dc 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -7,6 +7,9 @@ obj-$(CONFIG_KVM) += kvm/
 # Xen paravirtualization support
 obj-$(CONFIG_XEN) += xen/
 
+obj-$(CONFIG_XEN_PVH) += pvh.o
+obj-$(CONFIG_XEN_PVH) += pvh-head.o
+
 # Hyper-V paravirtualization support
 obj-$(subst m,y,$(CONFIG_HYPERV)) += hyperv/
 
diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/pvh-head.S
similarity index 100%
rename from arch/x86/xen/xen-pvh.S
rename to arch/x86/pvh-head.S
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/pvh.c
similarity index 100%
rename from arch/x86/xen/enlighten_pvh.c
rename to arch/x86/pvh.c
diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index d83cb5478f54..7e8145b33997 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -21,7 +21,6 @@ obj-y		:= enlighten.o multicalls.o mmu.o irq.o \
 obj-$(CONFIG_XEN_PVHVM)		+= enlighten_hvm.o mmu_hvm.o suspend_hvm.o
 obj-$(CONFIG_XEN_PV)			+= setup.o apic.o pmu.o suspend_pv.o \
 						p2m.o enlighten_pv.o mmu_pv.o
-obj-$(CONFIG_XEN_PVH)			+= enlighten_pvh.o
 
 obj-$(CONFIG_EVENT_TRACING) += trace.o
 
@@ -33,4 +32,3 @@ obj-$(CONFIG_XEN_DEBUG_FS)	+= debugfs.o
 obj-$(CONFIG_XEN_DOM0)		+= vga.o
 obj-$(CONFIG_SWIOTLB_XEN)	+= pci-swiotlb-xen.o
 obj-$(CONFIG_XEN_EFI)		+= efi.o
-obj-$(CONFIG_XEN_PVH)	 	+= xen-pvh.o
-- 
2.16.1
