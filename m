Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+dNQOz3HmW6ZR5j05a+eQigPFl49hYFWwDyXBavEZrH/M9CM0vHNkcKA/s74rPNoW1pyT5
ARC-Seal: i=1; a=rsa-sha256; t=1523022121; cv=none;
        d=google.com; s=arc-20160816;
        b=SzOy5OSosh9bhbflpjx9PBZUHgaOQPVsr0zCmLMnRnci2UTVgWwa3MwQjxFx8lWqjG
         8hP4GEMDIJQkTUjXTB0Y29K9Sn0Zz3VfbZG99TtM5Eo8r8CHLMavSYN6oZvDvY38svhR
         dUpN+JrvidJlpt4Zbuk3WQ38sJQkNNTucK8BpSfhxKiErN8fkZFyJA3JcTIcsjdCiA8k
         na55MM+JCS0pSen+148Ak5VPALTR0tNUap282AYZvZxY7sSo4rjEgdXgPw7icq2HiG44
         yJz8M0r6aDT5Jq7w6ht20kBkGsgxcGLGlIp67dtAdJUCr9yYW/ptoVTQly0ZVxvWQvhh
         2PMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JK+K9ev3BsSGHCfKs27YDgYvF3sT+kbBRKJ45NF9dX0=;
        b=ijxk2V8TUbUjPTxKGXqg/xSuglFEa6jC3scF93u4tuI8rmZDg2LluFXt0FE9ne7jU0
         5HEJLmN5aqotWEbgyqqs+0/QaLb7jppF6zVeTekZ3ToZNSQRm/aYpIOvrsqrkx39vki0
         sq/B7/AESmpBvQmWqR+KT4cEXQpfmuAhXWkd3MMIpCxhDGpwoA9b6NBrNcobPtl6J3gv
         ZEHpk3xtNrMbfX68Kwysiha3zkPG/ptF6d6t746AjyIhekv2WhuHVf9kgM5Mis8K3dy/
         t2b2t+wv1IjABYBGKH40MTq3l7Sl+rxkCUznshFhQ+1ifMreIJtzrVPjXIhSenfp+qJR
         gSzA==
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
Subject: [PATCH 4.15 17/72] powerpc/64s: Fix lost pending interrupt due to race causing lost update to irq_happened
Date: Fri,  6 Apr 2018 15:23:52 +0200
Message-Id: <20180406084350.872940110@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003938140949663?=
X-GMAIL-MSGID: =?utf-8?q?1597004443654304470?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -475,6 +475,14 @@ void force_external_irq_replay(void)
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
