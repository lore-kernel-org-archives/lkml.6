Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+MLcwCl0Q8Qe659/ywVUIybHdTvWUaSj/fIcri94YToiJMbigWv4aEgr7khj3tHTR99qjP
ARC-Seal: i=1; a=rsa-sha256; t=1523021638; cv=none;
        d=google.com; s=arc-20160816;
        b=pTI6WIv+ARO7zNtYrdivnaVFdy1H5P36FbSmc0xqRxEAJlbas2DmWVZwqfR266+nrW
         ACm97S+nrFMSpfPlZTrQHnJd6JPTgMrQOx9eOuVuj360+oThq+lZfH74iG7F6uRPnxCE
         bJ1G4z4npQCLuYVvqr24+hvpiFfsfw7sRfrOC3XVASZYUYFGuPlvgTneOdncXCyMcYuT
         u1jDSVSgN+myY9fQyTty2N0NXmLpLFfTWd76mg8lOnApHIKDQrMcSxMVebIH4m+asfKZ
         M82AiRac+5EzSWqk82+PNGtWOyPlMKvRFwZPX2PhVp4FESEkKa4TDv0YQEANIbYFWO7P
         J0Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=V8HClNqZ80DYITDFgpPF4lAEMFsrZZAKagHjG03hM98=;
        b=FMqCfHBbYklrgznvkw77F9SZMb7VwEBPESRWaxkmKru3FaWQuced1X7OgIryOYqdxT
         Oncb1W5QDcesTH72Gv0kdyiSZ1utTXzopkSUFCuE4lHN/W980+BInyKL+YPNsv6alEQO
         hoSC+e5ZWaqcfIPb/BKGpAlLDc5/ApYZIyZwdSxVUGXA0m3DNL09zGrII3RjgF3aLWLC
         mxR4tfnnWBrf8e10urinGQEQpad+Din8jFq0idlaBJvrOrnqpKt85oBp0O4r/9FGhqQm
         Mu0RP9AxT81RemnjCwiyI0HjkzbPQjDCsdQvrd5GaU5a4TJRqCgk3Vm2lyLSNhoS6Tjr
         Ji7Q==
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
Subject: [PATCH 4.9 009/102] powerpc/64s: Fix lost pending interrupt due to race causing lost update to irq_happened
Date: Fri,  6 Apr 2018 15:22:50 +0200
Message-Id: <20180406084332.878852809@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003938140949663?=
X-GMAIL-MSGID: =?utf-8?q?1597003938140949663?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -372,6 +372,14 @@ void force_external_irq_replay(void)
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
