Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AH8x226Aup8ZHS4yvqz8me1IdbK3YAuPm3FWiQwUGlWhw+iXg4tcMnkb0g3YOGHFtXDGh5Wo9xb4
ARC-Seal: i=1; a=rsa-sha256; t=1518420057; cv=none;
        d=google.com; s=arc-20160816;
        b=f7XcjmLU6jPg2dwhpIOIEXX5GgrKPvyeiSO7IO6y/encp5MH30UJHaFfnybAW6Nw6G
         Yt4xpOQSvDi3zjDinbg7rhiAT9TBIKts82uYbFvHEJSRy6vFqDzTfKasmMdWh8snxAZO
         bEmR2qXvrNcWmUz3Pc1kYHjmhKwoQ4QLzBoBon/4q5nZSEwtmcKtmL4ULjuJyMjbARAV
         LgvcrM2I7MhGXwVFspdHV+07nSpYIO+oiV7Jo8lgXWOxvGXlOjjnsKvjsp141/CTuV+g
         fWOLPz8WGV4gdJsY7MZtBQyz/t4DosL93tpGjnz2YE4IfEsfxHovdfARvx28ICU5zdC2
         poaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:cc:subject:from:to:dkim-signature
         :arc-authentication-results;
        bh=xUnbhRY4bMDP9wjt9f4Jl6U60gDrnrmD/TRXwk3vyws=;
        b=lJ7CUxxgNyFAST0cR0DXlFHB3a+AcsuH0IgNK9ng/+9d/0eM0Pj73V1OIsmHvxIq48
         ObBZG5q4kE8jP/lo0YCvZfuUR9S8cccPBL3fvOwLbRJwUYytGesxWVacCmUqkVw7Rn29
         vTX2CkDEzhVcllM0TOa+TmkfJrWhVIttVeIeMIRPJ4FIHZFZ7bg0ZejPCahH7lTgOUTK
         Znw2RUocLONb4b8g2uVPCY9ulTOATAJR9h8HyAyDZFrQJgVfXFYFqcE6P9iDFrerIpCy
         uNh8ymv3AASSsbcxJft/KfekrjtaRD569rgpoMwea1U1Ljht4WYiSAE7MSOKqeda/Ip+
         NTzw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=fAPHpygw;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=fAPHpygw;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
To: LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Fengguang Wu <fengguang.wu@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] headers: untangle kmemleak.h from mm.h
Cc: iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390 <linux-s390@vger.kernel.org>, sparclinux@vger.kernel.org,
 X86 ML <x86@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 John Johansen <john.johansen@canonical.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <a4629db7-194d-3c7c-c8fd-24f61b220a70@infradead.org>
Date: Sun, 11 Feb 2018 23:20:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592178829884506725?=
X-GMAIL-MSGID: =?utf-8?q?1592178829884506725?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Currently <linux/slab.h> #includes <linux/kmemleak.h> for no obvious
reason. It looks like it's only a convenience, so remove kmemleak.h
from slab.h and add <linux/kmemleak.h> to any users of kmemleak_*
that don't already #include it.
Also remove <linux/kmemleak.h> from source files that do not use it.

This is tested on i386 allmodconfig and x86_64 allmodconfig. It
would be good to run it through the 0day bot for other $ARCHes.
I have neither the horsepower nor the storage space for the other
$ARCHes.

[slab.h is the second most used header file after module.h; kernel.h
is right there with slab.h. There could be some minor error in the
counting due to some #includes having comments after them and I
didn't combine all of those.]

This is Lingchi patch #1 (death by a thousand cuts, applied to kernel
header files).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---

Fengguang, can you have this patch run thru 0day builds, please?

 arch/powerpc/sysdev/dart_iommu.c                          |    1 +
 arch/powerpc/sysdev/msi_bitmap.c                          |    1 +
 arch/s390/kernel/nmi.c                                    |    2 +-
 arch/s390/kernel/smp.c                                    |    1 -
 arch/sparc/kernel/irq_64.c                                |    1 -
 arch/x86/kernel/pci-dma.c                                 |    1 -
 drivers/iommu/exynos-iommu.c                              |    1 +
 drivers/iommu/mtk_iommu_v1.c                              |    1 -
 drivers/net/ethernet/ti/cpsw.c                            |    1 +
 drivers/net/wireless/realtek/rtlwifi/pci.c                |    1 -
 drivers/net/wireless/realtek/rtlwifi/rtl8192c/fw_common.c |    1 -
 drivers/staging/rtl8188eu/hal/fw.c                        |    2 +-
 drivers/staging/rtlwifi/pci.c                             |    1 -
 drivers/virtio/virtio_ring.c                              |    1 -
 include/linux/slab.h                                      |    1 -
 kernel/ucount.c                                           |    1 +
 mm/cma.c                                                  |    1 +
 mm/memblock.c                                             |    1 +
 net/core/sysctl_net_core.c                                |    1 -
 net/ipv4/route.c                                          |    1 -
 security/apparmor/lsm.c                                   |    1 -
 21 files changed, 9 insertions(+), 14 deletions(-)

