Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx494g0IHAGmCt2hmc9u6aKb20pI2TwsZhi8BRmjVcitiiHjoxwcPuxnE6OU5/H6UeDzteCrC
ARC-Seal: i=1; a=rsa-sha256; t=1524498479; cv=none;
        d=google.com; s=arc-20160816;
        b=0YTUCnXSsiJi0lJty3CxAVDC5RC54r3DwrAjgo0KmcaP8fny8BgXzikYsgCf9DMmEd
         FTAFX3n4DqqTESQycTVbJXteBNWE6uXgG9dgpZUl/zzhJWwZFdihGlUy3XFQgx7TID2K
         KZtf1G/bHhgn/ZU3P95PIxJY6iGYjGRp6dvM2aLkH5BObt5kXhLSDPQceajVzthlaIFr
         hVcGA/ZUazoBP0JiNf2qL0YkKgBLBeCHJ0s46PDwGw7ipTfY4doO2uVcGRlrblk3MH5y
         s8N/ssCPkApPxo84jfvzjlQXqDWYSEKR95rqR80Rk5ApmUihRwdNqhX3JUyMYayr9nXb
         NfMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=02ZYST3vL3TajOm1Vb8AN5LojMZtoSkZRi5vbIS2byQ=;
        b=hHydHqHxCjUdIAvvLHsiLz62WswIG1PFFyU0p1Lq0/uXh8usrHXjwEQJvNnR5k0y/i
         /cQibbK+W+RKh6BG0Ri8iueooQqROcA//opCa4zixoxpd2Hf2K88UzFNuYopeGqngp8M
         F+7Ew7UOLhkhrhJPII87/WyOsmIzBQ64ijkdD+LOvcLgk4fTWhtWBFEYoXD9LiN8VzMt
         s6R7jUZOh3CHSESNNp6q2Jvrpnu0cwMDmpDuChb5p2SPzgyM7nOJOp7UG/3rGxfgmK0Y
         d/AlO+wBIpjLIQdQTyrOGSohPIjUnF0/sMWSiHukL9cpHma0atPSPQVF86dsR0GfWJAp
         P60g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=Q911HJj8;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=Q911HJj8;
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
Subject: [PATCH 24/37] x86/mm/pti: Add an overflow check to pti_clone_pmds()
Date: Mon, 23 Apr 2018 17:47:27 +0200
Message-Id: <1524498460-25530-25-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552516749924845?=
X-GMAIL-MSGID: =?utf-8?q?1598552516749924845?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

The addr counter will overflow if we clone the last PMD of
the address space, resulting in an endless loop.

Check for that and bail out of the loop when it happens.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/pti.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 9bea9c3..f967b51 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -297,6 +297,10 @@ pti_clone_pmds(unsigned long start, unsigned long end, pmdval_t clear)
 		p4d_t *p4d;
 		pud_t *pud;
 
+		/* Overflow check */
+		if (addr < start)
+			break;
+
 		pgd = pgd_offset_k(addr);
 		if (WARN_ON(pgd_none(*pgd)))
 			return;
-- 
2.7.4
