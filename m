Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+MOBzNL7fB42CM2JuZ3a+IMwZMdpqCo7p7DEG1rP0FGzI+SVtEVZN50u/j7xwqLVtOEi51
ARC-Seal: i=1; a=rsa-sha256; t=1522168834; cv=none;
        d=google.com; s=arc-20160816;
        b=JNeWGujRYWSuNRuGHR+0KErMps1Q8ss+Au6bhb/kIO/Xr0wX8i6GRXqisdmFYLJyyI
         APb3hmxOmDDiNO78XZR9Wrx3a7+b8xbcGSwyzzOy03PrBSQSHzKiY69yjcg7tu8UTJOx
         AtNbT58eVjFC5FlGlQKzPz9yIuJ7p/lRoZ93oRM7KEgNy8GesAdCWxecChJKwzj2OX5I
         R0CAG8xBZK1abidqCs4mLI9JA4GcfoDPKi/5eNcKtsTURmdPbxkCsMaww022jQeyZiAE
         63lUtR3BO+o9i+lrRORkZ6eXCsUzhEZ0sTYGa+I9A80HLYPDjJh6lQbaYHuwKrHNPfX2
         l0rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1ZC5Us/ZpcdfKIrb9lucU/nPBX3mf3EHBS6OBatH2Q8=;
        b=sr4Qx5BAG+Up9vmQWI9eQKjKuU6Hev7OFgho3rlLdCeAZVCAYa3E/U07caicdALBr3
         Jgq08yVcduJ0PEaUKGd3xsGX0H2tt55gDgyz2006ik403yIQYtlvwMBIyS30eB649MEW
         Q3cV+JGBlLR/ZVHCVUkYVGD269cGTinRFXkW47LytNUw+CMSdzsiWE7ZLYnQ8ymbqitm
         m8UJgZS53LLTdsmUB77oNsb01wbd9iy+HCSRuBCqXA1H87MGIQmgIS+9bPDe3mqed0Ze
         qwcf2uWOotQN59bV/ohyNCZVMGzu9kL0AvYp7MgIMaEBn0siqODt5/EPpICczfmvZFwU
         DEQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lei Li <lious.lilei@hisilicon.com>,
	Toshi Kani <toshi.kani@hpe.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Wang Xuefeng <wxf.wang@hisilicon.com>,
	Will Deacon <will.deacon@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Michal Hocko <mhocko@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Borislav Petkov <bp@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Chintan Pandya <cpandya@codeaurora.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 049/105] mm/vmalloc: add interfaces to free unmapped page table
Date: Tue, 27 Mar 2018 18:27:29 +0200
Message-Id: <20180327162800.347756047@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108989017657999?=
X-GMAIL-MSGID: =?utf-8?q?1596109707532702889?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toshi Kani <toshi.kani@hpe.com>

commit b6bdb7517c3d3f41f20e5c2948d6bc3f8897394e upstream.

On architectures with CONFIG_HAVE_ARCH_HUGE_VMAP set, ioremap() may
create pud/pmd mappings.  A kernel panic was observed on arm64 systems
with Cortex-A75 in the following steps as described by Hanjun Guo.

 1. ioremap a 4K size, valid page table will build,
 2. iounmap it, pte0 will set to 0;
 3. ioremap the same address with 2M size, pgd/pmd is unchanged,
    then set the a new value for pmd;
 4. pte0 is leaked;
 5. CPU may meet exception because the old pmd is still in TLB,
    which will lead to kernel panic.

This panic is not reproducible on x86.  INVLPG, called from iounmap,
purges all levels of entries associated with purged address on x86.  x86
still has memory leak.

The patch changes the ioremap path to free unmapped page table(s) since
doing so in the unmap path has the following issues:

 - The iounmap() path is shared with vunmap(). Since vmap() only
   supports pte mappings, making vunmap() to free a pte page is an
   overhead for regular vmap users as they do not need a pte page freed
   up.

 - Checking if all entries in a pte page are cleared in the unmap path
   is racy, and serializing this check is expensive.

 - The unmap path calls free_vmap_area_noflush() to do lazy TLB purges.
   Clearing a pud/pmd entry before the lazy TLB purges needs extra TLB
   purge.

