Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C4BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2226B2146B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2226B2146B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754941AbeFZXcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 19:32:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:37565 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752445AbeFZXcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 19:32:33 -0400
Received: from pasglop.au.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5QNQ6qd022979;
        Tue, 26 Jun 2018 18:26:48 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 06/14] fsi: master-gpio: Add more tracepoints
Date:   Wed, 27 Jun 2018 09:25:57 +1000
Message-Id: <20180626232605.13420-7-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626232605.13420-1-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a few more tracepoints that have proven useful when
debugging issues with the FSI bus.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-master-gpio.c          | 16 ++++---
 include/trace/events/fsi_master_gpio.h | 59 ++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index 48e0e65b2982..a00a85aa6d56 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -130,10 +130,17 @@ static void set_sda_output(struct fsi_master_gpio *master, int value)
 
 static void clock_zeros(struct fsi_master_gpio *master, int count)
 {
+	trace_fsi_master_gpio_clock_zeros(master, count);
 	set_sda_output(master, 1);
 	clock_toggle(master, count);
 }
 
+static void echo_delay(struct fsi_master_gpio *master)
+{
+	clock_zeros(master, master->t_echo_delay);
+}
+
+
 static void serial_in(struct fsi_master_gpio *master, struct fsi_gpio_msg *msg,
 			uint8_t num_bits)
 {
@@ -279,16 +286,19 @@ static void build_ar_command(struct fsi_master_gpio *master,
 		addr_bits = 2;
 		opcode_bits = 2;
 		opcode = FSI_GPIO_CMD_SAME_AR;
+		trace_fsi_master_gpio_cmd_same_addr(master);
 
 	} else if (check_relative_address(master, id, addr, &rel_addr)) {
 		/* 8 bits plus sign */
 		addr_bits = 9;
 		addr = rel_addr;
 		opcode = FSI_GPIO_CMD_REL_AR;
+		trace_fsi_master_gpio_cmd_rel_addr(master, rel_addr);
 
 	} else {
 		addr_bits = 21;
 		opcode = FSI_GPIO_CMD_ABS_AR;
+		trace_fsi_master_gpio_cmd_abs_addr(master, addr);
 	}
 
 	/*
@@ -337,12 +347,6 @@ static void build_epoll_command(struct fsi_gpio_msg *cmd, uint8_t slave_id)
 	msg_push_crc(cmd);
 }
 
-static void echo_delay(struct fsi_master_gpio *master)
-{
-	set_sda_output(master, 1);
-	clock_toggle(master, master->t_echo_delay);
-}
-
 static void build_term_command(struct fsi_gpio_msg *cmd, uint8_t slave_id)
 {
 	cmd->bits = 0;
diff --git a/include/trace/events/fsi_master_gpio.h b/include/trace/events/fsi_master_gpio.h
index 389082132433..70ef66e63e84 100644
--- a/include/trace/events/fsi_master_gpio.h
+++ b/include/trace/events/fsi_master_gpio.h
@@ -50,6 +50,22 @@ TRACE_EVENT(fsi_master_gpio_out,
 	)
 );
 
+TRACE_EVENT(fsi_master_gpio_clock_zeros,
+	TP_PROTO(const struct fsi_master_gpio *master, int clocks),
+	TP_ARGS(master, clocks),
+	TP_STRUCT__entry(
+		__field(int,	master_idx)
+		__field(int,	clocks)
+	),
+	TP_fast_assign(
+		__entry->master_idx = master->master.idx;
+		__entry->clocks = clocks;
+	),
+	TP_printk("fsi-gpio%d clock %d zeros",
+		  __entry->master_idx, __entry->clocks
+	)
+);
+
 TRACE_EVENT(fsi_master_gpio_break,
 	TP_PROTO(const struct fsi_master_gpio *master),
 	TP_ARGS(master),
@@ -107,6 +123,49 @@ TRACE_EVENT(fsi_master_gpio_poll_response_busy,
 		__entry->master_idx, __entry->busy)
 );
 
+TRACE_EVENT(fsi_master_gpio_cmd_abs_addr,
+	TP_PROTO(const struct fsi_master_gpio *master, u32 addr),
+	TP_ARGS(master, addr),
+	TP_STRUCT__entry(
+		__field(int,	master_idx)
+		__field(u32,	addr)
+	),
+	TP_fast_assign(
+		__entry->master_idx = master->master.idx;
+		__entry->addr = addr;
+	),
+	TP_printk("fsi-gpio%d: Sending ABS_ADR %06x",
+		__entry->master_idx, __entry->addr)
+);
+
+TRACE_EVENT(fsi_master_gpio_cmd_rel_addr,
+	TP_PROTO(const struct fsi_master_gpio *master, u32 rel_addr),
+	TP_ARGS(master, rel_addr),
+	TP_STRUCT__entry(
+		__field(int,	master_idx)
+		__field(u32,	rel_addr)
+	),
+	TP_fast_assign(
+		__entry->master_idx = master->master.idx;
+		__entry->rel_addr = rel_addr;
+	),
+	TP_printk("fsi-gpio%d: Sending REL_ADR %03x",
+		__entry->master_idx, __entry->rel_addr)
+);
+
+TRACE_EVENT(fsi_master_gpio_cmd_same_addr,
+	TP_PROTO(const struct fsi_master_gpio *master),
+	TP_ARGS(master),
+	TP_STRUCT__entry(
+		__field(int,	master_idx)
+	),
+	TP_fast_assign(
+		__entry->master_idx = master->master.idx;
+	),
+	TP_printk("fsi-gpio%d: Sending SAME_ADR",
+		__entry->master_idx)
+);
+
 #endif /* _TRACE_FSI_MASTER_GPIO_H */
 
 #include <trace/define_trace.h>
-- 
2.17.1

