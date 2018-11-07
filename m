Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE41C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708392086A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O2wMMMyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708392086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389360AbeKGKC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:02:29 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39932 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389026AbeKGKBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:01:18 -0500
Received: by mail-it1-f194.google.com with SMTP id m15so20446279itl.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 16:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gWkYzB4k4xq/XrsrsazkTNMqoBAgIRq8t035xK0VvbY=;
        b=O2wMMMyqCeyAZLetK3AQTp70pj8qUdxwvVkM/kE8HXtiNoeZhmr4RujpizoOYn0LKi
         gTsx9TiTm+DN8R/kif1wCoDnWsfLsgzXvPTM49YQgjxAKkrg8RARh0VPjfUJ7hHxJA4A
         L7+7+xoumdphMy6eSH5HkiWjJFJq8LIWqXWsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gWkYzB4k4xq/XrsrsazkTNMqoBAgIRq8t035xK0VvbY=;
        b=WmWtkNyTHBpv2DhjxRVCDA76F8dh2RVptvqJJr8zY8rPwJ1NgJIBrmQlbagNK1VDgu
         O2LXl91SMbPtT7kOkSgmlmLKDSm0iQOAKQc6KAvd2QD0fuOyQF0xYqGPeT5hYno6SWSA
         FEM++vpBkI4CIBR3KFGWU78YEWByu650wsm/Hu3MZ+Kvsdrcc4gPq8rUah7z0ZwyC3uw
         KtAmpWVS30R8cGfhWu+M1z5vIGFxt2/rMSknpLV51duRDcZIzW1y9kwkTpNzF32NQFv2
         kX8JrRRzb6bxH+xKUrK6l+4adm+N+h8vigtk+bUPJRtVICutsWedZL0m4OpiCSny3aWg
         QwnQ==
X-Gm-Message-State: AGRZ1gLzF+jon4j8tlzpGYzgEhRnSWnvZfuXZ6bLBL7vy2JRFZY8K70+
        8A3Sw4o7LK0odRx43IJsd4MKjg==
X-Google-Smtp-Source: AJdET5c1Qqs7SqIeiELJUmyRU+ynUy8eFCLiHIFCg1BebyNkXV1P/lnWppm8IcBeeTZnGKbxjorYbQ==
X-Received: by 2002:a24:9ac7:: with SMTP id l190-v6mr117486ite.178.1541550802613;
        Tue, 06 Nov 2018 16:33:22 -0800 (PST)
Received: from shibby.gateway.innflux.com ([66.228.239.218])
        by smtp.gmail.com with ESMTPSA id e184-v6sm1061128ite.9.2018.11.06.16.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 16:33:21 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        syadagir@codeaurora.org, mjavid@codeaurora.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: [RFC PATCH 05/12] soc: qcom: ipa: IPA interrupts and the microcontroller
Date:   Tue,  6 Nov 2018 18:32:43 -0600
Message-Id: <20181107003250.5832-6-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181107003250.5832-1-elder@linaro.org>
References: <20181107003250.5832-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPA has an interrupt line distinct from the interrupt used by
the GSI code.  Whereas GSI interrupts are generally related to
channel events (like transfer completions), IPA interrupts are
related to other events related to the IPA.  When the IPA IRQ fires,
an IPA interrupt status register indicates which IPA interrupt
events are being signaled.  IPA interrupts can be masked
independently, and can also be endependently enabled or disabled.

The IPA has an embedded microcontroller that can be used for
additional processing of messages passing through the IPA.  This
feature is generally not used by the current code.

Currently only three IPA interrupts are used:  one to trigger a
resume when in a suspended state; and two that allow the embedded
microcontroller to signal events.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_interrupts.c | 307 ++++++++++++++++++++++++++++
 drivers/net/ipa/ipa_uc.c         | 336 +++++++++++++++++++++++++++++++
 2 files changed, 643 insertions(+)
 create mode 100644 drivers/net/ipa/ipa_interrupts.c
 create mode 100644 drivers/net/ipa/ipa_uc.c

