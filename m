Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754596AbeD3PMh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:12:37 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:39839 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754093AbeD3PMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:12:35 -0400
X-Google-Smtp-Source: AB8JxZp+rH2kS/miGrcXPjyJnZetV1E+Gr+i4pC3fAZrqEWOb9wYVfMjMV+WYriTC0lfLIMh6s1LAg==
Date: Mon, 30 Apr 2018 08:12:29 -0700
From: Sultan Alsawaf <sultanxda@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: tytso@mit.edu
Subject: Re: [PATCH] random: remove unused argument from
 add_interrupt_randomness()
Message-ID: <20180430151229.pen4kay5qjbrg2f3@sultan-box>
References: <20180430031222.mapajgwprkkr6p36@sultan-box>
 <201804301721.JEar9rKK%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201804301721.JEar9rKK%fengguang.wu@intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From a872cf4f0bb57a7bb3c95ea557082fb7733344f8 Mon Sep 17 00:00:00 2001
From: Sultan Alsawaf <sultanxda@gmail.com>
Date: Sun, 29 Apr 2018 20:04:35 -0700
Subject: [PATCH] random: remove unused argument from
 add_interrupt_randomness()

The irq_flags parameter is not used. Remove it.

Signed-off-by: Sultan Alsawaf <sultanxda@gmail.com>
---
 drivers/char/random.c  | 4 ++--
 drivers/hv/hv.c        | 2 +-
 drivers/hv/vmbus_drv.c | 2 +-
 include/linux/random.h | 2 +-
 kernel/irq/handle.c    | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 3cd3aae24d6d..125c1f545277 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -131,7 +131,7 @@
  *	void add_device_randomness(const void *buf, unsigned int size);
  * 	void add_input_randomness(unsigned int type, unsigned int code,
  *                                unsigned int value);
- *	void add_interrupt_randomness(int irq, int irq_flags);
+ *	void add_interrupt_randomness(int irq);
  * 	void add_disk_randomness(struct gendisk *disk);
  *
  * add_device_randomness() is for adding data to the random pool that
@@ -1189,7 +1189,7 @@ static __u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 	return *ptr;
 }
 
-void add_interrupt_randomness(int irq, int irq_flags)
+void add_interrupt_randomness(int irq)
 {
 	struct entropy_store	*r;
 	struct fast_pool	*fast_pool = this_cpu_ptr(&irq_randomness);
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 9b82549cbbc8..4b76ba23d666 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -115,7 +115,7 @@ static void hv_stimer0_isr(void)
 
 	hv_cpu = this_cpu_ptr(hv_context.cpu_context);
 	hv_cpu->clk_evt->event_handler(hv_cpu->clk_evt);
-	add_interrupt_randomness(stimer0_vector, 0);
+	add_interrupt_randomness(stimer0_vector);
 }
 
 static int hv_ce_set_next_event(unsigned long delta,
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index b10fe26c4891..41f4116f8c31 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1015,7 +1015,7 @@ static void vmbus_isr(void)
 			tasklet_schedule(&hv_cpu->msg_dpc);
 	}
 
-	add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR, 0);
+	add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR);
 }
 
 
diff --git a/include/linux/random.h b/include/linux/random.h
index 2ddf13b4281e..210400258fef 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -32,7 +32,7 @@ static inline void add_latent_entropy(void) {}
 
 extern void add_input_randomness(unsigned int type, unsigned int code,
 				 unsigned int value) __latent_entropy;
-extern void add_interrupt_randomness(int irq, int irq_flags) __latent_entropy;
+extern void add_interrupt_randomness(int irq) __latent_entropy;
 
 extern void get_random_bytes(void *buf, int nbytes);
 extern int wait_for_random_bytes(void);
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 38554bc35375..e2f7afcb1ae6 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -188,7 +188,7 @@ irqreturn_t handle_irq_event_percpu(struct irq_desc *desc)
 
 	retval = __handle_irq_event_percpu(desc, &flags);
 
-	add_interrupt_randomness(desc->irq_data.irq, flags);
+	add_interrupt_randomness(desc->irq_data.irq);
 
 	if (!noirqdebug)
 		note_interrupt(desc, retval);
-- 
2.14.1
