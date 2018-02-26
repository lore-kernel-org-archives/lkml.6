Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224Xrszi5hWkxicbqN4exDI0EWTsFUGZoaHk1YCXW7fANhmMIPD34j4Wkt1eD/fCoDuaiY9O
ARC-Seal: i=1; a=rsa-sha256; t=1519676826; cv=none;
        d=google.com; s=arc-20160816;
        b=jQwGYvUKNEfXC3ZURUzN935YT0WFMlq4R0AFh+g7awj6yh7Y+T70efr2wFidDMGp23
         K6e63+4QRemg3iBdSOMvMSPbcTF21m9u06Hzgh5UrAxT0Er/7iFq1SSkCEBm+ILXjy2J
         YFkqTfq1aQmqgcHIGdY5MmJpoFGVr4yaY2b+N1nD2P1oYzqIfLUZZeiUKw8LV9EUtBnj
         /gIQpOF3K2FswLLIKosde1U0mRmxgcz/pTwZonTvZji68CfcrvMq5jvb1KIBPRFlHtYn
         BIydDmHfymxrklIteBXoxQI3nI/MwMF0qJi1jnGPTK0Y5643+FoytQDK9YB9jia8hM7H
         7K+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dO4mQlhlrChXh2ZkZrW+l0q4sGlSkK17/gAv5KA+shQ=;
        b=MVCT4cKcdujWsj+d9FPUT4aqDn6D34hHd4GH6lbvLJfDoaTY2vA5N7scM8o6q8RIJz
         WnaCdyWLuI3ULbH4jQnyfhNV1esefNBRzRMEIMNRBzRa4APWCg0uwNjpjkslHNWEBm3C
         XYXsMx0sKn+z9c9Aci7+iJZOnwWcBK2X2QSX+XV+uAZuJS68M6VHTOZ9iKSj0+3hXbfY
         DaQLASWPseAzJOcpCeitKlb0KpTvPQabyCTRxS4FpvUCZQhSFonx2/X9DKV/b1cZTHgk
         6UqP2oO9vQOaBn6rfpPq3E4SBnd7Pnl5ylLv2qILvvh0jDGBKE/uS33UnOlVXfVSyqG7
         EMOw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yuriy Vostrikov <delamonpansie@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 27/64] x86/apic/vector: Handle vector release on CPU unplug correctly
Date: Mon, 26 Feb 2018 21:22:04 +0100
Message-Id: <20180226202154.620009713@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496647326652148?=
X-GMAIL-MSGID: =?utf-8?q?1593496647326652148?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit e84cf6aa501c58bf4bf451f1e425192ec090aed2 upstream.

When a irq vector is replaced, then the previous vector is normally
released when the first interrupt happens on the new vector. If the target
CPU of the previous vector is already offline when the new vector is
installed, then the previous vector is silently discarded, which leads to
accounting issues causing suspend failures and other problems.

Adjust the logic so that the previous vector is freed in the underlying
matrix allocator to ensure that the accounting stays correct.

Fixes: 69cde0004a4b ("x86/vector: Use matrix allocator for vector assignment")
Reported-by: Yuriy Vostrikov <delamonpansie@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Yuriy Vostrikov <delamonpansie@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180222112316.930791749@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/apic/vector.c |   25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -134,21 +134,40 @@ static void apic_update_vector(struct ir
 {
 	struct apic_chip_data *apicd = apic_chip_data(irqd);
 	struct irq_desc *desc = irq_data_to_desc(irqd);
+	bool managed = irqd_affinity_is_managed(irqd);
 
 	lockdep_assert_held(&vector_lock);
 
 	trace_vector_update(irqd->irq, newvec, newcpu, apicd->vector,
 			    apicd->cpu);
 
-	/* Setup the vector move, if required  */
-	if (apicd->vector && cpu_online(apicd->cpu)) {
+	/*
+	 * If there is no vector associated or if the associated vector is
+	 * the shutdown vector, which is associated to make PCI/MSI
+	 * shutdown mode work, then there is nothing to release. Clear out
+	 * prev_vector for this and the offlined target case.
+	 */
+	apicd->prev_vector = 0;
+	if (!apicd->vector || apicd->vector == MANAGED_IRQ_SHUTDOWN_VECTOR)
+		goto setnew;
+	/*
+	 * If the target CPU of the previous vector is online, then mark
+	 * the vector as move in progress and store it for cleanup when the
+	 * first interrupt on the new vector arrives. If the target CPU is
+	 * offline then the regular release mechanism via the cleanup
+	 * vector is not possible and the vector can be immediately freed
+	 * in the underlying matrix allocator.
+	 */
+	if (cpu_online(apicd->cpu)) {
 		apicd->move_in_progress = true;
 		apicd->prev_vector = apicd->vector;
 		apicd->prev_cpu = apicd->cpu;
 	} else {
-		apicd->prev_vector = 0;
+		irq_matrix_free(vector_matrix, apicd->cpu, apicd->vector,
+				managed);
 	}
 
+setnew:
 	apicd->vector = newvec;
 	apicd->cpu = newcpu;
 	BUG_ON(!IS_ERR_OR_NULL(per_cpu(vector_irq, newcpu)[newvec]));
