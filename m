Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2265U8zZykc10mOeSn4oDBsbpqTZZZ2x0xznvUuzb/yx5ZMkDyDAyNUr+mGcJv2dVWeYC4bv
ARC-Seal: i=1; a=rsa-sha256; t=1518708771; cv=none;
        d=google.com; s=arc-20160816;
        b=bWn4xMkNqoVL/R1/LkEgxDIy132J4C9IB10PVuKVcIjFsdnJ5rpTiG8s4Gi1k2H9tg
         n/jZbgKp/1gXrM34dfAOoMY1dH6FC4FKSWo3cJASdVp0tGjJnoz/742PQtZaJv+weYFQ
         TjPKR5eCP+sl9/vCIZZ1LtVqHsEwYiiXQVIC25nSko5nUPckKOrS8UFkBzrEBu7X48LJ
         zIHuDJMGle3ikYlciUQ3lXxBA2hQf6LlezjvqOOnMnfVln4svXJm6Cua3pwInDqs2d+c
         0O1+Aygc6vnL3PcSwzwEUX05896jnSsupmqV1w1xmXgIXkDU1aG45ULi9z8yM4QjfXtK
         NCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+fm0dQdB5EhReBNDdrUCHiMKjd2C4m+l5zPvxCtfc2U=;
        b=fKm9sq0a9psDk05cTlPQnax3H3x66++nJNXSgXVIiYsXfLGE/LvtuLjjNMloPi/HpX
         0CgnIv0vnV1DFyJWxo6VdpoirUbE5A8vZt7jvRdoIr7ADpY7toZQxga3aPNSaL1z7j7L
         EwnzK9DS3hI6jbOihevKCfKuQIYdibGa7AOpu/Z1vD8L7Y+phMyJA3mcphuXOakWuB36
         kGF4XYSV8jnoGbuxR2xF/RkZaJ1GDRntM9Z/w6YsHPr8NmugClabFQUYnPmDpb4vVT83
         tr6Vcf1EsvwqZAidHHnICMd5l6vzSQyb1YrZM3/aF8NHBmpQcOdYB+xaZs7q5iR04D0H
         hDSA==
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 074/195] [Variant 2/Spectre-v2] arm64: entry: Apply BP hardening for suspicious interrupts from EL0
Date: Thu, 15 Feb 2018 16:16:05 +0100
Message-Id: <20180215151709.395680184@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481568334464792?=
X-GMAIL-MSGID: =?utf-8?q?1592481568334464792?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/entry.S |    5 +++++
 arch/arm64/mm/fault.c     |    6 ++++++
 2 files changed, 11 insertions(+)

--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -821,6 +821,11 @@ el0_irq_naked:
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
@@ -751,6 +751,12 @@ asmlinkage void __exception do_mem_abort
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
