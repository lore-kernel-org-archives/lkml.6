Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2648C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0B62086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TdPPMs/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0B62086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388993AbeKGKBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:01:11 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42996 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388893AbeKGKBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:01:11 -0500
Received: by mail-io1-f67.google.com with SMTP id h19-v6so10684509iog.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 16:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x+IoJguFUHZzmlPmbMgOgMFeGPbHIdDyUWQqf7EjQBU=;
        b=TdPPMs/glep9fWKyGeF299MdA7WSnR9k7BqutKV8bq2TdcfXZVwta2TPVy3+DJj5Vq
         WZfVbOiEKBgj+Jz1gA+btfU0M6EyyxuPO2fru7dnd4N/LegnsRFYCjXDzECg/rBDbU4b
         ILMrfv3k6+jXFSg2NEF/jWmZMafBJfmTbaxzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x+IoJguFUHZzmlPmbMgOgMFeGPbHIdDyUWQqf7EjQBU=;
        b=jS8hmZsF82Ze7S+EgczlRcHhLJv5iYSwnYdthEtlbaiZHpfSnOhwV1xoeoxhLX5ORM
         b2qHI/6wgsJugSdVSsBASLQlEBlJ+lJlLGJVJvPInvGhVXf86m95/7qiPyaIW6s2wJpZ
         g6eeX4nUdnJ24RINQwio8joZLSggxEbt35pqreDuPknzgkMRraCY2+lajcHPmcrVp4IZ
         NmrQ1rdw3mMtrI5q4jeIq0p7mQ5LggKwCnah7bUXyFzGkUqNDyeAnEI/J5UWEQiS6lf7
         EEij/xopv97Uq0uhMf4aSQXhtkJZnpVL3hAvI7wSARzkAyiMGnQyYr0BXcoxRwF3Ab+t
         Gljw==
X-Gm-Message-State: AGRZ1gJUFXgv8/1rWxDrG5+c044haUg6kxk4tC+9yRVypeAQ555uy/0B
        h3yCIFjdOXxKvEyy9WoBrHJ2tA==
X-Google-Smtp-Source: AJdET5cuwQPTLKnHTev7ISrf4e7f3aA4RIgFWLy6XHACckT7CSZysF5YIs49jteB1TtzTYwU64Vx8A==
X-Received: by 2002:a6b:b450:: with SMTP id d77-v6mr23544093iof.15.1541550792807;
        Tue, 06 Nov 2018 16:33:12 -0800 (PST)
Received: from shibby.gateway.innflux.com ([66.228.239.218])
        by smtp.gmail.com with ESMTPSA id e184-v6sm1061128ite.9.2018.11.06.16.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 16:33:12 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        syadagir@codeaurora.org, mjavid@codeaurora.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: [RFC PATCH 03/12] soc: qcom: ipa: generic software interface
Date:   Tue,  6 Nov 2018 18:32:41 -0600
Message-Id: <20181107003250.5832-4-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181107003250.5832-1-elder@linaro.org>
References: <20181107003250.5832-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the code supporting the Generic Software
Interface (GSI) used by the IPA.  Although the GSI is an integral
part of the IPA, it provides a well-defined layer between the AP
subsystem (or, for that matter, the modem) and the IPA core.

The GSI code presents an abstract interface through which commands
and data transfers can be queued to be implemented on a channel.  A
hardware independent gsi_xfer_elem structure describes a single
transfer, and an array of these can be queued on a channel.  The
information in the gsi_xfer_elem is converted by the GSI layer into
the specific layout required by the hardware.

