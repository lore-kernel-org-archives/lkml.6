Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx4/KtkRwHi+5BMtfpNYRRweLkIG9Dt55cdKQraiXQU2B2WiIc3pjJ0MHioy3J6JDmahgrY53
ARC-Seal: i=1; a=rsa-sha256; t=1524498483; cv=none;
        d=google.com; s=arc-20160816;
        b=TeYySKo92zV6vg+Kvr70/b38UXy0IBwyZuuyCDHzonYsgBQZ3yefziGpaUaoIow5e1
         pJyRnHyDhO1wiiwHx3DeH01PS3rGJRHNHzS3rLa9ds0bOE20argcZLizFVnhKIX3vLIn
         JIIHcxcccXzakXXDeWF3z8W1j8MUNt6I62KC2N/eV+36oBcJbYJKq8y/D/umyCf3X90r
         5d93c/L20PkV5purjsJjF8Z+R5KNlsVEL66RbD5goroS2c/UArhvn7+7BISer9ZBkF2e
         aLuN+n0SCGrtzGK5BnZ0UUxrp7NKzR+KO5cUenz+IK4FOe17UA1KYFyH+lnif87/Sdsl
         RzMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=v2axBOnpnXabVVkJuEFD8oEyEA4P/N4K6umsrPMrA4w=;
        b=PZ3SJ0zz2jBygpc8oDFEXXDQNTeQW1MEsm2USR481AaliruCoO5+zus7L9n70FvM08
         gjAGcP/80sTBv5q+pSNOMAFQU2pu7hqWRyfUDqzSoBWxhv+L6VVsfxFHNq3GLRwYd6HU
         VUjYirEgQxpzSkaLQ71DTUO9t9+Gjzt/zrXfLsxe5lb31YUWaYW1uqga7CxzVOk9JHEh
         lUCunNm4AQUd/takTK983fPi9zhXxTw9kLBhIXROEpWygWevyge3qgKkTO6WuwvOqX3Y
         TAMsrNE0mxiO0p9FzZEQZDwb/HM9La5s/NFnSG5h0dNZ9K0gBM5LkWo9e0wVNh/qOos5
         BILA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=ERnBmOLn;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=ERnBmOLn;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
From: Joerg Roedel <joro@8bytes.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	aliguori@amazon.com,
	daniel.gruss@iaik.tugraz.at,
	hughd@google.com,
	keescook@google.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 31/37] x86/ldt: Reserve address-space range on 32 bit for the LDT
Date: Mon, 23 Apr 2018 17:47:34 +0200
Message-Id: <1524498460-25530-32-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552522055269667?=
X-GMAIL-MSGID: =?utf-8?q?1598552522055269667?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Reserve 2MB/4MB of address-space for mapping the LDT to
user-space on 32 bit PTI kernels.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/pgtable_32_types.h | 7 +++++--
 arch/x86/mm/dump_pagetables.c           | 9 +++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_32_types.h b/arch/x86/include/asm/pgtable_32_types.h
index e3225e8..1fa76c9 100644
--- a/arch/x86/include/asm/pgtable_32_types.h
+++ b/arch/x86/include/asm/pgtable_32_types.h
@@ -50,13 +50,16 @@ extern bool __vmalloc_start_set; /* set once high_memory is set */
 	((FIXADDR_TOT_START - PAGE_SIZE * (CPU_ENTRY_AREA_PAGES + 1))   \
 	 & PMD_MASK)
 
-#define PKMAP_BASE		\
+#define LDT_BASE_ADDR		\
 	((CPU_ENTRY_AREA_BASE - PAGE_SIZE) & PMD_MASK)
 
+#define PKMAP_BASE		\
+	((LDT_BASE_ADDR - PAGE_SIZE) & PMD_MASK)
+
 #ifdef CONFIG_HIGHMEM
 # define VMALLOC_END	(PKMAP_BASE - 2 * PAGE_SIZE)
 #else
-# define VMALLOC_END	(CPU_ENTRY_AREA_BASE - 2 * PAGE_SIZE)
+# define VMALLOC_END	(LDT_BASE_ADDR - 2 * PAGE_SIZE)
 #endif
 
 #define MODULES_VADDR	VMALLOC_START
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 23d24d1..db1d7a0 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -123,6 +123,9 @@ enum address_markers_idx {
 #ifdef CONFIG_HIGHMEM
 	PKMAP_BASE_NR,
 #endif
+#ifdef CONFIG_MODIFY_LDT_SYSCALL
+	LDT_NR,
+#endif
 	CPU_ENTRY_AREA_NR,
 	FIXADDR_START_NR,
 	END_OF_SPACE_NR,
@@ -136,6 +139,9 @@ static struct addr_marker address_markers[] = {
 #ifdef CONFIG_HIGHMEM
 	[PKMAP_BASE_NR]		= { 0UL,		"Persistent kmap() Area" },
 #endif
+#ifdef CONFIG_MODIFY_LDT_SYSCALL
+	[LDT_NR]		= { 0UL,		"LDT remap" },
+#endif
 	[CPU_ENTRY_AREA_NR]	= { 0UL,		"CPU entry area" },
 	[FIXADDR_START_NR]	= { 0UL,		"Fixmap area" },
 	[END_OF_SPACE_NR]	= { -1,			NULL }
@@ -609,6 +615,9 @@ static int __init pt_dump_init(void)
 # endif
 	address_markers[FIXADDR_START_NR].start_address = FIXADDR_START;
 	address_markers[CPU_ENTRY_AREA_NR].start_address = CPU_ENTRY_AREA_BASE;
+# ifdef CONFIG_MODIFY_LDT_SYSCALL
+	address_markers[LDT_NR].start_address = LDT_BASE_ADDR;
+# endif
 #endif
 	return 0;
 }
-- 
2.7.4
