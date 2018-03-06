Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELsVNePqYZEucJdtpx5ElXftHac9U1bQ1RvO7bBKTM7eoPUNSH11/9etefDTD9fZN9iyfJBu
ARC-Seal: i=1; a=rsa-sha256; t=1520295986; cv=none;
        d=google.com; s=arc-20160816;
        b=RI3rSPTcYGToCv4ZUCpDHFr7lTPLcReV53cM7BfxqrZqRJgdP2b/q2EqR9mr7s1fbi
         nyO2glrGDNgbUXkzELEpslzjv5kZvGtA5JT4x/kF+u0zaYDWCsb4aZfDDAUI38z5IUvb
         WPJH5Pi3bUoVVVAO+Wpv8si51MEbWUGBOWHrd8xxo3Y0LFoYOPMlfmIItpYTL0qIKis4
         T7RCONEUifr+g8BzqyD8QBg0BTkPJZdanb79N9zUY2XUYrCtBuRM44gec+qah+31U6e/
         l71HeEaDSF7VZsYlf/PtfjmLmeufiH7yvKGzOm+ke/P5Y4L8cy6u4ZmtbQ27GZLC9kXH
         GvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=b0sYpNZcTYiUhKugHUt8j7U/BMw7oc5hNhgDLi3c3Og=;
        b=DZeL7fIe3mTBXGIFjqBCdtuWOFgorHrE9bgd/DkxO4ivszDUWeFc4knvjTjOqGorwD
         6/UagxUkwArrgDFeXQe/hn5uNBq41wU4rTHpXwsCSw+t2yi6vHCM2nj62L4zZB5c1Oh2
         Tvg2kKLJsPNfjXB7YLh3eVNYne0dTVJ1e98X4LNqXdm0a6mMupsba+Mtjhn8WDAGISdC
         KJTSf1sjOMvvncmYFaj0cz4S2YQLrosIHMlgJHdRkFLqsg/XzEnKvo7c4fbsmJcc1lHX
         QqpipP3QU1liIyNEieqvtsdOAvpE3csoKLVbwCi+u+k5niZwn3FEigIitiBZm6W8dtWQ
         4Z0w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=g5TJO54h;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=g5TJO54h;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 28/65] kaiser: do not set _PAGE_NX on pgd_none
Date: Mon,  5 Mar 2018 19:25:01 -0500
Message-Id: <20180306002538.1761-29-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145884286134709?=
X-GMAIL-MSGID: =?utf-8?q?1594145884286134709?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

native_pgd_clear() uses native_set_pgd(), so native_set_pgd() must
avoid setting the _PAGE_NX bit on an otherwise pgd_none() entry:
usually that just generated a warning on exit, but sometimes
more mysterious and damaging failures (our production machines
could not complete booting).

The original fix to this just avoided adding _PAGE_NX to
an empty entry; but eventually more problems surfaced with kexec,
and EFI mapping expected to be a problem too.  So now instead
change native_set_pgd() to update shadow only if _PAGE_USER:

A few places (kernel/machine_kexec_64.c, platform/efi/efi_64.c for sure)
use set_pgd() to set up a temporary internal virtual address space, with
physical pages remapped at what Kaiser regards as userspace addresses:
Kaiser then assumes a shadow pgd follows, which it will try to corrupt.

This appears to be responsible for the recent kexec and kdump failures;
though it's unclear how those did not manifest as a problem before.
Ah, the shadow pgd will only be assumed to "follow" if the requested
pgd is on an even-numbered page: so I suppose it was going wrong 50%
of the time all along.

What we need is a flag to set_pgd(), to tell it we're dealing with
userspace.  Er, isn't that what the pgd's _PAGE_USER bit is saying?
Add a test for that.  But we cannot do the same for pgd_clear()
(which may be called to clear corrupted entries - set aside the
question of "corrupt in which pgd?" until later), so there just
rely on pgd_clear() not being called in the problematic cases -
with a WARN_ON_ONCE() which should fire half the time if it is.

But this is getting too big for an inline function: move it into
arch/x86/mm/kaiser.c (which then demands a boot/compressed mod);
and de-void and de-space native_get_shadow/normal_pgd() while here.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit edde73205b3fdde8c8a3adfce78cc6d0de72386b)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/boot/compressed/misc.h   |  1 +
 arch/x86/include/asm/pgtable_64.h | 51 ++++++++++-----------------------------
 arch/x86/mm/kaiser.c              | 42 ++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 38 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 805d25ca5f1d..cbaa2ebfa88d 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -9,6 +9,7 @@
  */
 #undef CONFIG_PARAVIRT
 #undef CONFIG_PARAVIRT_SPINLOCKS
+#undef CONFIG_KAISER
 #undef CONFIG_KASAN
 
 #include <linux/linkage.h>
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index b0adf0d11c9a..8629be9e6649 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -107,61 +107,36 @@ static inline void native_pud_clear(pud_t *pud)
 }
 
 #ifdef CONFIG_KAISER
