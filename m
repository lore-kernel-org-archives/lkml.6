Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33F2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF02B2087F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545998017;
	bh=G8TH5o2P35swP0E91NYORtckycqijh0Sll6E+LRL1Fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tNW47cmYUjtbHbadjXfrt2qmlqTYpnlOHAzTHiqGtZp1xBMIh56fY0seWkTQQ633Z
	 ASMsb8Um2BIesk7Fj46tSMGn1mihUimPZ/a1+Pgi944f1IexT05pVh/Mz4zpLOHuHK
	 OBPwrIB6OLEx1GokTx81FT5FSgPynXCcf5jOMW5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbeL1Lxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 06:53:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732247AbeL1Lxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 06:53:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14ACB2146F;
        Fri, 28 Dec 2018 11:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545998013;
        bh=G8TH5o2P35swP0E91NYORtckycqijh0Sll6E+LRL1Fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A3/ZXspX08SpYpet/zI9jGxWSd5jFERB+H2UVr/7xXoNafQS+tO/vUnAEcTgaewCB
         nsBTBaF0BEVW/ZfPbWwcGNJbYR0Z22GbwPNlpa0aITKkjH0ZhxQghTNq8VYMDL5qAq
         iPYzqe7+CVJOB9ppgIy8XqTIX/EB52T4lelFq6/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.19 19/46] gpiolib-acpi: Only defer request_irq for GpioInt ACPI event handlers
Date:   Fri, 28 Dec 2018 12:52:13 +0100
Message-Id: <20181228113125.904407232@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit e59f5e08ece1060073d92c66ded52e1f2c43b5bb upstream.

