Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx4+X/t4m0m2ejvonwBXV2tVZMpfl5nH0bOWlOVhLm2Si2fSbI0umn2TInUToMCjU9KvcR0jP
ARC-Seal: i=1; a=rsa-sha256; t=1523892351; cv=none;
        d=google.com; s=arc-20160816;
        b=c1dYBlOJMVsh+STDr2vTjhbpgi6WTe4F72nVFcRKqWi8gqP26vGHmAabfsk8nvgXby
         j26x+2PeFzrkGnZLH3j0vfN3cGPdzdJk8CUSUJSEVEM+tbdqhhOXBUiWlZgpDqqoSblI
         XDhnawptmN6v+ohjDbh0Sv2l8W6yFX3wIbqIgqutvAZl8Tnp1fFCP1uege7zblqlDAQH
         aCGZczFBoJqTP6d2JzP3eCyoO5umJNtuWGrN95gRadY2lMsmc3ntRH1FAJpWQNTVtYi3
         IbI9uS4dXJQOvwuCb0YvI0YjkWsrnCUcPOenfH+nQJjTRqPrTSyQgchwVpgCuFU2Xhtn
         IZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=yXjVihLm+2wNjR7+5+HSTgr8auLQO7nLO1HK3zaEXWI=;
        b=PMxM3PIJKJBPlU5wi2XIN/yKgocTujvvBTqcaRkmNZCAz10oeRFEBwMnJxmbkjBTQ2
         1zhhd6inOUDeh+TaIiurCFm/G+qFnD72DTXO+3rvgU7r1U/QlgJhhuC3HGGFo/nF4sdF
         IPR79at5roeXBGq77tZ8zCuZu8Du1XrVA3IoVu/hB0Lsc4IdJm7FMFxOkIm7ECQhhSfA
         0DqyymXdGIJjlB3TjRLDCnLnfO3i2kRspsQiYl5T0TbqOXBgV8vU1S4DJ19SkaCM+t1I
         uOD7JGA4GV+kZBahzLzWBz33LJRTsMMr2e8WCuiQE0sZStrSq6yOPI8+VBCUlUWex1oP
         ZQ7g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=M6BSfBf9;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=M6BSfBf9;
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
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 27/35] x86/mm/dump_pagetables: Define INIT_PGD
Date: Mon, 16 Apr 2018 17:25:15 +0200
Message-Id: <1523892323-14741-28-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523892323-14741-1-git-send-email-joro@8bytes.org>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916945928694888?=
X-GMAIL-MSGID: =?utf-8?q?1597916945928694888?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Define INIT_PGD to point to the correct initial page-table
for 32 and 64 bit and use it where needed. This fixes the
build on 32 bit with CONFIG_PAGE_TABLE_ISOLATION enabled.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/dump_pagetables.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 62a7e9f..84498da 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -110,6 +110,8 @@ static struct addr_marker address_markers[] = {
 	[END_OF_SPACE_NR]	= { -1,			NULL }
 };
 
+#define INIT_PGD	((pgd_t *) &init_top_pgt)
+
 #else /* CONFIG_X86_64 */
 
 enum address_markers_idx {
@@ -138,6 +140,8 @@ static struct addr_marker address_markers[] = {
 	[END_OF_SPACE_NR]	= { -1,			NULL }
 };
 
+#define INIT_PGD	(swapper_pg_dir)
+
 #endif /* !CONFIG_X86_64 */
 
 /* Multipliers for offsets within the PTEs */
@@ -495,11 +499,7 @@ static inline bool is_hypervisor_range(int idx)
 static void ptdump_walk_pgd_level_core(struct seq_file *m, pgd_t *pgd,
 				       bool checkwx, bool dmesg)
 {
-#ifdef CONFIG_X86_64
-	pgd_t *start = (pgd_t *) &init_top_pgt;
-#else
-	pgd_t *start = swapper_pg_dir;
-#endif
+	pgd_t *start = INIT_PGD;
 	pgprotval_t prot, eff;
 	int i;
 	struct pg_state st = {};
@@ -565,7 +565,7 @@ EXPORT_SYMBOL_GPL(ptdump_walk_pgd_level_debugfs);
 static void ptdump_walk_user_pgd_level_checkwx(void)
 {
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
-	pgd_t *pgd = (pgd_t *) &init_top_pgt;
+	pgd_t *pgd = INIT_PGD;
 
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return;
-- 
2.7.4
