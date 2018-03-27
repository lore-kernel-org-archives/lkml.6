Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48OE3dpig+h/dvitOF7x38SQ7B1mqqVdAcF5w/j+IDpfoSEzQrbM6p/lI3y1jM5wf3TWIwO
ARC-Seal: i=1; a=rsa-sha256; t=1522168935; cv=none;
        d=google.com; s=arc-20160816;
        b=CoNZQogHwOOciXwnHkTuyqHeQf9eri20EJ4z54urQvgc1CDBlqmeKr8+2YmdC9ZSCF
         qSVDEuoNb6ZdgmJIX19R661tuu12nqn9Hy8uy9IXxrJJuwI/D8lc6tsg+ZtVfZ5cr9fU
         ECarHp4VJCLyoxTjeHgr4U7sNtBxRgUyLgnYOL4Z26dYPrnioYH3iYvhJR7cWV7rUFBz
         h60zThbu1Dp6TwdEBM8PCjK4sHZjZw58b2xQNUoYCUgJ48KNlTdm3Bk3oFMhbJ7J8nQY
         BMT7Ky74jno8bLy54x42mL3Qb0vSgUIkdwGWQ4DTUvqnEluoj1U81d8bxRhaXL89NpdO
         ewmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=W+fbh/7ptG5k5yhulGgrerAbASMPxrSHMOi/+6snrPA=;
        b=uGmP0agy8+Apt0LcCSZF69+ooS2LPzVu5I6bNqxhajbemzcj/cgcKe4kxSIVw2pLYd
         3CwlvndZB0yvZIwT97wm3I2lJ8ewPi1SlmRX8CF2ofk1iL3JDiWH0PUGnm1cnknly3fm
         7YupOKL0332Jw4sBdbYWoGVht8unO26XSaSlS7yAkiOzmLQNlCUoyYRmXDBelOAONa+o
         jaBrMUBTfxFVmhhIqEJriTuPzj9c4O+958vm0Ek+7+zHoLAK+l6bHC3neO7gNq6VDoqF
         oOXCRBR29hHd6azQFMdsGdbyKweVIOhOtcNT8HWAti9lRm3GLhnzrgV3eDZ0Bz3WUCTo
         CiOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 085/105] x86/vsyscall/64: Use proper accessor to update P4D entry
Date: Tue, 27 Mar 2018 18:28:05 +0200
Message-Id: <20180327162803.479879950@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109505147946951?=
X-GMAIL-MSGID: =?utf-8?q?1596109813580997134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Ostrovsky <boris.ostrovsky@oracle.com>

commit 31ad7f8e7dc94d3b85ccf9b6141ce6dfd35a1781 upstream.

Writing to it directly does not work for Xen PV guests.

Fixes: 49275fef986a ("x86/vsyscall/64: Explicitly set _PAGE_USER in the pagetable hierarchy")
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180319143154.3742-1-boris.ostrovsky@oracle.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/vsyscall/vsyscall_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -355,7 +355,7 @@ void __init set_vsyscall_pgtable_user_bi
 	set_pgd(pgd, __pgd(pgd_val(*pgd) | _PAGE_USER));
 	p4d = p4d_offset(pgd, VSYSCALL_ADDR);
 #if CONFIG_PGTABLE_LEVELS >= 5
-	p4d->p4d |= _PAGE_USER;
+	set_p4d(p4d, __p4d(p4d_val(*p4d) | _PAGE_USER));
 #endif
 	pud = pud_offset(p4d, VSYSCALL_ADDR);
 	set_pud(pud, __pud(pud_val(*pud) | _PAGE_USER));
