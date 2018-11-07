Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE04C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051792086A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JcEHsVh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051792086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389394AbeKGKC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:02:29 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51576 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388999AbeKGKBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:01:17 -0500
Received: by mail-it1-f196.google.com with SMTP id h13so20647465itl.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 16:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pjR6c17n71mFi43rsN43F9+YeBe4+W87Vl2pubTjX8Y=;
        b=JcEHsVh0QqP4kppevC18a/zV3PQuPgIqQjhrDth4+/9x1A1xClctVmXWKVi2OILfp7
         Uw4RzqtL2hTAp2Dgh0P1QoeIGhONygHVdWdIZGooPkZXp+HothKObXa8fug9dWcJ5kRQ
         IMmNwET/TNFx1EKZFemtFOi6cIcL7gjwzDEeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pjR6c17n71mFi43rsN43F9+YeBe4+W87Vl2pubTjX8Y=;
        b=NL/PNZ3ndTV3po95xO6f98EJ5WRnTYTabVwydvjn7fg5LCa0TEagQB8OlIRVZ4tCUi
         DpZqIQH7PrFXpma2xbtRDY2B4eNVn/+/ewWbgaIyIdeuIwlIWW4+nBLhvImWs+cxgznT
         61hPqaXjKmv3hKms38hFnT0AXc5Ni8xiuq5nsyvpnYrDMsCVRu53WviasKeH5ARICKUj
         V/1WAIcuyFwty4W+uyikDhNrlhqUygg3KxyaGrX6ZTzTVpDBFJGii3OcK7bO/hgzQLCG
         i/3x2tB/jqxqI42sQmrWiUIt4xVtI8piFblNDzQqpjNYETz2VXh8dc5zOwj15FP/X0Du
         auPw==
X-Gm-Message-State: AGRZ1gIL7UWXNDdoRUg19OpQK+LeAFIfBQUes6gyjnkL2ik7kE6JcjiH
        BXjTVkxytNF002km+cf2cdNlGg==
X-Google-Smtp-Source: AJdET5ffHAVmGYx/GCJgg5CdeaTgOddjw2kG6DYRYxU/2j08VdsOfpJ8EDm38lXsTj/2TFzQ1JXekg==
X-Received: by 2002:a24:140b:: with SMTP id 11-v6mr112774itg.59.1541550800007;
        Tue, 06 Nov 2018 16:33:20 -0800 (PST)
Received: from shibby.gateway.innflux.com ([66.228.239.218])
        by smtp.gmail.com with ESMTPSA id e184-v6sm1061128ite.9.2018.11.06.16.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 16:33:19 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        syadagir@codeaurora.org, mjavid@codeaurora.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: [RFC PATCH 04/12] soc: qcom: ipa: immediate commands
Date:   Tue,  6 Nov 2018 18:32:42 -0600
Message-Id: <20181107003250.5832-5-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181107003250.5832-1-elder@linaro.org>
References: <20181107003250.5832-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains (mostly) code implementing "immediate commands."
(The source files are still named "ipahal" for historical reasons.)

One channel (APPS CMD_PROD) is used for sending commands *to* the
IPA itself, rather than passing data through it.  These immediate
commands are issued to the IPA using the normal GSI queueing
mechanism.  And each command's completion is handled using the
normal GSI transfer completion mechanisms.

In addition to immediate commands, the "IPA HAL" includes code for
interpreting status packets that are supplied to the IPA on consumer
channels.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipahal.c | 541 +++++++++++++++++++++++++++++++++++++++
 drivers/net/ipa/ipahal.h | 253 ++++++++++++++++++
 2 files changed, 794 insertions(+)
 create mode 100644 drivers/net/ipa/ipahal.c
 create mode 100644 drivers/net/ipa/ipahal.h