diff --git a/drivers/net/ipa/ipa_interrupts.c b/drivers/net/ipa/ipa_interrupts.c
new file mode 100644
index 000000000000..75cd81a1eab0
--- /dev/null
+++ b/drivers/net/ipa/ipa_interrupts.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2014-2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2018 Linaro Ltd.
+ */
+
+/*
+ * DOC: IPA Interrupts
+ *
+ * The IPA has an interrupt line distinct from the interrupt used
+ * by the GSI code.  Whereas GSI interrupts are generally related
+ * to channel events (like transfer completions), IPA interrupts are
+ * related to other events related to the IPA.  Some of the IPA
+ * interrupts come from a microcontroller embedded in the IPA.
+ * Each IPA interrupt type can be both masked and acknowledged
+ * independent of the others,
+ *
+ * So two of the IPA interrupts are initiated by the microcontroller.
+ * A third can be generated to signal the need for a wakeup/resume
+ * when the IPA has been suspended.  The modem can cause this event
+ * to occur (for example, for an incoming call).  There are other IPA
+ * events defined, but at this time only these three are supported.
+ */
+
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/workqueue.h>
+
+#include "ipa_i.h"
+#include "ipa_reg.h"
+
+struct ipa_interrupt_info {
+	ipa_irq_handler_t handler;
+	enum ipa_irq_type interrupt;
+};
+
+#define IPA_IRQ_NUM_MAX	32	/* Number of IRQ bits in IPA interrupt mask */
+static struct ipa_interrupt_info ipa_interrupt_info[IPA_IRQ_NUM_MAX];
+
+static struct workqueue_struct *ipa_interrupt_wq;
+
+static void enable_tx_suspend_work_func(struct work_struct *work);
+static DECLARE_DELAYED_WORK(tx_suspend_work, enable_tx_suspend_work_func);
+
+static const int ipa_irq_mapping[] = {
+	[IPA_INVALID_IRQ]		= -1,
+	[IPA_UC_IRQ_0]			= 2,
+	[IPA_UC_IRQ_1]			= 3,
+	[IPA_TX_SUSPEND_IRQ]		= 14,
+};
+
+/* IPA interrupt handlers are called in contexts that can block */
+static void ipa_interrupt_work_func(struct work_struct *work);
+static DECLARE_WORK(ipa_interrupt_work, ipa_interrupt_work_func);
+
+/* Workaround disables TX_SUSPEND interrupt for this long */
+#define DISABLE_TX_SUSPEND_INTR_DELAY	msecs_to_jiffies(5)
+
+/* Disable the IPA TX_SUSPEND interrupt, and arrange for it to be
+ * re-enabled again in 5 milliseconds.
+ *
+ * This is part of a hardware bug workaround.
+ */
+static void ipa_tx_suspend_interrupt_wa(void)
+{
+	u32 val;
+
+	val = ipa_read_reg_n(IPA_IRQ_EN_EE_N, IPA_EE_AP);
+	val &= ~BIT(ipa_irq_mapping[IPA_TX_SUSPEND_IRQ]);
+	ipa_write_reg_n(IPA_IRQ_EN_EE_N, IPA_EE_AP, val);
+
+	queue_delayed_work(ipa_interrupt_wq, &tx_suspend_work,
+			   DISABLE_TX_SUSPEND_INTR_DELAY);
+}
+
+static void ipa_handle_interrupt(int irq_num)
+{
+	struct ipa_interrupt_info *intr_info = &ipa_interrupt_info[irq_num];
+	u32 endpoints = 0;	/* Only TX_SUSPEND uses its interrupt_data */
+
+	if (!intr_info->handler)
+		return;
+
+	if (intr_info->interrupt == IPA_TX_SUSPEND_IRQ) {
+		/* Disable the suspend interrupt temporarily */
+		ipa_tx_suspend_interrupt_wa();
+
+		/* Get and clear mask of endpoints signaling TX_SUSPEND */
+		endpoints = ipa_read_reg_n(IPA_IRQ_SUSPEND_INFO_EE_N,
+					   IPA_EE_AP);
+		ipa_write_reg_n(IPA_SUSPEND_IRQ_CLR_EE_N, IPA_EE_AP, endpoints);
+	}
+
+	intr_info->handler(intr_info->interrupt, endpoints);
+}
+
+static inline bool is_uc_irq(int irq_num)
+{
+	enum ipa_irq_type interrupt = ipa_interrupt_info[irq_num].interrupt;
+
+	return interrupt != IPA_UC_IRQ_0 && interrupt != IPA_UC_IRQ_1;
+}
+
+static void ipa_process_interrupts(void)
+{
+	while (true) {
+		u32 ipa_intr_mask;
+		u32 imask;	/* one set bit */
+
+		/* Determine which interrupts have fired, then examine only
+		 * those that are enabled.  Note that a suspend interrupt
+		 * bug forces us to re-read the enabled mask every time to
+		 * avoid an endless loop.
+		 */
+		ipa_intr_mask = ipa_read_reg_n(IPA_IRQ_STTS_EE_N, IPA_EE_AP);
+		ipa_intr_mask &= ipa_read_reg_n(IPA_IRQ_EN_EE_N, IPA_EE_AP);
+
+		if (!ipa_intr_mask)
+			break;
+
+		do {
+			int i = __ffs(ipa_intr_mask);
+			bool uc_irq = is_uc_irq(i);
+
+			imask = BIT(i);
+
+			/* Clear uC interrupt before processing to avoid
+			 * clearing unhandled interrupts
+			 */
+			if (uc_irq)
+				ipa_write_reg_n(IPA_IRQ_CLR_EE_N, IPA_EE_AP,
+						imask);
+
+			ipa_handle_interrupt(i);
+
+			/* Clear non-uC interrupt after processing
+			 * to avoid clearing interrupt data
+			 */
+			if (!uc_irq)
+				ipa_write_reg_n(IPA_IRQ_CLR_EE_N, IPA_EE_AP,
+						imask);
+		} while ((ipa_intr_mask ^= imask));
+	}
+}
+
+static void ipa_interrupt_work_func(struct work_struct *work)
+{
+	ipa_client_add();
+
+	ipa_process_interrupts();
+
+	ipa_client_remove();
+}
+
+static irqreturn_t ipa_isr(int irq, void *ctxt)
+{
+	/* Schedule handling (if not already scheduled) */
+	queue_work(ipa_interrupt_wq, &ipa_interrupt_work);
+
+	return IRQ_HANDLED;
+}
+
+/* Re-enable the IPA TX_SUSPEND interrupt after having been disabled
+ * for a moment by ipa_tx_suspend_interrupt_wa().  This is part of a
+ * workaround for a hardware bug.
+ */
+static void enable_tx_suspend_work_func(struct work_struct *work)
+{
+	u32 val;
+
+	ipa_client_add();
+
+	val = ipa_read_reg_n(IPA_IRQ_EN_EE_N, IPA_EE_AP);
+	val |= BIT(ipa_irq_mapping[IPA_TX_SUSPEND_IRQ]);
+	ipa_write_reg_n(IPA_IRQ_EN_EE_N, IPA_EE_AP, val);
+
+	ipa_process_interrupts();
+
+	ipa_client_remove();
+}
+
+/* Register SUSPEND_IRQ_EN_EE_N_ADDR for L2 interrupt. */
+static void tx_suspend_enable(void)
+{
+	enum ipa_client_type client;
+	u32 val = ~0;
+
+	/* Compute the mask to use (bits set for all non-modem endpoints) */
+	for (client = 0; client < IPA_CLIENT_MAX; client++)
+		if (ipa_modem_consumer(client) || ipa_modem_producer(client))
+			val &= ~BIT(ipa_client_ep_id(client));
+
+	ipa_write_reg_n(IPA_SUSPEND_IRQ_EN_EE_N, IPA_EE_AP, val);
+}
+
+/* Unregister SUSPEND_IRQ_EN_EE_N_ADDR for L2 interrupt. */
+static void tx_suspend_disable(void)
+{
+	ipa_write_reg_n(IPA_SUSPEND_IRQ_EN_EE_N, IPA_EE_AP, 0);
+}
+
+/**
+ * ipa_add_interrupt_handler() - Adds handler for an IPA interrupt
+ * @interrupt:		IPA interrupt type
+ * @handler:		The handler for that interrupt
+ *
+ * Adds handler to an IPA interrupt type and enable it.  IPA interrupt
+ * handlers are allowed to block (they aren't run in interrupt context).
+ */
+void ipa_add_interrupt_handler(enum ipa_irq_type interrupt,
+			       ipa_irq_handler_t handler)
+{
+	int irq_num = ipa_irq_mapping[interrupt];
+	struct ipa_interrupt_info *intr_info;
+	u32 val;
+
+	intr_info = &ipa_interrupt_info[irq_num];
+	intr_info->handler = handler;
+	intr_info->interrupt = interrupt;
+
+	/* Enable the IPA interrupt */
+	val = ipa_read_reg_n(IPA_IRQ_EN_EE_N, IPA_EE_AP);
+	val |= BIT(irq_num);
+	ipa_write_reg_n(IPA_IRQ_EN_EE_N, IPA_EE_AP, val);
+
+	if (interrupt == IPA_TX_SUSPEND_IRQ)
+		tx_suspend_enable();
+}
+
+/**
+ * ipa_remove_interrupt_handler() - Removes handler for an IPA interrupt type
+ * @interrupt:		IPA interrupt type
+ *
+ * Remove an IPA interrupt handler and disable it.
+ */
+void ipa_remove_interrupt_handler(enum ipa_irq_type interrupt)
+{
+	int irq_num = ipa_irq_mapping[interrupt];
+	struct ipa_interrupt_info *intr_info;
+	u32 val;
+
+	intr_info = &ipa_interrupt_info[irq_num];
+	intr_info->handler = NULL;
+	intr_info->interrupt = IPA_INVALID_IRQ;
+
+	if (interrupt == IPA_TX_SUSPEND_IRQ)
+		tx_suspend_disable();
+
+	/* Disable the interrupt */
+	val = ipa_read_reg_n(IPA_IRQ_EN_EE_N, IPA_EE_AP);
+	val &= ~BIT(irq_num);
+	ipa_write_reg_n(IPA_IRQ_EN_EE_N, IPA_EE_AP, val);
+}
+
+/**
+ * ipa_interrupts_init() - Initialize the IPA interrupts framework
+ */
+int ipa_interrupts_init(void)
+{
+	int ret;
+
+	ret = request_irq(ipa_ctx->ipa_irq, ipa_isr, IRQF_TRIGGER_RISING,
+			  "ipa", ipa_ctx->dev);
+	if (ret)
+		return ret;
+
+	ipa_interrupt_wq = alloc_ordered_workqueue("ipa_interrupt_wq", 0);
+	if (ipa_interrupt_wq)
+		return 0;
+
+	free_irq(ipa_ctx->ipa_irq, ipa_ctx->dev);
+
+	return -ENOMEM;
+}
+
+/**
+ * ipa_suspend_active_aggr_wa() - Emulate suspend interrupt
+ * @ep_id:	Endpoint on which to emulate a suspend
+ *
+ *  Emulate suspend IRQ to unsuspend a client suspended with an open
+ *  aggregation frame.  This is to work around a hardware issue
+ *  where an IRQ is not generated as it should be when this occurs.
+ */
+void ipa_suspend_active_aggr_wa(u32 ep_id)
+{
+	struct ipa_reg_aggr_force_close force_close;
+	struct ipa_interrupt_info *intr_info;
+	u32 clnt_mask;
+	int irq_num;
+
+	irq_num = ipa_irq_mapping[IPA_TX_SUSPEND_IRQ];
+	intr_info = &ipa_interrupt_info[irq_num];
+	clnt_mask = BIT(ep_id);
+
+	/* Nothing to do if the endpoint doesn't have aggregation open */
+	if (!(ipa_read_reg(IPA_STATE_AGGR_ACTIVE) & clnt_mask))
+		return;
+
+	/* Force close aggregation */
+	ipa_reg_aggr_force_close(&force_close, clnt_mask);
+	ipa_write_reg_fields(IPA_AGGR_FORCE_CLOSE, &force_close);
+
+	/* Simulate suspend IRQ */
+	ipa_assert(!in_interrupt());
+	if (intr_info->handler)
+		intr_info->handler(intr_info->interrupt, clnt_mask);
+}
diff --git a/drivers/net/ipa/ipa_uc.c b/drivers/net/ipa/ipa_uc.c
new file mode 100644
index 000000000000..2065e53f3601
--- /dev/null
+++ b/drivers/net/ipa/ipa_uc.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2018 Linaro Ltd.
+ */
+
+#include <linux/types.h>
+#include <linux/delay.h>
+
+#include "ipa_i.h"
+
+/**
+ * DOC:  The IPA Embedded Microcontroller
+ *
+ * The IPA incorporates an embedded microcontroller that is able to
+ * do some additional handling/offloading of network activity.  The
+ * current code makes essentially no use of the microcontroller.
+ * Despite not being used, the microcontroller still requires some
+ * initialization, and it needs to be notified in the event the AP
+ * crashes.  The IPA embedded microcontroller represents another IPA
+ * execution environment (in addition to the AP subsystem and
+ * modem).
+ */
+
+/* Supports hardware interface version 0x2000 */
+
+#define IPA_RAM_UC_SMEM_SIZE	128	/* Size of shared memory area */
+
+/* Delay to allow a the microcontroller to save state when crashing */
+#define IPA_SEND_DELAY		100	/* microseconds */
+
+/*
+ * The IPA has an embedded microcontroller that is capable of doing
+ * more general-purpose processing, for example for handling certain
+ * exceptional conditions.  When it has completed its boot sequence
+ * it signals the AP with an interrupt.  At this time we don't use
+ * any of the microcontroller capabilities, but we do handle the
+ * "ready" interrupt.  We also notify it (by sending it a special
+ * command) in the event of a crash.
+ *
+ * A 128 byte block of structured memory within the IPA SRAM is used
+ * to communicate between the AP and the microcontroller embedded in
+ * the IPA.
+ *
+ * To send a command to the microcontroller, the AP fills in the
+ * command opcode and command parameter fields in this area, then
+ * writes a register to signal to the microcontroller the command is
+ * available.  When the microcontroller has executed the command, it
+ * writes response data to this shared area, then issues a response
+ * interrupt (micrcontroller IRQ 1) to the AP.  The response
+ * includes a "response operation" that indicates the completion,
+ * along with a "response parameter" which encodes the original
+ * command and the command's status (result).
+ *
+ * The shared area is also used to communicate events asynchronously
+ * from the microcontroller to the AP.  Events are signaled using
+ * the event interrupt (micrcontroller IRQ 0).  The microcontroller
+ * fills in an "event operation" and "event parameter" before
+ * triggering the interrupt.
+ *
+ * Some additional information is also found in this shared area,
+ * but is currently unused by the IPA driver.
+ *
+ * All other space in the shared area is reserved, and must not be
+ * read or written by the AP.
+ */
+
+/** struct ipa_uc_shared_area - AP/microcontroller shared memory area
+ *
+ * @command: command code (AP->microcontroller)
+ * @command_param: low 32 bits of command parameter (AP->microcontroller)
+ * @command_param_hi: high 32 bits of command parameter (AP->microcontroller)
+ *
+ * @response: response code (microcontroller->AP)
+ * @response_param: response parameter (microcontroller->AP)
+ *
+ * @event: event code (microcontroller->AP)
+ * @event_param: event parameter (microcontroller->AP)
+ *
+ * @first_error_address: address of first error-source on SNOC
+ * @hw_state: state of hardware (including error type information)
+ * @warning_counter: counter of non-fatal hardware errors
+ * @interface_version: hardware-reported interface version
+ */
+struct ipa_uc_shared_area {
+	u32 command		: 8;	/* enum ipa_uc_command */
+	/* 3 reserved bytes */
+	u32 command_param;
+	u32 command_param_hi;
+
+	u32 response		: 8; 	/* enum ipa_uc_response */
+	/* 3 reserved bytes */
+	u32 response_param;
+
+	u32 event		: 8;	/* enum ipa_uc_event */
+	/* 3 reserved bytes */
+	u32 event_param;
+
+	u32 first_error_address;
+	u32 hw_state		: 8,
+	    warning_counter	: 8,
+	    reserved		: 16;
+	u32 interface_version	: 16;
+	/* 2 reserved bytes */
+};
+
+/** struct ipa_uc_ctx - IPA microcontroller context
+ *
+ * @uc_loaded: whether microcontroller has been loaded
+ * @shared: pointer to AP/microcontroller shared memory area
+ */
+struct ipa_uc_ctx {
+	bool uc_loaded;
+	struct ipa_uc_shared_area *shared;
+} ipa_uc_ctx;
+
+/*
+ * Microcontroller event codes, error codes, commands, and responses
+ * to commands all encode both a "code" and a "feature" in their
+ * 8-bit numeric value.  The top 3 bits represent the feature, and
+ * the bottom 5 bits represent the code.  A "common" feature uses
+ * feature code 0, and at this time we only deal with common
+ * features.  Because of this we can just ignore the feature bits
+ * and define the values of symbols in  the following enumerated
+ * types by just their code values.
+ */
+
+/** enum ipa_uc_event - common cpu events (microcontroller->AP)
+ *
+ * @IPA_UC_EVENT_NO_OP: no event present
+ * @IPA_UC_EVENT_ERROR: system error has been detected
+ * @IPA_UC_EVENT_LOG_INFO: logging information available
+ */
+enum ipa_uc_event {
+	IPA_UC_EVENT_NO_OP     = 0,
+	IPA_UC_EVENT_ERROR     = 1,
+	IPA_UC_EVENT_LOG_INFO  = 2,
+};
+
+/** enum ipa_uc_error - common error types (microcontroller->AP)
+ *
+ * @IPA_UC_ERROR_NONE: no error
+ * @IPA_UC_ERROR_INVALID_DOORBELL: invalid data read from doorbell
+ * @IPA_UC_ERROR_DMA: unexpected DMA error
+ * @IPA_UC_ERROR_FATAL_SYSTEM: microcontroller has crashed and requires reset
+ * @IPA_UC_ERROR_INVALID_OPCODE: invalid opcode sent
+ * @IPA_UC_ERROR_INVALID_PARAMS: invalid params for the requested command
+ * @IPA_UC_ERROR_CONS_DISABLE_CMD_GSI_STOP: consumer endpoint stop failure
+ * @IPA_UC_ERROR_PROD_DISABLE_CMD_GSI_STOP: producer endpoint stop failure
+ * @IPA_UC_ERROR_CH_NOT_EMPTY: micrcontroller GSI channel is not empty
+ */
+enum ipa_uc_error {
+	IPA_UC_ERROR_NONE			= 0,
+	IPA_UC_ERROR_INVALID_DOORBELL		= 1,
+	IPA_UC_ERROR_DMA			= 2,
+	IPA_UC_ERROR_FATAL_SYSTEM		= 3,
+	IPA_UC_ERROR_INVALID_OPCODE		= 4,
+	IPA_UC_ERROR_INVALID_PARAMS		= 5,
+	IPA_UC_ERROR_CONS_DISABLE_CMD_GSI_STOP	= 6,
+	IPA_UC_ERROR_PROD_DISABLE_CMD_GSI_STOP	= 7,
+	IPA_UC_ERROR_CH_NOT_EMPTY		= 8,
+};
+
+/** enum ipa_uc_command - commands from the AP to the microcontroller
+ *
+ * @IPA_UC_COMMAND_NO_OP: no operation
+ * @IPA_UC_COMMAND_UPDATE_FLAGS: request to re-read configuration flags
+ * @IPA_UC_COMMAND_DEBUG_RUN_TEST: request to run hardware test
+ * @IPA_UC_COMMAND_DEBUG_GET_INFO: request to read internal debug information
+ * @IPA_UC_COMMAND_ERR_FATAL: AP system crash notification
+ * @IPA_UC_COMMAND_CLK_GATE: request hardware to enter clock gated state
+ * @IPA_UC_COMMAND_CLK_UNGATE: request hardware to enter clock ungated state
+ * @IPA_UC_COMMAND_MEMCPY: request hardware to perform memcpy
+ * @IPA_UC_COMMAND_RESET_PIPE: request endpoint reset
+ * @IPA_UC_COMMAND_REG_WRITE: request a register be written
+ * @IPA_UC_COMMAND_GSI_CH_EMPTY: request to determine whether channel is empty
+ */
+enum ipa_uc_command {
+	IPA_UC_COMMAND_NO_OP		= 0,
+	IPA_UC_COMMAND_UPDATE_FLAGS	= 1,
+	IPA_UC_COMMAND_DEBUG_RUN_TEST	= 2,
+	IPA_UC_COMMAND_DEBUG_GET_INFO	= 3,
+	IPA_UC_COMMAND_ERR_FATAL	= 4,
+	IPA_UC_COMMAND_CLK_GATE		= 5,
+	IPA_UC_COMMAND_CLK_UNGATE	= 6,
+	IPA_UC_COMMAND_MEMCPY		= 7,
+	IPA_UC_COMMAND_RESET_PIPE	= 8,
+	IPA_UC_COMMAND_REG_WRITE	= 9,
+	IPA_UC_COMMAND_GSI_CH_EMPTY	= 10,
+};
+
+/** enum ipa_uc_response - common hardware response codes
+ *
+ * @IPA_UC_RESPONSE_NO_OP: no operation
+ * @IPA_UC_RESPONSE_INIT_COMPLETED: microcontroller ready
+ * @IPA_UC_RESPONSE_CMD_COMPLETED: AP-issued command has completed
+ * @IPA_UC_RESPONSE_DEBUG_GET_INFO: get debug info
+ */
+enum ipa_uc_response {
+	IPA_UC_RESPONSE_NO_OP		= 0,
+	IPA_UC_RESPONSE_INIT_COMPLETED	= 1,
+	IPA_UC_RESPONSE_CMD_COMPLETED	= 2,
+	IPA_UC_RESPONSE_DEBUG_GET_INFO	= 3,
+};
+
+/** union ipa_uc_event_data - microcontroller->AP event data
+ *
+ * @error_type: ipa_uc_error error type value
+ * @raw32b: 32-bit register value (used when reading)
+ */
+union ipa_uc_event_data {
+	u8 error_type;	/* enum ipa_uc_error */
+	u32 raw32b;
+} __packed;
+
+/** union ipa_uc_response_data - response to AP command
+ *
+ * @command: the AP issued command this is responding to
+ * @status: 0 for success indication, otherwise failure
+ * @raw32b: 32-bit register value (used when reading)
+ */
+union ipa_uc_response_data {
+	struct ipa_uc_response_param {
+		u8 command;	/* enum ipa_uc_command */
+		u8 status;	/* enum ipa_uc_error */
+	} params;
+	u32 raw32b;
+} __packed;
+
+/** ipa_uc_loaded() - tell whether the microcontroller has been loaded
+ *
+ * Returns true if the microcontroller is loaded, false otherwise
+ */
+bool ipa_uc_loaded(void)
+{
+	return ipa_uc_ctx.uc_loaded;
+}
+
+static void
+ipa_uc_event_handler(enum ipa_irq_type interrupt, u32 interrupt_data)
+{
+	struct ipa_uc_shared_area *shared = ipa_uc_ctx.shared;
+	union ipa_uc_event_data event_param;
+	u8 event;
+
+	event = shared->event;
+	event_param.raw32b = shared->event_param;
+
+	/* General handling */
+	if (event == IPA_UC_EVENT_ERROR) {
+		ipa_err("uC error type 0x%02x timestamp 0x%08x\n",
+			event_param.error_type, ipa_read_reg(IPA_TAG_TIMER));
+		ipa_bug();
+	} else {
+		ipa_err("unsupported uC event opcode=%u\n", event);
+	}
+}
+
+static void
+ipa_uc_response_hdlr(enum ipa_irq_type interrupt, u32 interrupt_data)
+{
+	struct ipa_uc_shared_area *shared = ipa_uc_ctx.shared;
+	union ipa_uc_response_data response_data;
+	u8 response;
+
+	response = shared->response;
+
+	/* An INIT_COMPLETED response message is sent to the AP by
+	 * the microcontroller when it is operational.  Other than
+	 * this, the AP should only receive responses from the
+	 * microntroller when it has sent it a request message.
+	 */
+	if (response == IPA_UC_RESPONSE_INIT_COMPLETED) {
+		/* The proxy vote is held until uC is loaded to ensure that
+		 * IPA_HW_2_CPU_RESPONSE_INIT_COMPLETED is received.
+		 */
+		ipa_proxy_clk_unvote();
+		ipa_uc_ctx.uc_loaded = true;
+	} else if (response == IPA_UC_RESPONSE_CMD_COMPLETED) {
+		response_data.raw32b = shared->response_param;
+		ipa_err("uC command response code %u status %u\n",
+			response_data.params.command,
+			response_data.params.status);
+	} else {
+		ipa_err("Unsupported uC rsp opcode = %u\n", response);
+	}
+}
+
+/** ipa_uc_init() - Initialize the microcontroller
+ *
+ * Returns pointer to microcontroller context on success, NULL otherwise
+ */
+struct ipa_uc_ctx *ipa_uc_init(phys_addr_t phys_addr)
+{
+	phys_addr += ipa_reg_n_offset(IPA_SRAM_DIRECT_ACCESS_N, 0);
+	ipa_uc_ctx.shared = ioremap(phys_addr, IPA_RAM_UC_SMEM_SIZE);
+	if (!ipa_uc_ctx.shared)
+		return NULL;
+
+	ipa_add_interrupt_handler(IPA_UC_IRQ_0, ipa_uc_event_handler);
+	ipa_add_interrupt_handler(IPA_UC_IRQ_1, ipa_uc_response_hdlr);
+
+	return &ipa_uc_ctx;
+}
+
+/* Send a command to the microcontroller */
+static void send_uc_command(u32 command, u32 command_param)
+{
+	struct ipa_uc_shared_area *shared = ipa_uc_ctx.shared;
+
+	shared->command = command;
+	shared->command_param = command_param;
+	shared->command_param_hi = 0;
+	shared->response = 0;
+	shared->response_param = 0;
+
+	wmb();	/* ensure write to shared memory is done before triggering uc */
+
+	ipa_write_reg_n(IPA_IRQ_EE_UC_N, IPA_EE_AP, 0x1);
+}
+
+void ipa_uc_panic_notifier(void)
+{
+	if (!ipa_uc_ctx.uc_loaded)
+		return;
+
+	if (!ipa_client_add_additional())
+		return;
+
+	send_uc_command(IPA_UC_COMMAND_ERR_FATAL, 0);
+
+	/* give uc enough time to save state */
+	udelay(IPA_SEND_DELAY);
+
+	ipa_client_remove();
+}
-- 
2.17.1

