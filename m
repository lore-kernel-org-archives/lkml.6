Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+UEZdzbcZit7DO+kJgNfs7ry1Veut8NM8KM1/ys9vfC4u7rvqHktLqLi9mGUgV8fef7PNx
ARC-Seal: i=1; a=rsa-sha256; t=1523981346; cv=none;
        d=google.com; s=arc-20160816;
        b=fhQbRVcwl6mNCpfnXkNvVJpmOAQrH+GsbjG489c0MsBe6XBR8IlJri1t1A4/Ut+f+5
         twheEmTxVcIbafDhUYqUimeZyyUbOiuFtUIMWNeCfU2k00ngiTkC/3R/lXBsD3jq1Glb
         ZfMiKPLUlxKaLKpY2j8wVUbgyIotH+cNQ69ajP17tmtYyMOt/hvVNJMwlbcaQCysjHxq
         ZGYoyB2lpKiDQVF5H53XgIUXhrp1/ll+9BTLyOQXPbgOuBD2xNe4JJ0Ga8A4YZEbukE1
         nBto/8wnwZGhFYaLBVL363puwEkv17pPiNsCAms/fb3qIfgeKR2jSVeKlxdIrgPsDfZn
         ed6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=beb4xM8hnIH6wkwkxgTZ17oRM05hctvHBDVFUkGbl34=;
        b=ZteOEYUmu2VnIHfnYzitG6NCCCGfdYWgwZWMX87jlmciysE5sgogZQgqt5iYk3ijlz
         jJ6xBy7vg2OkQEVBHJgbWPuG8nIbXumgOW61fa6PSOP94MglLqDnm3wWq1XRwpnyYHkL
         RxZVDn9cZN30ChgULtDzidZvHHJ5470ZgGKwt7YJe3kEL9jpyl/hhgCC0DyEpK7gkCgd
         Uj3u7PMA7/4ZVQlsNDvJE/Pa/2sIxNzohYPwpEoD+BdzRA/huT7UKGo2NZHVJBU3cv5c
         rbBzSvty1lt6AfKb0psHRI4wItB0dEwJoYGACdRbDQSQhCGXxH6qaEq9c0ytjVtglAdp
         0XSA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Hettena <dhettena@nvidia.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 30/66] arm64: entry: Apply BP hardening for suspicious interrupts from EL0
Date: Tue, 17 Apr 2018 17:59:03 +0200
Message-Id: <20180417155647.179857158@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010264510882542?=
X-GMAIL-MSGID: =?utf-8?q?1598010264510882542?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Will Deacon <will.deacon@arm.com>

commit 30d88c0e3ace625a92eead9ca0ad94093a8f59fe upstream.

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
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/entry.S |    5 +++++
 arch/arm64/mm/fault.c     |    6 ++++++
 2 files changed, 11 insertions(+)

--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -686,6 +686,11 @@ el0_irq_naked:
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
@@ -590,6 +590,12 @@ asmlinkage void __exception do_mem_abort
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
