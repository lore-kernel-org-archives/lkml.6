Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C75C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13182086A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TXtKPJI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13182086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389146AbeKGKB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:01:26 -0500
Received: from mail-it1-f180.google.com ([209.85.166.180]:55012 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389089AbeKGKBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:01:25 -0500
Received: by mail-it1-f180.google.com with SMTP id d6so20624412itl.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 16:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0GKhDEf7lvJjOn0Dlwq9iV8xpscxCdWsFGeeRB9JznA=;
        b=TXtKPJI9STO3svOaiaZbfwbDrvbGqsboQxdvt/yr3wLmbwvvwuNydSmFfSoqY3TlTH
         3M30AAAUVjo/z4YCkwa1YIvFtPp6LdULhzjpqSQdL+/8kJOa6XDqC85WRYsZYOWAQefI
         ZG3eoxdpRb2kTkgMapNRiEM5CC1L8gbsXtvak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0GKhDEf7lvJjOn0Dlwq9iV8xpscxCdWsFGeeRB9JznA=;
        b=QGfURD9UIIpjFuu9qkWpXQct7Z+dHmi+ucItBxJvJ1fNSc5n2xAUHCRZRVeb2rkN+B
         cFkPvHoDuG9g9zHBCos0eOvse8fRmlaVTOI2aEEkP23kG/+k3Hb/AyR28zyO1xEDVo+2
         58xAdgqsv7fN/mK5lvdw3dXGVhBDvEU7qM2+qIRhgHEI4rjjFrZalF3nqPyKslxhV5WT
         yIhm3KamqgOGjyx7C/L5jPal0BVReslUDE4lECbaIMJ8MBtjdIq2rFpdmsJDKBiczobH
         NZCZy3mdCaG6EJOmx8ulGOjGKocH0CdG9w+Htx1Ue3MSnTknkGb6XDqre1wNKQZ7qtHF
         3kCQ==
X-Gm-Message-State: AGRZ1gJ/yvao0kg1MmD9HMAdEKtcPUe15ZjFCZwSmN/c5I9kTB3FwbLK
        UU5kliY+6T902Z3M4qfCrnxc1Q==
X-Google-Smtp-Source: AJdET5evu0sOLfFKb8HLcCdTWnO7zCosLY0uz3Okg53UT4vilLHeJXX1AEu2GOiAyz0DowXa2FAoFg==
X-Received: by 2002:a24:ac02:: with SMTP id s2-v6mr104992ite.105.1541550808480;
        Tue, 06 Nov 2018 16:33:28 -0800 (PST)
Received: from shibby.gateway.innflux.com ([66.228.239.218])
        by smtp.gmail.com with ESMTPSA id e184-v6sm1061128ite.9.2018.11.06.16.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 16:33:27 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        syadagir@codeaurora.org, mjavid@codeaurora.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: [RFC PATCH 07/12] soc: qcom: ipa: IPA register abstraction
Date:   Tue,  6 Nov 2018 18:32:45 -0600
Message-Id: <20181107003250.5832-8-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181107003250.5832-1-elder@linaro.org>
References: <20181107003250.5832-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Much of the following is copied from text in "ipa_reg.c".  Please
see that for the more complete explanation.)

The IPA code abstracts the details of its 32-bit registers, allowing
access to them to be done generically.  The original motivation for
this was that the field width and/or position for values stored in
some registers differed for different versions of IPA hardware.
Abstracting access this way allows code that uses such registers to
be simpler, describing how register fields are used without
proliferating special-case code that is dependent on hardware
version.

Each IPA register has a name, which is one of the values in the
"ipa_reg" enumerated type (e.g., IPA_ENABLED_PIPES).  The offset
(memory address) of the register having a given name is maintained
internal to the "ipa_reg" module.

Some registers hold one or more fields that are less than 32 bits
wide.  Each of these registers has a data structure that breaks out
those fields into individual (32-bit) values.  These field structures
allow the register contents to be defined in a hardware independent
way.  Such registers have a pair of functions associated with them
to "construct" (when writing) and "parse" (when reading) the fields
found within them, using the register's fields structure.  This
allows the content of these registers to be read in a generic way.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_reg.c | 972 ++++++++++++++++++++++++++++++++++++++
 drivers/net/ipa/ipa_reg.h | 614 ++++++++++++++++++++++++
 2 files changed, 1586 insertions(+)
 create mode 100644 drivers/net/ipa/ipa_reg.c
 create mode 100644 drivers/net/ipa/ipa_reg.h

