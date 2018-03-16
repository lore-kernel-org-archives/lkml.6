Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELuLVXjdxE3lsK8jpHnOHDRg1vMbcSk1J6thsxtuce6mShVKnUia4yhnwf5D62ZvBL7u/oZ6
ARC-Seal: i=1; a=rsa-sha256; t=1521228609; cv=none;
        d=google.com; s=arc-20160816;
        b=rP+ptTRyE979hTVgATdIoLNR9eMQA0Im3tHHZBvWFbGDtgBD5z0tUSfAFFbZ0ZoKMY
         KuKoyW2VNiyCuuTjL8sTa5C/uZN2BebtMLCHV45kzBE0Jm63mCMOlSzlBllwNjzPzQ5l
         XJI9Z+Asi+jrYJgnSHg/1HeFqGGgVSVOwaQgzau+VFbgpUnlID+2ljJ3IOIv1I9W5uOV
         bG38njEc3fBemwJx85Q/IPX4Ab1O2mC/YERC9+D8yi08mp/LKHKaRyeBjNxpbW/lwQdy
         XWOi8Y8H4mocXmFDwzOYsmBQdlCJwjZ8KR8xSA0K43u2lWRahsrmw6pHddeOqPr0LaWl
         1MaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=TBtohe2X5SHsmPjdTDHZdNzRuX9gI4sKHKxpvfjShHc=;
        b=VXXYe1dvvV8cHauGieHRiFZQCK+ZY0XbfEsK+pfFpEjx1VZvAVekRxLBBTJpWzV2b2
         UYLKaIY//lGVkBCWMzTZ1i7710ELV1Ie5cpVS07BZsI/E3eBSHCoac6oqo13oPCkDc7F
         oiacryHZth/VGHvmFA368VlGLPcCiJiq/ERWeY/BV5saiuGvuZEZybAN0DWLq7g0BS7e
         6nvX1GSt4v1yYvhZPii1P5JFOYxVfr10WJfYq55YpCy9ZAuCkGjoPOaVPd0D/6kgB9WN
         SqphA+OSd0xvu5syP9/LXoiTWuYfGeQ92zjy+xN+579ZdKY7TeguS/A8+BKN6w2VO2lv
         cMuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=V0klQ7HM;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=V0klQ7HM;
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
Subject: [PATCH 27/35] x86/mm/dump_pagetables: Define INIT_PGD
Date: Fri, 16 Mar 2018 20:29:45 +0100
Message-Id: <1521228593-3820-28-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521228593-3820-1-git-send-email-joro@8bytes.org>
References: <1521228593-3820-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595123810895760732?=
X-GMAIL-MSGID: =?utf-8?q?1595123810895760732?=
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
index 2a4849e..2151ebb 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -105,6 +105,8 @@ static struct addr_marker address_markers[] = {
 	[END_OF_SPACE_NR]	= { -1,			NULL }
 };
 
+#define INIT_PGD	((pgd_t *) &init_top_pgt)
+
 #else /* CONFIG_X86_64 */
 
 enum address_markers_idx {
@@ -133,6 +135,8 @@ static struct addr_marker address_markers[] = {
 	[END_OF_SPACE_NR]	= { -1,			NULL }
 };
 
+#define INIT_PGD	(swapper_pg_dir)
+
 #endif /* !CONFIG_X86_64 */
 
 /* Multipliers for offsets within the PTEs */
@@ -478,11 +482,7 @@ static inline bool is_hypervisor_range(int idx)
 static void ptdump_walk_pgd_level_core(struct seq_file *m, pgd_t *pgd,
 				       bool checkwx, bool dmesg)
 {
-#ifdef CONFIG_X86_64
-	pgd_t *start = (pgd_t *) &init_top_pgt;
-#else
-	pgd_t *start = swapper_pg_dir;
-#endif
+	pgd_t *start = INIT_PGD;
 	pgprotval_t prot;
 	int i;
 	struct pg_state st = {};
@@ -543,7 +543,7 @@ EXPORT_SYMBOL_GPL(ptdump_walk_pgd_level_debugfs);
 static void ptdump_walk_user_pgd_level_checkwx(void)
 {
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
-	pgd_t *pgd = (pgd_t *) &init_top_pgt;
+	pgd_t *pgd = INIT_PGD;
 
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return;
-- 
2.7.4