--- lnx-416-rc1.orig/include/linux/slab.h
+++ lnx-416-rc1/include/linux/slab.h
@@ -125,7 +125,6 @@
 #define ZERO_OR_NULL_PTR(x) ((unsigned long)(x) <= \
 				(unsigned long)ZERO_SIZE_PTR)
 
-#include <linux/kmemleak.h>
 #include <linux/kasan.h>
 
 struct mem_cgroup;
--- lnx-416-rc1.orig/kernel/ucount.c
+++ lnx-416-rc1/kernel/ucount.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/cred.h>
 #include <linux/hash.h>
+#include <linux/kmemleak.h>
 #include <linux/user_namespace.h>
 
 #define UCOUNTS_HASHTABLE_BITS 10
--- lnx-416-rc1.orig/mm/memblock.c
+++ lnx-416-rc1/mm/memblock.c
@@ -17,6 +17,7 @@
 #include <linux/poison.h>
 #include <linux/pfn.h>
 #include <linux/debugfs.h>
+#include <linux/kmemleak.h>
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
 
--- lnx-416-rc1.orig/mm/cma.c
+++ lnx-416-rc1/mm/cma.c
@@ -35,6 +35,7 @@
 #include <linux/cma.h>
 #include <linux/highmem.h>
 #include <linux/io.h>
+#include <linux/kmemleak.h>
 #include <trace/events/cma.h>
 
 #include "cma.h"
--- lnx-416-rc1.orig/drivers/staging/rtl8188eu/hal/fw.c
+++ lnx-416-rc1/drivers/staging/rtl8188eu/hal/fw.c
@@ -30,7 +30,7 @@
 #include "rtl8188e_hal.h"
 
 #include <linux/firmware.h>
