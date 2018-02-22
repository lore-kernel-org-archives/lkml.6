Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753807AbeBVMV5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:21:57 -0500
Received: from mout.gmx.net ([212.227.15.19]:38731 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753640AbeBVMV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:21:56 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        linux-mm@kvack.org, Joel Stanley <joel@jms.id.au>,
        Christophe LEROY <christophe.leroy@c-s.fr>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5/5] powerpc/mm/32: Remove the reserved memory hack
Date: Thu, 22 Feb 2018 13:15:16 +0100
Message-Id: <20180222121516.23415-6-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180222121516.23415-1-j.neuschaefer@gmx.net>
References: <20180222121516.23415-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Kpf3I2fDQadeeg4NT4Q2UoHC+BFIPk2FNPaFPBB60XeCkr5iOEK
 qJT1EpUgGiJf26wYJf16uIbNxDugw0QZdVWSKp/UyPB4l85+mUpsLx8jrpSTkTFK6n/LZGJ
 rgFGyMjgirinN8RA7fFoW+gOuV0tmU4StcXmEwN4SNUZQLZWUE3c7nzYdb0INTlp5lrSEjj
 0Fj5Moc0640HDrSScEU4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tQu57p0Wkt0=:zQjXsNLUIGZbGzIfboR7tU
 /VbKUycOHvRPhq6qALdg+8lyLROkv5CV90MGgR3ta1G+xT1o2ix/sBksJYwOrLVThFuVcoBl/
 OT+nNvN4nB6nOyi0Sb8W9xu+73COKcMsqwBf0lRs2/s1HU4Qh+VjVzM90S+PGT+Xc/wdyzq3e
 d5Nv8j/6ETimAb8KtW9l2Zzv+xhgkuXhQbGyqyp7wx7mnih5gscHgI3jxndv/0xLv+DwqoGHs
 dBnNPtmuYKaUk+GYP8ZZndKeYWagfuOCzfsqHKqpidsoFi1YKShVVmRanYzgB1jHl0B75aisL
 M6GaOvXHECNlJXk8J8pVpjZXGiP9saAMhXRT1oSn8Ri7yrDCBlRI9QuS3671ZbY7IgzInLToc
 IqYVz8BrF0Ul+daYGA2ipp4o0C+sOwtzB535gryol74aCnqWYpVJmIqbuckM/4kYj1z7s2/37
 gtqWzgI2hC8fI3hOv3QM1gzTk79061gAUKAdpvwIP5jasMrBPKacW44OeWhx5sQoIlzYFmuZj
 ZH2RC6+qVn1peYvFKsm/sDTK3JZPjHcblDyfXQ7iKKIMY5gwOLxtvIWJwX+XcG7dKwHcS1KK5
 eL0qauIKY8lfuB57c7vWuf/zuGtjAuhXMx09lTin7cH4J23Q2YPaG2B5nRiwGe3SbbP9TeSl/
 xW+MD7izR9wkLZ0uppOTcURW/xhJwcTVynFcF0y7uYp9iJ348wdwBtVfeil4Pdt8EcQNaJBcR
 TVlpaU6apNIRU72/phFy4DnACHSg8tSu+V93/pM+OacLf/DNTFJ8ZmIdphxsyXH4gkD2+adub
 wfHmEghM8aJDQfvmVYkt9zSgG5uUjuHxFRmI7AntTeDSdtCWSo=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This hack, introduced in commit c5df7f775148 ("powerpc: allow ioremap
within reserved memory regions") is now unnecessary.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 arch/powerpc/mm/init_32.c    | 5 -----
 arch/powerpc/mm/mmu_decl.h   | 1 -
 arch/powerpc/mm/pgtable_32.c | 3 +--
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 6419b33ca309..326240177fa6 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -88,11 +88,6 @@ void MMU_init(void);
 int __map_without_bats;
 int __map_without_ltlbs;
 
-/*
- * This tells the system to allow ioremapping memory marked as reserved.
- */
-int __allow_ioremap_reserved;
-
 /* max amount of low RAM to map in */
 unsigned long __max_low_memory = MAX_LOW_MEM;
 
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 57fbc554c785..c4c0a09a7775 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -98,7 +98,6 @@ extern void setbat(int index, unsigned long virt, phys_addr_t phys,
 		   unsigned int size, pgprot_t prot);
 
 extern int __map_without_bats;
-extern int __allow_ioremap_reserved;
 extern unsigned int rtas_data, rtas_size;
 
 struct hash_pte;
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index d54e1a9c1c99..a89eb3b898cd 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -146,8 +146,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using.
 	 */
-	if (page_is_ram(__phys_to_pfn(p)) &&
-	    !(__allow_ioremap_reserved && memblock_is_region_reserved(p, size))) {
+	if (page_is_ram(__phys_to_pfn(p))) {
 		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
 		       (unsigned long long)p, __builtin_return_address(0));
 		return NULL;
-- 
2.16.1
