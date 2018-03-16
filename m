Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELsDqNeNfGsfwnLCP+R3iArb00Sbvxo4Jqu8dyUMBWVSyFmLvK9+5K9aIsgxIdRvJ/G7jljC
ARC-Seal: i=1; a=rsa-sha256; t=1521228614; cv=none;
        d=google.com; s=arc-20160816;
        b=yzv40s2Vh4kO558xdwp1L4bWLuXSu7+UXNb7H96bh8FoihqDDHxRt+43TDHq7bFNhy
         4qeGnhH5+H++fY5ihuC+WcxyHfmaKFqde1u0Nmuwi5k3d3YG+oQuqG7razQkFqn+Klqz
         L3isQ5dx8vpsyVbMGMSyJXJet7+Rm7H6i4iJTO+P8qbyZ+xU9Fx3QZMmeM4UjDP9ijrH
         aDq8Aq8fi6bp5L9fCrKxgA4vBHEfQGif9Bvl4eUhJk6Px4pMVPVkDECoZu1BpDXBQ3lV
         vaGWoGvAdGzMIZcX4PQRjAebrMmK2mp+Mx5MM+ZvxEqLvpEiD7njp3TwEkjaVfN1a4gk
         6T8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=N4WE/Zg3/azljJ9vk+e7rysEuRey95VTb4WIU/mTR/Y=;
        b=uXERfNOG04Iq8DjiquvvTULnjQjeTCAZlnBf6fmXxsp1eFis2E4O/FwSv7NKXgrIzx
         pEecdsdYuarFtWpcJvnOx1jaHeVGgTh6zXoKttz/Xi98GPDhX4pg+fIXZI/45iojxoh5
         DhlUhr/E7B6WX5HaYd5x3Qn81zQNd8dUfWJYdU/lBWaK4H/pa9i1BxrcBKyeJWP1UzDw
         oCAPGdVZp1X0HvRrZI3+/yxO8tuf150e4NsfumBfaLZNZAOAneS0oMYXIs6pK+BgHrQT
         hFvPAQp/5TYzbyvlgKKIP8kwXRxDgsldCu0gNrMuo5YeFm/Wn+vrP20BrA/+84LoHG5i
         MW/w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=gd5wzH66;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=gd5wzH66;
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
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 29/35] x86/ldt: Reserve address-space range on 32 bit for the LDT
Date: Fri, 16 Mar 2018 20:29:47 +0100
Message-Id: <1521228593-3820-30-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521228593-3820-1-git-send-email-joro@8bytes.org>
References: <1521228593-3820-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595123815233178326?=
X-GMAIL-MSGID: =?utf-8?q?1595123815233178326?=
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
index 0777e18..eb2e97a 100644
--- a/arch/x86/include/asm/pgtable_32_types.h
+++ b/arch/x86/include/asm/pgtable_32_types.h
@@ -48,13 +48,16 @@ extern bool __vmalloc_start_set; /* set once high_memory is set */
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
index 2151ebb..fdefdf0 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -117,6 +117,9 @@ enum address_markers_idx {
 #ifdef CONFIG_HIGHMEM
 	PKMAP_BASE_NR,
 #endif
+#ifdef CONFIG_MODIFY_LDT_SYSCALL
+	LDT_NR,
+#endif
 	CPU_ENTRY_AREA_NR,
 	FIXADDR_START_NR,
 	END_OF_SPACE_NR,
@@ -130,6 +133,9 @@ static struct addr_marker address_markers[] = {
 #ifdef CONFIG_HIGHMEM
 	[PKMAP_BASE_NR]		= { 0UL,		"Persistent kmap() Area" },
 #endif
+#ifdef CONFIG_MODIFY_LDT_SYSCALL
+	[LDT_NR]		= { 0UL,		"LDT remap" },
+#endif
 	[CPU_ENTRY_AREA_NR]	= { 0UL,		"CPU entry area" },
 	[FIXADDR_START_NR]	= { 0UL,		"Fixmap area" },
 	[END_OF_SPACE_NR]	= { -1,			NULL }
@@ -579,6 +585,9 @@ static int __init pt_dump_init(void)
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
