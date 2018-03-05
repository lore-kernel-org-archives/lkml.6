Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELst5Lm944/qSRBsx//DtYfLLQmv8uhjGUx6+6DczQo7WYlnkhcFSEiYDBdAKuN7S12gE50K
ARC-Seal: i=1; a=rsa-sha256; t=1520245580; cv=none;
        d=google.com; s=arc-20160816;
        b=wgpQ3lNjnaTmim7Fkq6L19IMV0OTZuBsqRhBGKXekjZh9GIhgrRr1VGsYp0tZ63vsg
         JKA/BH6ETtYv4Bkpf9hL1KGwJYnIlKlxn+DBpiYjJ9CLhAK77ZQi2lgQVRkCppmYE8LT
         DIlcmeAwvjHWC5l7Kwfnfb7JNTiflL/8YNfuRXNs4B3MbINa+LsWORI0+RLAgDFK0NeY
         KP4qlby5JDW3YZw11X9ibKnD2jtuXC+OlfwuGRLuHBLxglib7pbxbqoyxDo+XKDRa54W
         gOPuMzdVcvxjKd079ZW5FN5Qvnw4YYdW3udbYQ0C0oD/vpeuYimJqfy06Kh1lSlsSZvM
         ZAjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=S/IFyE5s2WbwnTT/5msmNTwuegueAW0gy7hAJnfhu+M=;
        b=tSNorwTh0LmJQJoGH3jZjlQ1MrDRWS+4gJYak7wycxjFPCd1tij74IwzqZOepYAGcB
         KEraA4aoVXMRQpVYma2VKoS7u6jAjOxfPkgBwIXcbXvZ2OhksRThOilCAEvvnBtwyFZL
         gOsEsAtLg5gq3ETe1o8tcRYprYjn4+XfZ8XvdmmEqNXLmF3ldrjxKaKv06lV1BpMtijB
         4StIMqeQu+YzFNc54iZjgoDkpmSlZy+7DGUJN4D3U3j+sLYFU7nB3Z9GV9ndbhBmUOWP
         Z0NitvAUrE2fX30i37cURVUVGGsP6MkUdgAKCASAe1bZtne2rHx1JCfUDgwUZetn1zQE
         5uPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=liyGHI0Q;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=liyGHI0Q;
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
Subject: [PATCH 24/34] x86/mm/pti: Add an overflow check to pti_clone_pmds()
Date: Mon,  5 Mar 2018 11:25:53 +0100
Message-Id: <1520245563-8444-25-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520245563-8444-1-git-send-email-joro@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093029707975372?=
X-GMAIL-MSGID: =?utf-8?q?1594093029707975372?=
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
