Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx4+B0UXn3EKBQEUI1H+IAJAMu8rjitcTYUIuUdmfa8/8bL3RVhyGYjiU0bXRcUG8sdQkBjdf
ARC-Seal: i=1; a=rsa-sha256; t=1523892349; cv=none;
        d=google.com; s=arc-20160816;
        b=HJNHOTYP27RFCPUufMtG64+neZxa87Oh/u5fB0y1cn3ZEfrjyF1ONPq1D4Q+m3Co5s
         iNWRVh+JK0r8GXMAY4IgiSjV9iZGBVfQ1yd7LVMfjGUHKM8g+VK3dUm5JE1BM4728EMh
         HTrYmehvFJo9IkRJT9cHUVCjv/rAhcyG10voYcpbCOxEFbrLbQHZwRqFZmEVylL1Rn02
         HDQTAJTlOyoQO2oDr3dXCJbyrSo7b6jlLKSGM053P8oVurPF74+QqeX2LLu2/f1eog0m
         z8rYNUHaYWMCbnY7337QhhyT7GRkgX8oQ1XOOIr1u+fgvsQ+kCiY25YtHptwvs0T9eiA
         AuKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=02ZYST3vL3TajOm1Vb8AN5LojMZtoSkZRi5vbIS2byQ=;
        b=B46wUFMRvzvnKOn0Il1fhcKKHtx0NG0tcTtgFAEYT0RvrJA0JOC+WOEy2R7Vxp0pbz
         xFBbaxrqz1SlOp/BNsmYJlauAdIgjrjupsDgPEELYrUG0rO6Gb+AFnVLnIhyv0/NfL6d
         jrI2CC55DXvrfRuSGw8kli+J5MAIug+VpbV14ZeoNRHnEZ/8IauFRXXa2Q7N1cqamK5v
         GnHaM+GEIupxuTJANqn0ElQO2I9XNO3Ue49U2aRRMuhEUEvi1xLgV89gPc949DorBOMk
         dnh5k5FHDNqfawmUni4/1jZ3qWqyhBDPMVhaal1+pLaLNlN2Ge3yN7+1LRWC3XB84EVE
         uRuw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=kL+pVzQM;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=kL+pVzQM;
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
Subject: [PATCH 24/35] x86/mm/pti: Add an overflow check to pti_clone_pmds()
Date: Mon, 16 Apr 2018 17:25:12 +0200
Message-Id: <1523892323-14741-25-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523892323-14741-1-git-send-email-joro@8bytes.org>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916943877679358?=
X-GMAIL-MSGID: =?utf-8?q?1597916943877679358?=
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
