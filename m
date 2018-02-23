Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226+Tw+Lh3rraY1vmq4naePOCtiVQFEm+gXsBzrImlEpy3KGjBHTjRIbeHgitpRKrgC2X55w
ARC-Seal: i=1; a=rsa-sha256; t=1519411649; cv=none;
        d=google.com; s=arc-20160816;
        b=bJco8W8Vv7US9Z2FIewJgeWWtf0UUroGsx+AnVz2g5VbYPL5nPyVcj/ITPm5Ksic+y
         HAoEQknhIbhujexUYQRnfb7sZkNXTnYPhIsh6kHzTj7nPs3EqC7o+1XcPHKV8XKjLA+X
         qs8EU+0tyQH4GKEG7w/7h6CBol0w6cqk2bY5LIx+kwPtxL+R9VdZzx6QjHXBvldmnd7q
         ynkt0DPSXUeqLLGROERLHpr4V+JGIvwiT6KsoJGOoX8FUXhMXBfeKe94PLrDitQ2BHkA
         DejuUUPzFbbyZzBheWD7rVpOlvh28Ya+l08dcxuZOkupsPsfEjwJR2tLIxhrmlEM5ddb
         yCeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CbKLOaiyEk3zcBRjFxViK+rutXaS6/Gm6B9wjxn9FdM=;
        b=K5FhM4zn3mmWHmtiCK438by54EaYv3JyzZ0A6UaMjF88paiiaNBpRRuruniW7IltSU
         +wFb6DhLj32RFQKKxwR1LHprBJkkF8mxJrIQoQsyGjwNXseKqIlCFyjXehKnxBs8ahHO
         wUH6TSkudieatz0X5h3bcEGNQLfDMsQSSOsmBP3Hk9Q2SkDY1Mxc/QOInr2nLOL8zCs9
         pv9qMaKilm1HTPh454YvGzKUe9A3ZyMNZfQznVB7PJQtzNJzGR7teUO5I+yHSD1TG2VB
         luzj99gHI2UxQd+JasJzA1KDafkH1jZFa8qQMCCIVGhgQmTUF2/9DYkhMppPjwtWTOxH
         CX9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?= <jeremy.lefaure@lse.epita.fr>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Borislav Petkov <bp@suse.de>,
	Carlos ODonell <carlos@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.9 114/145] x86/vm86: Fix unused variable warning if THP is disabled
Date: Fri, 23 Feb 2018 19:27:00 +0100
Message-Id: <20180223170739.564633626@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218589982964410?=
X-GMAIL-MSGID: =?utf-8?q?1593218589982964410?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

commit 3ba5b5ea7dc3a10ef50819b43a9f8de2705f4eec upstream.

GCC complains about unused variable 'vma' in mark_screen_rdonly() if THP is
disabled:

arch/x86/kernel/vm86_32.c: In function ‘mark_screen_rdonly’:
arch/x86/kernel/vm86_32.c:180:26: warning: unused variable ‘vma’
[-Wunused-variable]
   struct vm_area_struct *vma = find_vma(mm, 0xA0000);

That's silly. pmd_trans_huge() resolves to 0 when THP is disabled, so the
whole block should be eliminated.

Moving the variable declaration outside the if() block shuts GCC up.

Reported-by: Jérémy Lefaure <jeremy.lefaure@lse.epita.fr>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Tested-by: Borislav Petkov <bp@suse.de>
Cc: Carlos O'Donell <carlos@redhat.com>
Link: http://lkml.kernel.org/r/20170213125228.63645-1-kirill.shutemov@linux.intel.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/vm86_32.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -160,11 +160,12 @@ void save_v86_state(struct kernel_vm86_r
 
 static void mark_screen_rdonly(struct mm_struct *mm)
 {
+	struct vm_area_struct *vma;
+	spinlock_t *ptl;
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
-	spinlock_t *ptl;
 	int i;
 
 	down_write(&mm->mmap_sem);
@@ -177,7 +178,7 @@ static void mark_screen_rdonly(struct mm
 	pmd = pmd_offset(pud, 0xA0000);
 
 	if (pmd_trans_huge(*pmd)) {
-		struct vm_area_struct *vma = find_vma(mm, 0xA0000);
+		vma = find_vma(mm, 0xA0000);
 		split_huge_pmd(vma, pmd, 0xA0000);
 	}
 	if (pmd_none_or_clear_bad(pmd))
