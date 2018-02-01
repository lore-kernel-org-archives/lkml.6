Return-Path: <khalid.aziz@oracle.com>
X-Google-Smtp-Source: AH8x227f+UmHJabFfxUA9G0SLyzp3UsLtaQ2IVK34ngFoULY8+aXLP1KhaAaiEN1WUc81MtfvI2A
ARC-Seal: i=1; a=rsa-sha256; t=1517508142; cv=none;
        d=google.com; s=arc-20160816;
        b=iKiC61hm7a3nHOMQq/GIjL7+YCHw2Cv+KmFKWIKqI2+Yi6Su24QCCkccEvHIJA73Yf
         38AGN6r1x3DrVt7r4B9PepFxWfwGU3VRfLpQ5aCTbGqlqGvLD7XwfwQs8otl5MHKEoBn
         ovvcmKQv2ShElWagMHKBsv/LBbwF0B69tjKBbARRA5jU97odFAI7Mm8JOlUkIIVCkjgm
         h6ITXrN58UDbxc9QqYQyKo9IukcwgleVQSXbPYuZ0CbsCvBsv3px+A7035I1rH5NaWSu
         Xd/Gx1VwyLYzOdtB07IAIdtBF9bCFBoLpSS6dThVvxousrIxuvMLjqWQMvxZm/tZM7dP
         ynDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ws8eNaYToEIU9XO56q+w5MSQF/u8Mh/5b48J+Su36nw=;
        b=dJhHcLjyZ3D4zFEQXz5pSgVrhTRZvjXpEsILAB/nYPIbdkZVFtxxwGVTeHcRVOkle6
         85V81H5OGgO5P8n16bDQaWBsjF4zZIDTkhIPd67RA9knpwOry2hkeeWmHrD/UBN2tID3
         sP2UphSy2diimYf/6yJadR6OyHAFeqj5vyj8Eyptw/trxostZWhQJic2J7OyGiewj0wU
         p+ZoUxZQ679uaQVTXqBW12aDNt0qctztNDdYC8zLNVxevnTGd18ZTDwVQ1SZCA9l63IQ
         mSv8Mb+RRHi51ON4NsSe6Kz2amFvEjfD5wd93m4cX+2jsAkPPxC4cqFgFMfhHdtZSMA9
         eGKA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=ptopmeIs;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=ptopmeIs;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Khalid Aziz <khalid.aziz@oracle.com>
To: akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, davem@davemloft.net, dave.hansen@linux.intel.com
Cc: Khalid Aziz <khalid.aziz@oracle.com>, bsingharora@gmail.com,
        nborisov@suse.com, aarcange@redhat.com, anthony.yznaga@oracle.com,
        mgorman@suse.de, kirill.shutemov@linux.intel.com,
        dan.j.williams@intel.com, jack@suse.cz, ross.zwisler@linux.intel.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de, mhocko@suse.com,
        n-horiguchi@ah.jp.nec.com, jglisse@redhat.com,
        khandual@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>
Subject: [PATCH v11 07/10] mm: Add address parameter to arch_validate_prot()
Date: Thu,  1 Feb 2018 11:01:15 -0700
Message-Id: <27616ceba664f0a0be02198102ba2d62a62f10d8.1517497017.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1517497017.git.khalid.aziz@oracle.com>
References: <cover.1517497017.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1517497017.git.khalid.aziz@oracle.com>
References: <cover.1517497017.git.khalid.aziz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8792 signatures=668660
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802010231
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591222617666666694?=
X-GMAIL-MSGID: =?utf-8?q?1591222617666666694?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

A protection flag may not be valid across entire address space and
hence arch_validate_prot() might need the address a protection bit is
being set on to ensure it is a valid protection flag. For example, sparc
processors support memory corruption detection (as part of ADI feature)
flag on memory addresses mapped on to physical RAM but not on PFN mapped
pages or addresses mapped on to devices. This patch adds address to the
parameters being passed to arch_validate_prot() so protection bits can
be validated in the relevant context.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Khalid Aziz <khalid@gonehiking.org>
Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
v8:
	- Added addr parameter to powerpc arch_validate_prot() (suggested
	  by Michael Ellerman)
v7:
	- new patch

 arch/powerpc/include/asm/mman.h | 4 ++--
 arch/powerpc/kernel/syscalls.c  | 2 +-
 include/linux/mman.h            | 2 +-
 mm/mprotect.c                   | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
index 30922f699341..1d129f4521ac 100644
--- a/arch/powerpc/include/asm/mman.h
+++ b/arch/powerpc/include/asm/mman.h
@@ -32,7 +32,7 @@ static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
 }
 #define arch_vm_get_page_prot(vm_flags) arch_vm_get_page_prot(vm_flags)
 
-static inline bool arch_validate_prot(unsigned long prot)
+static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
 {
 	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_SAO))
 		return false;
@@ -40,7 +40,7 @@ static inline bool arch_validate_prot(unsigned long prot)
 		return false;
 	return true;
 }
-#define arch_validate_prot(prot) arch_validate_prot(prot)
+#define arch_validate_prot arch_validate_prot
 
 #endif /* CONFIG_PPC64 */
 #endif	/* _ASM_POWERPC_MMAN_H */
diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index a877bf8269fe..6d90ddbd2d11 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -48,7 +48,7 @@ static inline long do_mmap2(unsigned long addr, size_t len,
 {
 	long ret = -EINVAL;
 
-	if (!arch_validate_prot(prot))
+	if (!arch_validate_prot(prot, addr))
 		goto out;
 
 	if (shift) {
diff --git a/include/linux/mman.h b/include/linux/mman.h
index 6a4d1caaff5c..4b08e9c9c538 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -92,7 +92,7 @@ static inline void vm_unacct_memory(long pages)
  *
  * Returns true if the prot flags are valid
  */
-static inline bool arch_validate_prot(unsigned long prot)
+static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
 {
 	return (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM)) == 0;
 }
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 58b629bb70de..80243e0166a7 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -412,7 +412,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 	end = start + len;
 	if (end <= start)
 		return -ENOMEM;
-	if (!arch_validate_prot(prot))
+	if (!arch_validate_prot(prot, start))
 		return -EINVAL;
 
 	reqprot = prot;
-- 
2.11.0