Add two interfaces, pud_free_pmd_page() and pmd_free_pte_page(), which
clear a given pud/pmd entry and free up a page for the lower level
entries.

This patch implements their stub functions on x86 and arm64, which work
as workaround.

[akpm@linux-foundation.org: fix typo in pmd_free_pte_page() stub]
Link: http://lkml.kernel.org/r/20180314180155.19492-2-toshi.kani@hpe.com
Fixes: e61ce6ade404e ("mm: change ioremap to set up huge I/O mappings")
Reported-by: Lei Li <lious.lilei@hisilicon.com>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Wang Xuefeng <wxf.wang@hisilicon.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Chintan Pandya <cpandya@codeaurora.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/mm/mmu.c           |   10 ++++++++++
 arch/x86/mm/pgtable.c         |   24 ++++++++++++++++++++++++
 include/asm-generic/pgtable.h |   10 ++++++++++
 lib/ioremap.c                 |    6 ++++--
 4 files changed, 48 insertions(+), 2 deletions(-)

--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -941,3 +941,13 @@ int pmd_clear_huge(pmd_t *pmd)
 	pmd_clear(pmd);
 	return 1;
 }
+
+int pud_free_pmd_page(pud_t *pud)
+{
+	return pud_none(*pud);
+}
+
+int pmd_free_pte_page(pmd_t *pmd)
+{
+	return pmd_none(*pmd);
+}
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -702,4 +702,28 @@ int pmd_clear_huge(pmd_t *pmd)
 
 	return 0;
 }
+
+/**
+ * pud_free_pmd_page - Clear pud entry and free pmd page.
+ * @pud: Pointer to a PUD.
+ *
+ * Context: The pud range has been unmaped and TLB purged.
+ * Return: 1 if clearing the entry succeeded. 0 otherwise.
+ */
+int pud_free_pmd_page(pud_t *pud)
+{
+	return pud_none(*pud);
+}
+
+/**
+ * pmd_free_pte_page - Clear pmd entry and free pte page.
+ * @pmd: Pointer to a PMD.
+ *
+ * Context: The pmd range has been unmaped and TLB purged.
+ * Return: 1 if clearing the entry succeeded. 0 otherwise.
+ */
+int pmd_free_pte_page(pmd_t *pmd)
+{
+	return pmd_none(*pmd);
+}
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -976,6 +976,8 @@ int pud_set_huge(pud_t *pud, phys_addr_t
 int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot);
 int pud_clear_huge(pud_t *pud);
 int pmd_clear_huge(pmd_t *pmd);
+int pud_free_pmd_page(pud_t *pud);
+int pmd_free_pte_page(pmd_t *pmd);
 #else	/* !CONFIG_HAVE_ARCH_HUGE_VMAP */
 static inline int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t prot)
 {
@@ -1001,6 +1003,14 @@ static inline int pmd_clear_huge(pmd_t *
 {
 	return 0;
 }
+static inline int pud_free_pmd_page(pud_t *pud)
+{
+	return 0;
+}
+static inline int pmd_free_pte_page(pmd_t *pmd)
+{
+	return 0;
+}
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
 
 #ifndef __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -91,7 +91,8 @@ static inline int ioremap_pmd_range(pud_
 
 		if (ioremap_pmd_enabled() &&
 		    ((next - addr) == PMD_SIZE) &&
-		    IS_ALIGNED(phys_addr + addr, PMD_SIZE)) {
+		    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
+		    pmd_free_pte_page(pmd)) {
 			if (pmd_set_huge(pmd, phys_addr + addr, prot))
 				continue;
 		}
@@ -117,7 +118,8 @@ static inline int ioremap_pud_range(p4d_
 
 		if (ioremap_pud_enabled() &&
 		    ((next - addr) == PUD_SIZE) &&
-		    IS_ALIGNED(phys_addr + addr, PUD_SIZE)) {
+		    IS_ALIGNED(phys_addr + addr, PUD_SIZE) &&
+		    pud_free_pmd_page(pud)) {
 			if (pud_set_huge(pud, phys_addr + addr, prot))
 				continue;
 		}
