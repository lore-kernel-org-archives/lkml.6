Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AE4C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54333204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwENkgpn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54333204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbeJIB7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:59:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbeJIB7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:59:38 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D796D2087D;
        Mon,  8 Oct 2018 18:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024392;
        bh=iLMvCfQoBLswHADMZbq6lYXVydsV9wA7kpzvmi5tGp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NwENkgpnneAHZ9k9PKBeOBbIVNlCznWN3TpKun4gV8hdIvCLmm3Z6T7HvszLIGRoB
         c3gq2dWZuTg0kP9fJCw/Tua13dlPTGhyELuZsPgoMOwF2KmFkFNOxc7I9RpsLCNjlW
         885z01C/qJN+0iyE6RIk+fT/F8T2bOaVPyocUyW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 026/168] gpiolib-acpi: Register GpioInt ACPI event handlers from a late_initcall
Date:   Mon,  8 Oct 2018 20:30:06 +0200
Message-Id: <20181008175621.042303594@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 78d3a92edbfb02e8cb83173cad84c3f2d5e1f070 ]

GpioInt ACPI event handlers may see there IRQ triggered immediately
after requesting the IRQ (esp. level triggered ones). This means that they
may run before any other (builtin) drivers have had a chance to register
their OpRegion handlers, leading to errors like this:

[    1.133274] ACPI Error: No handler for Region [PMOP] ((____ptrval____)) [UserDefinedRegion] (20180531/evregion-132)
[    1.133286] ACPI Error: Region UserDefinedRegion (ID=141) has no handler (20180531/exfldio-265)
[    1.133297] ACPI Error: Method parse/execution failed \_SB.GPO2._L01, AE_NOT_EXIST (20180531/psparse-516)

We already defer the manual initial trigger of edge triggered interrupts
by running it from a late_initcall handler, this commit replaces this with
deferring the entire acpi_gpiochip_request_interrupts() call till then,
fixing the problem of some OpRegions not being registered yet.

Note that this removes the need to have a list of edge triggered handlers
which need to run, since the entire acpi_gpiochip_request_interrupts() call
is now delayed, acpi_gpiochip_request_interrupt() can call these directly
now.

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpiolib-acpi.c |   84 +++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 35 deletions(-)

