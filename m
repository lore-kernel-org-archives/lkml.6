Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49DL4wSodATDFruYvdERYtf+62N2EAbEdMnJ30Th2wERa2zO11SA5WzqtJQifpVYOiyts2S
ARC-Seal: i=1; a=rsa-sha256; t=1523021864; cv=none;
        d=google.com; s=arc-20160816;
        b=KrUE81TJSaHxnZnKQ8OVnghO9Xu3Ja7XyISjJVOJnPbbtmf7NbAEBKOKMaPCPZgX9W
         OkrVkTTd/ZP5oMWiBXu5WFWArc6z79SvPprf4/a8SZWZiEe1E1DQLMzUTyNclycH1PuD
         gXqD8TcSHmw9tyWwEvWgEh7wyuNkUloAIuBBnV6P/OvWAHbnAu/WaPxEQDzIeeqUq5IH
         mx0UpEURu2mf9E6xVQVvWV9MhWle9HLaNbqD1Jt6fBJLXkWZQBVzE7PZ/ZGDNdXlTM6d
         V/Exeymi5jekZWEZmeZgAI1FIFGMsq7ULgV7MgdWbCbVbhoSv+9YaTRKdIDFaH2orUW2
         nRyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9H9t5L3ri4/7gAEyVpyz01qYJc3r25dI0Sd1bKCM0cs=;
        b=FOgdD2jqfqX4P7ATeEBIvDOcw1VZqHzQL9/f1GsOxkGugt8/8wfCCNRntIL0WLCQHQ
         y/47gu6cc3EVc0i0vNU727TEaC+GcH37YN9TUC641i9VEbiu9kiKtp93dXSpUuxdMf49
         fhfm5ckv+Atc2XNQ5VmOLoFpGsJllpUOa810mXrsh3qyrElW46KGJM9CCY9bocDbFmu7
         DNx8oNheVsFcZRZnLyoZLW9oCnTaa9l8HaAGkioXFvTuzKtgNx0CpcXsMb5YjWob221Z
         eohubrwgc1B/4rWedM9gQwmzqSyTXRfPaXY5leiYlF/wggGmKow1gKRIUO+skkWtaZgB
         KgAg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Carol L. Soto" <clsoto@us.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 15/67] powerpc/64s: Fix lost pending interrupt due to race causing lost update to irq_happened
Date: Fri,  6 Apr 2018 15:23:45 +0200
Message-Id: <20180406084343.313423886@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003938140949663?=
X-GMAIL-MSGID: =?utf-8?q?1597004175054700415?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit ff6781fd1bb404d8a551c02c35c70cec1da17ff1 upstream.

force_external_irq_replay() can be called in the do_IRQ path with
interrupts hard enabled and soft disabled if may_hard_irq_enable() set
MSR[EE]=1. It updates local_paca->irq_happened with a load, modify,
store sequence. If a maskable interrupt hits during this sequence, it
will go to the masked handler to be marked pending in irq_happened.
This update will be lost when the interrupt returns and the store
instruction executes. This can result in unpredictable latencies,
timeouts, lockups, etc.

Fix this by ensuring hard interrupts are disabled before modifying
irq_happened.

This could cause any maskable asynchronous interrupt to get lost, but
it was noticed on P9 SMP system doing RDMA NVMe target over 100GbE,
so very high external interrupt rate and high IPI rate. The hang was
bisected down to enabling doorbell interrupts for IPIs. These provided
an interrupt type that could run at high rates in the do_IRQ path,
stressing the race.

Fixes: 1d607bb3bd60 ("powerpc/irq: Add mechanism to force a replay of interrupts")
Cc: stable@vger.kernel.org # v4.8+
Reported-by: Carol L. Soto <clsoto@us.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/irq.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -430,6 +430,14 @@ void force_external_irq_replay(void)
 	 */
 	WARN_ON(!arch_irqs_disabled());
 
+	/*
+	 * Interrupts must always be hard disabled before irq_happened is
+	 * modified (to prevent lost update in case of interrupt between
+	 * load and store).
+	 */
+	__hard_irq_disable();
+	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;
+
 	/* Indicate in the PACA that we have an interrupt to replay */
 	local_paca->irq_happened |= PACA_IRQ_EE;
 }
