Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+w8As35jt7aNx3MSgGPrMJMv8Cm9/RiV/fBUUy4WdD+oCeL2yXVPoMuP6NZ9maM3rdJ9bx
ARC-Seal: i=1; a=rsa-sha256; t=1522346802; cv=none;
        d=google.com; s=arc-20160816;
        b=vBupoa+6J59czMynvOHamnLNrMY4xTgxYjZ1MvSnG0uJJTTUj7Zj8j2QrpQFFpH0um
         9ivI1pZ21GcFFpP08oYfrLPJ1+tUX31GYbEZ+JIOBNFnBUyZb6kxSAJuOP3tacfZNFnh
         Pl+FjtiHzX0KHxM1jFl17+5PDqaQG5yHTda+DfqDXvFl+40X699hNJ15ttIzdq3t2yqx
         uOIbSqJ/bCUyNpcQ9/Wkk5mvVpz+toN3eDPWfg+vvpP4PBzoiz/x11nz0k2ZyTp3Bvde
         35m/b63mOHmzHgIX2dwU5F1WRiqkkTZpol1gXN8BG0FHYp7W/NygR6epyk9ND6ENm+/o
         0acA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3I+yHrf+CPCpqQ4y6behOmiRZal4KpLvAy3mURHlHyc=;
        b=Gqn5byd379tjfO3JNp3BtTu7gadju2ehthTZcvcdo2oTFs9cxUzn5OsOXNtJTwaOeM
         OIAIm/p/6iYkM2oXFjeDzjqlDEFILA3fLpHlokpu8eRvpK0UFK5kYkE2wBthsFUNNe3m
         c+QmigoKUPjxkqlyuajmgsnSSVaTTiYStVeVzr3wCOCjhNeDDHJrsMCTrXYFIZdFBwFm
         Tj5Qw6xcY/TfvjxCYKALUNigGi3UizKNiIYs5PZZfOxi4diVzsYu17Z0XdYOFxYiIagy
         EBqqcGv5UaqEEd47zQ7uYFVFcablwtZgzhTgwNI0GmgA9228TdpZ4eQHR0tWYPPpvvKN
         Ze6A==
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
Subject: [PATCH 4.9 02/28] genirq: Track whether the trigger type has been set
Date: Thu, 29 Mar 2018 20:00:21 +0200
Message-Id: <20180329175733.738322674@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175733.447823703@linuxfoundation.org>
References: <20180329175733.447823703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296321269609847?=
X-GMAIL-MSGID: =?utf-8?q?1596296321269609847?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -199,6 +199,7 @@ struct irq_data {
  * IRQD_WAKEUP_ARMED		- Wakeup mode armed
  * IRQD_FORWARDED_TO_VCPU	- The interrupt is forwarded to a VCPU
  * IRQD_AFFINITY_MANAGED	- Affinity is auto-managed by the kernel
+ * IRQD_DEFAULT_TRIGGER_SET	- Expected trigger already been set
  */
 enum {
 	IRQD_TRIGGER_MASK		= 0xf,
@@ -216,6 +217,7 @@ enum {
 	IRQD_WAKEUP_ARMED		= (1 << 19),
 	IRQD_FORWARDED_TO_VCPU		= (1 << 20),
 	IRQD_AFFINITY_MANAGED		= (1 << 21),
+	IRQD_DEFAULT_TRIGGER_SET	= (1 << 25),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -245,18 +247,25 @@ static inline void irqd_mark_affinity_wa
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
@@ -1210,7 +1210,18 @@ __setup_irq(unsigned int irq, struct irq
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
