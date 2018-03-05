Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELtSNG/8rLs+t1dtzXjxGVr2aH2TBlZgck0nVGXKNy90nKm3xLhlNlx4jPfvw2OpsSt8Wl66
ARC-Seal: i=1; a=rsa-sha256; t=1520245582; cv=none;
        d=google.com; s=arc-20160816;
        b=FbSOqDJr0eiy0lWWHTDctU9GteU4XbGbMkFRCsjGyHdJ9/9cwc1qF7t7xaazpoyuXi
         4INPBzcIk6DzXFU70QtRyTJV8IzbvDsJBmbz6SZX9v2DOC6JwxF1BgZASPaM00tJtCgZ
         PvPJFqIBE0SHy+lcfxedNvVswc6C3VtfNRmrMf5DbpCsLUQvsKB0Tty34YASRttSiBo9
         AORvUKWJuD/rT9+orlDrZnkfiFhUfxp7Z/wGnVwjm5cqz8wEXh/I7Wpn91KNgrDkIoY8
         BX+gtnberOrV9x6ASUVX9WHF4ET+YRrKCvEq0odfDhiSUmoASY8rBCTFZtVb53P6ub6/
         xY0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=N4WE/Zg3/azljJ9vk+e7rysEuRey95VTb4WIU/mTR/Y=;
        b=CQ4sGYQDpTH+Uzbgycus4bpPML2SglQlOzmXOtzG/ElG19/IV8tw/D7dzFI9F8VFow
         Kn/OzD2r3u8FmAPhMf2UyiPJVMHkTNDEbeny7FQ8a7iQn2qj7tYnMQIW5DovvtjBOJ2K
         fMIJQmFjOvRvTOTbVOqXo214MCNgEsVDMA6bCfexcbM9HwLJliGlfb94Jj3FvTuMFde6
         DJFx7oYXuVB3jeY3VLEjsEPg3EbbM0Niz+u4bTU17diPVCkt+zkdSwZ3boLksJWZp3x7
         twSi1eZZBBRvNU2i9pC7PIwVHwGjJ3hP99Fl6cqGaOgK++EK/61uaqJhj6V+DetF2cf2
         Kx+g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=gYuZ9HXp;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=gYuZ9HXp;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
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
Subject: [PATCH 29/34] x86/ldt: Reserve address-space range on 32 bit for the LDT
Date: Mon,  5 Mar 2018 11:25:58 +0100
Message-Id: <1520245563-8444-30-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520245563-8444-1-git-send-email-joro@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093032801102636?=
X-GMAIL-MSGID: =?utf-8?q?1594093032801102636?=
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