-#include <linux/kmemleak.h>
+#include <linux/slab.h>
 
 static void _rtl88e_enable_fw_download(struct adapter *adapt, bool enable)
 {
--- lnx-416-rc1.orig/drivers/iommu/exynos-iommu.c
+++ lnx-416-rc1/drivers/iommu/exynos-iommu.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/iommu.h>
 #include <linux/interrupt.h>
+#include <linux/kmemleak.h>
 #include <linux/list.h>
 #include <linux/of.h>
 #include <linux/of_iommu.h>
--- lnx-416-rc1.orig/arch/s390/kernel/nmi.c
+++ lnx-416-rc1/arch/s390/kernel/nmi.c
@@ -15,7 +15,7 @@
 #include <linux/hardirq.h>
 #include <linux/log2.h>
 #include <linux/kprobes.h>
-#include <linux/slab.h>
+#include <linux/kmemleak.h>
 #include <linux/time.h>
 #include <linux/module.h>
 #include <linux/sched/signal.h>
--- lnx-416-rc1.orig/arch/powerpc/sysdev/dart_iommu.c
+++ lnx-416-rc1/arch/powerpc/sysdev/dart_iommu.c
@@ -38,6 +38,7 @@
 #include <linux/suspend.h>
 #include <linux/memblock.h>
 #include <linux/gfp.h>
+#include <linux/kmemleak.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/iommu.h>
--- lnx-416-rc1.orig/arch/powerpc/sysdev/msi_bitmap.c
+++ lnx-416-rc1/arch/powerpc/sysdev/msi_bitmap.c
@@ -10,6 +10,7 @@
 
 #include <linux/slab.h>
 #include <linux/kernel.h>
+#include <linux/kmemleak.h>
 #include <linux/bitmap.h>
 #include <linux/bootmem.h>
 #include <asm/msi_bitmap.h>
--- lnx-416-rc1.orig/drivers/net/ethernet/ti/cpsw.c
+++ lnx-416-rc1/drivers/net/ethernet/ti/cpsw.c
@@ -35,6 +35,7 @@
 #include <linux/of_net.h>
 #include <linux/of_device.h>
 #include <linux/if_vlan.h>
+#include <linux/kmemleak.h>
 
 #include <linux/pinctrl/consumer.h>
 
--- lnx-416-rc1.orig/drivers/virtio/virtio_ring.c
+++ lnx-416-rc1/drivers/virtio/virtio_ring.c
@@ -23,7 +23,6 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/hrtimer.h>
-#include <linux/kmemleak.h>
 #include <linux/dma-mapping.h>
 #include <xen/xen.h>
 
--- lnx-416-rc1.orig/security/apparmor/lsm.c
+++ lnx-416-rc1/security/apparmor/lsm.c
@@ -23,7 +23,6 @@
 #include <linux/sysctl.h>
 #include <linux/audit.h>
 #include <linux/user_namespace.h>
-#include <linux/kmemleak.h>
 #include <net/sock.h>
 
 #include "include/apparmor.h"
--- lnx-416-rc1.orig/drivers/iommu/mtk_iommu_v1.c
+++ lnx-416-rc1/drivers/iommu/mtk_iommu_v1.c
@@ -25,7 +25,6 @@
 #include <linux/io.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
-#include <linux/kmemleak.h>
 #include <linux/list.h>
 #include <linux/of_address.h>
 #include <linux/of_iommu.h>
--- lnx-416-rc1.orig/drivers/staging/rtlwifi/pci.c
+++ lnx-416-rc1/drivers/staging/rtlwifi/pci.c
@@ -31,7 +31,6 @@
 #include "efuse.h"
 #include <linux/interrupt.h>
 #include <linux/export.h>
-#include <linux/kmemleak.h>
 #include <linux/module.h>
 
 MODULE_AUTHOR("lizhaoming	<chaoming_li@realsil.com.cn>");
--- lnx-416-rc1.orig/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ lnx-416-rc1/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -31,7 +31,6 @@
 #include "efuse.h"
 #include <linux/interrupt.h>
 #include <linux/export.h>
-#include <linux/kmemleak.h>
 #include <linux/module.h>
 
 MODULE_AUTHOR("lizhaoming	<chaoming_li@realsil.com.cn>");
--- lnx-416-rc1.orig/drivers/net/wireless/realtek/rtlwifi/rtl8192c/fw_common.c
+++ lnx-416-rc1/drivers/net/wireless/realtek/rtlwifi/rtl8192c/fw_common.c
@@ -32,7 +32,6 @@
 #include "../rtl8192ce/def.h"
 #include "fw_common.h"
 #include <linux/export.h>
-#include <linux/kmemleak.h>
 
 static void _rtl92c_enable_fw_download(struct ieee80211_hw *hw, bool enable)
 {
--- lnx-416-rc1.orig/arch/s390/kernel/smp.c
+++ lnx-416-rc1/arch/s390/kernel/smp.c
@@ -27,7 +27,6 @@
 #include <linux/err.h>
 #include <linux/spinlock.h>
 #include <linux/kernel_stat.h>
-#include <linux/kmemleak.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/irqflags.h>
--- lnx-416-rc1.orig/arch/sparc/kernel/irq_64.c
+++ lnx-416-rc1/arch/sparc/kernel/irq_64.c
@@ -22,7 +22,6 @@
 #include <linux/seq_file.h>
 #include <linux/ftrace.h>
 #include <linux/irq.h>
-#include <linux/kmemleak.h>
 
 #include <asm/ptrace.h>
 #include <asm/processor.h>
--- lnx-416-rc1.orig/arch/x86/kernel/pci-dma.c
+++ lnx-416-rc1/arch/x86/kernel/pci-dma.c
@@ -6,7 +6,6 @@
 #include <linux/bootmem.h>
 #include <linux/gfp.h>
 #include <linux/pci.h>
-#include <linux/kmemleak.h>
 
 #include <asm/proto.h>
 #include <asm/dma.h>
--- lnx-416-rc1.orig/net/core/sysctl_net_core.c
+++ lnx-416-rc1/net/core/sysctl_net_core.c
@@ -15,7 +15,6 @@
 #include <linux/vmalloc.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/kmemleak.h>
 
 #include <net/ip.h>
 #include <net/sock.h>
--- lnx-416-rc1.orig/net/ipv4/route.c
+++ lnx-416-rc1/net/ipv4/route.c
@@ -108,7 +108,6 @@
 #include <net/rtnetlink.h>
 #ifdef CONFIG_SYSCTL
 #include <linux/sysctl.h>
-#include <linux/kmemleak.h>
 #endif
 #include <net/secure_seq.h>
 #include <net/ip_tunnels.h>
