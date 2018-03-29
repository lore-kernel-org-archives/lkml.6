Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48kRh81bYuhfQ/rzQOyLkjpAbPgZXyySjmc2MGQqaj4eoBTz6bSDzOj0JbviJoUjYDT5AIC
ARC-Seal: i=1; a=rsa-sha256; t=1522346865; cv=none;
        d=google.com; s=arc-20160816;
        b=X/CtoSejISmROD3tSvci3g+YJ1ZXOswUmIWH869eUcFoAV1c/VpEMTgprH0pkCZk2+
         FcUyFmg66SXliaF9PyOWVMGx7N5VfGLtjSm0TLm3jntBn1aLRTtWDiaQ7IESEuH80acS
         dPRLOCcSAmoLNLBSA8aRyb16Y3/g8O/tJi9kITp7uHYfQLHWQ5pE3RkJh+NPSPL/mVeD
         vTrLbnQIuw4rGWFQsldYfELQP+GeAx/pzOryfSSBrE7XBDiVqjiOYJuRuJOyfkfUYp5q
         SL+YyqEqHlg3zqaw0akpHkpQS/MZdqtIfzS2dJTt2QAXxehzLUYCP17WbA/OhXkglxQq
         T4EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k/cq8lIz+kGARkAVE3c9g1II+1SHl6eze3i+QKhCGXA=;
        b=uAMZDrvI0IccDp0DtoUaWirZ5Uv4YRdSFYNU2RFTPYY+sl2dp1k7XKE1YURdLhpyvi
         LR8T9r3yAbqTYrt1E13STZTey5RhsPO5YxdFDmFo+9qt0vneAlprpsm55cFEOOfwQZ13
         hsYf0fR/rnvl293FqkZypqD7zf3/faSSDyBp71IGzUeBjHP5viWalgPPjDMztkgqplfx
         LaYIJrCJatIFp0JI20aeDMlpa8CBnXq0xFLj6wuH7KGdmpLUDTgEx8tjVdj0ENEP5TWJ
         d7IMayzYXDhksX8MlNRxDor0LvW/ZAmRpQffw2CjNbHI3NL2gtkDPuNZkidd/HdHsmAD
         Nv/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 02/20] genirq: Track whether the trigger type has been set
Date: Thu, 29 Mar 2018 20:00:38 +0200
Message-Id: <20180329175741.988003717@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175741.886181131@linuxfoundation.org>
References: <20180329175741.886181131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296321269609847?=
X-GMAIL-MSGID: =?utf-8?q?1596296386262304555?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit 4f8413a3a799c958f7a10a6310a451e6b8aef5ad upstream.

When requesting a shared interrupt, we assume that the firmware
support code (DT or ACPI) has called irqd_set_trigger_type
already, so that we can retrieve it and check that the requester
is being reasonnable.

Unfortunately, we still have non-DT, non-ACPI systems around,
and these guys won't call irqd_set_trigger_type before requesting
the interrupt. The consequence is that we fail the request that
would have worked before.

We can either chase all these use cases (boring), or address it
in core code (easier). Let's have a per-irq_desc flag that
indicates whether irqd_set_trigger_type has been called, and
let's just check it when checking for a shared interrupt.
If it hasn't been set, just take whatever the interrupt
requester asks.

Fixes: 382bd4de6182 ("genirq: Use irqd_get_trigger_type to compare the trigger type for shared IRQs")
Cc: stable@vger.kernel.org
Reported-and-tested-by: Petr Cvek <petrcvekcz@gmail.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/irq.h |   11 ++++++++++-
 kernel/irq/manage.c |   13 ++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -191,6 +191,7 @@ struct irq_data {
  * IRQD_IRQ_INPROGRESS		- In progress state of the interrupt
  * IRQD_WAKEUP_ARMED		- Wakeup mode armed
  * IRQD_FORWARDED_TO_VCPU	- The interrupt is forwarded to a VCPU
+ * IRQD_DEFAULT_TRIGGER_SET	- Expected trigger already been set
  */
 enum {
 	IRQD_TRIGGER_MASK		= 0xf,
@@ -206,6 +207,7 @@ enum {
 	IRQD_IRQ_INPROGRESS		= (1 << 18),
 	IRQD_WAKEUP_ARMED		= (1 << 19),
 	IRQD_FORWARDED_TO_VCPU		= (1 << 20),
+	IRQD_DEFAULT_TRIGGER_SET	= (1 << 25),
 };
 
 #define __irqd_to_state(d)		((d)->common->state_use_accessors)
@@ -235,18 +237,25 @@ static inline void irqd_mark_affinity_wa
 	__irqd_to_state(d) |= IRQD_AFFINITY_SET;
 }
 
+static inline bool irqd_trigger_type_was_set(struct irq_data *d)
+{
+	return __irqd_to_state(d) & IRQD_DEFAULT_TRIGGER_SET;
+}
+
 static inline u32 irqd_get_trigger_type(struct irq_data *d)
 {
 	return __irqd_to_state(d) & IRQD_TRIGGER_MASK;
 }
 
 /*
- * Must only be called inside irq_chip.irq_set_type() functions.
+ * Must only be called inside irq_chip.irq_set_type() functions or
+ * from the DT/ACPI setup code.
  */
 static inline void irqd_set_trigger_type(struct irq_data *d, u32 type)
 {
 	__irqd_to_state(d) &= ~IRQD_TRIGGER_MASK;
 	__irqd_to_state(d) |= type & IRQD_TRIGGER_MASK;
+	__irqd_to_state(d) |= IRQD_DEFAULT_TRIGGER_SET;
 }
 
 static inline bool irqd_is_level_type(struct irq_data *d)
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1189,7 +1189,18 @@ __setup_irq(unsigned int irq, struct irq
 		 * set the trigger type must match. Also all must
 		 * agree on ONESHOT.
 		 */
-		unsigned int oldtype = irqd_get_trigger_type(&desc->irq_data);
+		unsigned int oldtype;
+
+		/*
+		 * If nobody did set the configuration before, inherit
+		 * the one provided by the requester.
+		 */
+		if (irqd_trigger_type_was_set(&desc->irq_data)) {
+			oldtype = irqd_get_trigger_type(&desc->irq_data);
+		} else {
+			oldtype = new->flags & IRQF_TRIGGER_MASK;
+			irqd_set_trigger_type(&desc->irq_data, oldtype);
+		}
 
 		if (!((old->flags & new->flags) & IRQF_SHARED) ||
 		    (oldtype != (new->flags & IRQF_TRIGGER_MASK)) ||
