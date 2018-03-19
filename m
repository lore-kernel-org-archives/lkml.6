Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsO1B+iuFkRAUq3ue1j5fEu/lSelgCQhctzTFsOz2qm9Xw84zO6pCQkneB9EirKIwZ7jYeg
ARC-Seal: i=1; a=rsa-sha256; t=1521484197; cv=none;
        d=google.com; s=arc-20160816;
        b=ecM6PXj1zKq7BbSkLEPAb+jfluA6Zwia6Gmcw/PhID6yj0AMJ0HPV6HlZUZhKBnQ5Y
         UZOKflPuK1Z7jH8ACi3WbbdczAsmAt4IPGs6axGsDspEutkAmYrsfNm8q9A/rqI385Pe
         +LKlzA5yKvJKnRBtOuXH9Vx4B+lTMKZahLazvjDEbRD1rV2wkA0bmzJGlEI7qKPc9gNf
         qaskc0KwsUtXZNYo4kcoKbnemTaZXD2QGh6yClojcw3wikE6faPLSBCZuT0WR9BqGfWC
         5FDLr2oWMCVsS8g8y/MYiESQ8iV/Oq6xDpfbmpa21tMAx9Mr3Z1pyqPFKpG7UKzwAQ88
         QHaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=q5vZMFkrhCLhW74fiNP8KcOf9GE/tbD6xMXspRUA9t8=;
        b=sv1+S2kIsan/S0gXY3C2zjZ1k+BuzAj6C+J3Y9cugtYx4TKVn+sJD1Vqubn9RZNG/3
         asFl+mS57aCCjhYuI+GDCmV/jay51tugDBZwJq9fcA2OLdCOsnivwRjJ74FQVMGmCjFe
         DYGKW4oc1MxyUGuzcYr29MmJQvuDLWGtQ/aGr3zwjeM6wXmiA5D7lEKdN5dwaJNclExF
         n/7KRE/zm10IdWPdUY18r+aYs78phl2wLGA3OYVvbrheXg6IzmN3kDMxjS1PupuS684w
         GWhgk8V+e5DLbtWpnrYkf8WRrndJczexp8qdGDz3ybFsoUMbnSMEBVYHUYnXn1VcdXBX
         Z1hQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stas Sergeev <stsp@list.ru>,
	Bart Oldeman <bartoldeman@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 07/41] x86/vm86/32: Fix POPF emulation
Date: Mon, 19 Mar 2018 19:08:07 +0100
Message-Id: <20180319180732.701007027@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391058826275806?=
X-GMAIL-MSGID: =?utf-8?q?1595391814038416523?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit b5069782453459f6ec1fdeb495d9901a4545fcb5 upstream.

POPF would trap if VIP was set regardless of whether IF was set.  Fix it.

Suggested-by: Stas Sergeev <stsp@list.ru>
Reported-by: Bart Oldeman <bartoldeman@gmail.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Fixes: 5ed92a8ab71f ("x86/vm86: Use the normal pt_regs area for vm86")
Link: http://lkml.kernel.org/r/ce95f40556e7b2178b6bc06ee9557827ff94bd28.1521003603.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/vm86_32.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -727,7 +727,8 @@ void handle_vm86_fault(struct kernel_vm8
 	return;
 
 check_vip:
-	if (VEFLAGS & X86_EFLAGS_VIP) {
+	if ((VEFLAGS & (X86_EFLAGS_VIP | X86_EFLAGS_VIF)) ==
+	    (X86_EFLAGS_VIP | X86_EFLAGS_VIF)) {
 		save_v86_state(regs, VM86_STI);
 		return;
 	}