diff --git a/drivers/net/ipa/ipahal.c b/drivers/net/ipa/ipahal.c
new file mode 100644
index 000000000000..de00bcd54d4f
--- /dev/null
+++ b/drivers/net/ipa/ipahal.c
@@ -0,0 +1,541 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2018 Linaro Ltd.
+ */
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <asm/unaligned.h>
+
+#include "ipahal.h"
+#include "ipa_i.h"	/* ipa_err() */
+#include "ipa_dma.h"
+
+/**
+ * DOC:  IPA Immediate Commands
+ *
+ * The APPS_CMD_PROD channel is used to issue immediate commands to
+ * the IPA.  An immediate command is generally used to request the
+ * IPA do something other than data transfer.
+ *
+ * An immediate command is represented by a GSI transfer element.
+ * Each immediate command has a well-defined format, with a known
+ * length.  The transfer element's length field can therefore be
+ * used to hold a command's opcode.  The "payload" of an immediate
+ * command contains additional information required for the command.
+ * It resides in DRAM and is referred to using the DMA memory data
+ * pointer (the same one used to refer to the data in a "normal"
+ * transfer).
+ *
+ * Immediate commands are issued to the IPA through the APPS_CMD_PROD
+ * channel using the normal GSI queueing mechanism.  And each command's
+ * completion is handled using the normal GSI transfer completion
+ * mechanisms.
+ */
+
+/**
+ * struct ipahal_context - HAL global context data
+ * @empty_fltrt_tbl:	Empty table to be used for table initialization
+ */
+static struct ipahal_context {
+	struct ipa_dma_mem empty_fltrt_tbl;
+} ipahal_ctx_struct;
+static struct ipahal_context *ipahal_ctx = &ipahal_ctx_struct;
+
+/* enum ipa_pipeline_clear_option - Values for pipeline clear waiting options
+ * @IPAHAL_HPS_CLEAR: Wait for HPS clear. All queues except high priority queue
+ *  shall not be serviced until HPS is clear of packets or immediate commands.
+ *  The high priority Rx queue / Q6ZIP group shall still be serviced normally.
+ *
+ * @IPAHAL_SRC_GRP_CLEAR: Wait for originating source group to be clear
+ *  (for no packet contexts allocated to the originating source group).
+ *  The source group / Rx queue shall not be serviced until all previously
+ *  allocated packet contexts are released. All other source groups/queues shall
+ *  be serviced normally.
+ *
+ * @IPAHAL_FULL_PIPELINE_CLEAR: Wait for full pipeline to be clear.
+ *  All groups / Rx queues shall not be serviced until IPA pipeline is fully
+ *  clear. This should be used for debug only.
+ *
+ *  The values assigned to these are assumed by the REGISTER_WRITE
+ *  (struct ipa_imm_cmd_hw_register_write) and the DMA_SHARED_MEM
+ *  (struct ipa_imm_cmd_hw_dma_shared_mem) immediate commands for
+ *  IPA version 3 hardware.  They are also used to modify the opcode
+ *  used to implement these commands for IPA version 4 hardware.
+ */
+enum ipahal_pipeline_clear_option {
+	IPAHAL_HPS_CLEAR		= 0,
+	IPAHAL_SRC_GRP_CLEAR		= 1,
+	IPAHAL_FULL_PIPELINE_CLEAR	= 2,
+};
+
+/* Immediate commands H/W structures */
+
+/* struct ipa_imm_cmd_hw_ip_fltrt_init - IP_V*_FILTER_INIT/IP_V*_ROUTING_INIT
+ * command payload in H/W format.
+ * Inits IPv4/v6 routing or filter block.
+ * @hash_rules_addr: Addr in system mem where hashable flt/rt rules starts
+ * @hash_rules_size: Size in bytes of the hashable tbl to cpy to local mem
+ * @hash_local_addr: Addr in shared mem where hashable flt/rt tbl should
+ *  be copied to
+ * @nhash_rules_size: Size in bytes of the non-hashable tbl to cpy to local mem
+ * @nhash_local_addr: Addr in shared mem where non-hashable flt/rt tbl should
+ *  be copied to
+ * @rsvd: reserved
+ * @nhash_rules_addr: Addr in sys mem where non-hashable flt/rt tbl starts
+ */
+struct ipa_imm_cmd_hw_ip_fltrt_init {
+	u64 hash_rules_addr;
+	u64 hash_rules_size	: 12,
+	    hash_local_addr	: 16,
+	    nhash_rules_size	: 12,
+	    nhash_local_addr	: 16,
+	    rsvd		: 8;
+	u64 nhash_rules_addr;
+};
+
+/* struct ipa_imm_cmd_hw_hdr_init_local - HDR_INIT_LOCAL command payload
+ *  in H/W format.
+ * Inits hdr table within local mem with the hdrs and their length.
+ * @hdr_table_addr: Word address in sys mem where the table starts (SRC)
+ * @size_hdr_table: Size of the above (in bytes)
+ * @hdr_addr: header address in IPA sram (used as DST for memory copy)
+ * @rsvd: reserved
+ */
+struct ipa_imm_cmd_hw_hdr_init_local {
+	u64 hdr_table_addr;
+	u32 size_hdr_table	: 12,
+	    hdr_addr		: 16,
+	    rsvd		: 4;
+};
+
+/* struct ipa_imm_cmd_hw_dma_shared_mem - DMA_SHARED_MEM command payload
+ *  in H/W format.
+ * Perform mem copy into or out of the SW area of IPA local mem
+ * @sw_rsvd: Ignored by H/W. My be used by S/W
+ * @size: Size in bytes of data to copy. Expected size is up to 2K bytes
+ * @local_addr: Address in IPA local memory
+ * @direction: Read or write?
+ *	0: IPA write, Write to local address from system address
+ *	1: IPA read, Read from local address to system address
+ * @skip_pipeline_clear: 0 to wait until IPA pipeline is clear. 1 don't wait
+ * @pipeline_clear_options: options for pipeline to clear
+ *	0: HPS - no pkt inside HPS (not grp specific)
+ *	1: source group - The immediate cmd src grp does npt use any pkt ctxs
+ *	2: Wait until no pkt reside inside IPA pipeline
+ *	3: reserved
+ * @rsvd: reserved - should be set to zero
+ * @system_addr: Address in system memory
+ */
+struct ipa_imm_cmd_hw_dma_shared_mem {
+	u16 sw_rsvd;
+	u16 size;
+	u16 local_addr;
+	u16 direction			: 1,
+	    skip_pipeline_clear		: 1,
+	    pipeline_clear_options	: 2,
+	    rsvd			: 12;
+	u64 system_addr;
+};
+
+/* struct ipa_imm_cmd_hw_dma_task_32b_addr -
+ *	IPA_DMA_TASK_32B_ADDR command payload in H/W format.
+ * Used by clients using 32bit addresses. Used to perform DMA operation on
+ *  multiple descriptors.
+ *  The Opcode is dynamic, where it holds the number of buffer to process
+ * @sw_rsvd: Ignored by H/W. My be used by S/W
+ * @cmplt: Complete flag: When asserted IPA will interrupt SW when the entire
+ *  DMA related data was completely xfered to its destination.
+ * @eof: Enf Of Frame flag: When asserted IPA will assert the EOT to the
+ *  dest client. This is used used for aggr sequence
+ * @flsh: Flush flag: When asserted, pkt will go through the IPA blocks but
+ *  will not be xfered to dest client but rather will be discarded
+ * @lock: Lock endpoint flag: When asserted, IPA will stop processing
+ *  descriptors from other EPs in the same src grp (RX queue)
+ * @unlock: Unlock endpoint flag: When asserted, IPA will stop exclusively
+ *  servicing current EP out of the src EPs of the grp (RX queue)
+ * @size1: Size of buffer1 data
+ * @addr1: Pointer to buffer1 data
+ * @packet_size: Total packet size. If a pkt send using multiple DMA_TASKs,
+ *  only the first one needs to have this field set. It will be ignored
+ *  in subsequent DMA_TASKs until the packet ends (EOT). First DMA_TASK
+ *  must contain this field (2 or more buffers) or EOT.
+ */
+struct ipa_imm_cmd_hw_dma_task_32b_addr {
+	u16 sw_rsvd	: 11,
+	    cmplt	: 1,
+	    eof		: 1,
+	    flsh	: 1,
+	    lock	: 1,
+	    unlock	: 1;
+	u16 size1;
+	u32 addr1;
+	u16 packet_size;
+	u16 rsvd1;
+	u32 rsvd2;
+};
+
+/* IPA Status packet H/W structures and info */
+
+/* struct ipa_status_pkt_hw - IPA status packet payload in H/W format.
+ *  This structure describes the status packet H/W structure for the
+ *   following statuses: IPA_STATUS_PACKET, IPA_STATUS_DROPPED_PACKET,
+ *   IPA_STATUS_SUSPENDED_PACKET.
+ *  Other statuses types has different status packet structure.
+ * @status_opcode: The Type of the status (Opcode).
+ * @exception: (not bitmask) - the first exception that took place.
+ *  In case of exception, src endp and pkt len are always valid.
+ * @status_mask: Bit mask specifying on which H/W blocks the pkt was processed.
+ * @pkt_len: Pkt payload len including hdr, include retained hdr if used. Does
+ *  not include padding or checksum trailer len.
+ * @endp_src_idx: Source end point index.
+ * @rsvd1: reserved
+ * @endp_dest_idx: Destination end point index.
+ *  Not valid in case of exception
+ * @rsvd2: reserved
+ * @metadata: meta data value used by packet
+ * @flt_local: Filter table location flag: Does matching flt rule belongs to
+ *  flt tbl that resides in lcl memory? (if not, then system mem)
+ * @flt_hash: Filter hash hit flag: Does matching flt rule was in hash tbl?
+ * @flt_global: Global filter rule flag: Does matching flt rule belongs to
+ *  the global flt tbl? (if not, then the per endp tables)
+ * @flt_ret_hdr: Retain header in filter rule flag: Does matching flt rule
+ *  specifies to retain header?
+ * @flt_rule_id: The ID of the matching filter rule. This info can be combined
+ *  with endp_src_idx to locate the exact rule. ID=0x3ff reserved to specify
+ *  flt miss. In case of miss, all flt info to be ignored
+ * @rt_local: Route table location flag: Does matching rt rule belongs to
+ *  rt tbl that resides in lcl memory? (if not, then system mem)
+ * @rt_hash: Route hash hit flag: Does matching rt rule was in hash tbl?
+ * @ucp: UC Processing flag.
+ * @rt_tbl_idx: Index of rt tbl that contains the rule on which was a match
+ * @rt_rule_id: The ID of the matching rt rule. This info can be combined
+ *  with rt_tbl_idx to locate the exact rule. ID=0x3ff reserved to specify
+ *  rt miss. In case of miss, all rt info to be ignored
+ * @nat_hit: NAT hit flag: Was their NAT hit?
+ * @nat_entry_idx: Index of the NAT entry used of NAT processing
+ * @nat_type: Defines the type of the NAT operation (ignored for now)
+ * @tag_info: S/W defined value provided via immediate command
+ * @seq_num: Per source endp unique packet sequence number
+ * @time_of_day_ctr: running counter from IPA clock
+ * @hdr_local: Header table location flag: In header insertion, was the header
+ *  taken from the table resides in local memory? (If no, then system mem)
+ * @hdr_offset: Offset of used header in the header table
+ * @frag_hit: Frag hit flag: Was their frag rule hit in H/W frag table?
+ * @frag_rule: Frag rule index in H/W frag table in case of frag hit
+ * @hw_specific: H/W specific reserved value
+ */
+#define IPA_RULE_ID_BITS	10	/* See ipahal_is_rule_miss_id() */
+struct ipa_pkt_status_hw {
+	u8  status_opcode;
+	u8  exception;
+	u16 status_mask;
+	u16 pkt_len;
+	u8  endp_src_idx	: 5,
+	    rsvd1		: 3;
+	u8  endp_dest_idx	: 5,
+	    rsvd2		: 3;
+	u32 metadata;
+	u16 flt_local		: 1,
+	    flt_hash		: 1,
+	    flt_global		: 1,
+	    flt_ret_hdr		: 1,
+	    flt_rule_id		: IPA_RULE_ID_BITS,
+	    rt_local		: 1,
+	    rt_hash		: 1;
+	u16 ucp			: 1,
+	    rt_tbl_idx		: 5,
+	    rt_rule_id		: IPA_RULE_ID_BITS;
+	u64 nat_hit		: 1,
+	    nat_entry_idx	: 13,
+	    nat_type		: 2,
+	    tag_info		: 48;
+	u32 seq_num		: 8,
+	    time_of_day_ctr	: 24;
+	u16 hdr_local		: 1,
+	    hdr_offset		: 10,
+	    frag_hit		: 1,
+	    frag_rule		: 4;
+	u16 hw_specific;
+};
+
+void *ipahal_dma_shared_mem_write_pyld(struct ipa_dma_mem *mem, u32 offset)
+{
+	struct ipa_imm_cmd_hw_dma_shared_mem *data;
+
+	ipa_assert(mem->size < 1 << 16);	/* size is 16 bits wide */
+	ipa_assert(offset < 1 << 16);		/* local_addr is 16 bits wide */
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return NULL;
+
+	data->size = mem->size;
+	data->local_addr = offset;
+	data->direction = 0;	/* 0 = write to IPA; 1 = read from IPA */
+	data->skip_pipeline_clear = 0;
+	data->pipeline_clear_options = IPAHAL_HPS_CLEAR;
+	data->system_addr = mem->phys;
+
+	return data;
+}
+
+void *ipahal_hdr_init_local_pyld(struct ipa_dma_mem *mem, u32 offset)
+{
+	struct ipa_imm_cmd_hw_hdr_init_local *data;
+
+	ipa_assert(mem->size < 1 << 12);  /* size_hdr_table is 12 bits wide */
+	ipa_assert(offset < 1 << 16);		/* hdr_addr is 16 bits wide */
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return NULL;
+
+	data->hdr_table_addr = mem->phys;
+	data->size_hdr_table = mem->size;
+	data->hdr_addr = offset;
+
+	return data;
+}
+
+static void *fltrt_init_common(struct ipa_dma_mem *mem, u32 hash_offset,
+			       u32 nhash_offset)
+{
+	struct ipa_imm_cmd_hw_ip_fltrt_init *data;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return NULL;
+
+	data->hash_rules_addr = (u64)mem->phys;
+	data->hash_rules_size = (u32)mem->size;
+	data->hash_local_addr = hash_offset;
+	data->nhash_rules_addr = (u64)mem->phys;
+	data->nhash_rules_size = (u32)mem->size;
+	data->nhash_local_addr = nhash_offset;
+
+	return data;
+}
+
+void *ipahal_ip_v4_routing_init_pyld(struct ipa_dma_mem *mem, u32 hash_offset,
+			       u32 nhash_offset)
+{
+	return fltrt_init_common(mem, hash_offset, nhash_offset);
+}
+
+void *ipahal_ip_v6_routing_init_pyld(struct ipa_dma_mem *mem, u32 hash_offset,
+				     u32 nhash_offset)
+{
+	return fltrt_init_common(mem, hash_offset, nhash_offset);
+}
+
+void *ipahal_ip_v4_filter_init_pyld(struct ipa_dma_mem *mem, u32 hash_offset,
+				    u32 nhash_offset)
+{
+	return fltrt_init_common(mem, hash_offset, nhash_offset);
+}
+
+void *ipahal_ip_v6_filter_init_pyld(struct ipa_dma_mem *mem, u32 hash_offset,
+				    u32 nhash_offset)
+{
+	return fltrt_init_common(mem, hash_offset, nhash_offset);
+}
+
+void *ipahal_dma_task_32b_addr_pyld(struct ipa_dma_mem *mem)
+{
+	struct ipa_imm_cmd_hw_dma_task_32b_addr *data;
+
+	/* size1 and packet_size are both 16 bits wide */
+	ipa_assert(mem->size < 1 << 16);
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return NULL;
+
+	data->cmplt = 0;
+	data->eof = 0;
+	data->flsh = 1;
+	data->lock = 0;
+	data->unlock = 0;
+	data->size1 = mem->size;
+	data->addr1 = mem->phys;
+	data->packet_size = mem->size;
+
+	return data;
+}
+
+void ipahal_payload_free(void *payload)
+{
+	kfree(payload);
+}
+
+/* IPA Packet Status Logic */
+
+/* Maps an exception type returned in a ipa_pkt_status_hw structure
+ * to the ipahal_pkt_status_exception value that represents it in
+ * the exception field of a ipahal_pkt_status structure.  Returns
+ * IPAHAL_PKT_STATUS_EXCEPTION_MAX for an unrecognized value.
+ */
+static enum ipahal_pkt_status_exception
+exception_map(u8 exception, bool is_ipv6)
+{
+	switch (exception) {
+	case 0x00:	return IPAHAL_PKT_STATUS_EXCEPTION_NONE;
+	case 0x01:	return IPAHAL_PKT_STATUS_EXCEPTION_DEAGGR;
+	case 0x04:	return IPAHAL_PKT_STATUS_EXCEPTION_IPTYPE;
+	case 0x08:	return IPAHAL_PKT_STATUS_EXCEPTION_PACKET_LENGTH;
+	case 0x10:	return IPAHAL_PKT_STATUS_EXCEPTION_FRAG_RULE_MISS;
+	case 0x20:	return IPAHAL_PKT_STATUS_EXCEPTION_SW_FILT;
+	case 0x40:	return is_ipv6 ? IPAHAL_PKT_STATUS_EXCEPTION_IPV6CT
+				       : IPAHAL_PKT_STATUS_EXCEPTION_NAT;
+	default:	return IPAHAL_PKT_STATUS_EXCEPTION_MAX;
+	}
+}
+
+/* ipahal_pkt_status_get_size() - Get H/W size of packet status */
+u32 ipahal_pkt_status_get_size(void)
+{
+	return sizeof(struct ipa_pkt_status_hw);
+}
+
+/* ipahal_pkt_status_parse() - Parse Packet Status payload to abstracted form
+ * @unparsed_status: Pointer to H/W format of the packet status as read from H/W
+ * @status: Pointer to pre-allocated buffer where the parsed info will be stored
+ */
+void ipahal_pkt_status_parse(const void *unparsed_status,
+			     struct ipahal_pkt_status *status)
+{
+	const struct ipa_pkt_status_hw *hw_status = unparsed_status;
+	bool is_ipv6;
+
+	status->status_opcode =
+			(enum ipahal_pkt_status_opcode)hw_status->status_opcode;
+	is_ipv6 = hw_status->status_mask & BIT(7) ? false : true;
+	/* If hardware status values change we may have to re-map this */
+	status->status_mask =
+			(enum ipahal_pkt_status_mask)hw_status->status_mask;
+	status->exception = exception_map(hw_status->exception, is_ipv6);
+	status->pkt_len = hw_status->pkt_len;
+	status->endp_src_idx = hw_status->endp_src_idx;
+	status->endp_dest_idx = hw_status->endp_dest_idx;
+	status->metadata = hw_status->metadata;
+	status->rt_miss = ipahal_is_rule_miss_id(hw_status->rt_rule_id);
+}
+
+int ipahal_init(void)
+{
+	struct ipa_dma_mem *mem = &ipahal_ctx->empty_fltrt_tbl;
+
+	/* Set up an empty filter/route table entry in system
+	 * memory.  This will be used, for example, to delete a
+	 * route safely.
+	 */
+	if (ipa_dma_alloc(mem, IPA_HW_TBL_WIDTH, GFP_KERNEL)) {
+		ipa_err("error allocating empty filter/route table\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void ipahal_exit(void)
+{
+	ipa_dma_free(&ipahal_ctx->empty_fltrt_tbl);
+}
+
+/* Does the given rule ID represent a routing or filter rule miss?
+ * A rule miss is indicated as an all-1's value in the rt_rule_id
+ * or flt_rule_id field of the ipahal_pkt_status structure.
+ */
+bool ipahal_is_rule_miss_id(u32 id)
+{
+	BUILD_BUG_ON(IPA_RULE_ID_BITS < 2);
+
+	return id == (1U << IPA_RULE_ID_BITS) - 1;
+}
+
+/**
+ * ipahal_rt_generate_empty_img() - Generate empty route table header
+ * @route_count:	Number of table entries
+ * @mem:		DMA memory object representing the header structure
+ *
+ * Allocates and fills an "empty" route table header having the given
+ * number of entries.  Each entry in the table contains the DMA address
+ * of a routing entry.
+ *
+ * This function initializes all entries to point at the preallocated
+ * empty routing entry in system RAM.
+ *
+ * Return:	0 if successful, or a negative error code otherwise
+ */
+int ipahal_rt_generate_empty_img(u32 route_count, struct ipa_dma_mem *mem)
+{
+	u64 addr;
+	int i;
+
+	BUILD_BUG_ON(!IPA_HW_TBL_HDR_WIDTH);
+
+	if (ipa_dma_alloc(mem, route_count * IPA_HW_TBL_HDR_WIDTH, GFP_KERNEL))
+		return -ENOMEM;
+
+	addr = (u64)ipahal_ctx->empty_fltrt_tbl.phys;
+	for (i = 0; i < route_count; i++)
+		put_unaligned(addr, mem->virt + i * IPA_HW_TBL_HDR_WIDTH);
+
+	return 0;
+}
+
+/**
+ * ipahal_flt_generate_empty_img() - Generate empty filter table header
+ * @filter_bitmap:	Bitmap representing which endpoints support filtering
+ * @mem:		DMA memory object representing the header structure
+ *
+ * Allocates and fills an "empty" filter table header based on the
+ * given filter bitmap.
+ *
+ * The first slot in a filter table header is a 64-bit bitmap whose
+ * set bits define which endpoints support filtering.  Following
+ * this, each set bit in the mask has the DMA address of the filter
+ * used for the corresponding endpoint.
+ *
+ * This function initializes all endpoints that support filtering to
+ * point at the preallocated empty filter in system RAM.
+ *
+ * Note:  the (software) bitmap here uses bit 0 to represent
+ * endpoint 0, bit 1 for endpoint 1, and so on.  This is different
+ * from the hardware (which uses bit 1 to represent filter 0, etc.).
+ *
+ * Return:	0 if successful, or a negative error code
+ */
+int ipahal_flt_generate_empty_img(u64 filter_bitmap, struct ipa_dma_mem *mem)
+{
+	u32 filter_count = hweight32(filter_bitmap) + 1;
+	u64 addr;
+	int i;
+
+	ipa_assert(filter_bitmap);
+
+	if (ipa_dma_alloc(mem, filter_count * IPA_HW_TBL_HDR_WIDTH, GFP_KERNEL))
+		return -ENOMEM;
+
+	/* Save the endpoint bitmap in the first slot of the table.
+	 * Convert it from software to hardware representation by
+	 * shifting it left one position.
+	 * XXX Does bit position 0 represent global?  At IPA3, global
+	 * XXX configuration is possible but not used.
+	 */
+	put_unaligned(filter_bitmap << 1, mem->virt);
+
+	/* Point every entry in the table at the empty filter */
+	addr = (u64)ipahal_ctx->empty_fltrt_tbl.phys;
+	for (i = 1; i < filter_count; i++)
+		put_unaligned(addr, mem->virt + i * IPA_HW_TBL_HDR_WIDTH);
+
+	return 0;
+}
+
+void ipahal_free_empty_img(struct ipa_dma_mem *mem)
+{
+	ipa_dma_free(mem);
+}
diff --git a/drivers/net/ipa/ipahal.h b/drivers/net/ipa/ipahal.h
new file mode 100644
index 000000000000..940254940d90
--- /dev/null
+++ b/drivers/net/ipa/ipahal.h
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2018 Linaro Ltd.
+ */
+#ifndef _IPAHAL_H_
+#define _IPAHAL_H_
+
+#include <linux/types.h>
+
+#include "ipa_dma.h"
+
+/* The IPA implements offloaded packet filtering and routing
+ * capabilities.  This is managed by programming IPA-resident
+ * tables of rules that define the processing that should be
+ * performed by the IPA and the conditions under which they
+ * should be applied.  Aspects of these rules are constrained
+ * by things like table entry sizes and alignment requirements;
+ * all of these are in units of bytes.  These definitions are
+ * subject to some constraints:
+ * - IPA_HW_TBL_WIDTH must be non-zero
+ * - IPA_HW_TBL_SYSADDR_ALIGN must be a non-zero power of 2
+ * - IPA_HW_TBL_HDR_WIDTH must be non-zero
+ *
+ * Values could differ for different versions of IPA hardware.
+ * These values are for v3.5.1, found in the SDM845.
+ */
+#define IPA_HW_TBL_WIDTH		8
+#define IPA_HW_TBL_SYSADDR_ALIGN	128
+#define IPA_HW_TBL_HDR_WIDTH		8
+
+/**
+ * ipahal_dma_shared_mem_write_pyld() - Write to shared memory command payload
+ *
+ * Return a pointer to the payload for a DMA shared memory write immediate
+ * command, or null if one can't be allocated.  Result is dynamically
+ * allocated, and caller must ensure it gets released by providing it to
+ * ipahal_destroy_imm_cmd() when it is no longer needed.
+ *
+ * Return:	 Pointer to the immediate command payload, or NULL
+ */
+void *ipahal_dma_shared_mem_write_pyld(struct ipa_dma_mem *mem, u32 offset);
+
+/**
+ * ipahal_hdr_init_local_pyld() - Header initialization command payload
+ * mem:		DMA buffer containing data for initialization
+ * offset:	Where in location IPA local memory to write
+ *
+ * Return a pointer to the payload for a header init local immediate
+ * command, or null if one can't be allocated.  Caller must ensure result
+ * gets released by providing it to ipahal_destroy_imm_cmd().
+ *
+ * Return:	 Pointer to the immediate command payload, or NULL
+ */
+void *ipahal_hdr_init_local_pyld(struct ipa_dma_mem *mem, u32 offset);
+
+/**
+ * ipahal_ip_v4_routing_init_pyld() - IPv4 routing table initialization payload
+ * mem:		The IPv4 routing table data to be written
+ * hash_offset:	The location in IPA memory for a hashed routing table
+ * nhash_offset: The location in IPA memory for a non-hashed routing table
+ *
+ * Return a pointer to the payload for an IPv4 routing init immediate
+ * command, or null if one can't be allocated.  Caller must ensure result
+ * gets released by providing it to ipahal_destroy_imm_cmd().
+ *
+ * Return:	 Pointer to the immediate command payload, or NULL
+ */
+void *ipahal_ip_v4_routing_init_pyld(struct ipa_dma_mem *mem,
+				     u32 hash_offset, u32 nhash_offset);
+
+/**
+ * ipahal_ip_v6_routing_init_pyld() - IPv6 routing table initialization payload
+ * mem:		The IPv6 routing table data to be written
+ * hash_offset:	The location in IPA memory for a hashed routing table
+ * nhash_offset: The location in IPA memory for a non-hashed routing table
+ *
+ * Return a pointer to the payload for an IPv4 routing init immediate
+ * command, or null if one can't be allocated.  Caller must ensure result
+ * gets released by providing it to ipahal_destroy_imm_cmd().
+ *
+ * Return:	 Pointer to the immediate command payload, or NULL
+ */
+void *ipahal_ip_v6_routing_init_pyld(struct ipa_dma_mem *mem,
+				     u32 hash_offset, u32 nhash_offset);
+
+/**
+ * ipahal_ip_v4_filter_init_pyld() - IPv4 filter table initialization payload
+ * mem:		The IPv4 filter table data to be written
+ * hash_offset:	The location in IPA memory for a hashed filter table
+ * nhash_offset: The location in IPA memory for a non-hashed filter table
+ *
+ * Return a pointer to the payload for an IPv4 filter init immediate
+ * command, or null if one can't be allocated.  Caller must ensure result
+ * gets released by providing it to ipahal_destroy_imm_cmd().
+ *
+ * Return:	 Pointer to the immediate command payload, or NULL
+ */
+void *ipahal_ip_v4_filter_init_pyld(struct ipa_dma_mem *mem,
+				    u32 hash_offset, u32 nhash_offset);
+
+/**
+ * ipahal_ip_v6_filter_init_pyld() - IPv6 filter table initialization payload
+ * mem:		The IPv6 filter table data to be written
+ * hash_offset:	The location in IPA memory for a hashed filter table
+ * nhash_offset: The location in IPA memory for a non-hashed filter table
+ *
+ * Return a pointer to the payload for an IPv4 filter init immediate
+ * command, or null if one can't be allocated.  Caller must ensure result
+ * gets released by providing it to ipahal_destroy_imm_cmd().
+ *
+ * Return:	 Pointer to the immediate command payload, or NULL
+ */
+void *ipahal_ip_v6_filter_init_pyld(struct ipa_dma_mem *mem,
+				    u32 hash_offset, u32 nhash_offset);
+
+/**
+ * ipahal_dma_task_32b_addr_pyld() - 32-bit DMA task command payload
+ * mem:		DMA memory involved in the task
+ *
+ * Return a pointer to the payload for DMA task 32-bit address immediate
+ * command, or null if one can't be allocated.  Caller must ensure result
+ * gets released by providing it to ipahal_destroy_imm_cmd().
+ */
+void *ipahal_dma_task_32b_addr_pyld(struct ipa_dma_mem *mem);
+
+/**
+ * ipahal_payload_free() - Release an allocated immediate command payload
+ * @payload:	Payload to be released
+ */
+void ipahal_payload_free(void *payload);
+
+/**
+ * enum ipahal_pkt_status_opcode - Packet Status Opcode
+ * @IPAHAL_STATUS_OPCODE_PACKET_2ND_PASS: Packet Status generated as part of
+ *  IPA second processing pass for a packet (i.e. IPA XLAT processing for
+ *  the translated packet).
+ *
+ *  The values assigned here are assumed by ipa_pkt_status_parse()
+ *  to match values returned in the status_opcode field of a
+ *  ipa_pkt_status_hw structure inserted by the IPA in received
+ *  buffer.
+ */
+enum ipahal_pkt_status_opcode {
+	IPAHAL_PKT_STATUS_OPCODE_PACKET			= 0x01,
+	IPAHAL_PKT_STATUS_OPCODE_NEW_FRAG_RULE		= 0x02,
+	IPAHAL_PKT_STATUS_OPCODE_DROPPED_PACKET		= 0x04,
+	IPAHAL_PKT_STATUS_OPCODE_SUSPENDED_PACKET	= 0x08,
+	IPAHAL_PKT_STATUS_OPCODE_LOG			= 0x10,
+	IPAHAL_PKT_STATUS_OPCODE_DCMP			= 0x20,
+	IPAHAL_PKT_STATUS_OPCODE_PACKET_2ND_PASS	= 0x40,
+};
+
+/**
+ * enum ipahal_pkt_status_exception - Packet Status exception type
+ * @IPAHAL_PKT_STATUS_EXCEPTION_PACKET_LENGTH: formerly IHL exception.
+ *
+ * Note: IPTYPE, PACKET_LENGTH and PACKET_THRESHOLD exceptions means that
+ *  partial / no IP processing took place and corresponding Status Mask
+ *  fields should be ignored. Flt and rt info is not valid.
+ *
+ * NOTE:: Any change to this enum, need to change to
+ *	ipahal_pkt_status_exception_to_str array as well.
+ */
+enum ipahal_pkt_status_exception {
+	IPAHAL_PKT_STATUS_EXCEPTION_NONE = 0,
+	IPAHAL_PKT_STATUS_EXCEPTION_DEAGGR,
+	IPAHAL_PKT_STATUS_EXCEPTION_IPTYPE,
+	IPAHAL_PKT_STATUS_EXCEPTION_PACKET_LENGTH,
+	IPAHAL_PKT_STATUS_EXCEPTION_PACKET_THRESHOLD,
+	IPAHAL_PKT_STATUS_EXCEPTION_FRAG_RULE_MISS,
+	IPAHAL_PKT_STATUS_EXCEPTION_SW_FILT,
+	/* NAT and IPv6CT have the same value at HW.
+	 * NAT for IPv4 and IPv6CT for IPv6 exceptions
+	 */
+	IPAHAL_PKT_STATUS_EXCEPTION_NAT,
+	IPAHAL_PKT_STATUS_EXCEPTION_IPV6CT,
+	IPAHAL_PKT_STATUS_EXCEPTION_MAX,
+};
+
+/**
+ * enum ipahal_pkt_status_mask - Packet Status bitmask values of
+ *  the contained flags. This bitmask indicates flags on the properties of
+ *  the packet as well as IPA processing it may had.
+ * @TAG_VALID: Flag specifying if TAG and TAG info valid?
+ * @CKSUM_PROCESS: CSUM block processing flag: Was pkt processed by csum block?
+ *  If so, csum trailer exists
+ */
+enum ipahal_pkt_status_mask {
+	/* Other values are defined but are not specifically handled yet. */
+	IPAHAL_PKT_STATUS_MASK_CKSUM_PROCESS	= 0x0100,
+};
+
+/**
+ * struct ipahal_pkt_status - IPA status packet abstracted payload.
+ * @status_opcode: The type of status (Opcode).
+ * @exception: The first exception that took place.
+ *  In case of exception, endp_src_idx and pkt_len are always valid.
+ * @status_mask: Bit mask for flags on several properties on the packet
+ *  and processing it may passed at IPA.
+ * @pkt_len: Pkt pyld len including hdr and retained hdr if used. Does
+ *  not include padding or checksum trailer len.
+ * @endp_src_idx: Source end point index.
+ * @endp_dest_idx: Destination end point index.
+ *  Not valid in case of exception
+ * @metadata: meta data value used by packet
+ * @rt_miss: Routing miss flag: Was their a routing rule miss?
+ *
+ * This structure describes the status packet fields for the following
+ * status values: IPA_STATUS_PACKET, IPA_STATUS_DROPPED_PACKET,
+ * IPA_STATUS_SUSPENDED_PACKET.  Other status types have different status
+ * packet structure.  Note that the hardware supplies additional status
+ * information that is currently unused.
+ */
+struct ipahal_pkt_status {
+	enum ipahal_pkt_status_opcode status_opcode;
+	enum ipahal_pkt_status_exception exception;
+	enum ipahal_pkt_status_mask status_mask;
+	u32 pkt_len;
+	u8 endp_src_idx;
+	u8 endp_dest_idx;
+	u32 metadata;
+	bool rt_miss;
+};
+
+/**
+ * ipahal_pkt_status_get_size() - Get size of a hardware packet status
+ */
+u32 ipahal_pkt_status_get_size(void);
+
+/* ipahal_pkt_status_parse() - Parse packet status payload
+ * @unparsed_status:	Packet status read from hardware
+ * @status:		Buffer to hold parsed status information
+ */
+void ipahal_pkt_status_parse(const void *unparsed_status,
+			     struct ipahal_pkt_status *status);
+
+int ipahal_init(void);
+void ipahal_exit(void);
+
+/* Does the given ID represent rule miss? */
+bool ipahal_is_rule_miss_id(u32 id);
+
+int ipahal_rt_generate_empty_img(u32 route_count, struct ipa_dma_mem *mem);
+int ipahal_flt_generate_empty_img(u64 ep_bitmap, struct ipa_dma_mem *mem);
+
+/**
+ * ipahal_free_empty_img() - Free empty filter or route image
+ * @mem:	DMA memory containing filter/route data
+ */
+void ipahal_free_empty_img(struct ipa_dma_mem *mem);
+
+#endif /* _IPAHAL_H_ */
-- 
2.17.1

