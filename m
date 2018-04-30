Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeD3DM2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 23:12:28 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41303 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeD3DM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 23:12:27 -0400
X-Google-Smtp-Source: AB8JxZogmg9yYJEOMNA5FkfPe76KA++fnRpOSol7rZT2dky4SMW5mj8OjP7KTJJpangXQ9GsNX9gug==
Date: Sun, 29 Apr 2018 20:12:22 -0700
From: Sultan Alsawaf <sultanxda@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: tytso@mit.edu
Subject: [PATCH] random: remove unused argument from
 add_interrupt_randomness()
Message-ID: <20180430031222.mapajgwprkkr6p36@sultan-box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From cdc2a03f93fdec88ad040a212605e20ab97c3e19 Mon Sep 17 00:00:00 2001
From: Sultan Alsawaf <sultanxda@gmail.com>
Date: Sun, 29 Apr 2018 20:04:35 -0700
Subject: [PATCH] random: remove unused argument from add_interrupt_randomness()

The irq_flags parameter is not used. Remove it.

Signed-off-by: Sultan Alsawaf <sultanxda@gmail.com>
---
 drivers/char/random.c  | 4 ++--
 drivers/hv/vmbus_drv.c | 2 +-
 include/linux/random.h | 2 +-
 kernel/irq/handle.c    | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 38729baed6ee..d9e38523b383 100644
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
@@ -1164,7 +1164,7 @@ static __u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 	return *ptr;
 }
 
-void add_interrupt_randomness(int irq, int irq_flags)
+void add_interrupt_randomness(int irq)
 {
 	struct entropy_store	*r;
 	struct fast_pool	*fast_pool = this_cpu_ptr(&irq_randomness);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index bc65c4d79c1f..777096d560cb 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1016,7 +1016,7 @@ static void vmbus_isr(void)
 			tasklet_schedule(&hv_cpu->msg_dpc);
 	}
 
-	add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR, 0);
+	add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR);
 }
 
 
diff --git a/include/linux/random.h b/include/linux/random.h
index 4024f7d9c77d..b71f87dbf7cd 100644
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
index 79f987b942b8..1bc4dcc489d0 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -186,7 +186,7 @@ irqreturn_t handle_irq_event_percpu(struct irq_desc *desc)
 
 	retval = __handle_irq_event_percpu(desc, &flags);
 
-	add_interrupt_randomness(desc->irq_data.irq, flags);
+	add_interrupt_randomness(desc->irq_data.irq);
 
 	if (!noirqdebug)
 		note_interrupt(desc, retval);
-- 
2.14.1
