Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C5AC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8BF20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8BF20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbeIHB7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:59:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42720 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbeIHB7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:59:16 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BB6E3FA4;
        Fri,  7 Sep 2018 21:16:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.18 082/145] ACPICA: AML Parser: skip opcodes that open a scope upon parse failure
Date:   Fri,  7 Sep 2018 23:09:08 +0200
Message-Id: <20180907210910.994587838@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Erik Schmauss <erik.schmauss@intel.com>

commit 4a7c94c721074eafb27298d93dbcc339aa28e745 upstream.

This change skips the entire length of opcodes that open a scope
(Device, Scope, Processor, etc) if the creation of the op fails. The
failure could be caused by various errors including AE_ALREADY_EXISTS
and AE_NOT_FOUND.

Reported-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Cc: 4.17+ <stable@vger.kernel.org> # 4.17+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/acpica/psloop.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -22,6 +22,7 @@
 #include "acdispat.h"
 #include "amlcode.h"
 #include "acconvert.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_PARSER
 ACPI_MODULE_NAME("psloop")
@@ -527,12 +528,18 @@ acpi_status acpi_ps_parse_loop(struct ac
 				if (ACPI_FAILURE(status)) {
 					return_ACPI_STATUS(status);
 				}
-				if (walk_state->opcode == AML_SCOPE_OP) {
+				if (acpi_ns_opens_scope
+				    (acpi_ps_get_opcode_info
+				     (walk_state->opcode)->object_type)) {
 					/*
-					 * If the scope op fails to parse, skip the body of the
-					 * scope op because the parse failure indicates that the
-					 * device may not exist.
+					 * If the scope/device op fails to parse, skip the body of
+					 * the scope op because the parse failure indicates that
+					 * the device may not exist.
 					 */
+					ACPI_ERROR((AE_INFO,
+						    "Skip parsing opcode %s",
+						    acpi_ps_get_opcode_name
+						    (walk_state->opcode)));
 					walk_state->parser_state.aml =
 					    walk_state->aml + 1;
 					walk_state->parser_state.aml =
@@ -540,8 +547,6 @@ acpi_status acpi_ps_parse_loop(struct ac
 					    (&walk_state->parser_state);
 					walk_state->aml =
 					    walk_state->parser_state.aml;
-					ACPI_ERROR((AE_INFO,
-						    "Skipping Scope block"));
 				}
 
 				continue;


