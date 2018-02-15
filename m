Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227w+sBwm3D9yT4QBe8NVexPeIN781fsRcR2v7dhN/hM9MNfIDoWhf44AjyQaoOtam+bwqvW
ARC-Seal: i=1; a=rsa-sha256; t=1518709297; cv=none;
        d=google.com; s=arc-20160816;
        b=zg0R3qo0knfKbeS7jwBwqiie4H08AvLY77FuvFrcf3D3e7mLb5HXWNsNxlsPt00tqv
         9/WtTllDxgkpSF2YkiTjSa3QYPD79QvTks9ptawKz7bvk+oygO05jBpSICFGgg77d2ym
         9qbSf0O8eoiiV+qrrotdacGqmQUN95uPBhSNesB8rfSzIMu58+ko7hbjEh+UqV9VEE5P
         77/yl6zFuRXR2lO9SFWrkdjtoVR/wMk5Vy/7BIni5OxGHyc/DZf6bWjGk6TnyLDtZPCt
         eBo+d4NxNo6Q5DA+RE/fwseEHhCQxRh+MCi26GiAuLELiTKwvRNspnaiSQ6YrJwV1dN3
         zFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XBlDDc/VHMoOUiO92bYLatONXnoNgzLm5aZCq0XH6Wg=;
        b=m40+BALFZchVPxRYSioEHotu35EiBEF66IWycqvENOgWshYY/VhMrV4w3O1EmFK7Sz
         KNXgfZsEq2iyQF8p2ImFh8T6mjR5Oj+zS/ttj1Ngb9oJYHgwadgj3wxdvdEBREC7BO07
         0RKQabVd8JK7HThACOfMpb+I+UDonfcBWUUnuvgDYameqlZthPM9plUFDLvsyJDXOfVH
         DoYtY2BAKkg/GlC1E6oOSzjkWH0jEcVboax4s9rMigQxYPPgkoLB7E1x+8vAI4WtBFyF
         sXLCtaGVfYxNnnvHx3OAgUsoJ8XxyAUmonXqs7BKbt3VAfCNG6poqMICbx2jY7tJdcmL
         AX6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Hettena <dhettena@nvidia.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 067/202] [Variant 2/Spectre-v2] arm64: entry: Apply BP hardening for suspicious interrupts from EL0
Date: Thu, 15 Feb 2018 16:16:07 +0100
Message-Id: <20180215151716.998604993@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481568334464792?=
X-GMAIL-MSGID: =?utf-8?q?1592482120153057154?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 30d88c0e3ace upstream.

It is possible to take an IRQ from EL0 following a branch to a kernel
address in such a way that the IRQ is prioritised over the instruction
abort. Whilst an attacker would need to get the stars to align here,
it might be sufficient with enough calibration so perform BP hardening
in the rare case that we see a kernel address in the ELR when handling
an IRQ from EL0.

Reported-by: Dan Hettena <dhettena@nvidia.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/entry.S |    5 +++++
 arch/arm64/mm/fault.c     |    6 ++++++
 2 files changed, 11 insertions(+)

--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -828,6 +828,11 @@ el0_irq_naked:
 #endif
 
 	ct_user_exit
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+	tbz	x22, #55, 1f
+	bl	do_el0_irq_bp_hardening
+1:
+#endif
 	irq_handler
 
 #ifdef CONFIG_TRACE_IRQFLAGS
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -707,6 +707,12 @@ asmlinkage void __exception do_mem_abort
 	arm64_notify_die("", regs, &info, esr);
 }
 
+asmlinkage void __exception do_el0_irq_bp_hardening(void)
+{
+	/* PC has already been checked in entry.S */
+	arm64_apply_bp_hardening();
+}
+
 asmlinkage void __exception do_el0_ia_bp_hardening(unsigned long addr,
 						   unsigned int esr,
 						   struct pt_regs *regs)