A channel has an associated event ring, through which completion of
channel commands can be signaled.  GSI channel commands are completed
in order, and may optionally generate an interrupt on completion.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c     | 1685 +++++++++++++++++++++++++++++++++++++
 drivers/net/ipa/gsi.h     |  195 +++++
 drivers/net/ipa/gsi_reg.h |  563 +++++++++++++
 3 files changed, 2443 insertions(+)
 create mode 100644 drivers/net/ipa/gsi.c
 create mode 100644 drivers/net/ipa/gsi.h
 create mode 100644 drivers/net/ipa/gsi_reg.h

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
new file mode 100644
index 000000000000..348ee1fc1bf5
--- /dev/null
+++ b/drivers/net/ipa/gsi.c
@@ -0,0 +1,1685 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2018 Linaro Ltd.
+ */
+
+#include <linux/types.h>
+#include <linux/bitops.h>
+#include <linux/log2.h>
+#include <linux/bitfield.h>
+#include <linux/atomic.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/completion.h>
+#include <linux/jiffies.h>
+#include <linux/string.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/bug.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+
+#include "gsi.h"
+#include "gsi_reg.h"
+#include "ipa_dma.h"
+#include "ipa_i.h"	/* ipa_err() */
+
+/**
+ * DOC: The Role of GSI in IPA Operation
+ *
+ * The generic software interface (GSI) is an integral component of
+ * the IPA, providing a well-defined layer between the AP subsystem
+ * (or, for that matter, the modem) and the IPA core::
+ *
+ *  ----------   -------------   ---------
+ *  |        |   |G|       |G|   |       |
+ *  |  APSS  |===|S|  IPA  |S|===| Modem |
+ *  |        |   |I|       |I|   |       |
+ *  ----------   -------------   ---------
+ *
+ * In the above diagram, the APSS and Modem represent "execution
+ * environments" (EEs), which are independent operating environments
+ * that use the IPA for data transfer.
+ *
+ * Each EE uses a set of unidirectional GSI "channels," which allow
+ * transfer of data to or from the IPA.  A channel is implemented as a
+ * ring buffer, with a DRAM-resident array of "transfer elements" (TREs)
+ * available to describe transfers to or from other EEs through the IPA.
+ * A transfer element can also contain an immediate command, requesting
+ * the IPA perform actions other than data transfer.
+ *
+ * Each transfer element refers to a block of data--also located DRAM.
+ * After writing one or more TREs to a channel, the writer (either the
+ * IPA or an EE) writes a doorbell register to inform the receiving side
+ * how many elements have been written.  Writing to a doorbell register
+ * triggers an interrupt on the receiver.
+ *
+ * Each channel has a GSI "event ring" associated with it.  An event
+ * ring is implemented very much like a channel ring, but is always
+ * directed from the IPA to an EE.  The IPA notifies an EE (such as
+ * the AP) about channel events by adding an entry to the event ring
+ * associated with the channel; when it writes the event ring's
+ * doorbell register the EE will be interrupted.
+ *
+ * A transfer element has a set of flags.  One flag indicates whether
+ * the completion of the transfer operation generates a channel event.
+ * Another flag allows transfer elements to be chained together,
+ * forming a single logical transaction.  These flags are used to
+ * control whether and when interrupts are generated to signal
+ * completion of a channel transfer.
+ *
+ * Elements in channel and event rings are completed (or consumed)
+ * strictly in order.  Completion of one entry implies the completion
+ * of all preceding entries.  A single completion interrupt can
+ * therefore be used to communicate the completion of many transfers.
+ */
+
+#define GSI_RING_ELEMENT_SIZE	16	/* bytes (channel or event ring) */
+
+#define GSI_CHAN_MAX		14
+#define GSI_EVT_RING_MAX	10
+
+/* Delay period if interrupt moderation is in effect */
+#define IPA_GSI_EVT_RING_INT_MODT	(32 * 1) /* 1ms under 32KHz clock */
+
+#define GSI_CMD_TIMEOUT		msecs_to_jiffies(5 * MSEC_PER_SEC)
+
+#define GSI_MHI_ER_START	10	/* First reserved event number */
+#define GSI_MHI_ER_END		16	/* Last reserved event number */
+
+#define GSI_RESET_WA_MIN_SLEEP	1000	/* microseconds */
+#define GSI_RESET_WA_MAX_SLEEP	2000	/* microseconds */
+
+#define GSI_MAX_PREFETCH	0	/* 0 means 1 segment; 1 means 2 */
+
+#define GSI_ISR_MAX_ITER	50
+
+/* Hardware values from the error log register code field */
+enum gsi_err_code {
+	GSI_INVALID_TRE_ERR			= 0x1,
+	GSI_OUT_OF_BUFFERS_ERR			= 0x2,
+	GSI_OUT_OF_RESOURCES_ERR		= 0x3,
+	GSI_UNSUPPORTED_INTER_EE_OP_ERR		= 0x4,
+	GSI_EVT_RING_EMPTY_ERR			= 0x5,
+	GSI_NON_ALLOCATED_EVT_ACCESS_ERR	= 0x6,
+	GSI_HWO_1_ERR				= 0x8,
+};
+
+/* Hardware values used when programming an event ring context */
+enum gsi_evt_chtype {
+	GSI_EVT_CHTYPE_MHI_EV	= 0x0,
+	GSI_EVT_CHTYPE_XHCI_EV	= 0x1,
+	GSI_EVT_CHTYPE_GPI_EV	= 0x2,
+	GSI_EVT_CHTYPE_XDCI_EV	= 0x3,
+};
+
+/* Hardware values used when programming a channel context */
+enum gsi_channel_protocol {
+	GSI_CHANNEL_PROTOCOL_MHI	= 0x0,
+	GSI_CHANNEL_PROTOCOL_XHCI	= 0x1,
+	GSI_CHANNEL_PROTOCOL_GPI	= 0x2,
+	GSI_CHANNEL_PROTOCOL_XDCI	= 0x3,
+};
+
+/* Hardware values returned in a transfer completion event structure */
+enum gsi_channel_evt {
+	GSI_CHANNEL_EVT_INVALID		= 0x0,
+	GSI_CHANNEL_EVT_SUCCESS		= 0x1,
+	GSI_CHANNEL_EVT_EOT		= 0x2,
+	GSI_CHANNEL_EVT_OVERFLOW	= 0x3,
+	GSI_CHANNEL_EVT_EOB		= 0x4,
+	GSI_CHANNEL_EVT_OOB		= 0x5,
+	GSI_CHANNEL_EVT_DB_MODE		= 0x6,
+	GSI_CHANNEL_EVT_UNDEFINED	= 0x10,
+	GSI_CHANNEL_EVT_RE_ERROR	= 0x11,
+};
+
+/* Hardware values signifying the state of an event ring */
+enum gsi_evt_ring_state {
+	GSI_EVT_RING_STATE_NOT_ALLOCATED	= 0x0,
+	GSI_EVT_RING_STATE_ALLOCATED		= 0x1,
+	GSI_EVT_RING_STATE_ERROR		= 0xf,
+};
+
+/* Hardware values signifying the state of a channel */
+enum gsi_channel_state {
+	GSI_CHANNEL_STATE_NOT_ALLOCATED	= 0x0,
+	GSI_CHANNEL_STATE_ALLOCATED	= 0x1,
+	GSI_CHANNEL_STATE_STARTED	= 0x2,
+	GSI_CHANNEL_STATE_STOPPED	= 0x3,
+	GSI_CHANNEL_STATE_STOP_IN_PROC	= 0x4,
+	GSI_CHANNEL_STATE_ERROR		= 0xf,
+};
+
+struct gsi_ring {
+	spinlock_t slock;		/* protects wp, rp updates */
+	struct ipa_dma_mem mem;
+	u64 wp;
+	u64 rp;
+	u64 wp_local;
+	u64 rp_local;
+	u64 end;			/* physical addr past last element */
+};
+
+struct gsi_channel {
+	bool from_ipa;			/* true: IPA->AP; false: AP->IPA */
+	bool priority;		/* Does hardware give this channel priority? */
+	enum gsi_channel_state state;
+	struct gsi_ring ring;
+	void *notify_data;
+	void **user_data;
+	struct gsi_evt_ring *evt_ring;
+	struct mutex mutex;		/* protects channel_scratch updates */
+	struct completion compl;
+	atomic_t poll_mode;
+	u32 tlv_count;			/* # slots in TLV */
+};
+
+struct gsi_evt_ring {
+	bool moderation;
+	enum gsi_evt_ring_state state;
+	struct gsi_ring ring;
+	struct completion compl;
+	struct gsi_channel *channel;
+};
+
+struct ch_debug_stats {
+	unsigned long ch_allocate;
+	unsigned long ch_start;
+	unsigned long ch_stop;
+	unsigned long ch_reset;
+	unsigned long ch_de_alloc;
+	unsigned long ch_db_stop;
+	unsigned long cmd_completed;
+};
+
+struct gsi {
+	void __iomem *base;
+	struct device *dev;
+	u32 phys;
+	unsigned int irq;
+	bool irq_wake_enabled;
+	spinlock_t slock;	/* protects global register updates */
+	struct mutex mutex;	/* protects 1-at-a-time commands, evt_bmap */
+	atomic_t channel_count;
+	atomic_t evt_ring_count;
+	struct gsi_channel channel[GSI_CHAN_MAX];
+	struct ch_debug_stats ch_dbg[GSI_CHAN_MAX];
+	struct gsi_evt_ring evt_ring[GSI_EVT_RING_MAX];
+	unsigned long evt_bmap;
+	u32 channel_max;
+	u32 evt_ring_max;
+};
+
+/* Hardware values representing a transfer element type */
+enum gsi_re_type {
+	GSI_RE_XFER	= 0x2,
+	GSI_RE_IMMD_CMD	= 0x3,
+	GSI_RE_NOP	= 0x4,
+};
+
+struct gsi_tre {
+	u64 buffer_ptr;
+	u16 buf_len;
+	u16 rsvd1;
+	u8  chain	: 1,
+	    rsvd4	: 7;
+	u8  ieob	: 1,
+	    ieot	: 1,
+	    bei		: 1,
+	    rsvd3	: 5;
+	u8 re_type;
+	u8 rsvd2;
+} __packed;
+
+struct gsi_xfer_compl_evt {
+	u64 xfer_ptr;
+	u16 len;
+	u8 rsvd1;
+	u8 code;  /* see gsi_channel_evt */
+	u16 rsvd;
+	u8 type;
+	u8 chid;
+} __packed;
+
+/* Hardware values from the error log register error type field */
+enum gsi_err_type {
+	GSI_ERR_TYPE_GLOB	= 0x1,
+	GSI_ERR_TYPE_CHAN	= 0x2,
+	GSI_ERR_TYPE_EVT	= 0x3,
+};
+
+struct gsi_log_err {
+	u8  arg3	: 4,
+	    arg2	: 4;
+	u8  arg1	: 4,
+	    code	: 4;
+	u8  rsvd	: 3,
+	    virt_idx	: 5;
+	u8  err_type	: 4,
+	    ee		: 4;
+} __packed;
+
+/* Hardware values repreasenting a channel immediate command opcode */
+enum gsi_ch_cmd_opcode {
+	GSI_CH_ALLOCATE	= 0x0,
+	GSI_CH_START	= 0x1,
+	GSI_CH_STOP	= 0x2,
+	GSI_CH_RESET	= 0x9,
+	GSI_CH_DE_ALLOC	= 0xa,
+	GSI_CH_DB_STOP	= 0xb,
+};
+
+/* Hardware values repreasenting an event ring immediate command opcode */
+enum gsi_evt_ch_cmd_opcode {
+	GSI_EVT_ALLOCATE	= 0x0,
+	GSI_EVT_RESET		= 0x9,
+	GSI_EVT_DE_ALLOC	= 0xa,
+};
+
+/** gsi_gpi_channel_scratch - GPI protocol SW config area of channel scratch
+ *
+ * @max_outstanding_tre: Used for the prefetch management sequence by the
+ *			 sequencer. Defines the maximum number of allowed
+ *			 outstanding TREs in IPA/GSI (in Bytes). RE engine
+ *			 prefetch will be limited by this configuration. It
+ *			 is suggested to configure this value to IPA_IF
+ *			 channel TLV queue size times element size. To disable
+ *			 the feature in doorbell mode (DB Mode=1). Maximum
+ *			 outstanding TREs should be set to 64KB
+ *			 (or any value larger or equal to ring length . RLEN)
+ * @outstanding_threshold: Used for the prefetch management sequence by the
+ *			 sequencer. Defines the threshold (in Bytes) as to when
+ *			 to update the channel doorbell. Should be smaller than
+ *			 Maximum outstanding TREs. value. It is suggested to
+ *			 configure this value to 2 * element size.
+ */
+struct gsi_gpi_channel_scratch {
+	u64 rsvd1;
+	u16 rsvd2;
+	u16 max_outstanding_tre;
+	u16 rsvd3;
+	u16 outstanding_threshold;
+} __packed;
+
+/** gsi_channel_scratch - channel scratch SW config area */
+union gsi_channel_scratch {
+	struct gsi_gpi_channel_scratch gpi;
+	struct {
+		u32 word1;
+		u32 word2;
+		u32 word3;
+		u32 word4;
+	} data;
+} __packed;
+
+/* Read a value from the given offset into the I/O space defined in
+ * the GSI context.
+ */
+static u32 gsi_readl(struct gsi *gsi, u32 offset)
+{
+	return readl(gsi->base + offset);
+}
+
+/* Write the provided value to the given offset into the I/O space
+ * defined in the GSI context.
+ */
+static void gsi_writel(struct gsi *gsi, u32 v, u32 offset)
+{
+	writel(v, gsi->base + offset);
+}
+
+static void
+_gsi_irq_control_event(struct gsi *gsi, u32 evt_ring_id, bool enable)
+{
+	u32 mask = BIT(evt_ring_id);
+	u32 val;
+
+	val = gsi_readl(gsi, GSI_CNTXT_SRC_IEOB_IRQ_MSK_OFFS);
+	if (enable)
+		val |= mask;
+	else
+		val &= ~mask;
+	gsi_writel(gsi, val, GSI_CNTXT_SRC_IEOB_IRQ_MSK_OFFS);
+}
+
+static void gsi_irq_disable_event(struct gsi *gsi, u32 evt_ring_id)
+{
+	_gsi_irq_control_event(gsi, evt_ring_id, false);
+}
+
+static void gsi_irq_enable_event(struct gsi *gsi, u32 evt_ring_id)
+{
+	_gsi_irq_control_event(gsi, evt_ring_id, true);
+}
+
+static void _gsi_irq_control_all(struct gsi *gsi, bool enable)
+{
+	u32 val = enable ? ~0 : 0;
+
+	/* Inter EE commands / interrupt are no supported. */
+	gsi_writel(gsi, val, GSI_CNTXT_TYPE_IRQ_MSK_OFFS);
+	gsi_writel(gsi, val, GSI_CNTXT_SRC_CH_IRQ_MSK_OFFS);
+	gsi_writel(gsi, val, GSI_CNTXT_SRC_EV_CH_IRQ_MSK_OFFS);
+	gsi_writel(gsi, val, GSI_CNTXT_SRC_IEOB_IRQ_MSK_OFFS);
+	gsi_writel(gsi, val, GSI_CNTXT_GLOB_IRQ_EN_OFFS);
+	/* Never enable GSI_BREAK_POINT */
+	val &= ~FIELD_PREP(EN_BREAK_POINT_FMASK, 1);
+	gsi_writel(gsi, val, GSI_CNTXT_GSI_IRQ_EN_OFFS);
+}
+
+static void gsi_irq_disable_all(struct gsi *gsi)
+{
+	_gsi_irq_control_all(gsi, false);
+}
+
+static void gsi_irq_enable_all(struct gsi *gsi)
+{
+	_gsi_irq_control_all(gsi, true);
+}
+
+static u32 gsi_channel_id(struct gsi *gsi, struct gsi_channel *channel)
+{
+	return (u32)(channel - &gsi->channel[0]);
+}
+
+static u32 gsi_evt_ring_id(struct gsi *gsi, struct gsi_evt_ring *evt_ring)
+{
+	return (u32)(evt_ring - &gsi->evt_ring[0]);
+}
+
+static enum gsi_channel_state gsi_channel_state(struct gsi *gsi, u32 channel_id)
+{
+	u32 val = gsi_readl(gsi, GSI_CH_C_CNTXT_0_OFFS(channel_id));
+
+	return (enum gsi_channel_state)FIELD_GET(CHSTATE_FMASK, val);
+}
+
+static enum gsi_evt_ring_state
+gsi_evt_ring_state(struct gsi *gsi, u32 evt_ring_id)
+{
+	u32 val = gsi_readl(gsi, GSI_EV_CH_E_CNTXT_0_OFFS(evt_ring_id));
+
+	return (enum gsi_evt_ring_state)FIELD_GET(EV_CHSTATE_FMASK, val);
+}
+
+static void gsi_isr_chan_ctrl(struct gsi *gsi)
+{
+	u32 channel_mask;
+
+	channel_mask = gsi_readl(gsi, GSI_CNTXT_SRC_CH_IRQ_OFFS);
+	gsi_writel(gsi, channel_mask, GSI_CNTXT_SRC_CH_IRQ_CLR_OFFS);
+
+	ipa_assert(!(channel_mask & ~GENMASK(gsi->channel_max - 1, 0)));
+
+	while (channel_mask) {
+		struct gsi_channel *channel;
+		int i = __ffs(channel_mask);
+
+		channel = &gsi->channel[i];
+		channel->state = gsi_channel_state(gsi, i);
+
+		complete(&channel->compl);
+
+		channel_mask ^= BIT(i);
+	}
+}
+
+static void gsi_isr_evt_ctrl(struct gsi *gsi)
+{
+	u32 evt_mask;
+
+	evt_mask = gsi_readl(gsi, GSI_CNTXT_SRC_EV_CH_IRQ_OFFS);
+	gsi_writel(gsi, evt_mask, GSI_CNTXT_SRC_EV_CH_IRQ_CLR_OFFS);
+
+	ipa_assert(!(evt_mask & ~GENMASK(gsi->evt_ring_max - 1, 0)));
+
+	while (evt_mask) {
+		struct gsi_evt_ring *evt_ring;
+		int i = __ffs(evt_mask);
+
+		evt_ring = &gsi->evt_ring[i];
+		evt_ring->state = gsi_evt_ring_state(gsi, i);
+
+		complete(&evt_ring->compl);
+
+		evt_mask ^= BIT(i);
+	}
+}
+
+static void
+gsi_isr_glob_chan_err(struct gsi *gsi, u32 err_ee, u32 channel_id, u32 code)
+{
+	struct gsi_channel *channel = &gsi->channel[channel_id];
+
+	if (err_ee != IPA_EE_AP)
+		ipa_bug_on(code != GSI_UNSUPPORTED_INTER_EE_OP_ERR);
+
+	if (WARN_ON(channel_id >= gsi->channel_max)) {
+		ipa_err("unexpected channel_id %u\n", channel_id);
+		return;
+	}
+
+	switch (code) {
+	case GSI_INVALID_TRE_ERR:
+		ipa_err("got INVALID_TRE_ERR\n");
+		channel->state = gsi_channel_state(gsi, channel_id);
+		ipa_bug_on(channel->state != GSI_CHANNEL_STATE_ERROR);
+		break;
+	case GSI_OUT_OF_BUFFERS_ERR:
+		ipa_err("got OUT_OF_BUFFERS_ERR\n");
+		break;
+	case GSI_OUT_OF_RESOURCES_ERR:
+		ipa_err("got OUT_OF_RESOURCES_ERR\n");
+		complete(&channel->compl);
+		break;
+	case GSI_UNSUPPORTED_INTER_EE_OP_ERR:
+		ipa_err("got UNSUPPORTED_INTER_EE_OP_ERR\n");
+		break;
+	case GSI_NON_ALLOCATED_EVT_ACCESS_ERR:
+		ipa_err("got NON_ALLOCATED_EVT_ACCESS_ERR\n");
+		break;
+	case GSI_HWO_1_ERR:
+		ipa_err("got HWO_1_ERR\n");
+		break;
+	default:
+		ipa_err("unexpected channel error code %u\n", code);
+		ipa_bug();
+	}
+}
+
+static void
+gsi_isr_glob_evt_err(struct gsi *gsi, u32 err_ee, u32 evt_ring_id, u32 code)
+{
+	struct gsi_evt_ring *evt_ring = &gsi->evt_ring[evt_ring_id];
+
+	if (err_ee != IPA_EE_AP)
+		ipa_bug_on(code != GSI_UNSUPPORTED_INTER_EE_OP_ERR);
+
+	if (WARN_ON(evt_ring_id >= gsi->evt_ring_max)) {
+		ipa_err("unexpected evt_ring_id %u\n", evt_ring_id);
+		return;
+	}
+
+	switch (code) {
+	case GSI_OUT_OF_BUFFERS_ERR:
+		ipa_err("got OUT_OF_BUFFERS_ERR\n");
+		break;
+	case GSI_OUT_OF_RESOURCES_ERR:
+		ipa_err("got OUT_OF_RESOURCES_ERR\n");
+		complete(&evt_ring->compl);
+		break;
+	case GSI_UNSUPPORTED_INTER_EE_OP_ERR:
+		ipa_err("got UNSUPPORTED_INTER_EE_OP_ERR\n");
+		break;
+	case GSI_EVT_RING_EMPTY_ERR:
+		ipa_err("got EVT_RING_EMPTY_ERR\n");
+		break;
+	default:
+		ipa_err("unexpected event error code %u\n", code);
+		ipa_bug();
+	}
+}
+
+static void gsi_isr_glob_err(struct gsi *gsi, u32 err)
+{
+	struct gsi_log_err *log = (struct gsi_log_err *)&err;
+
+	ipa_err("log err_type %u ee %u idx %u\n", log->err_type, log->ee,
+		log->virt_idx);
+	ipa_err("log code 0x%1x arg1 0x%1x arg2 0x%1x arg3 0x%1x\n", log->code,
+		log->arg1, log->arg2, log->arg3);
+
+	ipa_bug_on(log->err_type == GSI_ERR_TYPE_GLOB);
+
+	switch (log->err_type) {
+	case GSI_ERR_TYPE_CHAN:
+		gsi_isr_glob_chan_err(gsi, log->ee, log->virt_idx, log->code);
+		break;
+	case GSI_ERR_TYPE_EVT:
+		gsi_isr_glob_evt_err(gsi, log->ee, log->virt_idx, log->code);
+		break;
+	default:
+		WARN_ON(1);
+	}
+}
+
+static void gsi_isr_glob_ee(struct gsi *gsi)
+{
+	u32 val;
+
+	val = gsi_readl(gsi, GSI_CNTXT_GLOB_IRQ_STTS_OFFS);
+
+	if (val & ERROR_INT_FMASK) {
+		u32 err = gsi_readl(gsi, GSI_ERROR_LOG_OFFS);
+
+		gsi_writel(gsi, 0, GSI_ERROR_LOG_OFFS);
+		gsi_writel(gsi, ~0, GSI_ERROR_LOG_CLR_OFFS);
+
+		gsi_isr_glob_err(gsi, err);
+	}
+
+	if (val & EN_GP_INT1_FMASK)
+		ipa_err("unexpected GP INT1 received\n");
+
+	ipa_bug_on(val & EN_GP_INT2_FMASK);
+	ipa_bug_on(val & EN_GP_INT3_FMASK);
+
+	gsi_writel(gsi, val, GSI_CNTXT_GLOB_IRQ_CLR_OFFS);
+}
+
+static void ring_wp_local_inc(struct gsi_ring *ring)
+{
+	ring->wp_local += GSI_RING_ELEMENT_SIZE;
+	if (ring->wp_local == ring->end)
+		ring->wp_local = ring->mem.phys;
+}
+
+static void ring_rp_local_inc(struct gsi_ring *ring)
+{
+	ring->rp_local += GSI_RING_ELEMENT_SIZE;
+	if (ring->rp_local == ring->end)
+		ring->rp_local = ring->mem.phys;
+}
+
+static u16 ring_rp_local_index(struct gsi_ring *ring)
+{
+	return (u16)(ring->rp_local - ring->mem.phys) / GSI_RING_ELEMENT_SIZE;
+}
+
+static u16 ring_wp_local_index(struct gsi_ring *ring)
+{
+	return (u16)(ring->wp_local - ring->mem.phys) / GSI_RING_ELEMENT_SIZE;
+}
+
+static void channel_xfer_cb(struct gsi_channel *channel, u16 count)
+{
+	void *xfer_data;
+
+	if (!channel->from_ipa) {
+		u16 ring_rp_local = ring_rp_local_index(&channel->ring);
+
+		xfer_data = channel->user_data[ring_rp_local];;
+		ipa_gsi_irq_tx_notify_cb(xfer_data);
+	} else {
+		ipa_gsi_irq_rx_notify_cb(channel->notify_data, count);
+	}
+}
+
+static u16 gsi_channel_process(struct gsi *gsi, struct gsi_xfer_compl_evt *evt,
+			       bool callback)
+{
+	struct gsi_channel *channel;
+	u32 channel_id = (u32)evt->chid;
+
+	ipa_assert(channel_id < gsi->channel_max);
+
+	/* Event tells us the last completed channel ring element */
+	channel = &gsi->channel[channel_id];
+	channel->ring.rp_local = evt->xfer_ptr;
+
+	if (callback) {
+		if (evt->code == GSI_CHANNEL_EVT_EOT)
+			channel_xfer_cb(channel, evt->len);
+		else
+			ipa_err("ch %u unexpected %sX event id %hhu\n",
+				channel_id, channel->from_ipa ? "R" : "T",
+				evt->code);
+	}
+
+	/* Record that we've processed this channel ring element. */
+	ring_rp_local_inc(&channel->ring);
+	channel->ring.rp = channel->ring.rp_local;
+
+	return evt->len;
+}
+
+static void
+gsi_evt_ring_doorbell(struct gsi *gsi, struct gsi_evt_ring *evt_ring)
+{
+	u32 evt_ring_id = gsi_evt_ring_id(gsi, evt_ring);
+	u32 val;
+
+	/* The doorbell 0 and 1 registers store the low-order and
+	 * high-order 32 bits of the event ring doorbell register,
+	 * respectively.  LSB (doorbell 0) must be written last.
+	 */
+	val = evt_ring->ring.wp_local >> 32;
+	gsi_writel(gsi, val, GSI_EV_CH_E_DOORBELL_1_OFFS(evt_ring_id));
+
+	val = evt_ring->ring.wp_local & GENMASK(31, 0);
+	gsi_writel(gsi, val, GSI_EV_CH_E_DOORBELL_0_OFFS(evt_ring_id));
+}
+
+static void gsi_channel_doorbell(struct gsi *gsi, struct gsi_channel *channel)
+{
+	u32 channel_id = gsi_channel_id(gsi, channel);
+	u32 val;
+
+	/* allocate new events for this channel first
+	 * before submitting the new TREs.
+	 * for TO_GSI channels the event ring doorbell is rang as part of
+	 * interrupt handling.
+	 */
+	if (channel->from_ipa)
+		gsi_evt_ring_doorbell(gsi, channel->evt_ring);
+	channel->ring.wp = channel->ring.wp_local;
+
+	/* The doorbell 0 and 1 registers store the low-order and
+	 * high-order 32 bits of the channel ring doorbell register,
+	 * respectively.  LSB (doorbell 0) must be written last.
+	 */
+	val = channel->ring.wp_local >> 32;
+	gsi_writel(gsi, val, GSI_CH_C_DOORBELL_1_OFFS(channel_id));
+	val = channel->ring.wp_local & GENMASK(31, 0);
+	gsi_writel(gsi, val, GSI_CH_C_DOORBELL_0_OFFS(channel_id));
+}
+
+static void gsi_event_handle(struct gsi *gsi, u32 evt_ring_id)
+{
+	struct gsi_evt_ring *evt_ring = &gsi->evt_ring[evt_ring_id];
+	unsigned long flags;
+	bool check_again;
+
+	spin_lock_irqsave(&evt_ring->ring.slock, flags);
+
+	do {
+		u32 val = gsi_readl(gsi, GSI_EV_CH_E_CNTXT_4_OFFS(evt_ring_id));
+
+		evt_ring->ring.rp = evt_ring->ring.rp & GENMASK_ULL(63, 32);
+		evt_ring->ring.rp |= val;
+
+		check_again = false;
+		while (evt_ring->ring.rp_local != evt_ring->ring.rp) {
+			struct gsi_xfer_compl_evt *evt;
+
+			if (atomic_read(&evt_ring->channel->poll_mode)) {
+				check_again = false;
+				break;
+			}
+			check_again = true;
+
+			evt = ipa_dma_phys_to_virt(&evt_ring->ring.mem,
+						   evt_ring->ring.rp_local);
+			(void)gsi_channel_process(gsi, evt, true);
+
+			ring_rp_local_inc(&evt_ring->ring);
+			ring_wp_local_inc(&evt_ring->ring); /* recycle */
+		}
+
+		gsi_evt_ring_doorbell(gsi, evt_ring);
+	} while (check_again);
+
+	spin_unlock_irqrestore(&evt_ring->ring.slock, flags);
+}
+
+static void gsi_isr_ioeb(struct gsi *gsi)
+{
+	u32 evt_mask;
+
+	evt_mask = gsi_readl(gsi, GSI_CNTXT_SRC_IEOB_IRQ_OFFS);
+	evt_mask &= gsi_readl(gsi, GSI_CNTXT_SRC_IEOB_IRQ_MSK_OFFS);
+	gsi_writel(gsi, evt_mask, GSI_CNTXT_SRC_IEOB_IRQ_CLR_OFFS);
+
+	ipa_assert(!(evt_mask & ~GENMASK(gsi->evt_ring_max - 1, 0)));
+
+	while (evt_mask) {
+		u32 i = (u32)__ffs(evt_mask);
+
+		gsi_event_handle(gsi, i);
+
+		evt_mask ^= BIT(i);
+	}
+}
+
+static void gsi_isr_inter_ee_chan_ctrl(struct gsi *gsi)
+{
+	u32 channel_mask;
+
+	channel_mask = gsi_readl(gsi, GSI_INTER_EE_SRC_CH_IRQ_OFFS);
+	gsi_writel(gsi, channel_mask, GSI_INTER_EE_SRC_CH_IRQ_CLR_OFFS);
+
+	ipa_assert(!(channel_mask & ~GENMASK(gsi->channel_max - 1, 0)));
+
+	while (channel_mask) {
+		int i = __ffs(channel_mask);
+
+		/* not currently expected */
+		ipa_err("ch %d was inter-EE changed\n", i);
+		channel_mask ^= BIT(i);
+	}
+}
+
+static void gsi_isr_inter_ee_evt_ctrl(struct gsi *gsi)
+{
+	u32 evt_mask;
+
+	evt_mask = gsi_readl(gsi, GSI_INTER_EE_SRC_EV_CH_IRQ_OFFS);
+	gsi_writel(gsi, evt_mask, GSI_INTER_EE_SRC_EV_CH_IRQ_CLR_OFFS);
+
+	ipa_assert(!(evt_mask & ~GENMASK(gsi->evt_ring_max - 1, 0)));
+
+	while (evt_mask) {
+		u32 i = (u32)__ffs(evt_mask);
+
+		/* not currently expected */
+		ipa_err("evt %d was inter-EE changed\n", i);
+		evt_mask ^= BIT(i);
+	}
+}
+
+static void gsi_isr_general(struct gsi *gsi)
+{
+	u32 val;
+
+	val = gsi_readl(gsi, GSI_CNTXT_GSI_IRQ_STTS_OFFS);
+
+	ipa_bug_on(val & CLR_MCS_STACK_OVRFLOW_FMASK);
+	ipa_bug_on(val & CLR_CMD_FIFO_OVRFLOW_FMASK);
+	ipa_bug_on(val & CLR_BUS_ERROR_FMASK);
+
+	if (val & CLR_BREAK_POINT_FMASK)
+		ipa_err("got breakpoint\n");
+
+	gsi_writel(gsi, val, GSI_CNTXT_GSI_IRQ_CLR_OFFS);
+}
+
+/* Returns a bitmask of pending GSI interrupts */
+static u32 gsi_isr_type(struct gsi *gsi)
+{
+	return gsi_readl(gsi, GSI_CNTXT_TYPE_IRQ_OFFS);
+}
+
+static irqreturn_t gsi_isr(int irq, void *dev_id)
+{
+	struct gsi *gsi = dev_id;
+	u32 type;
+	u32 cnt;
+
+	cnt = 0;
+	while ((type = gsi_isr_type(gsi))) {
+		do {
+			u32 single = BIT(__ffs(type));
+
+			switch (single) {
+			case CH_CTRL_FMASK:
+				gsi_isr_chan_ctrl(gsi);
+				break;
+			case EV_CTRL_FMASK:
+				gsi_isr_evt_ctrl(gsi);
+				break;
+			case GLOB_EE_FMASK:
+				gsi_isr_glob_ee(gsi);
+				break;
+			case IEOB_FMASK:
+				gsi_isr_ioeb(gsi);
+				break;
+			case INTER_EE_CH_CTRL_FMASK:
+				gsi_isr_inter_ee_chan_ctrl(gsi);
+				break;
+			case INTER_EE_EV_CTRL_FMASK:
+				gsi_isr_inter_ee_evt_ctrl(gsi);
+				break;
+			case GENERAL_FMASK:
+				gsi_isr_general(gsi);
+				break;
+			default:
+				WARN(true, "%s: unrecognized type 0x%08x\n",
+				     __func__, single);
+				break;
+			}
+			type ^= single;
+		} while (type);
+
+		ipa_bug_on(++cnt > GSI_ISR_MAX_ITER);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static u32 gsi_channel_max(struct gsi *gsi)
+{
+	u32 val = gsi_readl(gsi, GSI_GSI_HW_PARAM_2_OFFS);
+
+	return FIELD_GET(NUM_CH_PER_EE_FMASK, val);
+}
+
+static u32 gsi_evt_ring_max(struct gsi *gsi)
+{
+	u32 val = gsi_readl(gsi, GSI_GSI_HW_PARAM_2_OFFS);
+
+	return FIELD_GET(NUM_EV_PER_EE_FMASK, val);
+}
+
+/* Zero bits in an event bitmap represent event numbers available
+ * for allocation.  Initialize the map so all events supported by
+ * the hardware are available; then preclude any reserved events
+ * from allocation.
+ */
+static u32 gsi_evt_bmap_init(u32 evt_ring_max)
+{
+	u32 evt_bmap = GENMASK(BITS_PER_LONG - 1, evt_ring_max);
+
+	return evt_bmap | GENMASK(GSI_MHI_ER_END, GSI_MHI_ER_START);
+}
+
+int gsi_device_init(struct gsi *gsi)
+{
+	u32 evt_ring_max;
+	u32 channel_max;
+	u32 val;
+	int ret;
+
+	val = gsi_readl(gsi, GSI_GSI_STATUS_OFFS);
+	if (!(val & ENABLED_FMASK)) {
+		ipa_err("manager EE has not enabled GSI, GSI un-usable\n");
+		return -EIO;
+	}
+
+	channel_max = gsi_channel_max(gsi);
+	ipa_debug("channel_max %u\n", channel_max);
+	ipa_assert(channel_max <= GSI_CHAN_MAX);
+
+	evt_ring_max = gsi_evt_ring_max(gsi);
+	ipa_debug("evt_ring_max %u\n", evt_ring_max);
+	ipa_assert(evt_ring_max <= GSI_EVT_RING_MAX);
+
+	ret = request_irq(gsi->irq, gsi_isr, IRQF_TRIGGER_HIGH, "gsi", gsi);
+	if (ret) {
+		ipa_err("failed to register isr for %u\n", gsi->irq);
+		return -EIO;
+	}
+
+	ret = enable_irq_wake(gsi->irq);
+	if (ret)
+		ipa_err("error %d enabling gsi wake irq\n", ret);
+	gsi->irq_wake_enabled = !ret;
+	gsi->channel_max = channel_max;
+	gsi->evt_ring_max = evt_ring_max;
+	gsi->evt_bmap = gsi_evt_bmap_init(evt_ring_max);
+
+	/* Enable all IPA interrupts */
+	gsi_irq_enable_all(gsi);
+
+	/* Writing 1 indicates IRQ interrupts; 0 would be MSI */
+	gsi_writel(gsi, 1, GSI_CNTXT_INTSET_OFFS);
+
+	/* Initialize the error log */
+	gsi_writel(gsi, 0, GSI_ERROR_LOG_OFFS);
+
+	return 0;
+}
+
+void gsi_device_exit(struct gsi *gsi)
+{
+	ipa_assert(!atomic_read(&gsi->channel_count));
+	ipa_assert(!atomic_read(&gsi->evt_ring_count));
+
+	/* Don't bother clearing the error log again (ERROR_LOG) or
+	 * setting the interrupt type again (INTSET).
+	 */
+	gsi_irq_disable_all(gsi);
+
+	/* Clean up everything else set up by gsi_device_init() */
+	gsi->evt_bmap = 0;
+	gsi->evt_ring_max = 0;
+	gsi->channel_max = 0;
+	if (gsi->irq_wake_enabled) {
+		(void)disable_irq_wake(gsi->irq);
+		gsi->irq_wake_enabled = false;
+	}
+	free_irq(gsi->irq, gsi);
+	gsi->irq = 0;
+}
+
+static void gsi_evt_ring_program(struct gsi *gsi, u32 evt_ring_id)
+{
+	struct gsi_evt_ring *evt_ring = &gsi->evt_ring[evt_ring_id];
+	u32 int_modt;
+	u32 int_modc;
+	u64 phys;
+	u32 val;
+
+	phys = evt_ring->ring.mem.phys;
+	int_modt = evt_ring->moderation ? IPA_GSI_EVT_RING_INT_MODT : 0;
+	int_modc = 1;	/* moderation always comes from channel*/
+
+	val = FIELD_PREP(EV_CHTYPE_FMASK, GSI_EVT_CHTYPE_GPI_EV);
+	val |= FIELD_PREP(EV_INTYPE_FMASK, 1);
+	val |= FIELD_PREP(EV_ELEMENT_SIZE_FMASK, GSI_RING_ELEMENT_SIZE);
+	gsi_writel(gsi, val, GSI_EV_CH_E_CNTXT_0_OFFS(evt_ring_id));
+
+	val = FIELD_PREP(EV_R_LENGTH_FMASK, (u32)evt_ring->ring.mem.size);
+	gsi_writel(gsi, val, GSI_EV_CH_E_CNTXT_1_OFFS(evt_ring_id));
+
+	/* The context 2 and 3 registers store the low-order and
+	 * high-order 32 bits of the address of the event ring,
+	 * respectively.
+	 */
+	val = phys & GENMASK(31, 0);
+	gsi_writel(gsi, val, GSI_EV_CH_E_CNTXT_2_OFFS(evt_ring_id));
+
+	val = phys >> 32;
+	gsi_writel(gsi, val, GSI_EV_CH_E_CNTXT_3_OFFS(evt_ring_id));
+
+	val = FIELD_PREP(MODT_FMASK, int_modt);
+	val |= FIELD_PREP(MODC_FMASK, int_modc);
+	gsi_writel(gsi, val, GSI_EV_CH_E_CNTXT_8_OFFS(evt_ring_id));
+
+	/* No MSI write data, and MSI address high and low address is 0 */
+	gsi_writel(gsi, 0, GSI_EV_CH_E_CNTXT_9_OFFS(evt_ring_id));
+	gsi_writel(gsi, 0, GSI_EV_CH_E_CNTXT_10_OFFS(evt_ring_id));
+	gsi_writel(gsi, 0, GSI_EV_CH_E_CNTXT_11_OFFS(evt_ring_id));
+
+	/* We don't need to get event read pointer updates */
+	gsi_writel(gsi, 0, GSI_EV_CH_E_CNTXT_12_OFFS(evt_ring_id));
+	gsi_writel(gsi, 0, GSI_EV_CH_E_CNTXT_13_OFFS(evt_ring_id));
+}
+
+static void gsi_ring_init(struct gsi_ring *ring)
+{
+	ring->wp_local = ring->wp = ring->mem.phys;
+	ring->rp_local = ring->rp = ring->mem.phys;
+}
+
+static int gsi_ring_alloc(struct gsi_ring *ring, u32 count)
+{
+	size_t size = roundup_pow_of_two(count * GSI_RING_ELEMENT_SIZE);
+
+	/* Hardware requires a power-of-2 ring size (and alignment) */
+	if (ipa_dma_alloc(&ring->mem, size, GFP_KERNEL))
+		return -ENOMEM;
+	ipa_assert(!(ring->mem.phys % size));
+
+	ring->end = ring->mem.phys + size;
+	spin_lock_init(&ring->slock);
+
+	return 0;
+}
+
+static void gsi_ring_free(struct gsi_ring *ring)
+{
+	ipa_dma_free(&ring->mem);
+	memset(ring, 0, sizeof(*ring));
+}
+
+static void gsi_evt_ring_prime(struct gsi *gsi, struct gsi_evt_ring *evt_ring)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&evt_ring->ring.slock, flags);
+	memset(evt_ring->ring.mem.virt, 0, evt_ring->ring.mem.size);
+	evt_ring->ring.wp_local = evt_ring->ring.end - GSI_RING_ELEMENT_SIZE;
+	gsi_evt_ring_doorbell(gsi, evt_ring);
+	spin_unlock_irqrestore(&evt_ring->ring.slock, flags);
+}
+
+/* Issue a GSI command by writing a value to a register, then wait
+ * for completion to be signaled.  Returns true if successful or
+ * false if a timeout occurred.  Note that the register offset is
+ * first, value to write is second (reverse of writel() order).
+ */
+static bool command(struct gsi *gsi, u32 reg, u32 val, struct completion *compl)
+{
+	bool ret;
+
+	gsi_writel(gsi, val, reg);
+	ret = !!wait_for_completion_timeout(compl, GSI_CMD_TIMEOUT);
+	if (!ret)
+		ipa_err("command timeout\n");
+
+	return ret;
+}
+
+/* Issue an event ring command and wait for it to complete */
+static bool evt_ring_command(struct gsi *gsi, u32 evt_ring_id,
+			     enum gsi_evt_ch_cmd_opcode op)
+{
+	struct completion *compl = &gsi->evt_ring[evt_ring_id].compl;
+	u32 val;
+
+	reinit_completion(compl);
+
+	val = FIELD_PREP(EV_CHID_FMASK, evt_ring_id);
+	val |= FIELD_PREP(EV_OPCODE_FMASK, (u32)op);
+
+	return command(gsi, GSI_EV_CH_CMD_OFFS, val, compl);
+}
+
+/* Issue a channel command and wait for it to complete */
+static bool
+channel_command(struct gsi *gsi, u32 channel_id, enum gsi_ch_cmd_opcode op)
+{
+	struct completion *compl = &gsi->channel[channel_id].compl;
+	u32 val;
+
+	reinit_completion(compl);
+
+	val = FIELD_PREP(CH_CHID_FMASK, channel_id);
+	val |= FIELD_PREP(CH_OPCODE_FMASK, (u32)op);
+
+	return command(gsi, GSI_CH_CMD_OFFS, val, compl);
+}
+
+/* Note: only GPI interfaces, IRQ interrupts are currently supported */
+static int gsi_evt_ring_alloc(struct gsi *gsi, u32 ring_count, bool moderation)
+{
+	struct gsi_evt_ring *evt_ring;
+	unsigned long flags;
+	u32 evt_ring_id;
+	u32 val;
+	int ret;
+
+	/* Get the mutex to allocate from the bitmap and issue a command */
+	mutex_lock(&gsi->mutex);
+
+	/* Start by allocating the event id to use */
+	ipa_assert(gsi->evt_bmap != ~0UL);
+	evt_ring_id = (u32)ffz(gsi->evt_bmap);
+	gsi->evt_bmap |= BIT(evt_ring_id);
+
+	evt_ring = &gsi->evt_ring[evt_ring_id];
+
+	ret = gsi_ring_alloc(&evt_ring->ring, ring_count);
+	if (ret)
+		goto err_free_bmap;
+
+	init_completion(&evt_ring->compl);
+
+	if (!evt_ring_command(gsi, evt_ring_id, GSI_EVT_ALLOCATE)) {
+		ret = -ETIMEDOUT;
+		goto err_free_ring;
+	}
+
+	if (evt_ring->state != GSI_EVT_RING_STATE_ALLOCATED) {
+		ipa_err("evt_ring_id %u allocation failed state %u\n",
+			evt_ring_id, evt_ring->state);
+		ret = -ENOMEM;
+		goto err_free_ring;
+	}
+	atomic_inc(&gsi->evt_ring_count);
+
+	evt_ring->moderation = moderation;
+
+	gsi_evt_ring_program(gsi, evt_ring_id);
+	gsi_ring_init(&evt_ring->ring);
+	gsi_evt_ring_prime(gsi, evt_ring);
+
+	mutex_unlock(&gsi->mutex);
+
+	spin_lock_irqsave(&gsi->slock, flags);
+
+	/* Enable the event interrupt (clear it first in case pending) */
+	val = BIT(evt_ring_id);
+	gsi_writel(gsi, val, GSI_CNTXT_SRC_IEOB_IRQ_CLR_OFFS);
+	gsi_irq_enable_event(gsi, evt_ring_id);
+
+	spin_unlock_irqrestore(&gsi->slock, flags);
+
+	return evt_ring_id;
+
+err_free_ring:
+	gsi_ring_free(&evt_ring->ring);
+	memset(evt_ring, 0, sizeof(*evt_ring));
+err_free_bmap:
+	ipa_assert(gsi->evt_bmap & BIT(evt_ring_id));
+	gsi->evt_bmap &= ~BIT(evt_ring_id);
+
+	mutex_unlock(&gsi->mutex);
+
+	return ret;
+}
+
+static void gsi_evt_ring_scratch_zero(struct gsi *gsi, u32 evt_ring_id)
+{
+	gsi_writel(gsi, 0, GSI_EV_CH_E_SCRATCH_0_OFFS(evt_ring_id));
+	gsi_writel(gsi, 0, GSI_EV_CH_E_SCRATCH_1_OFFS(evt_ring_id));
+}
+
+static void gsi_evt_ring_dealloc(struct gsi *gsi, u32 evt_ring_id)
+{
+	struct gsi_evt_ring *evt_ring = &gsi->evt_ring[evt_ring_id];
+	bool completed;
+
+	ipa_bug_on(evt_ring->state != GSI_EVT_RING_STATE_ALLOCATED);
+
+	mutex_lock(&gsi->mutex);
+
+	completed = evt_ring_command(gsi, evt_ring_id, GSI_EVT_RESET);
+	ipa_bug_on(!completed);
+	ipa_bug_on(evt_ring->state != GSI_EVT_RING_STATE_ALLOCATED);
+
+	gsi_evt_ring_program(gsi, evt_ring_id);
+	gsi_ring_init(&evt_ring->ring);
+	gsi_evt_ring_scratch_zero(gsi, evt_ring_id);
+	gsi_evt_ring_prime(gsi, evt_ring);
+
+	completed = evt_ring_command(gsi, evt_ring_id, GSI_EVT_DE_ALLOC);
+	ipa_bug_on(!completed);
+
+	ipa_bug_on(evt_ring->state != GSI_EVT_RING_STATE_NOT_ALLOCATED);
+
+	ipa_assert(gsi->evt_bmap & BIT(evt_ring_id));
+	gsi->evt_bmap &= ~BIT(evt_ring_id);
+
+	mutex_unlock(&gsi->mutex);
+
+	evt_ring->moderation = false;
+	gsi_ring_free(&evt_ring->ring);
+	memset(evt_ring, 0, sizeof(*evt_ring));
+
+	atomic_dec(&gsi->evt_ring_count);
+}
+
+static void gsi_channel_program(struct gsi *gsi, u32 channel_id,
+				u32 evt_ring_id, bool doorbell_enable)
+{
+	struct gsi_channel *channel = &gsi->channel[channel_id];
+	u32 low_weight;
+	u32 val;
+
+	val = FIELD_PREP(CHTYPE_PROTOCOL_FMASK, GSI_CHANNEL_PROTOCOL_GPI);
+	val |= FIELD_PREP(CHTYPE_DIR_FMASK, channel->from_ipa ? 0 : 1);
+	val |= FIELD_PREP(ERINDEX_FMASK, evt_ring_id);
+	val |= FIELD_PREP(ELEMENT_SIZE_FMASK, GSI_RING_ELEMENT_SIZE);
+	gsi_writel(gsi, val, GSI_CH_C_CNTXT_0_OFFS(channel_id));
+
+	val = FIELD_PREP(R_LENGTH_FMASK, channel->ring.mem.size);
+	gsi_writel(gsi, val, GSI_CH_C_CNTXT_1_OFFS(channel_id));
+
+	/* The context 2 and 3 registers store the low-order and
+	 * high-order 32 bits of the address of the channel ring,
+	 * respectively.
+	 */
+	val = channel->ring.mem.phys & GENMASK(31, 0);
+	gsi_writel(gsi, val, GSI_CH_C_CNTXT_2_OFFS(channel_id));
+
+	val = channel->ring.mem.phys >> 32;
+	gsi_writel(gsi, val, GSI_CH_C_CNTXT_3_OFFS(channel_id));
+
+	low_weight = channel->priority ? FIELD_MAX(WRR_WEIGHT_FMASK) : 0;
+	val = FIELD_PREP(WRR_WEIGHT_FMASK, low_weight);
+	val |= FIELD_PREP(MAX_PREFETCH_FMASK, GSI_MAX_PREFETCH);
+	val |= FIELD_PREP(USE_DB_ENG_FMASK, doorbell_enable ? 1 : 0);
+	gsi_writel(gsi, val, GSI_CH_C_QOS_OFFS(channel_id));
+}
+
+int gsi_channel_alloc(struct gsi *gsi, u32 channel_id, u32 channel_count,
+		      bool from_ipa, bool priority, u32 evt_ring_mult,
+		      bool moderation, void *notify_data)
+{
+	struct gsi_channel *channel = &gsi->channel[channel_id];
+	u32 evt_ring_count;
+	u32 evt_ring_id;
+	void **user_data;
+	int ret;
+
+	evt_ring_count = channel_count * evt_ring_mult;
+	ret = gsi_evt_ring_alloc(gsi, evt_ring_count, moderation);
+	if (ret < 0)
+		return ret;
+	evt_ring_id = (u32)ret;
+
+	ret = gsi_ring_alloc(&channel->ring, channel_count);
+	if (ret)
+		goto err_evt_ring_free;
+
+	user_data = kcalloc(channel_count, sizeof(void *), GFP_KERNEL);
+	if (!user_data) {
+		ret = -ENOMEM;
+		goto err_ring_free;
+	}
+
+	mutex_init(&channel->mutex);
+	init_completion(&channel->compl);
+	atomic_set(&channel->poll_mode, 0);	/* Initially in callback mode */
+	channel->from_ipa = from_ipa;
+	channel->notify_data = notify_data;
+
+	mutex_lock(&gsi->mutex);
+
+	if (!channel_command(gsi, channel_id, GSI_CH_ALLOCATE)) {
+		ret = -ETIMEDOUT;
+		goto err_mutex_unlock;
+	}
+	if (channel->state != GSI_CHANNEL_STATE_ALLOCATED) {
+		ret = -EIO;
+		goto err_mutex_unlock;
+	}
+
+	gsi->ch_dbg[channel_id].ch_allocate++;
+
+	mutex_unlock(&gsi->mutex);
+
+	channel->evt_ring = &gsi->evt_ring[evt_ring_id];
+	channel->evt_ring->channel = channel;
+	channel->priority = priority;
+
+	gsi_channel_program(gsi, channel_id, evt_ring_id, true);
+	gsi_ring_init(&channel->ring);
+
+	channel->user_data = user_data;
+	atomic_inc(&gsi->channel_count);
+
+	return 0;
+
+err_mutex_unlock:
+	mutex_unlock(&gsi->mutex);
+	kfree(user_data);
+err_ring_free:
+	gsi_ring_free(&channel->ring);
+err_evt_ring_free:
+	gsi_evt_ring_dealloc(gsi, evt_ring_id);
+
+	return ret;
+}
+
+static void __gsi_channel_scratch_write(struct gsi *gsi, u32 channel_id)
+{
+	struct gsi_channel *channel = &gsi->channel[channel_id];
+	struct gsi_gpi_channel_scratch *gpi;
+	union gsi_channel_scratch scr = { };
+	u32 val;
+
+	gpi = &scr.gpi;
+	/* See comments above definition of gsi_gpi_channel_scratch */
+	gpi->max_outstanding_tre = channel->tlv_count * GSI_RING_ELEMENT_SIZE;
+	gpi->outstanding_threshold = 2 * GSI_RING_ELEMENT_SIZE;
+
+	val = scr.data.word1;
+	gsi_writel(gsi, val, GSI_CH_C_SCRATCH_0_OFFS(channel_id));
+
+	val = scr.data.word2;
+	gsi_writel(gsi, val, GSI_CH_C_SCRATCH_1_OFFS(channel_id));
+
+	val = scr.data.word3;
+	gsi_writel(gsi, val, GSI_CH_C_SCRATCH_2_OFFS(channel_id));
+
+	/* We must preserve the upper 16 bits of the last scratch
+	 * register.  The next sequence assumes those bits remain
+	 * unchanged between the read and the write.
+	 */
+	val = gsi_readl(gsi, GSI_CH_C_SCRATCH_3_OFFS(channel_id));
+	val = (scr.data.word4 & GENMASK(31, 16)) | (val & GENMASK(15, 0));
+	gsi_writel(gsi, val, GSI_CH_C_SCRATCH_3_OFFS(channel_id));
+}
+
+void gsi_channel_scratch_write(struct gsi *gsi, u32 channel_id, u32 tlv_count)
+{
+	struct gsi_channel *channel = &gsi->channel[channel_id];
+
+	channel->tlv_count = tlv_count;
+
+	mutex_lock(&channel->mutex);
+
+	__gsi_channel_scratch_write(gsi, channel_id);
+
+	mutex_unlock(&channel->mutex);
+}
+
+int gsi_channel_start(struct gsi *gsi, u32 channel_id)
+{
+	struct gsi_channel *channel = &gsi->channel[channel_id];
+
+	if (channel->state != GSI_CHANNEL_STATE_ALLOCATED &&
+	    channel->state != GSI_CHANNEL_STATE_STOP_IN_PROC &&
+	    channel->state != GSI_CHANNEL_STATE_STOPPED) {
+		ipa_err("bad state %d\n", channel->state);
+		return -ENOTSUPP;
+	}
+
+	mutex_lock(&gsi->mutex);
+
+	gsi->ch_dbg[channel_id].ch_start++;
+
+	if (!channel_command(gsi, channel_id, GSI_CH_START)) {
+		mutex_unlock(&gsi->mutex);
+		return -ETIMEDOUT;
+	}
+	if (channel->state != GSI_CHANNEL_STATE_STARTED) {
+		ipa_err("channel %u unexpected state %u\n", channel_id,
+			channel->state);
+		ipa_bug();
+	}
+
+	mutex_unlock(&gsi->mutex);
+
+	return 0;
+}
+
+int gsi_channel_stop(struct gsi *gsi, u32 channel_id)
+{
+	struct gsi_channel *channel = &gsi->channel[channel_id];
+	int ret;
+
+	if (channel->state == GSI_CHANNEL_STATE_STOPPED)
+		return 0;
+
+	if (channel->state != GSI_CHANNEL_STATE_STARTED &&
+	    channel->state != GSI_CHANNEL_STATE_STOP_IN_PROC &&
+	    channel->state != GSI_CHANNEL_STATE_ERROR) {
+		ipa_err("bad state %d\n", channel->state);
+		return -ENOTSUPP;
+	}
+
+	mutex_lock(&gsi->mutex);
+
+	gsi->ch_dbg[channel_id].ch_stop++;
+
+	if (!channel_command(gsi, channel_id, GSI_CH_STOP)) {
+		/* check channel state here in case the channel is stopped but
+		 * the interrupt was not handled yet.
+		 */
+		channel->state = gsi_channel_state(gsi, channel_id);
+		if (channel->state == GSI_CHANNEL_STATE_STOPPED) {
+			ret = 0;
+			goto free_lock;
+		}
+		ret = -ETIMEDOUT;
+		goto free_lock;
+	}
+
+	if (channel->state != GSI_CHANNEL_STATE_STOPPED &&
+	    channel->state != GSI_CHANNEL_STATE_STOP_IN_PROC) {
+		ipa_err("channel %u unexpected state %u\n", channel_id,
+			channel->state);
+		ret = -EBUSY;
+		goto free_lock;
+	}
+
+	if (channel->state == GSI_CHANNEL_STATE_STOP_IN_PROC) {
+		ipa_err("channel %u busy try again\n", channel_id);
+		ret = -EAGAIN;
+		goto free_lock;
+	}
+
+	ret = 0;
+
+free_lock:
+	mutex_unlock(&gsi->mutex);
+
+	return ret;
+}
+
+int gsi_channel_reset(struct gsi *gsi, u32 channel_id)
+{
+	struct gsi_channel *channel = &gsi->channel[channel_id];
+	u32 evt_ring_id;
+	bool reset_done;
+
+	if (channel->state != GSI_CHANNEL_STATE_STOPPED) {
+		ipa_err("bad state %d\n", channel->state);
+		return -ENOTSUPP;
+	}
+
+	evt_ring_id = gsi_evt_ring_id(gsi, channel->evt_ring);
+	reset_done = false;
+	mutex_lock(&gsi->mutex);
+reset:
+
+	gsi->ch_dbg[channel_id].ch_reset++;
+
+	if (!channel_command(gsi, channel_id, GSI_CH_RESET)) {
+		mutex_unlock(&gsi->mutex);
+		return -ETIMEDOUT;
+	}
+
+	if (channel->state != GSI_CHANNEL_STATE_ALLOCATED) {
+		ipa_err("channel_id %u unexpected state %u\n", channel_id,
+			channel->state);
+		ipa_bug();
+	}
+
+	/* workaround: reset GSI producers again */
+	if (channel->from_ipa && !reset_done) {
+		usleep_range(GSI_RESET_WA_MIN_SLEEP, GSI_RESET_WA_MAX_SLEEP);
+		reset_done = true;
+		goto reset;
+	}
+
+	gsi_channel_program(gsi, channel_id, evt_ring_id, true);
+	gsi_ring_init(&channel->ring);
+
+	/* restore scratch */
+	__gsi_channel_scratch_write(gsi, channel_id);
+
+	mutex_unlock(&gsi->mutex);
+
+	return 0;
+}
+
+void gsi_channel_free(struct gsi *gsi, u32 channel_id)
+{
+	struct gsi_channel *channel = &gsi->channel[channel_id];
+	u32 evt_ring_id;
+	bool completed;
+
+	ipa_bug_on(channel->state != GSI_CHANNEL_STATE_ALLOCATED);
+
+	evt_ring_id = gsi_evt_ring_id(gsi, channel->evt_ring);
+	mutex_lock(&gsi->mutex);
+
+	gsi->ch_dbg[channel_id].ch_de_alloc++;
+
+	completed = channel_command(gsi, channel_id, GSI_CH_DE_ALLOC);
+	ipa_bug_on(!completed);
+
+	ipa_bug_on(channel->state != GSI_CHANNEL_STATE_NOT_ALLOCATED);
+
+	mutex_unlock(&gsi->mutex);
+
+	kfree(channel->user_data);
+	gsi_ring_free(&channel->ring);
+
+	gsi_evt_ring_dealloc(gsi, evt_ring_id);
+
+	memset(channel, 0, sizeof(*channel));
+
+	atomic_dec(&gsi->channel_count);
+}
+
+static u16 __gsi_query_ring_free_re(struct gsi_ring *ring)
+{
+	u64 delta;
+
+	if (ring->wp_local < ring->rp_local)
+		delta = ring->rp_local - ring->wp_local;
+	else
+		delta = ring->end - ring->wp_local + ring->rp_local;
+
+	return (u16)(delta / GSI_RING_ELEMENT_SIZE - 1);
+}
+
+int gsi_channel_queue(struct gsi *gsi, u32 channel_id, u16 num_xfers,
+		      struct gsi_xfer_elem *xfer, bool ring_db)
+{
+	struct gsi_channel *channel = &gsi->channel[channel_id];
+	unsigned long flags;
+	u32 i;
+
+	spin_lock_irqsave(&channel->evt_ring->ring.slock, flags);
+
+	if (num_xfers > __gsi_query_ring_free_re(&channel->ring)) {
+		spin_unlock_irqrestore(&channel->evt_ring->ring.slock, flags);
+		ipa_err("no space for %u-element transfer on ch %u\n",
+			num_xfers, channel_id);
+
+		return -ENOSPC;
+	}
+
+	for (i = 0; i < num_xfers; i++) {
+		struct gsi_tre *tre_ptr;
+		u16 idx = ring_wp_local_index(&channel->ring);
+
+		channel->user_data[idx] = xfer[i].user_data;
+
+		tre_ptr = ipa_dma_phys_to_virt(&channel->ring.mem,
+						  channel->ring.wp_local);
+
+		tre_ptr->buffer_ptr = xfer[i].addr;
+		tre_ptr->buf_len = xfer[i].len_opcode;
+		tre_ptr->bei = xfer[i].flags & GSI_XFER_FLAG_BEI ? 1 : 0;
+		tre_ptr->ieot = xfer[i].flags & GSI_XFER_FLAG_EOT ? 1 : 0;
+		tre_ptr->ieob = xfer[i].flags & GSI_XFER_FLAG_EOB ? 1 : 0;
+		tre_ptr->chain = xfer[i].flags & GSI_XFER_FLAG_CHAIN ? 1 : 0;
+
+		if (xfer[i].type == GSI_XFER_ELEM_DATA)
+			tre_ptr->re_type = GSI_RE_XFER;
+		else if (xfer[i].type == GSI_XFER_ELEM_IMME_CMD)
+			tre_ptr->re_type = GSI_RE_IMMD_CMD;
+		else if (xfer[i].type == GSI_XFER_ELEM_NOP)
+			tre_ptr->re_type = GSI_RE_NOP;
+		else
+			ipa_bug_on("invalid xfer type");
+
+		ring_wp_local_inc(&channel->ring);
+	}
+
+	wmb();	/* Ensure TRE is set before ringing doorbell */
+
+	if (ring_db)
+		gsi_channel_doorbell(gsi, channel);
+
+	spin_unlock_irqrestore(&channel->evt_ring->ring.slock, flags);
+
+	return 0;
+}
+
+int gsi_channel_poll(struct gsi *gsi, u32 channel_id)
+{
+	struct gsi_channel *channel = &gsi->channel[channel_id];
+	struct gsi_evt_ring *evt_ring;
+	unsigned long flags;
+	u32 evt_ring_id;
+	int size;
+
+	evt_ring = channel->evt_ring;
+	evt_ring_id = gsi_evt_ring_id(gsi, evt_ring);
+
+	spin_lock_irqsave(&evt_ring->ring.slock, flags);
+
+	/* update rp to see of we have anything new to process */
+	if (evt_ring->ring.rp == evt_ring->ring.rp_local) {
+		u32 val;
+
+		val = gsi_readl(gsi, GSI_EV_CH_E_CNTXT_4_OFFS(evt_ring_id));
+		evt_ring->ring.rp = channel->ring.rp & GENMASK_ULL(63, 32);
+		evt_ring->ring.rp |= val;
+	}
+
+	if (evt_ring->ring.rp != evt_ring->ring.rp_local) {
+		struct gsi_xfer_compl_evt *evt;
+
+		evt = ipa_dma_phys_to_virt(&evt_ring->ring.mem,
+					   evt_ring->ring.rp_local);
+		size = gsi_channel_process(gsi, evt, false);
+
+		ring_rp_local_inc(&evt_ring->ring);
+		ring_wp_local_inc(&evt_ring->ring); /* recycle element */
+	} else {
+		size = -ENOENT;
+	}
+
+	spin_unlock_irqrestore(&evt_ring->ring.slock, flags);
+
+	return size;
+}
+
+static void gsi_channel_mode_set(struct gsi *gsi, u32 channel_id, bool polling)
+{
+	struct gsi_channel *channel = &gsi->channel[channel_id];
+	unsigned long flags;
+	u32 evt_ring_id;
+
+	evt_ring_id = gsi_evt_ring_id(gsi, channel->evt_ring);
+
+	spin_lock_irqsave(&gsi->slock, flags);
+
+	if (polling)
+		gsi_irq_disable_event(gsi, evt_ring_id);
+	else
+		gsi_irq_enable_event(gsi, evt_ring_id);
+	atomic_set(&channel->poll_mode, polling ? 1 : 0);
+
+	spin_unlock_irqrestore(&gsi->slock, flags);
+}
+
+void gsi_channel_intr_enable(struct gsi *gsi, u32 channel_id)
+{
+	gsi_channel_mode_set(gsi, channel_id, false);
+}
+
+void gsi_channel_intr_disable(struct gsi *gsi, u32 channel_id)
+{
+	gsi_channel_mode_set(gsi, channel_id, true);
+}
+
+void gsi_channel_config(struct gsi *gsi, u32 channel_id, bool doorbell_enable)
+{
+	struct gsi_channel *channel = &gsi->channel[channel_id];
+	u32 evt_ring_id;
+
+	evt_ring_id = gsi_evt_ring_id(gsi, channel->evt_ring);
+
+	mutex_lock(&channel->mutex);
+
+	gsi_channel_program(gsi, channel_id, evt_ring_id, doorbell_enable);
+	gsi_ring_init(&channel->ring);
+
+	/* restore scratch */
+	__gsi_channel_scratch_write(gsi, channel_id);
+	mutex_unlock(&channel->mutex);
+}
+
+/* Initialize GSI driver */
+struct gsi *gsi_init(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	resource_size_t size;
+	struct gsi *gsi;
+	int irq;
+
+	/* Get GSI memory range and map it */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "gsi");
+	if (!res) {
+		ipa_err("missing \"gsi\" property in DTB\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	size = resource_size(res);
+	if (res->start > U32_MAX || size > U32_MAX) {
+		ipa_err("\"gsi\" values out of range\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* Get IPA GSI IRQ number */
+	irq = platform_get_irq_byname(pdev, "gsi");
+	if (irq < 0) {
+		ipa_err("failed to get gsi IRQ!\n");
+		return ERR_PTR(irq);
+	}
+
+	gsi = kzalloc(sizeof(*gsi), GFP_KERNEL);
+	if (!gsi)
+		return ERR_PTR(-ENOMEM);
+
+	gsi->base = devm_ioremap_nocache(dev, res->start, size);
+	if (!gsi->base) {
+		kfree(gsi);
+
+		return ERR_PTR(-ENOMEM);
+	}
+	gsi->dev = dev;
+	gsi->phys = (u32)res->start;
+	gsi->irq = irq;
+	spin_lock_init(&gsi->slock);
+	mutex_init(&gsi->mutex);
+	atomic_set(&gsi->channel_count, 0);
+	atomic_set(&gsi->evt_ring_count, 0);
+
+	return gsi;
+}
diff --git a/drivers/net/ipa/gsi.h b/drivers/net/ipa/gsi.h
new file mode 100644
index 000000000000..497f67cc6f80
--- /dev/null
+++ b/drivers/net/ipa/gsi.h
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2018 Linaro Ltd.
+ */
+#ifndef _GSI_H_
+#define _GSI_H_
+
+#include <linux/types.h>
+#include <linux/platform_device.h>
+
+#define GSI_RING_ELEMENT_SIZE	16	/* bytes (channel or event ring) */
+
+/**
+ * enum gsi_xfer_flag - Transfer element flag values.
+ * @GSI_XFER_FLAG_CHAIN:	Not the last element in a transaction.
+ * @GSI_XFER_FLAG_EOB:		Generate event interrupt when complete.
+ * @GSI_XFER_FLAG_EOT:		Interrupt on end of transfer condition.
+ * @GSI_XFER_FLAG_BEI:		Block (do not generate) event interrupt.
+ *
+ * Normally an event generated by completion of a transfer will cause
+ * the AP to be interrupted; the BEI flag prevents that.
+ */
+enum gsi_xfer_flag {
+	GSI_XFER_FLAG_CHAIN	= BIT(1),
+	GSI_XFER_FLAG_EOB	= BIT(2),
+	GSI_XFER_FLAG_EOT	= BIT(3),
+	GSI_XFER_FLAG_BEI	= BIT(4),
+};
+
+/**
+ * enum gsi_xfer_elem_type - Transfer element type.
+ * @GSI_XFER_ELEM_DATA:		Element represents a data transfer
+ * @GSI_XFER_ELEM_IMME_CMD:	Element contains an immediate command.
+ * @GSI_XFER_ELEM_NOP:		Element contans a no-op command.
+ */
+enum gsi_xfer_elem_type {
+	GSI_XFER_ELEM_DATA,
+	GSI_XFER_ELEM_IMME_CMD,
+	GSI_XFER_ELEM_NOP,
+};
+
+/**
+ * gsi_xfer_elem - Description of a single transfer.
+ * @addr:	Physical address of a buffer for data or immediate commands.
+ * @len_opcode:	Length of the data buffer, or enum ipahal_imm_cmd opcode
+ * @flags:	Flags for the transfer
+ * @type:	Command type (immediate command, data transfer NOP)
+ * @user_data:	Data maintained for (but unused by) the transfer element.
+ */
+struct gsi_xfer_elem {
+	u64 addr;
+	u16 len_opcode;
+	enum gsi_xfer_flag flags;
+	enum gsi_xfer_elem_type type;
+	void *user_data;
+};
+
+struct gsi;
+
+/**
+ * gsi_init() - Initialize GSI subsystem
+ * @pdev:	IPA platform device, to look up resources
+ *
+ * This stage of initialization can occur before the GSI firmware
+ * has been loaded.
+ *
+ * Return:	GSI pointer to provide to other GSI functions.
+ */
+struct gsi *gsi_init(struct platform_device *pdev);
+
+/**
+ * gsi_device_init() - Initialize a GSI device
+ * @gsi:	GSI pointer returned by gsi_init()
+ *
+ * Initialize a GSI device.
+ *
+ * @Return:	0 if successful or a negative error code otherwise.
+ */
+int gsi_device_init(struct gsi *gsi);
+
+/**
+ * gsi_device_exit() - De-initialize a GSI device
+ * @gsi:	GSI pointer returned by gsi_init()
+ *
+ * This is the inverse of gsi_device_init()
+ */
+void gsi_device_exit(struct gsi *gsi);
+
+/**
+ * gsi_channel_alloc() - Allocate a GSI channel
+ * @gsi:	GSI pointer returned by gsi_init()
+ * @channel_id:	Channel to allocate
+ * @channel_count: Number of transfer element slots in the channel
+ * @from_ipa:	Direction of data transfer (true: IPA->AP; false: AP->IPA)
+ * @priority:	Whether this channel will given prioroity
+ * @evt_ring_mult: Factor to use to get the number of elements in the
+ *		event ring associated with this channel
+ * @moderation:	Whether interrupt moderation should be enabled
+ * @notify_data: Pointer value to supply with notifications that
+ * 		occur because of events on this channel
+ *
+ * @Return:	 0 if successful, or a negative error code.
+ */
+int gsi_channel_alloc(struct gsi *gsi, u32 channel_id, u32 channel_count,
+		      bool from_ipa, bool priority, u32 evt_ring_mult,
+		      bool moderation, void *notify_data);
+
+/**
+ * gsi_channel_scratch_write() - Write channel scratch area
+ * @gsi:	GSI pointer returned by gsi_init()
+ * @channel_id:	Channel whose scratch area should be written
+ * @tlv_count:	The number of type-length-value the channel uses
+ */
+void gsi_channel_scratch_write(struct gsi *gsi, u32 channel_id, u32 tlv_count);
+
+/**
+ * gsi_channel_start() - Make a channel operational
+ * @gsi:	GSI pointer returned by gsi_init()
+ * @channel_id:	Channel to start
+ *
+ * @Return:	 0 if successful, or a negative error code.
+ */
+int gsi_channel_start(struct gsi *gsi, u32 channel_id);
+
+/**
+ * gsi_channel_stop() - Stop an operational channel
+ * @gsi:	GSI pointer returned by gsi_init()
+ * @channel_id:	Channel to stop
+ *
+ * @Return:	 0 if successful, or a negative error code.
+ */
+int gsi_channel_stop(struct gsi *gsi, u32 channel_id);
+
+/**
+ * gsi_channel_reset() - Reset a channel, to recover from error state
+ * @gsi:	GSI pointer returned by gsi_init()
+ * @channel_id:	Channel to be reset
+ *
+ * @Return:	 0 if successful, or a negative error code.
+ */
+int gsi_channel_reset(struct gsi *gsi, u32 channel_id);
+
+/**
+ * gsi_channel_free() - Release a previously-allocated channel
+ * @gsi:	GSI pointer returned by gsi_init()
+ * @channel_id:	Channel to be freed
+ */
+void gsi_channel_free(struct gsi *gsi, u32 channel_id);
+
+/**
+ * gsi_channel_config() - Configure a channel
+ * @gsi:		GSI pointer returned by gsi_init()
+ * @channel_id:		Channel to be configured
+ * @doorbell_enable:	Whether to enable hardware doorbell engine
+ */
+void gsi_channel_config(struct gsi *gsi, u32 channel_id, bool doorbell_enable);
+
+/**
+ * gsi_channel_poll() - Poll for a single completion on a channel
+ * @gsi:	GSI pointer returned by gsi_init()
+ * @channel_id:	Channel to be polled
+ *
+ * @Return:	Byte transfer count if successful, or a negative error code
+ */
+int gsi_channel_poll(struct gsi *gsi, u32 channel_id);
+
+/**
+ * gsi_channel_intr_enable() - Enable interrupts on a channel
+ * @gsi:	GSI pointer returned by gsi_init()
+ * @channel_id:	Channel whose interrupts should be enabled
+ */
+void gsi_channel_intr_enable(struct gsi *gsi, u32 channel_id);
+
+/**
+ * gsi_channel_intr_disable() - Disable interrupts on a channel
+ * @gsi:	GSI pointer returned by gsi_init()
+ * @channel_id:	Channel whose interrupts should be disabled
+ */
+void gsi_channel_intr_disable(struct gsi *gsi, u32 channel_id);
+
+/**
+ * gsi_channel_queue() - Queue transfer requests on a channel
+ * @gsi:	GSI pointer returned by gsi_init()
+ * @channel_id:	Channel on which transfers should be queued
+ * @num_xfers:	Number of transfer descriptors in the @xfer array
+ * @xfer:	Array of transfer descriptors
+ * @ring_db:	Whether to tell the hardware about these queued transfers
+ *
+ * @Return:	0 if successful, or a negative error code
+ */
+int gsi_channel_queue(struct gsi *gsi, u32 channel_id, u16 num_xfers,
+		      struct gsi_xfer_elem *xfer, bool ring_db);
+
+#endif /* _GSI_H_ */
diff --git a/drivers/net/ipa/gsi_reg.h b/drivers/net/ipa/gsi_reg.h
new file mode 100644
index 000000000000..fe5f98ef3840
--- /dev/null
+++ b/drivers/net/ipa/gsi_reg.h
@@ -0,0 +1,563 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2018 Linaro Ltd.
+ */
+#ifndef __GSI_REG_H__
+#define __GSI_REG_H__
+
+/* The maximum allowed value of "n" for any N-parameterized macro below
+ * is 3.  The N value comes from the ipa_ees enumerated type.
+ *
+ * For GSI_INST_RAM_I_OFFS(), the "i" value supplied is an instruction
+ * offset (where each instruction is 32 bits wide).  The maximum offset
+ * value is 4095.
+ *
+ * Macros parameterized by (data) channel number supply a parameter "c".
+ * The maximum value of "c" is 30 (but the limit is hardware-dependent).
+ *
+ * Macros parameterized by event channel number supply a parameter "e".
+ * The maximum value of "e" is 15 (but the limit is hardware-dependent).
+ *
+ * For any K-parameterized macros, the "k" value will represent either an
+ * event ring id or a (data) channel id.  15 is the maximum value of
+ * "k" for event rings; otherwise the maximum is 30.
+ */
+#define GSI_CFG_OFFS				0x00000000
+#define GSI_ENABLE_FMASK			0x00000001
+#define MCS_ENABLE_FMASK			0x00000002
+#define DOUBLE_MCS_CLK_FREQ_FMASK		0x00000004
+#define UC_IS_MCS_FMASK				0x00000008
+#define PWR_CLPS_FMASK				0x00000010
+#define BP_MTRIX_DISABLE_FMASK			0x00000020
+
+#define GSI_MCS_CFG_OFFS			0x0000b000
+#define MCS_CFG_ENABLE_FMASK			0x00000001
+
+#define GSI_PERIPH_BASE_ADDR_LSB_OFFS		0x00000018
+
+#define GSI_PERIPH_BASE_ADDR_MSB_OFFS		0x0000001c
+
+#define GSI_IC_DISABLE_CHNL_BCK_PRS_LSB_OFFS	0x000000a0
+#define CHNL_REE_INT_FMASK			0x00000007
+#define CHNL_EV_ENG_INT_FMASK			0x00000040
+#define CHNL_INT_END_INT_FMASK			0x00001000
+#define CHNL_CSR_INT_FMASK			0x00fc0000
+#define CHNL_TLV_INT_FMASK			0x3f000000
+
+#define GSI_IC_DISABLE_CHNL_BCK_PRS_MSB_OFFS	0x000000a4
+#define CHNL_TIMER_INT_FMASK			0x00000001
+#define CHNL_DB_ENG_INT_FMASK			0x00000040
+#define CHNL_RD_WR_INT_FMASK			0x00003000
+#define CHNL_UCONTROLLER_INT_FMASK		0x00fc0000
+
+#define GSI_IC_GEN_EVNT_BCK_PRS_LSB_OFFS	0x000000a8
+#define EVT_REE_INT_FMASK			0x00000007
+#define EVT_EV_ENG_INT_FMASK			0x00000040
+#define EVT_INT_END_INT_FMASK			0x00001000
+#define EVT_CSR_INT_FMASK			0x00fc0000
+#define EVT_TLV_INT_FMASK			0x3f000000
+
+#define GSI_IC_GEN_EVNT_BCK_PRS_MSB_OFFS	0x000000ac
+#define EVT_TIMER_INT_FMASK			0x00000001
+#define EVT_DB_ENG_INT_FMASK			0x00000040
+#define EVT_RD_WR_INT_FMASK			0x00003000
+#define EVT_UCONTROLLER_INT_FMASK		0x00fc0000
+
+#define GSI_IC_GEN_INT_BCK_PRS_LSB_OFFS		0x000000b0
+#define INT_REE_INT_FMASK			0x00000007
+#define INT_EV_ENG_INT_FMASK			0x00000040
+#define INT_INT_END_INT_FMASK			0x00001000
+#define INT_CSR_INT_FMASK			0x00fc0000
+#define INT_TLV_INT_FMASK			0x3f000000
+
+#define GSI_IC_GEN_INT_BCK_PRS_MSB_OFFS		0x000000b4
+#define INT_TIMER_INT_FMASK			0x00000001
+#define INT_DB_ENG_INT_FMASK			0x00000040
+#define INT_RD_WR_INT_FMASK			0x00003000
+#define INT_UCONTROLLER_INT_FMASK		0x00fc0000
+
+#define GSI_IC_STOP_INT_MOD_BCK_PRS_LSB_OFFS	0x000000b8
+#define REE_INT_FMASK				0x00000007
+#define EV_ENG_INT_FMASK			0x00000040
+#define INT_END_INT_FMASK			0x00001000
+#define CSR_INT_FMASK				0x00fc0000
+#define TLV_INT_FMASK				0x3f000000
+
+#define GSI_IC_STOP_INT_MOD_BCK_PRS_MSB_OFFS	0x000000bc
+#define TIMER_INT_FMASK				0x00000001
+#define DB_ENG_INT_FMASK			0x00000040
+#define RD_WR_INT_FMASK				0x00003000
+#define UCONTROLLER_INT_FMASK			0x00fc0000
+
+#define GSI_IC_PROCESS_DESC_BCK_PRS_LSB_OFFS	0x000000c0
+#define DESC_REE_INT_FMASK			0x00000007
+#define DESC_EV_ENG_INT_FMASK			0x00000040
+#define DESC_INT_END_INT_FMASK			0x00001000
+#define DESC_CSR_INT_FMASK			0x00fc0000
+#define DESC_TLV_INT_FMASK			0x3f000000
+
+#define GSI_IC_PROCESS_DESC_BCK_PRS_MSB_OFFS	0x000000c4
+#define DESC_TIMER_INT_FMASK			0x00000001
+#define DESC_DB_ENG_INT_FMASK			0x00000040
+#define DESC_RD_WR_INT_FMASK			0x00003000
+#define DESC_UCONTROLLER_INT_FMASK		0x00fc0000
+
+#define GSI_IC_TLV_STOP_BCK_PRS_LSB_OFFS	0x000000c8
+#define STOP_REE_INT_FMASK			0x00000007
+#define STOP_EV_ENG_INT_FMASK			0x00000040
+#define STOP_INT_END_INT_FMASK			0x00001000
+#define STOP_CSR_INT_FMASK			0x00fc0000
+#define STOP_TLV_INT_FMASK			0x3f000000
+
+#define GSI_IC_TLV_STOP_BCK_PRS_MSB_OFFS	0x000000cc
+#define STOP_TIMER_INT_FMASK			0x00000001
+#define STOP_DB_ENG_INT_FMASK			0x00000040
+#define STOP_RD_WR_INT_FMASK			0x00003000
+#define STOP_UCONTROLLER_INT_FMASK		0x00fc0000
+
+#define GSI_IC_TLV_RESET_BCK_PRS_LSB_OFFS	0x000000d0
+#define RST_REE_INT_FMASK			0x00000007
+#define RST_EV_ENG_INT_FMASK			0x00000040
+#define RST_INT_END_INT_FMASK			0x00001000
+#define RST_CSR_INT_FMASK			0x00fc0000
+#define RST_TLV_INT_FMASK			0x3f000000
+
+#define GSI_IC_TLV_RESET_BCK_PRS_MSB_OFFS	0x000000d4
+#define RST_TIMER_INT_FMASK			0x00000001
+#define RST_DB_ENG_INT_FMASK			0x00000040
+#define RST_RD_WR_INT_FMASK			0x00003000
+#define RST_UCONTROLLER_INT_FMASK		0x00fc0000
+
+#define GSI_IC_RGSTR_TIMER_BCK_PRS_LSB_OFFS	0x000000d8
+#define TMR_REE_INT_FMASK			0x00000007
+#define TMR_EV_ENG_INT_FMASK			0x00000040
+#define TMR_INT_END_INT_FMASK			0x00001000
+#define TMR_CSR_INT_FMASK			0x00fc0000
+#define TMR_TLV_INT_FMASK			0x3f000000
+
+#define GSI_IC_RGSTR_TIMER_BCK_PRS_MSB_OFFS	0x000000dc
+#define TMR_TIMER_INT_FMASK			0x00000001
+#define TMR_DB_ENG_INT_FMASK			0x00000040
+#define TMR_RD_WR_INT_FMASK			0x00003000
+#define TMR_UCONTROLLER_INT_FMASK		0x00fc0000
+
+#define GSI_IC_READ_BCK_PRS_LSB_OFFS		0x000000e0
+#define RD_REE_INT_FMASK			0x00000007
+#define RD_EV_ENG_INT_FMASK			0x00000040
+#define RD_INT_END_INT_FMASK			0x00001000
+#define RD_CSR_INT_FMASK			0x00fc0000
+#define RD_TLV_INT_FMASK			0x3f000000
+
+#define GSI_IC_READ_BCK_PRS_MSB_OFFS		0x000000e4
+#define RD_TIMER_INT_FMASK			0x00000001
+#define RD_DB_ENG_INT_FMASK			0x00000040
+#define RD_RD_WR_INT_FMASK			0x00003000
+#define RD_UCONTROLLER_INT_FMASK		0x00fc0000
+
+#define GSI_IC_WRITE_BCK_PRS_LSB_OFFS		0x000000e8
+#define WR_REE_INT_FMASK			0x00000007
+#define WR_EV_ENG_INT_FMASK			0x00000040
+#define WR_INT_END_INT_FMASK			0x00001000
+#define WR_CSR_INT_FMASK			0x00fc0000
+#define WR_TLV_INT_FMASK			0x3f000000
+
+#define GSI_IC_WRITE_BCK_PRS_MSB_OFFS		0x000000ec
+#define WR_TIMER_INT_FMASK			0x00000001
+#define WR_DB_ENG_INT_FMASK			0x00000040
+#define WR_RD_WR_INT_FMASK			0x00003000
+#define WR_UCONTROLLER_INT_FMASK		0x00fc0000
+
+#define GSI_IC_UCONTROLLER_GPR_BCK_PRS_LSB_OFFS	0x000000f0
+#define UC_REE_INT_FMASK			0x00000007
+#define UC_EV_ENG_INT_FMASK			0x00000040
+#define UC_INT_END_INT_FMASK			0x00001000
+#define UC_CSR_INT_FMASK			0x00fc0000
+#define UC_TLV_INT_FMASK			0x3f000000
+
+#define GSI_IC_UCONTROLLER_GPR_BCK_PRS_MSB_OFFS	0x000000f4
+#define UC_TIMER_INT_FMASK			0x00000001
+#define UC_DB_ENG_INT_FMASK			0x00000040
+#define UC_RD_WR_INT_FMASK			0x00003000
+#define UC_UCONTROLLER_INT_FMASK		0x00fc0000
+
+#define GSI_IRAM_PTR_CH_CMD_OFFS		0x00000400
+#define CMD_IRAM_PTR_FMASK			0x00000fff
+
+#define GSI_IRAM_PTR_EE_GENERIC_CMD_OFFS	0x00000404
+#define EE_IRAM_PTR_FMASK			0x00000fff
+
+#define GSI_IRAM_PTR_CH_DB_OFFS			0x00000418
+#define CH_DB_IRAM_PTR_FMASK			0x00000fff
+
+#define GSI_IRAM_PTR_EV_DB_OFFS			0x0000041c
+#define EV_DB_IRAM_PTR_FMASK			0x00000fff
+
+#define GSI_IRAM_PTR_NEW_RE_OFFS		0x00000420
+#define NEW_RE_IRAM_PTR_FMASK			0x00000fff
+
+#define GSI_IRAM_PTR_CH_DIS_COMP_OFFS		0x00000424
+#define DIS_IRAM_PTR_FMASK			0x00000fff
+
+#define GSI_IRAM_PTR_CH_EMPTY_OFFS		0x00000428
+#define EMPTY_IRAM_PTR_FMASK			0x00000fff
+
+#define GSI_IRAM_PTR_EVENT_GEN_COMP_OFFS	0x0000042c
+#define EVT_IRAM_PTR_FMASK			0x00000fff
+
+#define GSI_IRAM_PTR_PERIPH_IF_TLV_IN_0_OFFS	0x00000430
+#define IN_0_IRAM_PTR_FMASK			0x00000fff
+
+#define GSI_IRAM_PTR_PERIPH_IF_TLV_IN_2_OFFS	0x00000434
+#define IN_2_IRAM_PTR_FMASK			0x00000fff
+
+#define GSI_IRAM_PTR_PERIPH_IF_TLV_IN_1_OFFS	0x00000438
+#define IN_1_IRAM_PTR_FMASK			0x00000fff
+
+#define GSI_IRAM_PTR_TIMER_EXPIRED_OFFS		0x0000043c
+#define TMR_IRAM_PTR_FMASK			0x00000fff
+
+#define GSI_IRAM_PTR_WRITE_ENG_COMP_OFFS	0x00000440
+#define WR_IRAM_PTR_FMASK			0x00000fff
+
+#define GSI_IRAM_PTR_READ_ENG_COMP_OFFS		0x00000444
+#define RD_IRAM_PTR_FMASK			0x00000fff
+
+#define GSI_IRAM_PTR_UC_GP_INT_OFFS		0x00000448
+#define UC_IRAM_PTR_FMASK			0x00000fff
+
+#define GSI_IRAM_PTR_INT_MOD_STOPPED_OFFS	0x0000044c
+#define STOP_IRAM_PTR_FMASK			0x00000fff
+
+/* Max value of I for the GSI_INST_RAM_I_OFFS() is 4095 */
+#define GSI_INST_RAM_I_OFFS(i)			(0x00004000 + 0x0004 * (i))
+#define INST_BYTE_0_FMASK			0x000000ff
+#define INST_BYTE_1_FMASK			0x0000ff00
+#define INST_BYTE_2_FMASK			0x00ff0000
+#define INST_BYTE_3_FMASK			0xff000000
+
+#define GSI_CH_C_CNTXT_0_OFFS(c) \
+				GSI_EE_N_CH_C_CNTXT_0_OFFS(c, IPA_EE_AP)
+#define GSI_EE_N_CH_C_CNTXT_0_OFFS(c, n) \
+					(0x0001c000 + 0x4000 * (n) + 0x80 * (c))
+#define CHTYPE_PROTOCOL_FMASK			0x00000007
+#define CHTYPE_DIR_FMASK			0x00000008
+#define EE_FMASK				0x000000f0
+#define CHID_FMASK				0x00001f00
+#define ERINDEX_FMASK				0x0007c000
+#define CHSTATE_FMASK				0x00f00000
+#define ELEMENT_SIZE_FMASK			0xff000000
+
+#define GSI_CH_C_CNTXT_1_OFFS(c) \
+				GSI_EE_N_CH_C_CNTXT_1_OFFS(c, IPA_EE_AP)
+#define GSI_EE_N_CH_C_CNTXT_1_OFFS(c, n) \
+					(0x0001c004 + 0x4000 * (n) + 0x80 * (c))
+#define R_LENGTH_FMASK				0x0000ffff
+
+#define GSI_CH_C_CNTXT_2_OFFS(c) \
+				GSI_EE_N_CH_C_CNTXT_2_OFFS(c, IPA_EE_AP)
+#define GSI_EE_N_CH_C_CNTXT_2_OFFS(c, n) \
+					(0x0001c008 + 0x4000 * (n) + 0x80 * (c))
+
+#define GSI_CH_C_CNTXT_3_OFFS(c) \
+				GSI_EE_N_CH_C_CNTXT_3_OFFS(c, IPA_EE_AP)
+#define GSI_EE_N_CH_C_CNTXT_3_OFFS(c, n) \
+					(0x0001c00c + 0x4000 * (n) + 0x80 * (c))
+
+#define GSI_CH_C_CNTXT_4_OFFS(c) \
+				GSI_EE_N_CH_C_CNTXT_4_OFFS(c, IPA_EE_AP)
+#define GSI_EE_N_CH_C_CNTXT_4_OFFS(c, n) \
+					(0x0001c010 + 0x4000 * (n) + 0x80 * (c))
+
+#define GSI_CH_C_CNTXT_6_OFFS(c) \
+				GSI_EE_N_CH_C_CNTXT_6_OFFS(c, IPA_EE_AP)
+#define GSI_EE_N_CH_C_CNTXT_6_OFFS(c, n) \
+					(0x0001c018 + 0x4000 * (n) + 0x80 * (c))
+
+#define GSI_CH_C_QOS_OFFS(c)	GSI_EE_N_CH_C_QOS_OFFS(c, IPA_EE_AP)
+#define GSI_EE_N_CH_C_QOS_OFFS(c, n)	(0x0001c05c + 0x4000 * (n) + 0x80 * (c))
+#define WRR_WEIGHT_FMASK			0x0000000f
+#define MAX_PREFETCH_FMASK			0x00000100
+#define USE_DB_ENG_FMASK			0x00000200
+
+#define GSI_CH_C_SCRATCH_0_OFFS(c) \
+				GSI_EE_N_CH_C_SCRATCH_0_OFFS(c, IPA_EE_AP)
+#define GSI_EE_N_CH_C_SCRATCH_0_OFFS(c, n) \
+					(0x0001c060 + 0x4000 * (n) + 0x80 * (c))
+
+#define GSI_CH_C_SCRATCH_1_OFFS(c) \
+				GSI_EE_N_CH_C_SCRATCH_1_OFFS(c, IPA_EE_AP)
+#define GSI_EE_N_CH_C_SCRATCH_1_OFFS(c, n) \
+					(0x0001c064 + 0x4000 * (n) + 0x80 * (c))
+
+#define GSI_CH_C_SCRATCH_2_OFFS(c) \
+				GSI_EE_N_CH_C_SCRATCH_2_OFFS(c, IPA_EE_AP)
+#define GSI_EE_N_CH_C_SCRATCH_2_OFFS(c, n) \
+					(0x0001c068 + 0x4000 * (n) + 0x80 * (c))
+
+#define GSI_CH_C_SCRATCH_3_OFFS(c) \
+				GSI_EE_N_CH_C_SCRATCH_3_OFFS(c, IPA_EE_AP)
+#define GSI_EE_N_CH_C_SCRATCH_3_OFFS(c, n) \
+					(0x0001c06c + 0x4000 * (n) + 0x80 * (c))
+
+#define GSI_EV_CH_E_CNTXT_0_OFFS(e) \
+				GSI_EE_N_EV_CH_E_CNTXT_0_OFFS(e, IPA_EE_AP)
+#define GSI_EE_N_EV_CH_E_CNTXT_0_OFFS(e, n) \
+					(0x0001d000 + 0x4000 * (n) + 0x80 * (e))
+#define EV_CHTYPE_FMASK				0x0000000f
+#define EV_EE_FMASK				0x000000f0
+#define EV_EVCHID_FMASK				0x0000ff00
+#define EV_INTYPE_FMASK				0x00010000
+#define EV_CHSTATE_FMASK			0x00f00000
+#define EV_ELEMENT_SIZE_FMASK			0xff000000
+
+#define GSI_EV_CH_E_CNTXT_1_OFFS(e) \
+				GSI_EE_N_EV_CH_E_CNTXT_1_OFFS(e, IPA_EE_AP)
+#define GSI_EE_N_EV_CH_E_CNTXT_1_OFFS(e, n) \
+					(0x0001d004 + 0x4000 * (n) + 0x80 * (e))
+#define EV_R_LENGTH_FMASK			0x0000ffff
+
+#define GSI_EV_CH_E_CNTXT_2_OFFS(e) \
+				GSI_EE_N_EV_CH_E_CNTXT_2_OFFS(e, IPA_EE_AP)
+#define GSI_EE_N_EV_CH_E_CNTXT_2_OFFS(e, n) \
+					(0x0001d008 + 0x4000 * (n) + 0x80 * (e))
+
+#define GSI_EV_CH_E_CNTXT_3_OFFS(e) \
+				GSI_EE_N_EV_CH_E_CNTXT_3_OFFS(e, IPA_EE_AP)
+#define GSI_EE_N_EV_CH_E_CNTXT_3_OFFS(e, n) \
+					(0x0001d00c + 0x4000 * (n) + 0x80 * (e))
+
+#define GSI_EV_CH_E_CNTXT_4_OFFS(e) \
+				GSI_EE_N_EV_CH_E_CNTXT_4_OFFS(e, IPA_EE_AP)
+#define GSI_EE_N_EV_CH_E_CNTXT_4_OFFS(e, n) \
+					(0x0001d010 + 0x4000 * (n) + 0x80 * (e))
+
+#define GSI_EV_CH_E_CNTXT_8_OFFS(e) \
+				GSI_EE_N_EV_CH_E_CNTXT_8_OFFS(e, IPA_EE_AP)
+#define GSI_EE_N_EV_CH_E_CNTXT_8_OFFS(e, n) \
+					(0x0001d020 + 0x4000 * (n) + 0x80 * (e))
+#define MODT_FMASK				0x0000ffff
+#define MODC_FMASK				0x00ff0000
+#define MOD_CNT_FMASK				0xff000000
+
+#define GSI_EV_CH_E_CNTXT_9_OFFS(e) \
+				GSI_EE_N_EV_CH_E_CNTXT_9_OFFS(e, IPA_EE_AP)
+#define GSI_EE_N_EV_CH_E_CNTXT_9_OFFS(e, n) \
+					(0x0001d024 + 0x4000 * (n) + 0x80 * (e))
+
+#define GSI_EV_CH_E_CNTXT_10_OFFS(e) \
+				GSI_EE_N_EV_CH_E_CNTXT_10_OFFS(e, IPA_EE_AP)
+#define GSI_EE_N_EV_CH_E_CNTXT_10_OFFS(e, n) \
+					(0x0001d028 + 0x4000 * (n) + 0x80 * (e))
+
+#define GSI_EV_CH_E_CNTXT_11_OFFS(e) \
+				GSI_EE_N_EV_CH_E_CNTXT_11_OFFS(e, IPA_EE_AP)
+#define GSI_EE_N_EV_CH_E_CNTXT_11_OFFS(e, n) \
+					(0x0001d02c + 0x4000 * (n) + 0x80 * (e))
+
+#define GSI_EV_CH_E_CNTXT_12_OFFS(e) \
+				GSI_EE_N_EV_CH_E_CNTXT_12_OFFS(e, IPA_EE_AP)
+#define GSI_EE_N_EV_CH_E_CNTXT_12_OFFS(e, n) \
+					(0x0001d030 + 0x4000 * (n) + 0x80 * (e))
+
+#define GSI_EV_CH_E_CNTXT_13_OFFS(e) \
+				GSI_EE_N_EV_CH_E_CNTXT_13_OFFS(e, IPA_EE_AP)
+#define GSI_EE_N_EV_CH_E_CNTXT_13_OFFS(e, n) \
+					(0x0001d034 + 0x4000 * (n) + 0x80 * (e))
+
+#define GSI_EV_CH_E_SCRATCH_0_OFFS(e) \
+				GSI_EE_N_EV_CH_E_SCRATCH_0_OFFS(e, IPA_EE_AP)
+#define GSI_EE_N_EV_CH_E_SCRATCH_0_OFFS(e, n) \
+					(0x0001d048 + 0x4000 * (n) + 0x80 * (e))
+
+#define GSI_EV_CH_E_SCRATCH_1_OFFS(e) \
+				GSI_EE_N_EV_CH_E_SCRATCH_1_OFFS(e, IPA_EE_AP)
+#define GSI_EE_N_EV_CH_E_SCRATCH_1_OFFS(e, n) \
+					(0x0001d04c + 0x4000 * (n) + 0x80 * (e))
+
+#define GSI_CH_C_DOORBELL_0_OFFS(c) \
+				GSI_EE_N_CH_C_DOORBELL_0_OFFS(c, IPA_EE_AP)
+#define GSI_EE_N_CH_C_DOORBELL_0_OFFS(c, n) \
+					(0x0001e000 + 0x4000 * (n) + 0x08 * (c))
+
+#define GSI_CH_C_DOORBELL_1_OFFS(c) \
+				GSI_EE_N_CH_C_DOORBELL_1_OFFS(c, IPA_EE_AP)
+#define GSI_EE_N_CH_C_DOORBELL_1_OFFS(c, n) \
+					(0x0001e004 + 0x4000 * (n) + 0x08 * (c))
+
+#define GSI_EV_CH_E_DOORBELL_0_OFFS(e) \
+				GSI_EE_N_EV_CH_E_DOORBELL_0_OFFS(e, IPA_EE_AP)
+#define GSI_EE_N_EV_CH_E_DOORBELL_0_OFFS(e, n) \
+					(0x0001e100 + 0x4000 * (n) + 0x08 * (e))
+
+#define GSI_EV_CH_E_DOORBELL_1_OFFS(e) \
+				GSI_EE_N_EV_CH_E_DOORBELL_1_OFFS(e, IPA_EE_AP)
+#define GSI_EE_N_EV_CH_E_DOORBELL_1_OFFS(e, n) \
+					(0x0001e104 + 0x4000 * (n) + 0x08 * (e))
+
+#define GSI_GSI_STATUS_OFFS	GSI_EE_N_GSI_STATUS_OFFS(IPA_EE_AP)
+#define GSI_EE_N_GSI_STATUS_OFFS(n)		(0x0001f000 + 0x4000 * (n))
+#define ENABLED_FMASK				0x00000001
+
+#define GSI_CH_CMD_OFFS		GSI_EE_N_CH_CMD_OFFS(IPA_EE_AP)
+#define GSI_EE_N_CH_CMD_OFFS(n)			(0x0001f008 + 0x4000 * (n))
+#define CH_CHID_FMASK				0x000000ff
+#define CH_OPCODE_FMASK				0xff000000
+
+#define GSI_EV_CH_CMD_OFFS	GSI_EE_N_EV_CH_CMD_OFFS(IPA_EE_AP)
+#define GSI_EE_N_EV_CH_CMD_OFFS(n)		(0x0001f010 + 0x4000 * (n))
+#define EV_CHID_FMASK				0x000000ff
+#define EV_OPCODE_FMASK				0xff000000
+
+#define GSI_GSI_HW_PARAM_2_OFFS	GSI_EE_N_GSI_HW_PARAM_2_OFFS(IPA_EE_AP)
+#define GSI_EE_N_GSI_HW_PARAM_2_OFFS(n)		(0x0001f040 + 0x4000 * (n))
+#define IRAM_SIZE_FMASK				0x00000007
+#define NUM_CH_PER_EE_FMASK			0x000000f8
+#define NUM_EV_PER_EE_FMASK			0x00001f00
+#define GSI_CH_PEND_TRANSLATE_FMASK		0x00002000
+#define GSI_CH_FULL_LOGIC_FMASK			0x00004000
+#define IRAM_SIZE_ONE_KB_FVAL			0
+#define IRAM_SIZE_TWO_KB_FVAL			1
+
+#define GSI_GSI_SW_VERSION_OFFS	GSI_EE_N_GSI_SW_VERSION_OFFS(IPA_EE_AP)
+#define GSI_EE_N_GSI_SW_VERSION_OFFS(n)		(0x0001f044 + 0x4000 * (n))
+#define STEP_FMASK				0x0000ffff
+#define MINOR_FMASK				0x0fff0000
+#define MAJOR_FMASK				0xf0000000
+
+#define GSI_GSI_MCS_CODE_VER_OFFS \
+				GSI_EE_N_GSI_MCS_CODE_VER_OFFS(IPA_EE_AP)
+#define GSI_EE_N_GSI_MCS_CODE_VER_OFFS(n)	(0x0001f048 + 0x4000 * (n))
+
+#define GSI_CNTXT_TYPE_IRQ_OFFS	GSI_EE_N_CNTXT_TYPE_IRQ_OFFS(IPA_EE_AP)
+#define GSI_EE_N_CNTXT_TYPE_IRQ_OFFS(n)		(0x0001f080 + 0x4000 * (n))
+#define CH_CTRL_FMASK				0x00000001
+#define EV_CTRL_FMASK				0x00000002
+#define GLOB_EE_FMASK				0x00000004
+#define IEOB_FMASK				0x00000008
+#define INTER_EE_CH_CTRL_FMASK			0x00000010
+#define INTER_EE_EV_CTRL_FMASK			0x00000020
+#define GENERAL_FMASK				0x00000040
+
+#define GSI_CNTXT_TYPE_IRQ_MSK_OFFS \
+				GSI_EE_N_CNTXT_TYPE_IRQ_MSK_OFFS(IPA_EE_AP)
+#define GSI_EE_N_CNTXT_TYPE_IRQ_MSK_OFFS(n)	(0x0001f088 + 0x4000 * (n))
+#define MSK_CH_CTRL_FMASK			0x00000001
+#define MSK_EV_CTRL_FMASK			0x00000002
+#define MSK_GLOB_EE_FMASK			0x00000004
+#define MSK_IEOB_FMASK				0x00000008
+#define MSK_INTER_EE_CH_CTRL_FMASK		0x00000010
+#define MSK_INTER_EE_EV_CTRL_FMASK		0x00000020
+#define MSK_GENERAL_FMASK			0x00000040
+
+#define GSI_CNTXT_SRC_CH_IRQ_OFFS \
+				GSI_EE_N_CNTXT_SRC_CH_IRQ_OFFS(IPA_EE_AP)
+#define GSI_EE_N_CNTXT_SRC_CH_IRQ_OFFS(n)	(0x0001f090 + 0x4000 * (n))
+
+#define GSI_CNTXT_SRC_EV_CH_IRQ_OFFS \
+				GSI_EE_N_CNTXT_SRC_EV_CH_IRQ_OFFS(IPA_EE_AP)
+#define GSI_EE_N_CNTXT_SRC_EV_CH_IRQ_OFFS(n)	(0x0001f094 + 0x4000 * (n))
+
+#define GSI_CNTXT_SRC_CH_IRQ_MSK_OFFS \
+				GSI_EE_N_CNTXT_SRC_CH_IRQ_MSK_OFFS(IPA_EE_AP)
+#define GSI_EE_N_CNTXT_SRC_CH_IRQ_MSK_OFFS(n)	(0x0001f098 + 0x4000 * (n))
+
+#define GSI_CNTXT_SRC_EV_CH_IRQ_MSK_OFFS \
+				GSI_EE_N_CNTXT_SRC_EV_CH_IRQ_MSK_OFFS(IPA_EE_AP)
+#define GSI_EE_N_CNTXT_SRC_EV_CH_IRQ_MSK_OFFS(n) (0x0001f09c + 0x4000 * (n))
+
+#define GSI_CNTXT_SRC_CH_IRQ_CLR_OFFS \
+				GSI_EE_N_CNTXT_SRC_CH_IRQ_CLR_OFFS(IPA_EE_AP)
+#define GSI_EE_N_CNTXT_SRC_CH_IRQ_CLR_OFFS(n)	(0x0001f0a0 + 0x4000 * (n))
+
+#define GSI_CNTXT_SRC_EV_CH_IRQ_CLR_OFFS \
+				GSI_EE_N_CNTXT_SRC_EV_CH_IRQ_CLR_OFFS(IPA_EE_AP)
+#define GSI_EE_N_CNTXT_SRC_EV_CH_IRQ_CLR_OFFS(n) (0x0001f0a4 + 0x4000 * (n))
+
+#define GSI_CNTXT_SRC_IEOB_IRQ_OFFS \
+				GSI_EE_N_CNTXT_SRC_IEOB_IRQ_OFFS(IPA_EE_AP)
+#define GSI_EE_N_CNTXT_SRC_IEOB_IRQ_OFFS(n)	(0x0001f0b0 + 0x4000 * (n))
+
+#define GSI_CNTXT_SRC_IEOB_IRQ_MSK_OFFS \
+				GSI_EE_N_CNTXT_SRC_IEOB_IRQ_MSK_OFFS(IPA_EE_AP)
+#define GSI_EE_N_CNTXT_SRC_IEOB_IRQ_MSK_OFFS(n)	(0x0001f0b8 + 0x4000 * (n))
+
+#define GSI_CNTXT_SRC_IEOB_IRQ_CLR_OFFS \
+				GSI_EE_N_CNTXT_SRC_IEOB_IRQ_CLR_OFFS(IPA_EE_AP)
+#define GSI_EE_N_CNTXT_SRC_IEOB_IRQ_CLR_OFFS(n)	(0x0001f0c0 + 0x4000 * (n))
+
+#define GSI_CNTXT_GLOB_IRQ_STTS_OFFS \
+				GSI_EE_N_CNTXT_GLOB_IRQ_STTS_OFFS(IPA_EE_AP)
+#define GSI_EE_N_CNTXT_GLOB_IRQ_STTS_OFFS(n)	(0x0001f100 + 0x4000 * (n))
+#define ERROR_INT_FMASK				0x00000001
+#define GP_INT1_FMASK				0x00000002
+#define GP_INT2_FMASK				0x00000004
+#define GP_INT3_FMASK				0x00000008
+
+#define GSI_CNTXT_GLOB_IRQ_EN_OFFS \
+				GSI_EE_N_CNTXT_GLOB_IRQ_EN_OFFS(IPA_EE_AP)
+#define GSI_EE_N_CNTXT_GLOB_IRQ_EN_OFFS(n)	(0x0001f108 + 0x4000 * (n))
+#define EN_ERROR_INT_FMASK			0x00000001
+#define EN_GP_INT1_FMASK			0x00000002
+#define EN_GP_INT2_FMASK			0x00000004
+#define EN_GP_INT3_FMASK			0x00000008
+
+#define GSI_CNTXT_GLOB_IRQ_CLR_OFFS \
+				GSI_EE_N_CNTXT_GLOB_IRQ_CLR_OFFS(IPA_EE_AP)
+#define GSI_EE_N_CNTXT_GLOB_IRQ_CLR_OFFS(n)	(0x0001f110 + 0x4000 * (n))
+#define CLR_ERROR_INT_FMASK			0x00000001
+#define CLR_GP_INT1_FMASK			0x00000002
+#define CLR_GP_INT2_FMASK			0x00000004
+#define CLR_GP_INT3_FMASK			0x00000008
+
+#define GSI_CNTXT_GSI_IRQ_STTS_OFFS \
+				GSI_EE_N_CNTXT_GSI_IRQ_STTS_OFFS(IPA_EE_AP)
+#define GSI_EE_N_CNTXT_GSI_IRQ_STTS_OFFS(n)	(0x0001f118 + 0x4000 * (n))
+#define BREAK_POINT_FMASK			0x00000001
+#define BUS_ERROR_FMASK				0x00000002
+#define CMD_FIFO_OVRFLOW_FMASK			0x00000004
+#define MCS_STACK_OVRFLOW_FMASK			0x00000008
+
+#define GSI_CNTXT_GSI_IRQ_EN_OFFS \
+				GSI_EE_N_CNTXT_GSI_IRQ_EN_OFFS(IPA_EE_AP)
+#define GSI_EE_N_CNTXT_GSI_IRQ_EN_OFFS(n)	(0x0001f120 + 0x4000 * (n))
+#define EN_BREAK_POINT_FMASK			0x00000001
+#define EN_BUS_ERROR_FMASK			0x00000002
+#define EN_CMD_FIFO_OVRFLOW_FMASK		0x00000004
+#define EN_MCS_STACK_OVRFLOW_FMASK		0x00000008
+
+#define GSI_CNTXT_GSI_IRQ_CLR_OFFS \
+				GSI_EE_N_CNTXT_GSI_IRQ_CLR_OFFS(IPA_EE_AP)
+#define GSI_EE_N_CNTXT_GSI_IRQ_CLR_OFFS(n)	(0x0001f128 + 0x4000 * (n))
+#define CLR_BREAK_POINT_FMASK			0x00000001
+#define CLR_BUS_ERROR_FMASK			0x00000002
+#define CLR_CMD_FIFO_OVRFLOW_FMASK		0x00000004
+#define CLR_MCS_STACK_OVRFLOW_FMASK		0x00000008
+
+#define GSI_EE_N_CNTXT_INTSET_OFFS(n)		(0x0001f180 + 0x4000 * (n))
+#define INTYPE_FMASK				0x00000001
+#define GSI_CNTXT_INTSET_OFFS	GSI_EE_N_CNTXT_INTSET_OFFS(IPA_EE_AP)
+
+#define GSI_ERROR_LOG_OFFS	GSI_EE_N_ERROR_LOG_OFFS(IPA_EE_AP)
+#define GSI_EE_N_ERROR_LOG_OFFS(n)		(0x0001f200 + 0x4000 * (n))
+
+#define GSI_ERROR_LOG_CLR_OFFS	GSI_EE_N_ERROR_LOG_CLR_OFFS(IPA_EE_AP)
+#define GSI_EE_N_ERROR_LOG_CLR_OFFS(n)		(0x0001f210 + 0x4000 * (n))
+
+#define GSI_INTER_EE_SRC_CH_IRQ_OFFS \
+				GSI_INTER_EE_N_SRC_CH_IRQ_OFFS(IPA_EE_AP)
+#define GSI_INTER_EE_N_SRC_CH_IRQ_OFFS(n)	(0x0000c018 + 0x1000 * (n))
+
+#define GSI_INTER_EE_SRC_EV_CH_IRQ_OFFS \
+				GSI_INTER_EE_N_SRC_EV_CH_IRQ_OFFS(IPA_EE_AP)
+#define GSI_INTER_EE_N_SRC_EV_CH_IRQ_OFFS(n)	(0x0000c01c + 0x1000 * (n))
+
+#define GSI_INTER_EE_SRC_CH_IRQ_CLR_OFFS \
+				GSI_INTER_EE_N_SRC_CH_IRQ_CLR_OFFS(IPA_EE_AP)
+#define GSI_INTER_EE_N_SRC_CH_IRQ_CLR_OFFS(n)	(0x0000c028 + 0x1000 * (n))
+
+#define GSI_INTER_EE_SRC_EV_CH_IRQ_CLR_OFFS \
+				GSI_INTER_EE_N_SRC_EV_CH_IRQ_CLR_OFFS(IPA_EE_AP)
+#define GSI_INTER_EE_N_SRC_EV_CH_IRQ_CLR_OFFS(n) (0x0000c02c + 0x1000 * (n))
+
+#endif	/* _GSI_REG_H__ */
-- 
2.17.1

