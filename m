Return-Path: <xieyisheng1@huawei.com>
X-Google-Smtp-Source: AIpwx48DrITX8Tq3LxgZ1mMlkiQXVPAGJ1A540UGOHaaPGECw6YgaJLzYG+2HtaKb5v/MnZH2XJN
ARC-Seal: i=1; a=rsa-sha256; t=1522386029; cv=none;
        d=google.com; s=arc-20160816;
        b=gfx0PKB2/Gn6KabNb6MKmJNLv3L56pWhXPwpa7IIiqGhp5b/2b9H4flmZLNXrWCQHf
         bQeSlM4ts4Kgmo3tiWb2foat1KRoPwPgRKoTYRrOZyRrSFLZZgtsGYOoqexwOa7U1r9U
         Zi/yqidYUD9GvlUeCI0Q94VIwGdUvOWr+THSfVpx2BoyiWa6xI86U+HOB8IkHunyqPdA
         ZrJbBZuuRoLNW89W2NIb40eh9bdPULEMVcRF9h9B9xrPLwY03Hwfz+nLAdVNlJXKpCp1
         RhLeaOA/vGgDFIU22arTsFADLibEvHOy7qSyknQtkDmXPpMQh65+HiBG4CGrWD8fcJFi
         camg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=lwCj4GKGBkNA08ZtKaVyU1SqOSs0pEwct78ENswoJb8=;
        b=DUFNM2v/4aIp6fJPTtA6fXd1LvSVrwgrU8YnpxqtdOhvfLlgAhd7Tb8n1TwiE4LCC5
         BcDzqCM+JNoNYL0PsS6sIeZAH8qubc/vMu8VmKYBmwwN3diMC/PtyC9wDkxccbJtWAzb
         8qycTVPjaJ4J6nk0MGzZDG4a3647KzupOKtn4fu0nF0wVd44LJm2okezG+n4zvE6+5GH
         lbBxuiClKcEUriuLqpf16r34jPMEi+IYCGYFgGW0XlaG3JnhgXxqRVXBwUBWQKiFT3BI
         zpTS2RE/UxUrNNGFBNxuHwjyncekAdJyfo527crZl/mpUIxG3ZZNAm8pCUC9NFP4xpSs
         kZHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of xieyisheng1@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=xieyisheng1@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of xieyisheng1@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=xieyisheng1@huawei.com
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <akpm@linux-foundation.org>
CC: <arnd@arndb.de>, <kstewart@linuxfoundation.org>,
	<gregkh@linuxfoundation.org>, <toshi.kani@hpe.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jcm@redhat.com>, <guohanjun@huawei.com>, <wangzhou1@hisilicon.com>,
	<tanxiaojun@huawei.com>, Yisheng Xie <xieyisheng1@huawei.com>
Subject: [RFC PATCH] lib/ioremap: Avoid triggering BUG_ON when end is not PAGE_ALIGN
Date: Fri, 30 Mar 2018 12:49:45 +0800
Message-ID: <1522385385-7074-1-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596337453491201592?=
X-GMAIL-MSGID: =?utf-8?q?1596337453491201592?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Zhou reported a bug on Hisilicon arm64 D06 platform with 64KB page size:

 [    2.470908] kernel BUG at lib/ioremap.c:72!
 [    2.475079] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
 [    2.480551] Modules linked in:
 [    2.483594] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc7-00062-g0b41260-dirty #23
 [    2.491756] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 UEFI Nemo 2.0 RC0 - B120 03/23/2018
 [    2.500614] pstate: 80c00009 (Nzcv daif +PAN +UAO)
 [    2.505395] pc : ioremap_page_range+0x268/0x36c
 [    2.509912] lr : pci_remap_iospace+0xe4/0x100
 [...]
 [    2.603733] Call trace:
 [    2.606168]  ioremap_page_range+0x268/0x36c
 [    2.610337]  pci_remap_iospace+0xe4/0x100
 [    2.614334]  acpi_pci_probe_root_resources+0x1d4/0x214
 [    2.619460]  pci_acpi_root_prepare_resources+0x18/0xa8
 [    2.624585]  acpi_pci_root_create+0x98/0x214
 [    2.628843]  pci_acpi_scan_root+0x124/0x20c
 [    2.633013]  acpi_pci_root_add+0x224/0x494
 [    2.637096]  acpi_bus_attach+0xf8/0x200
 [    2.640918]  acpi_bus_attach+0x98/0x200
 [    2.644740]  acpi_bus_attach+0x98/0x200
 [    2.648562]  acpi_bus_scan+0x48/0x9c
 [    2.652125]  acpi_scan_init+0x104/0x268
 [    2.655948]  acpi_init+0x308/0x374
 [    2.659337]  do_one_initcall+0x48/0x14c
 [    2.663160]  kernel_init_freeable+0x19c/0x250
 [    2.667504]  kernel_init+0x10/0x100
 [    2.670979]  ret_from_fork+0x10/0x18

The cause is the size of PCI IO resource is 32KB, which is 4K aligned but
not 64KB aligned, so when do ioremap_pte_range(), its incoming end is not
PAGE_ALIGN on 64KB page size system, but ioremap_pte_range increase the
addr by PAGE_SIZE, which makes addr != end until trigger BUG_ON.

This patch introduces pte_addr_end(addr, end) to resolve this problem, just
as what pmd_addr_end do. When end is not PAGE_ALIGN, it will return end
instead of addr + PAGE_SIZE, therefore ioremap_pte_range() can break out
when real end is coming.

Reported-by: Zhou Wang <wangzhou1@hisilicon.com>
Tested-by: Xiaojun Tan <tanxiaojun@huawei.com>
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 include/asm-generic/pgtable.h | 7 +++++++
 lib/ioremap.c                 | 5 ++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index bfbb44a..7d5ee84 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -478,6 +478,13 @@ static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
 })
 #endif
 
+#ifndef pte_addr_end
+#define pte_addr_end(addr, end)						\
+({	unsigned long __boundary = ((addr) + PAGE_SIZE) & PAGE_MASK;	\
+	(__boundary - 1 < (end) - 1) ? __boundary : (end);		\
+})
+#endif
+
 /*
  * When walking page tables, we usually want to skip any p?d_none entries;
  * and any p?d_bad entries - reporting the error before resetting to none.
diff --git a/lib/ioremap.c b/lib/ioremap.c
index 54e5bba..82c8502 100644
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -63,16 +63,19 @@ static int ioremap_pte_range(pmd_t *pmd, unsigned long addr,
 {
 	pte_t *pte;
 	u64 pfn;
+	unsigned long next;
 
 	pfn = phys_addr >> PAGE_SHIFT;
 	pte = pte_alloc_kernel(pmd, addr);
 	if (!pte)
 		return -ENOMEM;
 	do {
+		next = pte_addr_end(addr, end);
+
 		BUG_ON(!pte_none(*pte));
 		set_pte_at(&init_mm, addr, pte, pfn_pte(pfn, prot));
 		pfn++;
-	} while (pte++, addr += PAGE_SIZE, addr != end);
+	} while (pte++, addr = next, addr != end);
 	return 0;
 }
 
-- 
1.7.12.4