diff --git a/drivers/net/ipa/ipa_reg.c b/drivers/net/ipa/ipa_reg.c
new file mode 100644
index 000000000000..5e0aa6163235
--- /dev/null
+++ b/drivers/net/ipa/ipa_reg.c
@@ -0,0 +1,972 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2018 Linaro Ltd.
+ */
+
+#include <linux/types.h>
+#include <linux/io.h>
+#include <linux/bitfield.h>
+
+#include "ipa_reg.h"
+
+/* I/O remapped base address of IPA register space */
+static void __iomem *ipa_reg_virt;
+
+/* struct ipa_reg_desc - descriptor for an abstracted hardware register
+ *
+ * @construct - fn to construct the register value from its field structure
+ * @parse - function to parse register field values into its field structure
+ * @offset - register offset relative to base address
+ * @n_ofst - size multiplier for "N-parameterized" registers
+ */
+struct ipa_reg_desc {
+	u32 (*construct)(enum ipa_reg reg, const void *fields);
+	void (*parse)(enum ipa_reg reg, void *fields, u32 val);
+	u32 offset;
+	u16 n_ofst;
+};
+
+/* IPA_ROUTE register */
+
+void ipa_reg_route(struct ipa_reg_route *route, u32 ep_id)
+{
+	route->route_dis = 0;
+	route->route_def_pipe = ep_id;
+	route->route_def_hdr_table = 1;
+	route->route_def_hdr_ofst = 0;
+	route->route_frag_def_pipe = ep_id;
+	route->route_def_retain_hdr = 1;
+}
+
+#define ROUTE_DIS_FMASK			0x00000001
+#define ROUTE_DEF_PIPE_FMASK		0x0000003e
+#define ROUTE_DEF_HDR_TABLE_FMASK	0x00000040
+#define ROUTE_DEF_HDR_OFST_FMASK	0x0001ff80
+#define ROUTE_FRAG_DEF_PIPE_FMASK	0x003e0000
+#define ROUTE_DEF_RETAIN_HDR_FMASK	0x01000000
+
+static u32 ipa_reg_construct_route(enum ipa_reg reg, const void *fields)
+{
+	const struct ipa_reg_route *route = fields;
+	u32 val;
+
+	val = FIELD_PREP(ROUTE_DIS_FMASK, route->route_dis);
+	val |= FIELD_PREP(ROUTE_DEF_PIPE_FMASK, route->route_def_pipe);
+	val |= FIELD_PREP(ROUTE_DEF_HDR_TABLE_FMASK,
+			  route->route_def_hdr_table);
+	val |= FIELD_PREP(ROUTE_DEF_HDR_OFST_FMASK, route->route_def_hdr_ofst);
+	val |= FIELD_PREP(ROUTE_FRAG_DEF_PIPE_FMASK,
+			  route->route_frag_def_pipe);
+	val |= FIELD_PREP(ROUTE_DEF_RETAIN_HDR_FMASK,
+			  route->route_def_retain_hdr);
+
+	return val;
+}
+
+/* IPA_ENDP_INIT_HDR_N register */
+
+static void
+ipa_reg_endp_init_hdr_common(struct ipa_reg_endp_init_hdr *init_hdr)
+{
+	init_hdr->hdr_additional_const_len = 0;	/* XXX description? */
+	init_hdr->hdr_a5_mux = 0;		/* XXX description? */
+	init_hdr->hdr_len_inc_deagg_hdr = 0;	/* XXX description? */
+	init_hdr->hdr_metadata_reg_valid = 0;	/* XXX description? */
+}
+
+void ipa_reg_endp_init_hdr_cons(struct ipa_reg_endp_init_hdr *init_hdr,
+				u32 header_size, u32 metadata_offset,
+				u32 length_offset)
+{
+	init_hdr->hdr_len = header_size;
+	init_hdr->hdr_ofst_metadata_valid = 1;
+	init_hdr->hdr_ofst_metadata = metadata_offset;	/* XXX ignored */
+	init_hdr->hdr_ofst_pkt_size_valid = 1;
+	init_hdr->hdr_ofst_pkt_size = length_offset;
+
+	ipa_reg_endp_init_hdr_common(init_hdr);
+}
+
+void ipa_reg_endp_init_hdr_prod(struct ipa_reg_endp_init_hdr *init_hdr,
+				u32 header_size, u32 metadata_offset,
+				u32 length_offset)
+{
+	init_hdr->hdr_len = header_size;
+	init_hdr->hdr_ofst_metadata_valid = 1;
+	init_hdr->hdr_ofst_metadata = metadata_offset;
+	init_hdr->hdr_ofst_pkt_size_valid = 1;
+	init_hdr->hdr_ofst_pkt_size = length_offset;	/* XXX ignored */
+
+	ipa_reg_endp_init_hdr_common(init_hdr);
+}
+
+#define HDR_LEN_FMASK			0x0000003f
+#define HDR_OFST_METADATA_VALID_FMASK	0x00000040
+#define HDR_OFST_METADATA_FMASK		0x00001f80
+#define HDR_ADDITIONAL_CONST_LEN_FMASK	0x0007e000
+#define HDR_OFST_PKT_SIZE_VALID_FMASK	0x00080000
+#define HDR_OFST_PKT_SIZE_FMASK		0x03f00000
+#define HDR_A5_MUX_FMASK		0x04000000
+#define HDR_LEN_INC_DEAGG_HDR_FMASK	0x08000000
+#define HDR_METADATA_REG_VALID_FMASK	0x10000000
+
+static u32
+ipa_reg_construct_endp_init_hdr_n(enum ipa_reg reg, const void *fields)
+{
+	const struct ipa_reg_endp_init_hdr *init_hdr = fields;
+	u32 val;
+
+	val = FIELD_PREP(HDR_LEN_FMASK, init_hdr->hdr_len);
+	val |= FIELD_PREP(HDR_OFST_METADATA_VALID_FMASK,
+			  init_hdr->hdr_ofst_metadata_valid);
+	val |= FIELD_PREP(HDR_OFST_METADATA_FMASK, init_hdr->hdr_ofst_metadata);
+	val |= FIELD_PREP(HDR_ADDITIONAL_CONST_LEN_FMASK,
+			  init_hdr->hdr_additional_const_len);
+	val |= FIELD_PREP(HDR_OFST_PKT_SIZE_VALID_FMASK,
+			  init_hdr->hdr_ofst_pkt_size_valid);
+	val |= FIELD_PREP(HDR_OFST_PKT_SIZE_FMASK,
+			  init_hdr->hdr_ofst_pkt_size);
+	val |= FIELD_PREP(HDR_A5_MUX_FMASK, init_hdr->hdr_a5_mux);
+	val |= FIELD_PREP(HDR_LEN_INC_DEAGG_HDR_FMASK,
+			  init_hdr->hdr_len_inc_deagg_hdr);
+	val |= FIELD_PREP(HDR_METADATA_REG_VALID_FMASK,
+			  init_hdr->hdr_metadata_reg_valid);
+
+	return val;
+}
+
+/* IPA_ENDP_INIT_HDR_EXT_N register */
+
+void ipa_reg_endp_init_hdr_ext_common(struct ipa_reg_endp_init_hdr_ext *hdr_ext)
+{
+	hdr_ext->hdr_endianness = 1;			/* big endian */
+	hdr_ext->hdr_total_len_or_pad_valid = 1;
+	hdr_ext->hdr_total_len_or_pad = 0;		/* pad */
+	hdr_ext->hdr_total_len_or_pad_offset = 0;	/* XXX description? */
+}
+
+void ipa_reg_endp_init_hdr_ext_cons(struct ipa_reg_endp_init_hdr_ext *hdr_ext,
+				    u32 pad_align, bool pad_included)
+{
+	hdr_ext->hdr_payload_len_inc_padding = pad_included ? 1 : 0;
+	hdr_ext->hdr_pad_to_alignment = pad_align;
+
+	ipa_reg_endp_init_hdr_ext_common(hdr_ext);
+}
+
+void ipa_reg_endp_init_hdr_ext_prod(struct ipa_reg_endp_init_hdr_ext *hdr_ext,
+				    u32 pad_align)
+{
+	hdr_ext->hdr_payload_len_inc_padding = 0;
+	hdr_ext->hdr_pad_to_alignment = pad_align;	/* XXX ignored */
+
+	ipa_reg_endp_init_hdr_ext_common(hdr_ext);
+}
+
+#define HDR_ENDIANNESS_FMASK			0x00000001
+#define HDR_TOTAL_LEN_OR_PAD_VALID_FMASK	0x00000002
+#define HDR_TOTAL_LEN_OR_PAD_FMASK		0x00000004
+#define HDR_PAYLOAD_LEN_INC_PADDING_FMASK	0x00000008
+#define HDR_TOTAL_LEN_OR_PAD_OFFSET_FMASK	0x000003f0
+#define HDR_PAD_TO_ALIGNMENT_FMASK		0x00003c00
+
+static u32
+ipa_reg_construct_endp_init_hdr_ext_n(enum ipa_reg reg, const void *fields)
+{
+	const struct ipa_reg_endp_init_hdr_ext *init_hdr_ext = fields;
+	u32 val;
+
+	/* 0 = little endian; 1 = big endian */
+	val = FIELD_PREP(HDR_ENDIANNESS_FMASK, 1);
+	val |= FIELD_PREP(HDR_TOTAL_LEN_OR_PAD_VALID_FMASK,
+			  init_hdr_ext->hdr_total_len_or_pad_valid);
+	val |= FIELD_PREP(HDR_TOTAL_LEN_OR_PAD_FMASK,
+			  init_hdr_ext->hdr_total_len_or_pad);
+	val |= FIELD_PREP(HDR_PAYLOAD_LEN_INC_PADDING_FMASK,
+			  init_hdr_ext->hdr_payload_len_inc_padding);
+	val |= FIELD_PREP(HDR_TOTAL_LEN_OR_PAD_OFFSET_FMASK, 0);
+	val |= FIELD_PREP(HDR_PAD_TO_ALIGNMENT_FMASK,
+			  init_hdr_ext->hdr_pad_to_alignment);
+
+	return val;
+}
+
+/* IPA_ENDP_INIT_AGGR_N register */
+
+static void
+ipa_reg_endp_init_aggr_common(struct ipa_reg_endp_init_aggr *init_aggr)
+{
+	init_aggr->aggr_force_close = 0;	/* XXX description?  */
+	init_aggr->aggr_hard_byte_limit_en = 0;	/* XXX ignored for PROD? */
+}
+
+void ipa_reg_endp_init_aggr_cons(struct ipa_reg_endp_init_aggr *init_aggr,
+				 u32 byte_limit, u32 packet_limit,
+				 bool close_on_eof)
+{
+	init_aggr->aggr_en = IPA_ENABLE_AGGR;
+	init_aggr->aggr_type = IPA_GENERIC;
+	init_aggr->aggr_byte_limit = byte_limit;
+	init_aggr->aggr_time_limit = IPA_AGGR_TIME_LIMIT_DEFAULT;
+	init_aggr->aggr_pkt_limit = packet_limit;
+	init_aggr->aggr_sw_eof_active = close_on_eof ? 1 : 0;
+
+	ipa_reg_endp_init_aggr_common(init_aggr);
+}
+
+void ipa_reg_endp_init_aggr_prod(struct ipa_reg_endp_init_aggr *init_aggr,
+				 enum ipa_aggr_en aggr_en,
+				 enum ipa_aggr_type aggr_type)
+{
+	init_aggr->aggr_en = (u32)aggr_en;
+	init_aggr->aggr_type = aggr_en == IPA_BYPASS_AGGR ? 0 : (u32)aggr_type;
+	init_aggr->aggr_byte_limit = 0;		/* ignored */
+	init_aggr->aggr_time_limit = 0;		/* ignored */
+	init_aggr->aggr_pkt_limit = 0;		/* ignored */
+	init_aggr->aggr_sw_eof_active = 0;	/* ignored */
+
+	ipa_reg_endp_init_aggr_common(init_aggr);
+}
+
+#define AGGR_EN_FMASK				0x00000003
+#define AGGR_TYPE_FMASK				0x0000001c
+#define AGGR_BYTE_LIMIT_FMASK			0x000003e0
+#define AGGR_TIME_LIMIT_FMASK			0x00007c00
+#define AGGR_PKT_LIMIT_FMASK			0x001f8000
+#define AGGR_SW_EOF_ACTIVE_FMASK		0x00200000
+#define AGGR_FORCE_CLOSE_FMASK			0x00400000
+#define AGGR_HARD_BYTE_LIMIT_ENABLE_FMASK	0x01000000
+
+static u32
+ipa_reg_construct_endp_init_aggr_n(enum ipa_reg reg, const void *fields)
+{
+	const struct ipa_reg_endp_init_aggr *init_aggr = fields;
+	u32 val;
+
+	val = FIELD_PREP(AGGR_EN_FMASK, init_aggr->aggr_en);
+	val |= FIELD_PREP(AGGR_TYPE_FMASK, init_aggr->aggr_type);
+	val |= FIELD_PREP(AGGR_BYTE_LIMIT_FMASK, init_aggr->aggr_byte_limit);
+	val |= FIELD_PREP(AGGR_TIME_LIMIT_FMASK, init_aggr->aggr_time_limit);
+	val |= FIELD_PREP(AGGR_PKT_LIMIT_FMASK, init_aggr->aggr_pkt_limit);
+	val |= FIELD_PREP(AGGR_SW_EOF_ACTIVE_FMASK,
+			  init_aggr->aggr_sw_eof_active);
+	val |= FIELD_PREP(AGGR_FORCE_CLOSE_FMASK, init_aggr->aggr_force_close);
+	val |= FIELD_PREP(AGGR_HARD_BYTE_LIMIT_ENABLE_FMASK,
+			  init_aggr->aggr_hard_byte_limit_en);
+
+	return val;
+}
+
+static void
+ipa_reg_parse_endp_init_aggr_n(enum ipa_reg reg, void *fields, u32 val)
+{
+	struct ipa_reg_endp_init_aggr *init_aggr = fields;
+
+	memset(init_aggr, 0, sizeof(*init_aggr));
+
+	init_aggr->aggr_en = FIELD_GET(AGGR_EN_FMASK, val);
+	init_aggr->aggr_type = FIELD_GET(AGGR_TYPE_FMASK, val);
+	init_aggr->aggr_byte_limit = FIELD_GET(AGGR_BYTE_LIMIT_FMASK, val);
+	init_aggr->aggr_time_limit = FIELD_GET(AGGR_TIME_LIMIT_FMASK, val);
+	init_aggr->aggr_pkt_limit = FIELD_GET(AGGR_PKT_LIMIT_FMASK, val);
+	init_aggr->aggr_sw_eof_active =
+			FIELD_GET(AGGR_SW_EOF_ACTIVE_FMASK, val);
+	init_aggr->aggr_force_close = FIELD_GET(AGGR_SW_EOF_ACTIVE_FMASK, val);
+	init_aggr->aggr_hard_byte_limit_en =
+			FIELD_GET(AGGR_HARD_BYTE_LIMIT_ENABLE_FMASK, val);
+}
+
+/* IPA_AGGR_FORCE_CLOSE register */
+
+void ipa_reg_aggr_force_close(struct ipa_reg_aggr_force_close *force_close,
+			      u32 pipe_bitmap)
+{
+	force_close->pipe_bitmap = pipe_bitmap;
+}
+
+#define PIPE_BITMAP_FMASK	0x000fffff
+
+static u32
+ipa_reg_construct_aggr_force_close(enum ipa_reg reg, const void *fields)
+{
+	const struct ipa_reg_aggr_force_close *force_close = fields;
+
+	return FIELD_PREP(PIPE_BITMAP_FMASK, force_close->pipe_bitmap);
+}
+
+/* IPA_ENDP_INIT_MODE_N register */
+
+static void
+ipa_reg_endp_init_mode_common(struct ipa_reg_endp_init_mode *init_mode)
+{
+	init_mode->byte_threshold = 0;		/* XXX description? */
+	init_mode->pipe_replication_en = 0;	/* XXX description? */
+	init_mode->pad_en = 0;			/* XXX description? */
+	init_mode->hdr_ftch_disable = 0;	/* XXX description? */
+}
+
+/* IPA_ENDP_INIT_MODE is not valid for consumer pipes */
+void ipa_reg_endp_init_mode_cons(struct ipa_reg_endp_init_mode *init_mode)
+{
+	init_mode->mode = 0;            /* ignored */
+	init_mode->dest_pipe_index = 0; /* ignored */
+
+	ipa_reg_endp_init_mode_common(init_mode);
+}
+
+void ipa_reg_endp_init_mode_prod(struct ipa_reg_endp_init_mode *init_mode,
+				 enum ipa_mode mode, u32 dest_endp)
+{
+	init_mode->mode = mode;
+	init_mode->dest_pipe_index = mode == IPA_DMA ? dest_endp : 0;
+
+	ipa_reg_endp_init_mode_common(init_mode);
+}
+
+#define MODE_FMASK			0x00000007
+#define DEST_PIPE_INDEX_FMASK		0x000001f0
+#define BYTE_THRESHOLD_FMASK		0x0ffff000
+#define PIPE_REPLICATION_EN_FMASK	0x10000000
+#define PAD_EN_FMASK			0x20000000
+#define HDR_FTCH_DISABLE_FMASK		0x40000000
+
+static u32
+ipa_reg_construct_endp_init_mode_n(enum ipa_reg reg, const void *fields)
+{
+	const struct ipa_reg_endp_init_mode *init_mode = fields;
+	u32 val;
+
+	val = FIELD_PREP(MODE_FMASK, init_mode->mode);
+	val |= FIELD_PREP(DEST_PIPE_INDEX_FMASK, init_mode->dest_pipe_index);
+	val |= FIELD_PREP(BYTE_THRESHOLD_FMASK, init_mode->byte_threshold);
+	val |= FIELD_PREP(PIPE_REPLICATION_EN_FMASK,
+			  init_mode->pipe_replication_en);
+	val |= FIELD_PREP(PAD_EN_FMASK, init_mode->pad_en);
+	val |= FIELD_PREP(HDR_FTCH_DISABLE_FMASK, init_mode->hdr_ftch_disable);
+
+	return val;
+}
+
+/* IPA_ENDP_INIT_CTRL_N register */
+
+void
+ipa_reg_endp_init_ctrl(struct ipa_reg_endp_init_ctrl *init_ctrl, bool suspend)
+{
+	init_ctrl->endp_suspend = suspend ? 1 : 0;
+	init_ctrl->endp_delay = 0;
+}
+
+#define ENDP_SUSPEND_FMASK	0x00000001
+#define ENDP_DELAY_FMASK	0x00000002
+
+static u32
+ipa_reg_construct_endp_init_ctrl_n(enum ipa_reg reg, const void *fields)
+{
+	const struct ipa_reg_endp_init_ctrl *init_ctrl = fields;
+	u32 val;
+
+	val = FIELD_PREP(ENDP_SUSPEND_FMASK, init_ctrl->endp_suspend);
+	val |= FIELD_PREP(ENDP_DELAY_FMASK, init_ctrl->endp_delay);
+
+	return val;
+}
+
+static void
+ipa_reg_parse_endp_init_ctrl_n(enum ipa_reg reg, void *fields, u32 val)
+{
+	struct ipa_reg_endp_init_ctrl *init_ctrl = fields;
+
+	memset(init_ctrl, 0, sizeof(*init_ctrl));
+
+	init_ctrl->endp_suspend = FIELD_GET(ENDP_SUSPEND_FMASK, val);
+	init_ctrl->endp_delay = FIELD_GET(ENDP_DELAY_FMASK, val);
+}
+
+/* IPA_ENDP_INIT_DEAGGR_N register */
+
+static void
+ipa_reg_endp_init_deaggr_common(struct ipa_reg_endp_init_deaggr *init_deaggr)
+{
+	init_deaggr->deaggr_hdr_len = 0;		/* XXX description? */
+	init_deaggr->packet_offset_valid = 0;		/* XXX description? */
+	init_deaggr->packet_offset_location = 0;	/* XXX description? */
+	init_deaggr->max_packet_len = 0;		/* XXX description? */
+}
+
+/* XXX The deaggr setting seems not to be valid for consumer endpoints */
+void
+ipa_reg_endp_init_deaggr_cons(struct ipa_reg_endp_init_deaggr *init_deaggr)
+{
+	ipa_reg_endp_init_deaggr_common(init_deaggr);
+}
+
+void
+ipa_reg_endp_init_deaggr_prod(struct ipa_reg_endp_init_deaggr *init_deaggr)
+{
+	ipa_reg_endp_init_deaggr_common(init_deaggr);
+}
+
+#define DEAGGR_HDR_LEN_FMASK		0x0000003f
+#define PACKET_OFFSET_VALID_FMASK	0x00000080
+#define PACKET_OFFSET_LOCATION_FMASK	0x00003f00
+#define MAX_PACKET_LEN_FMASK		0xffff0000
+
+static u32
+ipa_reg_construct_endp_init_deaggr_n(enum ipa_reg reg, const void *fields)
+{
+	const struct ipa_reg_endp_init_deaggr *init_deaggr = fields;
+	u32 val;
+
+	/* fields value is completely ignored (can be NULL) */
+	val = FIELD_PREP(DEAGGR_HDR_LEN_FMASK, init_deaggr->deaggr_hdr_len);
+	val |= FIELD_PREP(PACKET_OFFSET_VALID_FMASK,
+			  init_deaggr->packet_offset_valid);
+	val |= FIELD_PREP(PACKET_OFFSET_LOCATION_FMASK,
+			  init_deaggr->packet_offset_location);
+	val |= FIELD_PREP(MAX_PACKET_LEN_FMASK,
+			  init_deaggr->max_packet_len);
+
+	return val;
+}
+
+/* IPA_ENDP_INIT_SEQ_N register */
+
+static void
+ipa_reg_endp_init_seq_common(struct ipa_reg_endp_init_seq *init_seq)
+{
+	init_seq->dps_seq_type = 0;	/* XXX description? */
+	init_seq->hps_rep_seq_type = 0;	/* XXX description? */
+	init_seq->dps_rep_seq_type = 0;	/* XXX description? */
+}
+
+void ipa_reg_endp_init_seq_cons(struct ipa_reg_endp_init_seq *init_seq)
+{
+	init_seq->hps_seq_type = 0;	/* ignored */
+
+	ipa_reg_endp_init_seq_common(init_seq);
+}
+
+void ipa_reg_endp_init_seq_prod(struct ipa_reg_endp_init_seq *init_seq,
+				enum ipa_seq_type seq_type)
+{
+	init_seq->hps_seq_type = (u32)seq_type;
+
+	ipa_reg_endp_init_seq_common(init_seq);
+}
+
+#define HPS_SEQ_TYPE_FMASK	0x0000000f
+#define DPS_SEQ_TYPE_FMASK	0x000000f0
+#define HPS_REP_SEQ_TYPE_FMASK	0x00000f00
+#define DPS_REP_SEQ_TYPE_FMASK	0x0000f000
+
+static u32
+ipa_reg_construct_endp_init_seq_n(enum ipa_reg reg, const void *fields)
+{
+	const struct ipa_reg_endp_init_seq *init_seq = fields;
+	u32 val;
+
+	val = FIELD_PREP(HPS_SEQ_TYPE_FMASK, init_seq->hps_seq_type);
+	val |= FIELD_PREP(DPS_SEQ_TYPE_FMASK, init_seq->dps_seq_type);
+	val |= FIELD_PREP(HPS_REP_SEQ_TYPE_FMASK, init_seq->hps_rep_seq_type);
+	val |= FIELD_PREP(DPS_REP_SEQ_TYPE_FMASK, init_seq->dps_rep_seq_type);
+
+	return val;
+}
+
+/* IPA_ENDP_INIT_CFG_N register */
+
+static void
+ipa_reg_endp_init_cfg_common(struct ipa_reg_endp_init_cfg *init_cfg)
+{
+	init_cfg->frag_offload_en = 0;		/* XXX description?  */
+	init_cfg->cs_gen_qmb_master_sel = 0;	/* XXX description?  */
+}
+
+void ipa_reg_endp_init_cfg_cons(struct ipa_reg_endp_init_cfg *init_cfg,
+				enum ipa_cs_offload_en offload_type)
+{
+	init_cfg->cs_offload_en = offload_type;
+	init_cfg->cs_metadata_hdr_offset = 0;	/* ignored */
+
+	ipa_reg_endp_init_cfg_common(init_cfg);
+}
+
+void ipa_reg_endp_init_cfg_prod(struct ipa_reg_endp_init_cfg *init_cfg,
+				enum ipa_cs_offload_en offload_type,
+				u32 metadata_offset)
+{
+	init_cfg->cs_offload_en = offload_type;
+	init_cfg->cs_metadata_hdr_offset = metadata_offset;
+
+	ipa_reg_endp_init_cfg_common(init_cfg);
+}
+
+#define FRAG_OFFLOAD_EN_FMASK		0x00000001
+#define CS_OFFLOAD_EN_FMASK		0x00000006
+#define CS_METADATA_HDR_OFFSET_FMASK	0x00000078
+#define CS_GEN_QMB_MASTER_SEL_FMASK	0x00000100
+
+static u32
+ipa_reg_construct_endp_init_cfg_n(enum ipa_reg reg, const void *fields)
+{
+	const struct ipa_reg_endp_init_cfg *init_cfg = fields;
+	u32 val;
+
+	val = FIELD_PREP(FRAG_OFFLOAD_EN_FMASK, init_cfg->frag_offload_en);
+	val |= FIELD_PREP(CS_OFFLOAD_EN_FMASK, init_cfg->cs_offload_en);
+	val |= FIELD_PREP(CS_METADATA_HDR_OFFSET_FMASK,
+			  init_cfg->cs_metadata_hdr_offset);
+	val |= FIELD_PREP(CS_GEN_QMB_MASTER_SEL_FMASK,
+			  init_cfg->cs_gen_qmb_master_sel);
+
+	return val;
+}
+
+/* IPA_ENDP_INIT_HDR_METADATA_MASK_N register */
+
+void ipa_reg_endp_init_hdr_metadata_mask_cons(
+		struct ipa_reg_endp_init_hdr_metadata_mask *metadata_mask,
+		u32 mask)
+{
+	metadata_mask->metadata_mask = mask;
+}
+
+/* IPA_ENDP_INIT_HDR_METADATA_MASK is not valid for producer pipes */
+void ipa_reg_endp_init_hdr_metadata_mask_prod(
+		struct ipa_reg_endp_init_hdr_metadata_mask *metadata_mask)
+{
+	metadata_mask->metadata_mask = 0;	/* ignored */
+}
+
+
+#define METADATA_MASK_FMASK	0xffffffff
+
+static u32 ipa_reg_construct_endp_init_hdr_metadata_mask_n(enum ipa_reg reg,
+							  const void *fields)
+{
+	const struct ipa_reg_endp_init_hdr_metadata_mask *metadata_mask;
+
+	metadata_mask = fields;
+
+	return FIELD_PREP(METADATA_MASK_FMASK, metadata_mask->metadata_mask);
+}
+
+/* IPA_SHARED_MEM_SIZE register (read-only) */
+
+#define SHARED_MEM_SIZE_FMASK	0x0000ffff
+#define SHARED_MEM_BADDR_FMASK	0xffff0000
+
+static void
+ipa_reg_parse_shared_mem_size(enum ipa_reg reg, void *fields, u32 val)
+{
+	struct ipa_reg_shared_mem_size *mem_size = fields;
+
+	memset(mem_size, 0, sizeof(*mem_size));
+
+	mem_size->shared_mem_size = FIELD_GET(SHARED_MEM_SIZE_FMASK, val);
+	mem_size->shared_mem_baddr = FIELD_GET(SHARED_MEM_BADDR_FMASK, val);
+}
+
+/* IPA_ENDP_STATUS_N register */
+
+static void ipa_reg_endp_status_common(struct ipa_reg_endp_status *endp_status)
+{
+	endp_status->status_pkt_suppress = 0;	/* XXX description?  */
+}
+
+void ipa_reg_endp_status_cons(struct ipa_reg_endp_status *endp_status,
+			      bool enable)
+{
+	endp_status->status_en = enable ? 1 : 0;
+	endp_status->status_endp = 0;		/* ignored */
+	endp_status->status_location = 0;	/* before packet data */
+
+	ipa_reg_endp_status_common(endp_status);
+}
+
+void ipa_reg_endp_status_prod(struct ipa_reg_endp_status *endp_status,
+			      bool enable, u32 endp)
+{
+	endp_status->status_en = enable ? 1 : 0;
+	endp_status->status_endp = endp;
+	endp_status->status_location = 0;	/* ignored */
+
+	ipa_reg_endp_status_common(endp_status);
+}
+
+#define STATUS_EN_FMASK			0x00000001
+#define STATUS_ENDP_FMASK		0x0000003e
+#define STATUS_LOCATION_FMASK		0x00000100
+#define STATUS_PKT_SUPPRESS_FMASK	0x00000200
+
+static u32 ipa_reg_construct_endp_status_n(enum ipa_reg reg, const void *fields)
+{
+	const struct ipa_reg_endp_status *endp_status = fields;
+	u32 val;
+
+	val = FIELD_PREP(STATUS_EN_FMASK, endp_status->status_en);
+	val |= FIELD_PREP(STATUS_ENDP_FMASK, endp_status->status_endp);
+	val |= FIELD_PREP(STATUS_LOCATION_FMASK, endp_status->status_location);
+	val |= FIELD_PREP(STATUS_PKT_SUPPRESS_FMASK, 0);
+
+	return val;
+}
+
+/* IPA_ENDP_FILTER_ROUTER_HSH_CFG_N register */
+
+void ipa_reg_hash_tuple(struct ipa_reg_hash_tuple *tuple)
+{
+	tuple->src_id = 0;	/* pipe number in flt, table index in rt */
+	tuple->src_ip = 0;
+	tuple->dst_ip = 0;
+	tuple->src_port = 0;
+	tuple->dst_port = 0;
+	tuple->protocol = 0;
+	tuple->metadata = 0;
+	tuple->undefined = 0;
+}
+
+#define FILTER_HASH_MSK_SRC_ID_FMASK	0x00000001
+#define FILTER_HASH_MSK_SRC_IP_FMASK	0x00000002
+#define FILTER_HASH_MSK_DST_IP_FMASK	0x00000004
+#define FILTER_HASH_MSK_SRC_PORT_FMASK	0x00000008
+#define FILTER_HASH_MSK_DST_PORT_FMASK	0x00000010
+#define FILTER_HASH_MSK_PROTOCOL_FMASK	0x00000020
+#define FILTER_HASH_MSK_METADATA_FMASK	0x00000040
+#define FILTER_HASH_UNDEFINED1_FMASK	0x0000ff80
+
+#define ROUTER_HASH_MSK_SRC_ID_FMASK	0x00010000
+#define ROUTER_HASH_MSK_SRC_IP_FMASK	0x00020000
+#define ROUTER_HASH_MSK_DST_IP_FMASK	0x00040000
+#define ROUTER_HASH_MSK_SRC_PORT_FMASK	0x00080000
+#define ROUTER_HASH_MSK_DST_PORT_FMASK	0x00100000
+#define ROUTER_HASH_MSK_PROTOCOL_FMASK	0x00200000
+#define ROUTER_HASH_MSK_METADATA_FMASK	0x00400000
+#define ROUTER_HASH_UNDEFINED2_FMASK	0xff800000
+
+static u32 ipa_reg_construct_hash_cfg_n(enum ipa_reg reg, const void *fields)
+{
+	const struct ipa_ep_filter_router_hsh_cfg *hsh_cfg = fields;
+	u32 val;
+
+	val = FIELD_PREP(FILTER_HASH_MSK_SRC_ID_FMASK, hsh_cfg->flt.src_id);
+	val |= FIELD_PREP(FILTER_HASH_MSK_SRC_IP_FMASK, hsh_cfg->flt.src_ip);
+	val |= FIELD_PREP(FILTER_HASH_MSK_DST_IP_FMASK, hsh_cfg->flt.dst_ip);
+	val |= FIELD_PREP(FILTER_HASH_MSK_SRC_PORT_FMASK,
+			  hsh_cfg->flt.src_port);
+	val |= FIELD_PREP(FILTER_HASH_MSK_DST_PORT_FMASK,
+			  hsh_cfg->flt.dst_port);
+	val |= FIELD_PREP(FILTER_HASH_MSK_PROTOCOL_FMASK,
+			  hsh_cfg->flt.protocol);
+	val |= FIELD_PREP(FILTER_HASH_MSK_METADATA_FMASK,
+			  hsh_cfg->flt.metadata);
+	val |= FIELD_PREP(FILTER_HASH_UNDEFINED1_FMASK, hsh_cfg->flt.undefined);
+
+	val |= FIELD_PREP(ROUTER_HASH_MSK_SRC_ID_FMASK, hsh_cfg->rt.src_id);
+	val |= FIELD_PREP(ROUTER_HASH_MSK_SRC_IP_FMASK, hsh_cfg->rt.src_ip);
+	val |= FIELD_PREP(ROUTER_HASH_MSK_DST_IP_FMASK, hsh_cfg->rt.dst_ip);
+	val |= FIELD_PREP(ROUTER_HASH_MSK_SRC_PORT_FMASK, hsh_cfg->rt.src_port);
+	val |= FIELD_PREP(ROUTER_HASH_MSK_DST_PORT_FMASK, hsh_cfg->rt.dst_port);
+	val |= FIELD_PREP(ROUTER_HASH_MSK_PROTOCOL_FMASK, hsh_cfg->rt.protocol);
+	val |= FIELD_PREP(ROUTER_HASH_MSK_METADATA_FMASK, hsh_cfg->rt.metadata);
+	val |= FIELD_PREP(FILTER_HASH_UNDEFINED1_FMASK, hsh_cfg->rt.undefined);
+
+	return val;
+}
+
+static void ipa_reg_parse_hash_cfg_n(enum ipa_reg reg, void *fields, u32 val)
+{
+	struct ipa_ep_filter_router_hsh_cfg *hsh_cfg = fields;
+
+	memset(hsh_cfg, 0, sizeof(*hsh_cfg));
+
+	hsh_cfg->flt.src_id = FIELD_GET(FILTER_HASH_MSK_SRC_ID_FMASK, val);
+	hsh_cfg->flt.src_ip = FIELD_GET(FILTER_HASH_MSK_SRC_IP_FMASK, val);
+	hsh_cfg->flt.dst_ip = FIELD_GET(FILTER_HASH_MSK_DST_IP_FMASK, val);
+	hsh_cfg->flt.src_port = FIELD_GET(FILTER_HASH_MSK_SRC_PORT_FMASK, val);
+	hsh_cfg->flt.dst_port = FIELD_GET(FILTER_HASH_MSK_DST_PORT_FMASK, val);
+	hsh_cfg->flt.protocol = FIELD_GET(FILTER_HASH_MSK_PROTOCOL_FMASK, val);
+	hsh_cfg->flt.metadata = FIELD_GET(FILTER_HASH_MSK_METADATA_FMASK, val);
+	hsh_cfg->flt.undefined = FIELD_GET(FILTER_HASH_UNDEFINED1_FMASK, val);
+
+	hsh_cfg->rt.src_id = FIELD_GET(ROUTER_HASH_MSK_SRC_ID_FMASK, val);
+	hsh_cfg->rt.src_ip = FIELD_GET(ROUTER_HASH_MSK_SRC_IP_FMASK, val);
+	hsh_cfg->rt.dst_ip = FIELD_GET(ROUTER_HASH_MSK_DST_IP_FMASK, val);
+	hsh_cfg->rt.src_port = FIELD_GET(ROUTER_HASH_MSK_SRC_PORT_FMASK, val);
+	hsh_cfg->rt.dst_port = FIELD_GET(ROUTER_HASH_MSK_DST_PORT_FMASK, val);
+	hsh_cfg->rt.protocol = FIELD_GET(ROUTER_HASH_MSK_PROTOCOL_FMASK, val);
+	hsh_cfg->rt.metadata = FIELD_GET(ROUTER_HASH_MSK_METADATA_FMASK, val);
+	hsh_cfg->rt.undefined = FIELD_GET(ROUTER_HASH_UNDEFINED2_FMASK, val);
+}
+
+/* IPA_RSRC_GRP_XY_RSRC_TYPE_N register(s) */
+
+void
+ipa_reg_rsrc_grp_xy_rsrc_type_n(struct ipa_reg_rsrc_grp_xy_rsrc_type_n *limits,
+				 u32 x_min, u32 x_max, u32 y_min, u32 y_max)
+{
+	limits->x_min = x_min;
+	limits->x_max = x_max;
+	limits->y_min = y_min;
+	limits->y_max = y_max;
+}
+
+#define X_MIN_LIM_FMASK	0x0000003f
+#define X_MAX_LIM_FMASK	0x00003f00
+#define Y_MIN_LIM_FMASK	0x003f0000
+#define Y_MAX_LIM_FMASK	0x3f000000
+
+static u32
+ipa_reg_construct_rsrg_grp_xy_rsrc_type_n(enum ipa_reg reg, const void *fields)
+{
+	const struct ipa_reg_rsrc_grp_xy_rsrc_type_n *limits = fields;
+	u32 val;
+
+	val = FIELD_PREP(X_MIN_LIM_FMASK, limits->x_min);
+	val |= FIELD_PREP(X_MAX_LIM_FMASK, limits->x_max);
+
+	/* DST_23 register has only X fields at ipa V3_5 */
+	if (reg == IPA_DST_RSRC_GRP_23_RSRC_TYPE_N)
+		return val;
+
+	val |= FIELD_PREP(Y_MIN_LIM_FMASK, limits->y_min);
+	val |= FIELD_PREP(Y_MAX_LIM_FMASK, limits->y_max);
+
+	return val;
+}
+
+/* IPA_QSB_MAX_WRITES register */
+
+void ipa_reg_qsb_max_writes(struct ipa_reg_qsb_max_writes *max_writes,
+			    u32 qmb_0_max_writes, u32 qmb_1_max_writes)
+{
+	max_writes->qmb_0_max_writes = qmb_0_max_writes;
+	max_writes->qmb_1_max_writes = qmb_1_max_writes;
+}
+
+#define GEN_QMB_0_MAX_WRITES_FMASK	0x0000000f
+#define GEN_QMB_1_MAX_WRITES_FMASK	0x000000f0
+
+static u32
+ipa_reg_construct_qsb_max_writes(enum ipa_reg reg, const void *fields)
+{
+	const struct ipa_reg_qsb_max_writes *max_writes = fields;
+	u32 val;
+
+	val = FIELD_PREP(GEN_QMB_0_MAX_WRITES_FMASK,
+			  max_writes->qmb_0_max_writes);
+	val |= FIELD_PREP(GEN_QMB_1_MAX_WRITES_FMASK,
+			  max_writes->qmb_1_max_writes);
+
+	return val;
+}
+
+/* IPA_QSB_MAX_READS register */
+
+void ipa_reg_qsb_max_reads(struct ipa_reg_qsb_max_reads *max_reads,
+			   u32 qmb_0_max_reads, u32 qmb_1_max_reads)
+{
+	max_reads->qmb_0_max_reads = qmb_0_max_reads;
+	max_reads->qmb_1_max_reads = qmb_1_max_reads;
+}
+
+#define GEN_QMB_0_MAX_READS_FMASK	0x0000000f
+#define GEN_QMB_1_MAX_READS_FMASK	0x000000f0
+
+static u32 ipa_reg_construct_qsb_max_reads(enum ipa_reg reg, const void *fields)
+{
+	const struct ipa_reg_qsb_max_reads *max_reads = fields;
+	u32 val;
+
+	val = FIELD_PREP(GEN_QMB_0_MAX_READS_FMASK, max_reads->qmb_0_max_reads);
+	val |= FIELD_PREP(GEN_QMB_1_MAX_READS_FMASK,
+			  max_reads->qmb_1_max_reads);
+
+	return val;
+}
+
+/* IPA_IDLE_INDICATION_CFG register */
+
+void ipa_reg_idle_indication_cfg(struct ipa_reg_idle_indication_cfg *indication,
+				 u32 debounce_thresh, bool non_idle_enable)
+{
+	indication->enter_idle_debounce_thresh = debounce_thresh;
+	indication->const_non_idle_enable = non_idle_enable;
+}
+
+#define ENTER_IDLE_DEBOUNCE_THRESH_FMASK	0x0000ffff
+#define CONST_NON_IDLE_ENABLE_FMASK		0x00010000
+
+static u32
+ipa_reg_construct_idle_indication_cfg(enum ipa_reg reg, const void *fields)
+{
+	const struct ipa_reg_idle_indication_cfg *indication_cfg;
+	u32 val;
+
+	indication_cfg = fields;
+
+	val = FIELD_PREP(ENTER_IDLE_DEBOUNCE_THRESH_FMASK,
+			  indication_cfg->enter_idle_debounce_thresh);
+	val |= FIELD_PREP(CONST_NON_IDLE_ENABLE_FMASK,
+			  indication_cfg->const_non_idle_enable);
+
+	return val;
+}
+
+/* The entries in the following table have the following constraints:
+ * - 0 is not a valid offset (it represents an unused entry).  It is
+ *   a bug for code to attempt to access a register which has an
+ *   undefined (zero) offset value.
+ * - If a construct function is supplied, the register must be
+ *   written using ipa_write_reg_n_fields() (or its wrapper
+ *   function ipa_write_reg_fields()).
+ * - Generally, if a parse function is supplied, the register should
+ *   read using ipa_read_reg_n_fields() (or ipa_read_reg_fields()).
+ *   (Currently some debug code reads some registers directly, without
+ *   parsing.)
+ */
+#define cfunc(f)	ipa_reg_construct_ ## f
+#define pfunc(f)	ipa_reg_parse_ ## f
+#define reg_obj_common(id, cf, pf, o, n)	\
+	[id] = {				\
+		.construct = cf,		\
+		.parse = pf,			\
+		.offset = o,			\
+		.n_ofst = n,			\
+	}
+#define reg_obj_cfunc(id, f, o, n)		\
+	reg_obj_common(id, cfunc(f), NULL, o, n)
+#define reg_obj_pfunc(id, f, o, n)		\
+	reg_obj_common(id, NULL, pfunc(f), o, n)
+#define reg_obj_both(id, f, o, n)		\
+	reg_obj_common(id, cfunc(f), pfunc(f), o, n)
+#define reg_obj_nofunc(id, o, n)		\
+	reg_obj_common(id, NULL, NULL, o, n)
+
+/* IPAv3.5.1 */
+static const struct ipa_reg_desc ipa_reg[] = {
+	reg_obj_cfunc(IPA_ROUTE, route,			0x00000048,	0x0000),
+	reg_obj_nofunc(IPA_IRQ_STTS_EE_N,		0x00003008,	0x1000),
+	reg_obj_nofunc(IPA_IRQ_EN_EE_N,			0x0000300c,	0x1000),
+	reg_obj_nofunc(IPA_IRQ_CLR_EE_N,		0x00003010,	0x1000),
+	reg_obj_nofunc(IPA_IRQ_SUSPEND_INFO_EE_N,	0x00003030,	0x1000),
+	reg_obj_nofunc(IPA_SUSPEND_IRQ_EN_EE_N,		0x00003034,	0x1000),
+	reg_obj_nofunc(IPA_SUSPEND_IRQ_CLR_EE_N,	0x00003038,	0x1000),
+	reg_obj_nofunc(IPA_BCR,				0x000001d0,	0x0000),
+	reg_obj_nofunc(IPA_ENABLED_PIPES,		0x00000038,	0x0000),
+	reg_obj_nofunc(IPA_TAG_TIMER,			0x00000060,	0x0000),
+	reg_obj_nofunc(IPA_STATE_AGGR_ACTIVE,		0x0000010c,	0x0000),
+	reg_obj_cfunc(IPA_ENDP_INIT_HDR_N,
+		      endp_init_hdr_n,			0x00000810,	0x0070),
+	reg_obj_cfunc(IPA_ENDP_INIT_HDR_EXT_N,
+		      endp_init_hdr_ext_n,		0x00000814,	0x0070),
+	reg_obj_both(IPA_ENDP_INIT_AGGR_N,
+		     endp_init_aggr_n,			0x00000824,	0x0070),
+	reg_obj_cfunc(IPA_AGGR_FORCE_CLOSE,
+		     aggr_force_close,			0x000001ec,	0x0000),
+	reg_obj_cfunc(IPA_ENDP_INIT_MODE_N,
+		      endp_init_mode_n,			0x00000820,	0x0070),
+	reg_obj_both(IPA_ENDP_INIT_CTRL_N,
+		     endp_init_ctrl_n,			0x00000800,	0x0070),
+	reg_obj_cfunc(IPA_ENDP_INIT_DEAGGR_N,
+		      endp_init_deaggr_n,		0x00000834,	0x0070),
+	reg_obj_cfunc(IPA_ENDP_INIT_SEQ_N,
+		      endp_init_seq_n,			0x0000083c,	0x0070),
+	reg_obj_cfunc(IPA_ENDP_INIT_CFG_N,
+		      endp_init_cfg_n,			0x00000808,	0x0070),
+	reg_obj_nofunc(IPA_IRQ_EE_UC_N,			0x0000301c,	0x1000),
+	reg_obj_cfunc(IPA_ENDP_INIT_HDR_METADATA_MASK_N,
+		      endp_init_hdr_metadata_mask_n,	0x00000818,	0x0070),
+	reg_obj_pfunc(IPA_SHARED_MEM_SIZE,
+		      shared_mem_size,			0x00000054,	0x0000),
+	reg_obj_nofunc(IPA_SRAM_DIRECT_ACCESS_N,	0x00007000,	0x0004),
+	reg_obj_nofunc(IPA_LOCAL_PKT_PROC_CNTXT_BASE,	0x000001e8,	0x0000),
+	reg_obj_cfunc(IPA_ENDP_STATUS_N,
+		      endp_status_n,			0x00000840,	0x0070),
+	reg_obj_both(IPA_ENDP_FILTER_ROUTER_HSH_CFG_N,
+		     hash_cfg_n,			0x0000085c,	0x0070),
+	reg_obj_cfunc(IPA_SRC_RSRC_GRP_01_RSRC_TYPE_N,
+		      rsrg_grp_xy_rsrc_type_n,		0x00000400,	0x0020),
+	reg_obj_cfunc(IPA_SRC_RSRC_GRP_23_RSRC_TYPE_N,
+		      rsrg_grp_xy_rsrc_type_n,		0x00000404,	0x0020),
+	reg_obj_cfunc(IPA_DST_RSRC_GRP_01_RSRC_TYPE_N,
+		      rsrg_grp_xy_rsrc_type_n,		0x00000500,	0x0020),
+	reg_obj_cfunc(IPA_DST_RSRC_GRP_23_RSRC_TYPE_N,
+		      rsrg_grp_xy_rsrc_type_n,		0x00000504,	0x0020),
+	reg_obj_cfunc(IPA_QSB_MAX_WRITES,
+		      qsb_max_writes,			0x00000074,	0x0000),
+	reg_obj_cfunc(IPA_QSB_MAX_READS,
+		      qsb_max_reads,			0x00000078,	0x0000),
+	reg_obj_cfunc(IPA_IDLE_INDICATION_CFG,
+		      idle_indication_cfg,		0x00000220,	0x0000),
+};
+
+#undef reg_obj_nofunc
+#undef reg_obj_both
+#undef reg_obj_pfunc
+#undef reg_obj_cfunc
+#undef reg_obj_common
+#undef pfunc
+#undef cfunc
+
+int ipa_reg_init(phys_addr_t phys_addr, size_t size)
+{
+	ipa_reg_virt = ioremap(phys_addr, size);
+
+	return ipa_reg_virt ? 0 : -ENOMEM;
+}
+
+void ipa_reg_exit(void)
+{
+	iounmap(ipa_reg_virt);
+	ipa_reg_virt = NULL;
+}
+
+/* Get the offset of an "n parameterized" register */
+u32 ipa_reg_n_offset(enum ipa_reg reg, u32 n)
+{
+	return ipa_reg[reg].offset + n * ipa_reg[reg].n_ofst;
+}
+
+/* ipa_read_reg_n() - Get an "n parameterized" register's value */
+u32 ipa_read_reg_n(enum ipa_reg reg, u32 n)
+{
+	return ioread32(ipa_reg_virt + ipa_reg_n_offset(reg, n));
+}
+
+/* ipa_write_reg_n() - Write a raw value to an "n parameterized" register */
+void ipa_write_reg_n(enum ipa_reg reg, u32 n, u32 val)
+{
+	iowrite32(val, ipa_reg_virt + ipa_reg_n_offset(reg, n));
+}
+
+/* ipa_read_reg_n_fields() - Parse value of an "n parameterized" register */
+void ipa_read_reg_n_fields(enum ipa_reg reg, u32 n, void *fields)
+{
+	u32 val = ipa_read_reg_n(reg, n);
+
+	ipa_reg[reg].parse(reg, fields, val);
+}
+
+/* ipa_write_reg_n_fields() - Construct a vlaue to write to an "n
+ * parameterized" register
+ */
+void ipa_write_reg_n_fields(enum ipa_reg reg, u32 n, const void *fields)
+{
+	u32 val = ipa_reg[reg].construct(reg, fields);
+
+	ipa_write_reg_n(reg, n, val);
+}
+
+/* Maximum representable aggregation byte limit value (in bytes) */
+u32 ipa_reg_aggr_max_byte_limit(void)
+{
+	return FIELD_MAX(AGGR_BYTE_LIMIT_FMASK) * SZ_1K;
+}
+
+/* Maximum representable aggregation packet limit value */
+u32 ipa_reg_aggr_max_packet_limit(void)
+{
+	return FIELD_MAX(AGGR_PKT_LIMIT_FMASK);
+}
diff --git a/drivers/net/ipa/ipa_reg.h b/drivers/net/ipa/ipa_reg.h
new file mode 100644
index 000000000000..fb7c1ab6408c
--- /dev/null
+++ b/drivers/net/ipa/ipa_reg.h
@@ -0,0 +1,614 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2018 Linaro Ltd.
+ */
+#ifndef _IPA_REG_H_
+#define _IPA_REG_H_
+
+/**
+ * DOC: The IPA Register Abstraction
+ *
+ * The IPA code abstracts the details of its 32-bit registers, allowing access
+ * to them to be done generically.  The original motivation for this was that
+ * the field width and/or position for values stored in some registers differed
+ * for different versions of IPA hardware.  Abstracting access this way allows
+ * code that uses such registers to be simpler, describing how register fields
+ * are used without proliferating special-case code that is dependent on
+ * hardware version.
+ *
+ * Each IPA register has a name, which is one of the values in the "ipa_reg"
+ * enumerated type (e.g., IPA_ENABLED_PIPES).  The offset (memory address) of
+ * the register having a given name is maintained internal to the "ipa_reg"
+ * module.
+ *
+ * For simple registers that hold a single 32-bit value, two functions provide
+ * access to the register:
+ *	u32 ipa_read_reg(enum ipa_reg reg);
+ *	void ipa_write_reg(enum ipa_reg reg, u32 val);
+ *
+ * Some registers are "N-parameterized."  This means there is a set of
+ * registers having identical format, and each is accessed by supplying
+ * the "N" value to select which register is intended.  The names for
+ * N-parameterized registers have an "_N" suffix (e.g. IPA_IRQ_STTS_EE_N).
+ * Details of computing the offset for such registers are maintained internal
+ * to the "ipa_reg" module.  For simple registers holding a single 32-bit
+ * value, these functions provide access to N-parameterized registers:
+ *	u32 ipa_read_reg_n(enum ipa_reg reg, u32 n);
+ *	void ipa_write_reg_n(enum ipa_reg reg, u32 n, u32 val);
+ *
+ * Some registers contain fields less than 32 bits wide (call these "field
+ * registers").  For each such register a "field structure" is defined to
+ * represent the values of the individual fields within the register.  The
+ * name of the structure matches the name of the register (in lower case).
+ * For example, the individual fields in the IPA_ROUTE register are represented
+ * by the field structure named ipa_reg_route.
+ *
+ * Each field register has a function used to fill in its corresponding
+ * field structure with particular values.  Parameters to this function
+ * supply values to assign.  In many cases only a few such parameters
+ * are required, because some field values are invariant.  The name of
+ * this sort of function is derived from the structure name, so for example
+ * ipa_reg_route() is used to initialize an ipa_reg_route structure.
+ * Field registers associated with endpoints often use different fields
+ * or different values dependent on whether the endpoint is a producer or
+ * consumer.  In these cases separate functions are used to initialize
+ * the field structure (for example ipa_reg_endp_init_hdr_cons() and
+ * ipa_reg_endp_init_hdr_prod()).
+ *
+ * The position and width of fields within a register are defined (in
+ * "ipa_reg.c") using field masks, and the names of the members in the field
+ * structure associated with such registers match the names of the bit masks
+ * that define the fields.  (E.g., ipa_reg_route->route_dis is used to
+ * represent the field defined by the ROUTE_DIS field mask.)
+ *
+ * "Field registers" are accessed using these functions:
+ *	void ipa_read_reg_fields(enum ipa_reg reg, void *fields);
+ *	void ipa_write_reg_fields(enum ipa_reg reg, const void *fields);
+ * The "fields" parameter in both cases is the address of the "field structure"
+ * associated with the register being accessed.  When reading, the structure
+ * is filled by ipa_read_reg_fields() with values found in the register's
+ * fields.  (All fields will be filled; there is no need for the caller to
+ * initialize the passed-in structure before the call.)  When writing, the
+ * caller initializes the structure with all values that should be written to
+ * the fields in the register.
+ *
+ * "Field registers" can also be N-parameterized, in which case they are
+ * accessed using these functions:
+ *	void ipa_read_reg_n_fields(enum ipa_reg reg, u32 n, void *fields);
+ *	void ipa_write_reg_n_fields(enum ipa_reg reg, u32 n,
+ *				    const void *fields);
+ */
+
+/* Register names */
+enum ipa_reg {
+	IPA_ROUTE,
+	IPA_IRQ_STTS_EE_N,
+	IPA_IRQ_EN_EE_N,
+	IPA_IRQ_CLR_EE_N,
+	IPA_IRQ_SUSPEND_INFO_EE_N,
+	IPA_SUSPEND_IRQ_EN_EE_N,
+	IPA_SUSPEND_IRQ_CLR_EE_N,
+	IPA_BCR,
+	IPA_ENABLED_PIPES,
+	IPA_TAG_TIMER,
+	IPA_STATE_AGGR_ACTIVE,
+	IPA_ENDP_INIT_HDR_N,
+	IPA_ENDP_INIT_HDR_EXT_N,
+	IPA_ENDP_INIT_AGGR_N,
+	IPA_AGGR_FORCE_CLOSE,
+	IPA_ENDP_INIT_MODE_N,
+	IPA_ENDP_INIT_CTRL_N,
+	IPA_ENDP_INIT_DEAGGR_N,
+	IPA_ENDP_INIT_SEQ_N,
+	IPA_ENDP_INIT_CFG_N,
+	IPA_IRQ_EE_UC_N,
+	IPA_ENDP_INIT_HDR_METADATA_MASK_N,
+	IPA_SHARED_MEM_SIZE,
+	IPA_SRAM_DIRECT_ACCESS_N,
+	IPA_LOCAL_PKT_PROC_CNTXT_BASE,
+	IPA_ENDP_STATUS_N,
+	IPA_ENDP_FILTER_ROUTER_HSH_CFG_N,
+	IPA_SRC_RSRC_GRP_01_RSRC_TYPE_N,
+	IPA_SRC_RSRC_GRP_23_RSRC_TYPE_N,
+	IPA_DST_RSRC_GRP_01_RSRC_TYPE_N,
+	IPA_DST_RSRC_GRP_23_RSRC_TYPE_N,
+	IPA_QSB_MAX_WRITES,
+	IPA_QSB_MAX_READS,
+	IPA_IDLE_INDICATION_CFG,
+};
+
+/**
+ * struct ipa_reg_route - IPA_ROUTE field structure
+ * @route_dis: route disable
+ * @route_def_pipe: route default pipe
+ * @route_def_hdr_table: route default header table
+ * @route_def_hdr_ofst: route default header offset table
+ * @route_frag_def_pipe: Default pipe to route fragmented exception
+ *    packets and frag new rule statues, if source pipe does not have
+ *    a notification status pipe defined.
+ * @route_def_retain_hdr: default value of retain header. It is used
+ *    when no rule was hit
+ */
+struct ipa_reg_route {
+	u32 route_dis;
+	u32 route_def_pipe;
+	u32 route_def_hdr_table;
+	u32 route_def_hdr_ofst;
+	u32 route_frag_def_pipe;
+	u32 route_def_retain_hdr;
+};
+
+/**
+ * ipa_reg_endp_init_hdr - ENDP_INIT_HDR_N field structure
+ *
+ * @hdr_len:
+ * @hdr_ofst_metadata_valid:
+ * @hdr_ofst_metadata:
+ * @hdr_additional_const_len:
+ * @hdr_ofst_pkt_size_valid:
+ * @hdr_ofst_pkt_size:
+ * @hdr_a5_mux:
+ * @hdr_len_inc_deagg_hdr:
+ * @hdr_metadata_reg_valid:
+*/
+struct ipa_reg_endp_init_hdr {
+	u32 hdr_len;
+	u32 hdr_ofst_metadata_valid;
+	u32 hdr_ofst_metadata;
+	u32 hdr_additional_const_len;
+	u32 hdr_ofst_pkt_size_valid;
+	u32 hdr_ofst_pkt_size;
+	u32 hdr_a5_mux;
+	u32 hdr_len_inc_deagg_hdr;
+	u32 hdr_metadata_reg_valid;
+};
+
+/**
+ * ipa_reg_endp_init_hdr_ext - IPA_ENDP_INIT_HDR_EXT_N field structure
+ *
+ * @hdr_endianness:
+ * @hdr_total_len_or_pad_valid:
+ * @hdr_total_len_or_pad:
+ * @hdr_payload_len_inc_padding:
+ * @hdr_total_len_or_pad_offset:
+ * @hdr_pad_to_alignment:
+ */
+struct ipa_reg_endp_init_hdr_ext {
+	u32 hdr_endianness;		/* 0 = little endian; 1 = big endian */
+	u32 hdr_total_len_or_pad_valid;
+	u32 hdr_total_len_or_pad;	/* 0 = pad; 1 = total_len */
+	u32 hdr_payload_len_inc_padding;
+	u32 hdr_total_len_or_pad_offset;
+	u32 hdr_pad_to_alignment;
+};
+
+/**
+ * enum ipa_aggr_en - aggregation setting type in IPA end-point
+ */
+enum ipa_aggr_en {
+	IPA_BYPASS_AGGR		= 0,
+	IPA_ENABLE_AGGR		= 1,
+	IPA_ENABLE_DEAGGR	= 2,
+};
+
+/**
+ * enum ipa_aggr_type - type of aggregation in IPA end-point
+ */
+enum ipa_aggr_type {
+	IPA_MBIM_16 = 0,
+	IPA_HDLC    = 1,
+	IPA_TLP	    = 2,
+	IPA_RNDIS   = 3,
+	IPA_GENERIC = 4,
+	IPA_QCMAP   = 6,
+};
+
+#define IPA_AGGR_TIME_LIMIT_DEFAULT	1	/* XXX units? */
+
+/**
+ * struct ipa_reg_endp_init_aggr - IPA_ENDP_INIT_AGGR_N field structure
+ * @aggr_en: bypass aggregation, enable aggregation, or deaggregation
+ *	     (enum ipa_aggr_en)
+ * @aggr_type: type of aggregation (enum ipa_aggr_type aggr)
+ * @aggr_byte_limit: aggregated byte limit in KB, or no limit if 0
+ *		     (producer pipes only)
+ * @aggr_time_limit: time limit before close of aggregation, or
+ *		     aggregation disabled if 0 (producer pipes only)
+ * @aggr_pkt_limit: packet limit before closing aggregation, or no
+ *		    limit if 0 (producer pipes only) XXX units
+ * @aggr_sw_eof_active: whether EOF closes aggregation--in addition to
+ *			hardware aggregation configuration (producer
+ *			pipes configured for generic aggregation only)
+ * @aggr_force_close: whether to force a close XXX verify/when
+ * @aggr_hard_byte_limit_en: whether aggregation frames close *before*
+ * 			     byte count has crossed limit, rather than
+ * 			     after XXX producer only?
+ */
+struct ipa_reg_endp_init_aggr {
+	u32 aggr_en;		/* enum ipa_aggr_en */
+	u32 aggr_type;		/* enum ipa_aggr_type */
+	u32 aggr_byte_limit;
+	u32 aggr_time_limit;
+	u32 aggr_pkt_limit;
+	u32 aggr_sw_eof_active;
+	u32 aggr_force_close;
+	u32 aggr_hard_byte_limit_en;
+};
+
+/**
+ * struct ipa_aggr_force_close - IPA_AGGR_FORCE_CLOSE field structure
+ * @pipe_bitmap: bitmap of pipes on which aggregation should be closed
+ */
+struct ipa_reg_aggr_force_close {
+	u32 pipe_bitmap;
+};
+
+/**
+ * enum ipa_mode - mode setting type in IPA end-point
+ * @BASIC: basic mode
+ * @ENABLE_FRAMING_HDLC: not currently supported
+ * @ENABLE_DEFRAMING_HDLC: not currently supported
+ * @DMA: all data arriving IPA will not go through IPA logic blocks, this
+ *  allows IPA to work as DMA for specific pipes.
+ */
+enum ipa_mode {
+	IPA_BASIC			= 0,
+	IPA_ENABLE_FRAMING_HDLC		= 1,
+	IPA_ENABLE_DEFRAMING_HDLC	= 2,
+	IPA_DMA				= 3,
+};
+
+/**
+ * struct ipa_reg_endp_init_mode - IPA_ENDP_INIT_MODE_N field structure
+ *
+ * @mode: endpoint mode setting (enum ipa_mode_type)
+ * @dst_pipe_index: This parameter specifies destination output-pipe-packets
+ *	will be routed to. Valid for DMA mode only and for Input
+ *	Pipes only (IPA Consumer)
+ * @byte_threshold:
+ * @pipe_replication_en:
+ * @pad_en:
+ * @hdr_ftch_disable:
+ */
+struct ipa_reg_endp_init_mode {
+	u32 mode;		/* enum ipa_mode */
+	u32 dest_pipe_index;
+	u32 byte_threshold;
+	u32 pipe_replication_en;
+	u32 pad_en;
+	u32 hdr_ftch_disable;
+};
+
+/**
+ * struct ipa_ep_init_ctrl - IPA_ENDP_INIT_CTRL_N field structure
+ *
+ * @ipa_ep_suspend: 0 - ENDP is enabled, 1 - ENDP is suspended (disabled).
+ *			Valid for PROD Endpoints
+ * @ipa_ep_delay:   0 - ENDP is free-running, 1 - ENDP is delayed.
+ *			SW controls the data flow of an endpoint usind this bit.
+ *			Valid for CONS Endpoints
+ */
+struct ipa_reg_endp_init_ctrl {
+	u32 endp_suspend;
+	u32 endp_delay;
+};
+
+/**
+ * struct ipa_reg_endp_init_deaggr - IPA_ENDP_INIT_DEAGGR_N field structure
+ *
+ * @deaggr_hdr_len:
+ * @packet_offset_valid:
+ * @packet_offset_location:
+ * @max_packet_len:
+ */
+struct ipa_reg_endp_init_deaggr {
+	u32 deaggr_hdr_len;
+	u32 packet_offset_valid;
+	u32 packet_offset_location;
+	u32 max_packet_len;
+};
+
+/* HPS, DPS sequencers types */
+enum ipa_seq_type {
+	IPA_SEQ_DMA_ONLY			= 0x00,
+	/* Packet Processing + no decipher + uCP (for Ethernet Bridging) */
+	IPA_SEQ_PKT_PROCESS_NO_DEC_UCP		= 0x02,
+	/* 2 Packet Processing pass + no decipher + uCP */
+	IPA_SEQ_2ND_PKT_PROCESS_PASS_NO_DEC_UCP	= 0x04,
+	/* DMA + DECIPHER/CIPHER */
+	IPA_SEQ_DMA_DEC				= 0x11,
+	/* COMP/DECOMP */
+	IPA_SEQ_DMA_COMP_DECOMP			= 0x20,
+	/* Invalid sequencer type */
+	IPA_SEQ_INVALID				= 0xff,
+};
+
+/**
+ * struct ipa_ep_init_seq - IPA_ENDP_INIT_SEQ_N field structure
+ * @hps_seq_type: type of HPS sequencer (enum ipa_hps_dps_sequencer_type)
+ * @dps_seq_type: type of DPS sequencer (enum ipa_hps_dps_sequencer_type)
+ */
+struct ipa_reg_endp_init_seq {
+	u32 hps_seq_type;
+	u32 dps_seq_type;
+	u32 hps_rep_seq_type;
+	u32 dps_rep_seq_type;
+};
+
+/**
+ * enum ipa_cs_offload_en - checksum offload setting
+ */
+enum ipa_cs_offload_en {
+	IPA_CS_OFFLOAD_NONE	= 0,
+	IPA_CS_OFFLOAD_UL	= 1,
+	IPA_CS_OFFLOAD_DL	= 2,
+	IPA_CS_RSVD
+};
+
+/**
+ * struct ipa_reg_endp_init_cfg - IPA_ENDP_INIT_CFG_N field structure
+ * @frag_offload_en:
+ * @cs_offload_en: type of offloading (enum ipa_cs_offload)
+ * @cs_metadata_hdr_offset: offload (in 4-byte words) within header
+ * where 4-byte checksum metadata begins.  Valid only for consumer
+ * pipes.
+ * @cs_gen_qmb_master_sel:
+ */
+struct ipa_reg_endp_init_cfg {
+	u32 frag_offload_en;
+	u32 cs_offload_en;		/* enum ipa_cs_offload_en */
+	u32 cs_metadata_hdr_offset;
+	u32 cs_gen_qmb_master_sel;
+};
+
+/**
+ * struct ipa_reg_endp_init_hdr_metadata_mask -
+ *	IPA_ENDP_INIT_HDR_METADATA_MASK_N field structure
+ * @metadata_mask: mask specifying metadata bits to write
+ *
+ * Valid for producer pipes only.
+ */
+struct ipa_reg_endp_init_hdr_metadata_mask {
+	u32 metadata_mask;
+};
+
+/**
+ * struct ipa_reg_shared_mem_size - SHARED_MEM_SIZE field structure
+ * @shared_mem_size: Available size [in 8Bytes] of SW partition within
+ *	IPA shared memory.
+ * @shared_mem_baddr: Offset of SW partition within IPA
+ *	shared memory[in 8Bytes]. To get absolute address of SW partition,
+ *	add this offset to IPA_SRAM_DIRECT_ACCESS_N baddr.
+ */
+struct ipa_reg_shared_mem_size {
+	u32 shared_mem_size;
+	u32 shared_mem_baddr;
+};
+
+/**
+ * struct ipa_reg_endp_status - IPA_ENDP_STATUS_N field structure
+ * @status_en: Determines if end point supports Status Indications. SW should
+ *	set this bit in order to enable Statuses. Output Pipe - send
+ *	Status indications only if bit is set. Input Pipe - forward Status
+ *	indication to STATUS_ENDP only if bit is set. Valid for Input
+ *	and Output Pipes (IPA Consumer and Producer)
+ * @status_endp: Statuses generated for this endpoint will be forwarded to the
+ *	specified Status End Point. Status endpoint needs to be
+ *	configured with STATUS_EN=1 Valid only for Input Pipes (IPA
+ *	Consumer)
+ * @status_location: Location of PKT-STATUS on destination pipe.
+ *	If set to 0 (default), PKT-STATUS will be appended before the packet
+ *	for this endpoint. If set to 1, PKT-STATUS will be appended after the
+ *	packet for this endpoint. Valid only for Output Pipes (IPA Producer)
+ * @status_pkt_suppress:
+ */
+struct ipa_reg_endp_status {
+	u32 status_en;
+	u32 status_endp;
+	u32 status_location;
+	u32 status_pkt_suppress;
+};
+
+/**
+ * struct ipa_hash_tuple - structure used to group filter and route fields in
+ *			   struct ipa_ep_filter_router_hsh_cfg
+ * @src_id: pipe number for flt, table index for rt
+ * @src_ip_addr: IP source address
+ * @dst_ip_addr: IP destination address
+ * @src_port: L4 source port
+ * @dst_port: L4 destination port
+ * @protocol: IP protocol field
+ * @meta_data: packet meta-data
+ *
+ * Each field is a Boolean value, indicating whether that particular value
+ * should be used for filtering or routing.
+ *
+ */
+struct ipa_reg_hash_tuple {
+	u32 src_id;	/* pipe number in flt, table index in rt */
+	u32 src_ip;
+	u32 dst_ip;
+	u32 src_port;
+	u32 dst_port;
+	u32 protocol;
+	u32 metadata;
+	u32 undefined;
+};
+
+/**
+ * struct ipa_ep_filter_router_hsh_cfg - IPA_ENDP_FILTER_ROUTER_HSH_CFG_N
+ * 					 field structure
+ * @flt: Hash tuple info for filtering
+ * @undefined1:
+ * @rt: Hash tuple info for routing
+ * @undefined2:
+ * @undefinedX: Undefined/Unused bit fields set of the register
+ */
+struct ipa_ep_filter_router_hsh_cfg {
+	struct ipa_reg_hash_tuple flt;
+	struct ipa_reg_hash_tuple rt;
+};
+
+/**
+ * struct ipa_reg_rsrc_grp_xy_rsrc_type_n -
+ *    IPA_{SRC,DST}_RSRC_GRP_{02}{13}Y_RSRC_TYPE_N field structure
+ * @x_min - first group min value
+ * @x_max - first group max value
+ * @y_min - second group min value
+ * @y_max - second group max value
+ *
+ * This field structure is used for accessing the following registers:
+ *	IPA_SRC_RSRC_GRP_01_RSRC_TYPE_N IPA_SRC_RSRC_GRP_23_RSRC_TYPE_N
+ *	IPA_DST_RSRC_GRP_01_RSRC_TYPE_N IPA_DST_RSRC_GRP_23_RSRC_TYPE_N
+ *
+ */
+struct ipa_reg_rsrc_grp_xy_rsrc_type_n {
+	u32 x_min;
+	u32 x_max;
+	u32 y_min;
+	u32 y_max;
+};
+
+/**
+ * struct ipa_reg_qsb_max_writes - IPA_QSB_MAX_WRITES field register
+ * @qmb_0_max_writes: Max number of outstanding writes for GEN_QMB_0
+ * @qmb_1_max_writes: Max number of outstanding writes for GEN_QMB_1
+ */
+struct ipa_reg_qsb_max_writes {
+	u32 qmb_0_max_writes;
+	u32 qmb_1_max_writes;
+};
+
+/**
+ * struct ipa_reg_qsb_max_reads - IPA_QSB_MAX_READS field register
+ * @qmb_0_max_reads: Max number of outstanding reads for GEN_QMB_0
+ * @qmb_1_max_reads: Max number of outstanding reads for GEN_QMB_1
+ */
+struct ipa_reg_qsb_max_reads {
+	u32 qmb_0_max_reads;
+	u32 qmb_1_max_reads;
+};
+
+/** struct ipa_reg_idle_indication_cfg - IPA_IDLE_INDICATION_CFG field register
+ * @enter_idle_debounce_thresh:	 configure the debounce threshold
+ * @const_non_idle_enable: enable the asserting of the IDLE value and DCD
+ */
+struct ipa_reg_idle_indication_cfg {
+	u32 enter_idle_debounce_thresh;
+	u32 const_non_idle_enable;
+};
+
+/* Initialize the IPA register subsystem */
+int ipa_reg_init(phys_addr_t phys_addr, size_t size);
+void ipa_reg_exit(void);
+
+void ipa_reg_route(struct ipa_reg_route *route, u32 ep_id);
+void ipa_reg_endp_init_hdr_cons(struct ipa_reg_endp_init_hdr *init_hdr,
+				u32 header_size, u32 metadata_offset,
+				u32 length_offset);
+void ipa_reg_endp_init_hdr_prod(struct ipa_reg_endp_init_hdr *init_hdr,
+				u32 header_size, u32 metadata_offset,
+				u32 length_offset);
+void ipa_reg_endp_init_hdr_ext_cons(struct ipa_reg_endp_init_hdr_ext *hdr_ext,
+				    u32 pad_align, bool pad_included);
+void ipa_reg_endp_init_hdr_ext_prod(struct ipa_reg_endp_init_hdr_ext *hdr_ext,
+				    u32 pad_align);
+void ipa_reg_endp_init_aggr_cons(struct ipa_reg_endp_init_aggr *init_aggr,
+				 u32 byte_limit, u32 packet_limit,
+				 bool close_on_eof);
+void ipa_reg_endp_init_aggr_prod(struct ipa_reg_endp_init_aggr *init_aggr,
+				 enum ipa_aggr_en aggr_en,
+				 enum ipa_aggr_type aggr_type);
+void ipa_reg_aggr_force_close(struct ipa_reg_aggr_force_close *force_close,
+			      u32 pipe_bitmap);
+void ipa_reg_endp_init_mode_cons(struct ipa_reg_endp_init_mode *init_mode);
+void ipa_reg_endp_init_mode_prod(struct ipa_reg_endp_init_mode *init_mode,
+				 enum ipa_mode mode, u32 dest_endp);
+void ipa_reg_endp_init_cfg_cons(struct ipa_reg_endp_init_cfg *init_cfg,
+				enum ipa_cs_offload_en offload_type);
+void ipa_reg_endp_init_cfg_prod(struct ipa_reg_endp_init_cfg *init_cfg,
+				enum ipa_cs_offload_en offload_type,
+				u32 metadata_offset);
+void ipa_reg_endp_init_ctrl(struct ipa_reg_endp_init_ctrl *init_ctrl,
+			    bool suspend);
+void ipa_reg_endp_init_deaggr_cons(
+		struct ipa_reg_endp_init_deaggr *init_deaggr);
+void ipa_reg_endp_init_deaggr_prod(
+		struct ipa_reg_endp_init_deaggr *init_deaggr);
+void ipa_reg_endp_init_seq_cons(struct ipa_reg_endp_init_seq *init_seq);
+void ipa_reg_endp_init_seq_prod(struct ipa_reg_endp_init_seq *init_seq,
+				enum ipa_seq_type seq_type);
+void ipa_reg_endp_init_hdr_metadata_mask_cons(
+		struct ipa_reg_endp_init_hdr_metadata_mask *metadata_mask,
+		u32 mask);
+void ipa_reg_endp_init_hdr_metadata_mask_prod(
+		struct ipa_reg_endp_init_hdr_metadata_mask *metadata_mask);
+void ipa_reg_endp_status_cons(struct ipa_reg_endp_status *endp_status,
+			      bool enable);
+void ipa_reg_endp_status_prod(struct ipa_reg_endp_status *endp_status,
+			      bool enable, u32 endp);
+
+void ipa_reg_hash_tuple(struct ipa_reg_hash_tuple *tuple);
+
+void ipa_reg_rsrc_grp_xy_rsrc_type_n(
+				struct ipa_reg_rsrc_grp_xy_rsrc_type_n *limits,
+				u32 x_min, u32 x_max, u32 y_min, u32 y_max);
+
+void ipa_reg_qsb_max_writes(struct ipa_reg_qsb_max_writes *max_writes,
+			    u32 qmb_0_max_writes, u32 qmb_1_max_writes);
+void ipa_reg_qsb_max_reads(struct ipa_reg_qsb_max_reads *max_reads,
+			   u32 qmb_0_max_reads, u32 qmb_1_max_reads);
+
+void ipa_reg_idle_indication_cfg(struct ipa_reg_idle_indication_cfg *indication,
+			         u32 debounce_thresh, bool non_idle_enable);
+
+/* Get the offset of an n-parameterized register */
+u32 ipa_reg_n_offset(enum ipa_reg reg, u32 n);
+
+/* Get the offset of a register */
+static inline u32 ipa_reg_offset(enum ipa_reg reg)
+{
+	return ipa_reg_n_offset(reg, 0);
+}
+
+/* ipa_read_reg_n() - Get the raw value of n-parameterized register */
+u32 ipa_read_reg_n(enum ipa_reg reg, u32 n);
+
+/* ipa_write_reg_n() - Write a raw value to an n-param register */
+void ipa_write_reg_n(enum ipa_reg reg, u32 n, u32 val);
+
+/* ipa_read_reg_n_fields() - Get the parsed value of an n-param register */
+void ipa_read_reg_n_fields(enum ipa_reg reg, u32 n, void *fields);
+
+/* ipa_write_reg_n_fields() - Write a parsed value to an n-param register */
+void ipa_write_reg_n_fields(enum ipa_reg reg, u32 n, const void *fields);
+
+/* ipa_read_reg() - Get the raw value from a register */
+static inline u32 ipa_read_reg(enum ipa_reg reg)
+{
+	return ipa_read_reg_n(reg, 0);
+}
+
+/* ipa_write_reg() - Write a raw value to a register*/
+static inline void ipa_write_reg(enum ipa_reg reg, u32 val)
+{
+	ipa_write_reg_n(reg, 0, val);
+}
+
+/* ipa_read_reg_fields() - Get the parsed value of a register */
+static inline void ipa_read_reg_fields(enum ipa_reg reg, void *fields)
+{
+	ipa_read_reg_n_fields(reg, 0, fields);
+}
+
+/* ipa_write_reg_fields() - Write a parsed value to a register */
+static inline void ipa_write_reg_fields(enum ipa_reg reg, const void *fields)
+{
+	ipa_write_reg_n_fields(reg, 0, fields);
+}
+
+u32 ipa_reg_aggr_max_byte_limit(void);
+u32 ipa_reg_aggr_max_packet_limit(void);
+
+#endif /* _IPA_REG_H_ */
-- 
2.17.1