Commit 78d3a92edbfb ("gpiolib-acpi: Register GpioInt ACPI event handlers
from a late_initcall") deferred the entire acpi_gpiochip_request_interrupt
call for each event resource.

This means it also delays the gpiochip_request_own_desc(..., "ACPI:Event")
call. This is a problem if some AML code reads the GPIO pin before we
run the deferred acpi_gpiochip_request_interrupt, because in that case
acpi_gpio_adr_space_handler() will already have called
gpiochip_request_own_desc(..., "ACPI:OpRegion") causing the call from
acpi_gpiochip_request_interrupt to fail with -EBUSY and we will fail to
register an event handler.

acpi_gpio_adr_space_handler is prepared for acpi_gpiochip_request_interrupt
already having claimed the pin, but the other way around does not work.

One example of a problem this causes, is the event handler for the OTG
ID pin on a Prowise PT301 tablet not registering, keeping the port stuck
in whatever mode it was in during boot and e.g. only allowing charging
after a reboot.

This commit fixes this by only deferring the request_irq call and the
initial run of edge-triggered IRQs instead of deferring all of
acpi_gpiochip_request_interrupt.

Cc: stable@vger.kernel.org
Fixes: 78d3a92edbfb ("gpiolib-acpi: Register GpioInt ACPI event ...")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpiolib-acpi.c |  144 +++++++++++++++++++++++++-------------------
 1 file changed, 84 insertions(+), 60 deletions(-)

--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -23,11 +23,28 @@
 
 #include "gpiolib.h"
 
+/**
+ * struct acpi_gpio_event - ACPI GPIO event handler data
+ *
+ * @node:	  list-entry of the events list of the struct acpi_gpio_chip
+ * @handle:	  handle of ACPI method to execute when the IRQ triggers
+ * @handler:	  irq_handler to pass to request_irq when requesting the IRQ
+ * @pin:	  GPIO pin number on the gpio_chip
+ * @irq:	  Linux IRQ number for the event, for request_ / free_irq
+ * @irqflags:     flags to pass to request_irq when requesting the IRQ
+ * @irq_is_wake:  If the ACPI flags indicate the IRQ is a wakeup source
+ * @is_requested: True if request_irq has been done
+ * @desc:	  gpio_desc for the GPIO pin for this event
+ */
 struct acpi_gpio_event {
 	struct list_head node;
 	acpi_handle handle;
+	irq_handler_t handler;
 	unsigned int pin;
 	unsigned int irq;
+	unsigned long irqflags;
+	bool irq_is_wake;
+	bool irq_requested;
 	struct gpio_desc *desc;
 };
 
@@ -53,10 +70,10 @@ struct acpi_gpio_chip {
 
 /*
  * For gpiochips which call acpi_gpiochip_request_interrupts() before late_init
- * (so builtin drivers) we register the ACPI GpioInt event handlers from a
+ * (so builtin drivers) we register the ACPI GpioInt IRQ handlers from a
  * late_initcall_sync handler, so that other builtin drivers can register their
  * OpRegions before the event handlers can run.  This list contains gpiochips
- * for which the acpi_gpiochip_request_interrupts() has been deferred.
+ * for which the acpi_gpiochip_request_irqs() call has been deferred.
  */
 static DEFINE_MUTEX(acpi_gpio_deferred_req_irqs_lock);
 static LIST_HEAD(acpi_gpio_deferred_req_irqs_list);
@@ -137,8 +154,42 @@ bool acpi_gpio_get_irq_resource(struct a
 }
 EXPORT_SYMBOL_GPL(acpi_gpio_get_irq_resource);
 
-static acpi_status acpi_gpiochip_request_interrupt(struct acpi_resource *ares,
-						   void *context)
+static void acpi_gpiochip_request_irq(struct acpi_gpio_chip *acpi_gpio,
+				      struct acpi_gpio_event *event)
+{
+	int ret, value;
+
+	ret = request_threaded_irq(event->irq, NULL, event->handler,
+				   event->irqflags, "ACPI:Event", event);
+	if (ret) {
+		dev_err(acpi_gpio->chip->parent,
+			"Failed to setup interrupt handler for %d\n",
+			event->irq);
+		return;
+	}
+
+	if (event->irq_is_wake)
+		enable_irq_wake(event->irq);
+
+	event->irq_requested = true;
+
+	/* Make sure we trigger the initial state of edge-triggered IRQs */
+	value = gpiod_get_raw_value_cansleep(event->desc);
+	if (((event->irqflags & IRQF_TRIGGER_RISING) && value == 1) ||
+	    ((event->irqflags & IRQF_TRIGGER_FALLING) && value == 0))
+		event->handler(event->irq, event);
+}
+
+static void acpi_gpiochip_request_irqs(struct acpi_gpio_chip *acpi_gpio)
+{
+	struct acpi_gpio_event *event;
+
+	list_for_each_entry(event, &acpi_gpio->events, node)
+		acpi_gpiochip_request_irq(acpi_gpio, event);
+}
+
+static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
+					     void *context)
 {
 	struct acpi_gpio_chip *acpi_gpio = context;
 	struct gpio_chip *chip = acpi_gpio->chip;
@@ -147,8 +198,7 @@ static acpi_status acpi_gpiochip_request
 	struct acpi_gpio_event *event;
 	irq_handler_t handler = NULL;
 	struct gpio_desc *desc;
-	unsigned long irqflags;
-	int ret, pin, irq, value;
+	int ret, pin, irq;
 
 	if (!acpi_gpio_get_irq_resource(ares, &agpio))
 		return AE_OK;
@@ -179,8 +229,6 @@ static acpi_status acpi_gpiochip_request
 
 	gpiod_direction_input(desc);
 
-	value = gpiod_get_value_cansleep(desc);
-
 	ret = gpiochip_lock_as_irq(chip, pin);
 	if (ret) {
 		dev_err(chip->parent, "Failed to lock GPIO as interrupt\n");
@@ -193,64 +241,42 @@ static acpi_status acpi_gpiochip_request
 		goto fail_unlock_irq;
 	}
 
-	irqflags = IRQF_ONESHOT;
+	event = kzalloc(sizeof(*event), GFP_KERNEL);
+	if (!event)
+		goto fail_unlock_irq;
+
+	event->irqflags = IRQF_ONESHOT;
 	if (agpio->triggering == ACPI_LEVEL_SENSITIVE) {
 		if (agpio->polarity == ACPI_ACTIVE_HIGH)
-			irqflags |= IRQF_TRIGGER_HIGH;
+			event->irqflags |= IRQF_TRIGGER_HIGH;
 		else
-			irqflags |= IRQF_TRIGGER_LOW;
+			event->irqflags |= IRQF_TRIGGER_LOW;
 	} else {
 		switch (agpio->polarity) {
 		case ACPI_ACTIVE_HIGH:
-			irqflags |= IRQF_TRIGGER_RISING;
+			event->irqflags |= IRQF_TRIGGER_RISING;
 			break;
 		case ACPI_ACTIVE_LOW:
-			irqflags |= IRQF_TRIGGER_FALLING;
+			event->irqflags |= IRQF_TRIGGER_FALLING;
 			break;
 		default:
-			irqflags |= IRQF_TRIGGER_RISING |
-				    IRQF_TRIGGER_FALLING;
+			event->irqflags |= IRQF_TRIGGER_RISING |
+					   IRQF_TRIGGER_FALLING;
 			break;
 		}
 	}
 
-	event = kzalloc(sizeof(*event), GFP_KERNEL);
-	if (!event)
-		goto fail_unlock_irq;
-
 	event->handle = evt_handle;
+	event->handler = handler;
 	event->irq = irq;
+	event->irq_is_wake = agpio->wake_capable == ACPI_WAKE_CAPABLE;
 	event->pin = pin;
 	event->desc = desc;
 
-	ret = request_threaded_irq(event->irq, NULL, handler, irqflags,
-				   "ACPI:Event", event);
-	if (ret) {
-		dev_err(chip->parent,
-			"Failed to setup interrupt handler for %d\n",
-			event->irq);
-		goto fail_free_event;
-	}
-
-	if (agpio->wake_capable == ACPI_WAKE_CAPABLE)
-		enable_irq_wake(irq);
-
 	list_add_tail(&event->node, &acpi_gpio->events);
 
-	/*
-	 * Make sure we trigger the initial state of the IRQ when using RISING
-	 * or FALLING.  Note we run the handlers on late_init, the AML code
-	 * may refer to OperationRegions from other (builtin) drivers which
-	 * may be probed after us.
-	 */
-	if (((irqflags & IRQF_TRIGGER_RISING) && value == 1) ||
-	    ((irqflags & IRQF_TRIGGER_FALLING) && value == 0))
-		handler(event->irq, event);
-
 	return AE_OK;
 
-fail_free_event:
-	kfree(event);
 fail_unlock_irq:
 	gpiochip_unlock_as_irq(chip, pin);
 fail_free_desc:
@@ -287,6 +313,9 @@ void acpi_gpiochip_request_interrupts(st
 	if (ACPI_FAILURE(status))
 		return;
 
+	acpi_walk_resources(handle, "_AEI",
+			    acpi_gpiochip_alloc_event, acpi_gpio);
+
 	mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
 	defer = !acpi_gpio_deferred_req_irqs_done;
 	if (defer)
@@ -297,8 +326,7 @@ void acpi_gpiochip_request_interrupts(st
 	if (defer)
 		return;
 
-	acpi_walk_resources(handle, "_AEI",
-			    acpi_gpiochip_request_interrupt, acpi_gpio);
+	acpi_gpiochip_request_irqs(acpi_gpio);
 }
 EXPORT_SYMBOL_GPL(acpi_gpiochip_request_interrupts);
 
@@ -335,10 +363,13 @@ void acpi_gpiochip_free_interrupts(struc
 	list_for_each_entry_safe_reverse(event, ep, &acpi_gpio->events, node) {
 		struct gpio_desc *desc;
 
-		if (irqd_is_wakeup_set(irq_get_irq_data(event->irq)))
-			disable_irq_wake(event->irq);
+		if (event->irq_requested) {
+			if (event->irq_is_wake)
+				disable_irq_wake(event->irq);
+
+			free_irq(event->irq, event);
+		}
 
-		free_irq(event->irq, event);
 		desc = event->desc;
 		if (WARN_ON(IS_ERR(desc)))
 			continue;
@@ -1204,23 +1235,16 @@ bool acpi_can_fallback_to_crs(struct acp
 	return con_id == NULL;
 }
 
-/* Run deferred acpi_gpiochip_request_interrupts() */
-static int acpi_gpio_handle_deferred_request_interrupts(void)
+/* Run deferred acpi_gpiochip_request_irqs() */
+static int acpi_gpio_handle_deferred_request_irqs(void)
 {
 	struct acpi_gpio_chip *acpi_gpio, *tmp;
 
 	mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
 	list_for_each_entry_safe(acpi_gpio, tmp,
 				 &acpi_gpio_deferred_req_irqs_list,
-				 deferred_req_irqs_list_entry) {
-		acpi_handle handle;
-
-		handle = ACPI_HANDLE(acpi_gpio->chip->parent);
-		acpi_walk_resources(handle, "_AEI",
-				    acpi_gpiochip_request_interrupt, acpi_gpio);
-
-		list_del_init(&acpi_gpio->deferred_req_irqs_list_entry);
-	}
+				 deferred_req_irqs_list_entry)
+		acpi_gpiochip_request_irqs(acpi_gpio);
 
 	acpi_gpio_deferred_req_irqs_done = true;
 	mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
@@ -1228,4 +1252,4 @@ static int acpi_gpio_handle_deferred_req
 	return 0;
 }
 /* We must use _sync so that this runs after the first deferred_probe run */
-late_initcall_sync(acpi_gpio_handle_deferred_request_interrupts);
+late_initcall_sync(acpi_gpio_handle_deferred_request_irqs);


