Return-Path: <khalid.aziz@oracle.com>
X-Google-Smtp-Source: AH8x227sZrCR2VcY8rOXYqAyfP90ts6oZGaL/NRfytunS3Hq9EELfoq3dY9/mUriZfNqsZiRaIiD
ARC-Seal: i=1; a=rsa-sha256; t=1519233461; cv=none;
        d=google.com; s=arc-20160816;
        b=xTXoVDpfJsDN9BWQBLs6uIdOUJgtkWvOtBMM1fOew5lMlW0MuNHrfuMySmEkVZ40+j
         vIXdZGNPx8Eu5T1HJrTVIUO1EohwSl6mDRVoS0lTwDZcS84MNyRp0gdRcIHtMxdOfQZG
         MfqhvRqvGKRZS61QnCPIWHnBbca3B8UucwXBrHg75mo/iumNATSNsTkSkAGHGluoKBKE
         PSXp5MyoBwest3bRMnzw2c2oDJf9Fe+fyDZaeJjcbNFLShWzKDKK6y1gx+uO3rSeayNV
         L3K0CnVH4pNh/cTGJsYQtSBoOHl84Q23JskrLudDZvFtPhNYpMvHUrUP0kn5C16DQE1x
         VBQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=wfgUfs6PuaXYCEU0HA4+xKurr2t2QzThslZSbf63Jmg=;
        b=txh+qGvHkUinbmXafau9MG8E+luZwecs7ST8H96/q9BMDaHsUKlsPb2Qwla/DBEESj
         ++2CGm7YfqfXgC1FcmRGGVoQj2CIbKGxzsDlM1nAjAa6lxVsSMqVMWEI4+QSRAY88tVd
         YBbtvz8ytLUQoWUGhxIiogExszoWeQ+wT/aJIUukmCkjWvFb6yzDLMW7SH5TBQpEqIo8
         BlyxR4T4umCm+Oe4JHdygLV4taO75v+E8eAUPCHNorVKZG6MnvUmpsrC4/nOkjBfuHB+
         tIfVwTyqN1XlCSZP62ofALGmvubSrkaIfS9A2mn52+SL9p4Q0u9OmNVZVnuLu3QICeXD
         KQ3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=cQjVyvLc;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=cQjVyvLc;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Khalid Aziz <khalid.aziz@oracle.com>
To: akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, davem@davemloft.net, dave.hansen@linux.intel.com
Cc: Khalid Aziz <khalid.aziz@oracle.com>, bsingharora@gmail.com,
        nborisov@suse.com, aarcange@redhat.com, anthony.yznaga@oracle.com,
        mgorman@suse.de, linuxram@us.ibm.com, kirill.shutemov@linux.intel.com,
        dan.j.williams@intel.com, jack@suse.cz, ross.zwisler@linux.intel.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de, mhocko@suse.com,
        n-horiguchi@ah.jp.nec.com, jglisse@redhat.com,
        henry.willard@oracle.com, aneesh.kumar@linux.vnet.ibm.com,
        khandual@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>
Subject: [PATCH v12 07/11] mm: Add address parameter to arch_validate_prot()
Date: Wed, 21 Feb 2018 10:15:49 -0700
Message-Id: <349751cbd54fda6f4a223f941aa71bbfe7be77ce.1519227112.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1519227112.git.khalid.aziz@oracle.com>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1519227112.git.khalid.aziz@oracle.com>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8811 signatures=668676
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802210211
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593031745545119756?=
X-GMAIL-MSGID: =?utf-8?q?1593031745545119756?=
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
v9:
	- new patch

 arch/powerpc/include/asm/mman.h | 4 ++--
 arch/powerpc/kernel/syscalls.c  | 2 +-
 include/linux/mman.h            | 2 +-
 mm/mprotect.c                   | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
index 07e3f54de9e3..e3f1b5ba5d5c 100644
--- a/arch/powerpc/include/asm/mman.h
+++ b/arch/powerpc/include/asm/mman.h
@@ -43,7 +43,7 @@ static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
 }
 #define arch_vm_get_page_prot(vm_flags) arch_vm_get_page_prot(vm_flags)
 
-static inline bool arch_validate_prot(unsigned long prot)
+static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
 {
 	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_SAO))
 		return false;
@@ -51,7 +51,7 @@ static inline bool arch_validate_prot(unsigned long prot)
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
index e3309fcf586b..088ea9c08678 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -417,7 +417,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 	end = start + len;
 	if (end <= start)
 		return -ENOMEM;
-	if (!arch_validate_prot(prot))
+	if (!arch_validate_prot(prot, start))
 		return -EINVAL;
 
 	reqprot = prot;
-- 
2.11.0