--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -25,7 +25,6 @@
 
 struct acpi_gpio_event {
 	struct list_head node;
-	struct list_head initial_sync_list;
 	acpi_handle handle;
 	unsigned int pin;
 	unsigned int irq;
@@ -49,10 +48,19 @@ struct acpi_gpio_chip {
 	struct mutex conn_lock;
 	struct gpio_chip *chip;
 	struct list_head events;
+	struct list_head deferred_req_irqs_list_entry;
 };
 
-static LIST_HEAD(acpi_gpio_initial_sync_list);
-static DEFINE_MUTEX(acpi_gpio_initial_sync_list_lock);
+/*
+ * For gpiochips which call acpi_gpiochip_request_interrupts() before late_init
+ * (so builtin drivers) we register the ACPI GpioInt event handlers from a
+ * late_initcall_sync handler, so that other builtin drivers can register their
+ * OpRegions before the event handlers can run.  This list contains gpiochips
+ * for which the acpi_gpiochip_request_interrupts() has been deferred.
+ */
+static DEFINE_MUTEX(acpi_gpio_deferred_req_irqs_lock);
+static LIST_HEAD(acpi_gpio_deferred_req_irqs_list);
+static bool acpi_gpio_deferred_req_irqs_done;
 
 static int acpi_gpiochip_find(struct gpio_chip *gc, void *data)
 {
@@ -89,21 +97,6 @@ static struct gpio_desc *acpi_get_gpiod(
 	return gpiochip_get_desc(chip, pin);
 }
 
-static void acpi_gpio_add_to_initial_sync_list(struct acpi_gpio_event *event)
-{
-	mutex_lock(&acpi_gpio_initial_sync_list_lock);
-	list_add(&event->initial_sync_list, &acpi_gpio_initial_sync_list);
-	mutex_unlock(&acpi_gpio_initial_sync_list_lock);
-}
-
-static void acpi_gpio_del_from_initial_sync_list(struct acpi_gpio_event *event)
-{
-	mutex_lock(&acpi_gpio_initial_sync_list_lock);
-	if (!list_empty(&event->initial_sync_list))
-		list_del_init(&event->initial_sync_list);
-	mutex_unlock(&acpi_gpio_initial_sync_list_lock);
-}
-
 static irqreturn_t acpi_gpio_irq_handler(int irq, void *data)
 {
 	struct acpi_gpio_event *event = data;
@@ -229,7 +222,6 @@ static acpi_status acpi_gpiochip_request
 	event->irq = irq;
 	event->pin = pin;
 	event->desc = desc;
-	INIT_LIST_HEAD(&event->initial_sync_list);
 
 	ret = request_threaded_irq(event->irq, NULL, handler, irqflags,
 				   "ACPI:Event", event);
@@ -251,10 +243,9 @@ static acpi_status acpi_gpiochip_request
 	 * may refer to OperationRegions from other (builtin) drivers which
 	 * may be probed after us.
 	 */
-	if (handler == acpi_gpio_irq_handler &&
-	    (((irqflags & IRQF_TRIGGER_RISING) && value == 1) ||
-	     ((irqflags & IRQF_TRIGGER_FALLING) && value == 0)))
-		acpi_gpio_add_to_initial_sync_list(event);
+	if (((irqflags & IRQF_TRIGGER_RISING) && value == 1) ||
+	    ((irqflags & IRQF_TRIGGER_FALLING) && value == 0))
+		handler(event->irq, event);
 
 	return AE_OK;
 
@@ -283,6 +274,7 @@ void acpi_gpiochip_request_interrupts(st
 	struct acpi_gpio_chip *acpi_gpio;
 	acpi_handle handle;
 	acpi_status status;
+	bool defer;
 
 	if (!chip->parent || !chip->to_irq)
 		return;
@@ -295,6 +287,16 @@ void acpi_gpiochip_request_interrupts(st
 	if (ACPI_FAILURE(status))
 		return;
 
+	mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
+	defer = !acpi_gpio_deferred_req_irqs_done;
+	if (defer)
+		list_add(&acpi_gpio->deferred_req_irqs_list_entry,
+			 &acpi_gpio_deferred_req_irqs_list);
+	mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
+
+	if (defer)
+		return;
+
 	acpi_walk_resources(handle, "_AEI",
 			    acpi_gpiochip_request_interrupt, acpi_gpio);
 }
@@ -325,11 +327,14 @@ void acpi_gpiochip_free_interrupts(struc
 	if (ACPI_FAILURE(status))
 		return;
 
+	mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
+	if (!list_empty(&acpi_gpio->deferred_req_irqs_list_entry))
+		list_del_init(&acpi_gpio->deferred_req_irqs_list_entry);
+	mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
+
 	list_for_each_entry_safe_reverse(event, ep, &acpi_gpio->events, node) {
 		struct gpio_desc *desc;
 
-		acpi_gpio_del_from_initial_sync_list(event);
-
 		if (irqd_is_wakeup_set(irq_get_irq_data(event->irq)))
 			disable_irq_wake(event->irq);
 
@@ -1049,6 +1054,7 @@ void acpi_gpiochip_add(struct gpio_chip
 
 	acpi_gpio->chip = chip;
 	INIT_LIST_HEAD(&acpi_gpio->events);
+	INIT_LIST_HEAD(&acpi_gpio->deferred_req_irqs_list_entry);
 
 	status = acpi_attach_data(handle, acpi_gpio_chip_dh, acpi_gpio);
 	if (ACPI_FAILURE(status)) {
@@ -1195,20 +1201,28 @@ bool acpi_can_fallback_to_crs(struct acp
 	return con_id == NULL;
 }
 
-/* Sync the initial state of handlers after all builtin drivers have probed */
-static int acpi_gpio_initial_sync(void)
+/* Run deferred acpi_gpiochip_request_interrupts() */
+static int acpi_gpio_handle_deferred_request_interrupts(void)
 {
-	struct acpi_gpio_event *event, *ep;
+	struct acpi_gpio_chip *acpi_gpio, *tmp;
+
+	mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
+	list_for_each_entry_safe(acpi_gpio, tmp,
+				 &acpi_gpio_deferred_req_irqs_list,
+				 deferred_req_irqs_list_entry) {
+		acpi_handle handle;
 
-	mutex_lock(&acpi_gpio_initial_sync_list_lock);
-	list_for_each_entry_safe(event, ep, &acpi_gpio_initial_sync_list,
-				 initial_sync_list) {
-		acpi_evaluate_object(event->handle, NULL, NULL, NULL);
-		list_del_init(&event->initial_sync_list);
+		handle = ACPI_HANDLE(acpi_gpio->chip->parent);
+		acpi_walk_resources(handle, "_AEI",
+				    acpi_gpiochip_request_interrupt, acpi_gpio);
+
+		list_del_init(&acpi_gpio->deferred_req_irqs_list_entry);
 	}
-	mutex_unlock(&acpi_gpio_initial_sync_list_lock);
+
+	acpi_gpio_deferred_req_irqs_done = true;
+	mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
 
 	return 0;
 }
 /* We must use _sync so that this runs after the first deferred_probe run */
-late_initcall_sync(acpi_gpio_initial_sync);
+late_initcall_sync(acpi_gpio_handle_deferred_request_interrupts);