-static inline pgd_t * native_get_shadow_pgd(pgd_t *pgdp)
+extern pgd_t kaiser_set_shadow_pgd(pgd_t *pgdp, pgd_t pgd);
+
+static inline pgd_t *native_get_shadow_pgd(pgd_t *pgdp)
 {
-	return (pgd_t *)(void*)((unsigned long)(void*)pgdp | (unsigned long)PAGE_SIZE);
+	return (pgd_t *)((unsigned long)pgdp | (unsigned long)PAGE_SIZE);
 }
 
-static inline pgd_t * native_get_normal_pgd(pgd_t *pgdp)
+static inline pgd_t *native_get_normal_pgd(pgd_t *pgdp)
 {
-	return (pgd_t *)(void*)((unsigned long)(void*)pgdp &  ~(unsigned long)PAGE_SIZE);
+	return (pgd_t *)((unsigned long)pgdp & ~(unsigned long)PAGE_SIZE);
 }
 #else
-static inline pgd_t * native_get_shadow_pgd(pgd_t *pgdp)
+static inline pgd_t kaiser_set_shadow_pgd(pgd_t *pgdp, pgd_t pgd)
+{
+	return pgd;
+}
+static inline pgd_t *native_get_shadow_pgd(pgd_t *pgdp)
 {
 	BUILD_BUG_ON(1);
 	return NULL;
 }
-static inline pgd_t * native_get_normal_pgd(pgd_t *pgdp)
+static inline pgd_t *native_get_normal_pgd(pgd_t *pgdp)
 {
 	return pgdp;
 }
 #endif /* CONFIG_KAISER */
 
-/*
- * Page table pages are page-aligned.  The lower half of the top
- * level is used for userspace and the top half for the kernel.
- * This returns true for user pages that need to get copied into
- * both the user and kernel copies of the page tables, and false
- * for kernel pages that should only be in the kernel copy.
- */
-static inline bool is_userspace_pgd(void *__ptr)
-{
-	unsigned long ptr = (unsigned long)__ptr;
-
-	return ((ptr % PAGE_SIZE) < (PAGE_SIZE / 2));
-}
-
 static inline void native_set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
-#ifdef CONFIG_KAISER
-	pteval_t extra_kern_pgd_flags = 0;
-	/* Do we need to also populate the shadow pgd? */
-	if (is_userspace_pgd(pgdp)) {
-		native_get_shadow_pgd(pgdp)->pgd = pgd.pgd;
-		/*
-		 * Even if the entry is *mapping* userspace, ensure
-		 * that userspace can not use it.  This way, if we
-		 * get out to userspace running on the kernel CR3,
-		 * userspace will crash instead of running.
-		 */
-		extra_kern_pgd_flags = _PAGE_NX;
-	}
-	pgdp->pgd = pgd.pgd;
-	pgdp->pgd |= extra_kern_pgd_flags;
-#else /* CONFIG_KAISER */
-	*pgdp = pgd;
-#endif
+	*pgdp = kaiser_set_shadow_pgd(pgdp, pgd);
 }
 
 static inline void native_pgd_clear(pgd_t *pgd)
diff --git a/arch/x86/mm/kaiser.c b/arch/x86/mm/kaiser.c
index f29c0db1c9b4..df7f6591d5aa 100644
--- a/arch/x86/mm/kaiser.c
+++ b/arch/x86/mm/kaiser.c
@@ -303,4 +303,46 @@ void kaiser_remove_mapping(unsigned long start, unsigned long size)
 		unmap_pud_range_nofree(pgd, addr, end);
 	}
 }
+
+/*
+ * Page table pages are page-aligned.  The lower half of the top
+ * level is used for userspace and the top half for the kernel.
+ * This returns true for user pages that need to get copied into
+ * both the user and kernel copies of the page tables, and false
+ * for kernel pages that should only be in the kernel copy.
+ */
+static inline bool is_userspace_pgd(pgd_t *pgdp)
+{
+	return ((unsigned long)pgdp % PAGE_SIZE) < (PAGE_SIZE / 2);
+}
+
+pgd_t kaiser_set_shadow_pgd(pgd_t *pgdp, pgd_t pgd)
+{
+	/*
+	 * Do we need to also populate the shadow pgd?  Check _PAGE_USER to
+	 * skip cases like kexec and EFI which make temporary low mappings.
+	 */
+	if (pgd.pgd & _PAGE_USER) {
+		if (is_userspace_pgd(pgdp)) {
+			native_get_shadow_pgd(pgdp)->pgd = pgd.pgd;
+			/*
+			 * Even if the entry is *mapping* userspace, ensure
+			 * that userspace can not use it.  This way, if we
+			 * get out to userspace running on the kernel CR3,
+			 * userspace will crash instead of running.
+			 */
+			pgd.pgd |= _PAGE_NX;
+		}
+	} else if (!pgd.pgd) {
+		/*
+		 * pgd_clear() cannot check _PAGE_USER, and is even used to
+		 * clear corrupted pgd entries: so just rely on cases like
+		 * kexec and EFI never to be using pgd_clear().
+		 */
+		if (!WARN_ON_ONCE((unsigned long)pgdp & PAGE_SIZE) &&
+		    is_userspace_pgd(pgdp))
+			native_get_shadow_pgd(pgdp)->pgd = pgd.pgd;
+	}
+	return pgd;
+}
 #endif /* CONFIG_KAISER */
-- 
2.16.2
