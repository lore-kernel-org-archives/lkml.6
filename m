Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B457CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A99D208D4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A99D208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeH0ONF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:13:05 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:15145 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeH0ONE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:13:04 -0400
X-IronPort-AV: E=Sophos;i="5.53,294,1531810800"; 
   d="scan'208";a="18441297"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 27 Aug 2018 03:26:59 -0700
Received: from localhost.localdomain.com (10.10.76.4) by
 chn-sv-exch04.mchp-main.com (10.10.76.105) with Microsoft SMTP Server id
 14.3.352.0; Mon, 27 Aug 2018 03:26:59 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <marek.vasut@gmail.com>, <cyrille.pitchen@microchip.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <boris.brezillon@bootlin.com>, <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <Cristian.Birsan@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [RESEND PATCH v2 3/3] mtd: spi-nor: parse SFDP 4-byte Address Instruction Table
Date:   Mon, 27 Aug 2018 13:26:44 +0300
Message-ID: <20180827102644.7323-4-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20180827102644.7323-1-tudor.ambarus@microchip.com>
References: <20180827102644.7323-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cyrille Pitchen <cyrille.pitchen@microchip.com>

Add support for SFDP (JESD216B) 4-byte Address Instruction Table. This
table is optional but when available, we parse it to get the 4-byte
address op codes supported by the memory.
Using these op codes is stateless as opposed to entering the 4-byte
address mode or setting the Base Address Register (BAR).

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 148 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 522d5aa..4e69d47 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2196,6 +2196,7 @@ struct sfdp_parameter_header {
 
 #define SFDP_BFPT_ID		0xff00	/* Basic Flash Parameter Table */
 #define SFDP_SECTOR_MAP_ID	0xff81	/* Sector Map Table */
+#define SFDP_4BAIT_ID		0xff84u	/* 4-byte Address Instruction Table */
 
 #define SFDP_SIGNATURE		0x50444653U
 #define SFDP_JESD216_MAJOR	1
@@ -2883,6 +2884,149 @@ static int spi_nor_parse_smpt(struct spi_nor *nor,
 	return ret;
 }
 
+struct sfdp_4bait {
+	/* The hardware capability. */
+	u32		hwcaps;
+
+	/*
+	 * The <supported_bit> bit in DWORD1 of the 4BAIT tells us whether
+	 * the associated 4-byte address op code is supported.
+	 */
+	u32		supported_bit;
+};
+
+static int spi_nor_parse_4bait(struct spi_nor *nor,
+			       const struct sfdp_parameter_header *param_header,
+			       struct spi_nor_flash_parameter *params)
+{
+	static const struct sfdp_4bait reads[] = {
+		{ SNOR_HWCAPS_READ,		BIT(0) },
+		{ SNOR_HWCAPS_READ_FAST,	BIT(1) },
+		{ SNOR_HWCAPS_READ_1_1_2,	BIT(2) },
+		{ SNOR_HWCAPS_READ_1_2_2,	BIT(3) },
+		{ SNOR_HWCAPS_READ_1_1_4,	BIT(4) },
+		{ SNOR_HWCAPS_READ_1_4_4,	BIT(5) },
+		{ SNOR_HWCAPS_READ_1_1_1_DTR,	BIT(13) },
+		{ SNOR_HWCAPS_READ_1_2_2_DTR,	BIT(14) },
+		{ SNOR_HWCAPS_READ_1_4_4_DTR,	BIT(15) },
+	};
+	static const struct sfdp_4bait programs[] = {
+		{ SNOR_HWCAPS_PP,		BIT(6) },
+		{ SNOR_HWCAPS_PP_1_1_4,		BIT(7) },
+		{ SNOR_HWCAPS_PP_1_4_4,		BIT(8) },
+	};
+	static const struct sfdp_4bait erases[SNOR_ERASE_TYPE_MAX] = {
+		{ 0u /* not used */,		BIT(9) },
+		{ 0u /* not used */,		BIT(10) },
+		{ 0u /* not used */,		BIT(11) },
+		{ 0u /* not used */,		BIT(12) },
+	};
+	u32 dwords[2], addr, discard_hwcaps, read_hwcaps, pp_hwcaps, erase_mask;
+	struct spi_nor_erase_map *map = &nor->erase_map;
+	int i, err;
+
+	if (param_header->major != SFDP_JESD216_MAJOR ||
+	    param_header->length < ARRAY_SIZE(dwords))
+		return -EINVAL;
+
+	/* Read the 4-byte Address Instruction Table. */
+	addr = SFDP_PARAM_HEADER_PTP(param_header);
+	err = spi_nor_read_sfdp(nor, addr, sizeof(dwords), dwords);
+	if (err)
+		return err;
+
+	/* Fix endianness of the 4BAIT DWORDs. */
+	for (i = 0; i < ARRAY_SIZE(dwords); i++)
+		dwords[i] = le32_to_cpu(dwords[i]);
+
+	/*
+	 * Compute the subset of (Fast) Read commands for which the 4-byte
+	 * version is supported.
+	 */
+	discard_hwcaps = 0;
+	read_hwcaps = 0;
+	for (i = 0; i < ARRAY_SIZE(reads); i++) {
+		const struct sfdp_4bait *read = &reads[i];
+
+		discard_hwcaps |= read->hwcaps;
+		if ((params->hwcaps.mask & read->hwcaps) &&
+		    (dwords[0] & read->supported_bit))
+			read_hwcaps |= read->hwcaps;
+	}
+
+	/*
+	 * Compute the subset of Page Program commands for which the 4-byte
+	 * version is supported.
+	 */
+	pp_hwcaps = 0;
+	for (i = 0; i < ARRAY_SIZE(programs); i++) {
+		const struct sfdp_4bait *program = &programs[i];
+
+		discard_hwcaps |= program->hwcaps;
+		if ((params->hwcaps.mask & program->hwcaps) &&
+		    (dwords[0] & program->supported_bit))
+			pp_hwcaps |= program->hwcaps;
+	}
+
+	/*
+	 * Compute the subet of Sector Erase commands for which the 4-byte
+	 * version is supported.
+	 */
+	erase_mask = 0;
+	for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++) {
+		const struct sfdp_4bait *erase = &erases[i];
+
+		if (map->erase_type[i].size > 0 &&
+		    (dwords[0] & erase->supported_bit))
+			erase_mask |= BIT(i);
+	}
+
+	/*
+	 * We need at least one 4-byte op code per read, program and erase
+	 * operation; the .read(), .write() and .erase() hooks share the
+	 * nor->addr_width value.
+	 */
+	if (!read_hwcaps || !pp_hwcaps || !erase_mask)
+		return 0;
+
+	/*
+	 * Discard all operations from the 4-byte instruction set which are
+	 * not supported by this memory.
+	 */
+	params->hwcaps.mask &= ~discard_hwcaps;
+	params->hwcaps.mask |= (read_hwcaps | pp_hwcaps);
+
+	/* Use the 4-byte address instruction set. */
+	for (i = 0; i < SNOR_CMD_READ_MAX; i++) {
+		struct spi_nor_read_command *read_cmd = &params->reads[i];
+
+		read_cmd->opcode = spi_nor_convert_3to4_read(read_cmd->opcode);
+	}
+	for (i = 0; i < SNOR_CMD_PP_MAX; i++) {
+		struct spi_nor_pp_command *pp_cmd = &params->page_programs[i];
+
+		pp_cmd->opcode = spi_nor_convert_3to4_program(pp_cmd->opcode);
+	}
+	for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++) {
+		struct spi_nor_erase_type *erase = &map->erase_type[i];
+
+		if (erase_mask & BIT(erase->idx))
+			erase->opcode = (dwords[1] >> (erase->idx * 8)) & 0xFF;
+		else
+			spi_nor_set_erase_type(erase, 0u, 0xFF);
+	}
+
+	/*
+	 * We set nor->addr_width here to skip spi_nor_set_4byte_opcodes()
+	 * later because this latest function implements a legacy quirk for
+	 * the erase size of Spansion memory. However this quirk is no longer
+	 * needed with new SFDP compliant memories.
+	 */
+	nor->addr_width = 4;
+	nor->flags |= SPI_NOR_4B_OPCODES;
+	return 0;
+}
+
 /**
  * spi_nor_parse_sfdp() - parse the Serial Flash Discoverable Parameters.
  * @nor:		pointer to a 'struct spi_nor'
@@ -2980,6 +3124,10 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
 			err = spi_nor_parse_smpt(nor, param_header);
 			break;
 
+		case SFDP_4BAIT_ID:
+			err = spi_nor_parse_4bait(nor, param_header, params);
+			break;
+
 		default:
 			break;
 		}
-- 
2.9.4

