Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AH8x224NOhspz+/XQ13qvtlLjdNV+99VtPXAlQDf/yq/LV31B6pqnTa4TnDzZbVu09jZhEbqF+n0
ARC-Seal: i=1; a=rsa-sha256; t=1518168363; cv=none;
        d=google.com; s=arc-20160816;
        b=boQFPmwlFoIadnVpK5nLe2+c6xS+OS0Zh5pZlAzYQqvBJdilPLM+SQOecDzf+2euZH
         ZfbI1LLaN+Zc5bQGzvnS3/l2lK3dyZOpCyRZ53WeacISN5gmrsoEICOqBtl8kMWbVVlQ
         tVSGj1VoUmXNsvS5uUHHSQIAifbWLaAfIaZHX29N8Fq1261CLDbj90rqrCo6xRG/ufOS
         KdG8+f8FVuml1SXIW7z463EpqBdvGC4jssYM68WnIej4a4ah8rEmiE29zs8SNMZLt8FD
         NdiYxGsoKdTzDXE+hMOIPhQ0be94oh5jJXuM9AF4SVGV2dsboq2e3uzMzx6pjcDtTgBc
         ObLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=kqT+xs1h0YBF59TsgWukt4ky2noFJrr8eyw6YG++EPc=;
        b=qAYLYFVahk0KQ9qapHAjGtopWgGMsj5ViNdEAZBYxPbuXGK7xXkkkN9nHoBu9WGMJ7
         NqLh1qJ6I5a8iYpb2fe6PpQVrDNjVfx0Dgbq8f7yxhXjC27f1DQqqdGwwlHtWMKOobDL
         TQ5I6n/VJ9X93oi8EXSJ0doViwZnKryaGKOvCaNFfJF5T6TPNfym+89ukpHr1cWem7WF
         DNk8x1s+Azt6ZBYU0ClkpxG90/uocXIP1xLm3d0vqZOvNUe6hq90C8Dw+sIWROthQ7yr
         DU7F3aIddqMIBVahHLubErnkz3nAESZRz04XXbuy+vkbjMnxDSASs8fVaNv2CdEC9dRC
         8bXw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=BoazetOs;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=BoazetOs;
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
Subject: [PATCH 22/31] x86/mm/pti: Add an overflow check to pti_clone_pmds()
Date: Fri,  9 Feb 2018 10:25:31 +0100
Message-Id: <1518168340-9392-23-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518168340-9392-1-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914910084902847?=
X-GMAIL-MSGID: =?utf-8?q?1591914910084902847?=
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
index ce38f16..7f5e698 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -282,6 +282,10 @@ pti_clone_pmds(unsigned long start, unsigned long end, pmdval_t clear)
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
