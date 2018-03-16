Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELv9HGku4Ep7Qd0QtHPGqF9DiZqwYsuaP7C4pmUmItTwoMy57Ng+xzL2SIJQewUvonZ+6Q3c
ARC-Seal: i=1; a=rsa-sha256; t=1521228611; cv=none;
        d=google.com; s=arc-20160816;
        b=Cx4n6yCxtL8q/99HBvKjhD7DjVslTuJMWj2kBNP+zjyQaz7o/OX71idjbOMxT+BWh2
         kcrg8s9C2VlbDDJzYzwQsfHSXNmmtulVqlC933R430eBrUTD3lIEzslZY/hyjO4Za94h
         vMjyE0bvkYSjbGWCfXvgVhvsMGSfqob8OR7f/2OKvk7qJgQ3ETcbz+3I01V/FBegyZRy
         dGnXtrKyl+d7ci2d8HZxf+NRTPj2+ns02rUcrbR2HHlcRiR3x6iWfxLRy6qW+lkXp47Q
         JTiNj/jeG9ys7yNEnoI48A133IkOInTJyVVLcwkDdoVPVGHbLiQ2YavAtxpY7f9FJdO3
         Rj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=S/IFyE5s2WbwnTT/5msmNTwuegueAW0gy7hAJnfhu+M=;
        b=R0/zQJSvg+X28SZf6xV+nViUqhuuImiNdwzisuOo4RvA0wR+vYG2MvKYArd6gMxDXh
         LoQife10UI5q/NHCe3Br5JUJxX56H+dLpnzwF3/18a5uR0UxuM+AWSb+jzl5u6p2IUCK
         lX53hJd5eSdrmTZjQMzqvGtoRfx1SeOAvTO4MsdLso0X09iK02dRaHAez/t8sY8BOb/w
         bn8+HHnPtncG18IVvgXBXITA+gASmdx1AGnwQMHdc5ec+qMl++F3tGsQQxAv3c8g8Ye1
         aGj1VS361Ad9Wyup3+lJ2Kzj8xCziZrF9dEgotT0SMg82Xmo3dSqQl6zI+HG+A096y1t
         I6kw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=hF+xr0Gp;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=hF+xr0Gp;
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
Subject: [PATCH 24/35] x86/mm/pti: Add an overflow check to pti_clone_pmds()
Date: Fri, 16 Mar 2018 20:29:42 +0100
Message-Id: <1521228593-3820-25-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521228593-3820-1-git-send-email-joro@8bytes.org>
References: <1521228593-3820-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595123813092757960?=
X-GMAIL-MSGID: =?utf-8?q?1595123813092757960?=
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
index 8f53d21..96a690e 100644
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
