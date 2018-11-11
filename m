Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6B2C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AEA20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1LYoEkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90AEA20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387556AbeKLITO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:40380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387540AbeKLITN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:13 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 037E821527;
        Sun, 11 Nov 2018 22:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975357;
        bh=pu9n5+l15AIitGqnhZnWPINdCPV6WNG+03VDIYHAwCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a1LYoEkp8haxezC8yRcOj8BvFzFjVZhHgz97G2pZJ+cDC4xuNdwYslsDEB3d5sZl4
         C7pPGOVQASPYHcVlfCUE8NV0/p2kDgxblx77W9ICx2EQGxj+EhjzGNMcOfzseFC/rb
         5lMT1O8txVvR68Zc2U6CAusqvPEvc3guTOJmXAwM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.18 022/350] ACPICA: AML Parser: fix parse loop to correctly skip erroneous extended opcodes
Date:   Sun, 11 Nov 2018 14:18:06 -0800
Message-Id: <20181111221708.101723879@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

From: Erik Schmauss <erik.schmauss@intel.com>

commit c64baa3a6fa207d112706bc5e7fd645cd8a8663f upstream.

AML opcodes come in two lengths: 1-byte opcodes and 2-byte, extended opcodes.
If an error occurs due to illegal opcodes during table load, the AML parser
needs to continue loading the table. In order to do this, it needs to skip
parsing of the offending opcode and operands associated with that opcode.

This change fixes the AML parse loop to correctly skip parsing of incorrect
extended opcodes. Previously, only the short opcodes were skipped correctly.

Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/acpica/psloop.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -417,6 +417,7 @@ acpi_status acpi_ps_parse_loop(struct ac
 	union acpi_parse_object *op = NULL;	/* current op */
 	struct acpi_parse_state *parser_state;
 	u8 *aml_op_start = NULL;
+	u8 opcode_length;
 
 	ACPI_FUNCTION_TRACE_PTR(ps_parse_loop, walk_state);
 
@@ -540,8 +541,19 @@ acpi_status acpi_ps_parse_loop(struct ac
 						    "Skip parsing opcode %s",
 						    acpi_ps_get_opcode_name
 						    (walk_state->opcode)));
+
+					/*
+					 * Determine the opcode length before skipping the opcode.
+					 * An opcode can be 1 byte or 2 bytes in length.
+					 */
+					opcode_length = 1;
+					if ((walk_state->opcode & 0xFF00) ==
+					    AML_EXTENDED_OPCODE) {
+						opcode_length = 2;
+					}
 					walk_state->parser_state.aml =
-					    walk_state->aml + 1;
+					    walk_state->aml + opcode_length;
+
 					walk_state->parser_state.aml =
 					    acpi_ps_get_next_package_end
 					    (&walk_state->parser_state);


