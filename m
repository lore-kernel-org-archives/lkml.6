Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B53C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32634208AF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32634208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932105AbeFXPn7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:43:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60164 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756189AbeFXPn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:43:56 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 626B82C;
        Sun, 24 Jun 2018 15:43:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.17 15/70] ACPICA: AML parser: attempt to continue loading table after error
Date:   Sun, 24 Jun 2018 23:22:07 +0800
Message-Id: <20180624142741.441277396@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142740.481662434@linuxfoundation.org>
References: <20180624142740.481662434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Erik Schmauss <erik.schmauss@intel.com>

commit 5088814a6e931350e5bd29f5d59fa40c6dbbdf10 upstream.

This change alters the parser so that the table load does not abort
upon an error.

Notable changes:

If there is an error while parsing an element of the termlist, we
will skip parsing the current termlist element and continue parsing
to the next opcode in the termlist.

If we get an error while parsing the conditional of If/Else/While or
the device name of Scope, we will skip the body of the statement all
together and pop the parser_state.

If we get an error while parsing the base offset and length of an
operation region declaration, we will remove the operation region
from the namespace.

Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/acpica/psloop.c   |   51 ++++++++++++++++++++++++++++++++++++++++-
 drivers/acpi/acpica/psobject.c |   30 ++++++++++++++++++++++++
 drivers/acpi/acpica/uterror.c  |   10 ++++----
 3 files changed, 85 insertions(+), 6 deletions(-)

--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -515,6 +515,22 @@ acpi_status acpi_ps_parse_loop(struct ac
 				if (ACPI_FAILURE(status)) {
 					return_ACPI_STATUS(status);
 				}
+				if (walk_state->opcode == AML_SCOPE_OP) {
+					/*
+					 * If the scope op fails to parse, skip the body of the
+					 * scope op because the parse failure indicates that the
+					 * device may not exist.
+					 */
+					walk_state->parser_state.aml =
+					    walk_state->aml + 1;
+					walk_state->parser_state.aml =
+					    acpi_ps_get_next_package_end
+					    (&walk_state->parser_state);
+					walk_state->aml =
+					    walk_state->parser_state.aml;
+					ACPI_ERROR((AE_INFO,
+						    "Skipping Scope block"));
+				}
 
 				continue;
 			}
@@ -557,7 +573,40 @@ acpi_status acpi_ps_parse_loop(struct ac
 				if (ACPI_FAILURE(status)) {
 					return_ACPI_STATUS(status);
 				}
-
+				if ((walk_state->control_state) &&
+				    ((walk_state->control_state->control.
+				      opcode == AML_IF_OP)
+				     || (walk_state->control_state->control.
+					 opcode == AML_WHILE_OP))) {
+					/*
+					 * If the if/while op fails to parse, we will skip parsing
+					 * the body of the op.
+					 */
+					parser_state->aml =
+					    walk_state->control_state->control.
+					    aml_predicate_start + 1;
+					parser_state->aml =
+					    acpi_ps_get_next_package_end
+					    (parser_state);
+					walk_state->aml = parser_state->aml;
+
+					ACPI_ERROR((AE_INFO,
+						    "Skipping While/If block"));
+					if (*walk_state->aml == AML_ELSE_OP) {
+						ACPI_ERROR((AE_INFO,
+							    "Skipping Else block"));
+						walk_state->parser_state.aml =
+						    walk_state->aml + 1;
+						walk_state->parser_state.aml =
+						    acpi_ps_get_next_package_end
+						    (parser_state);
+						walk_state->aml =
+						    parser_state->aml;
+					}
+					ACPI_FREE(acpi_ut_pop_generic_state
+						  (&walk_state->control_state));
+				}
+				op = NULL;
 				continue;
 			}
 		}
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -12,6 +12,7 @@
 #include "acparser.h"
 #include "amlcode.h"
 #include "acconvert.h"
+#include "acnamesp.h"
 
 #define _COMPONENT          ACPI_PARSER
 ACPI_MODULE_NAME("psobject")
@@ -549,6 +550,21 @@ acpi_ps_complete_op(struct acpi_walk_sta
 
 		do {
 			if (*op) {
+				/*
+				 * These Opcodes need to be removed from the namespace because they
+				 * get created even if these opcodes cannot be created due to
+				 * errors.
+				 */
+				if (((*op)->common.aml_opcode == AML_REGION_OP)
+				    || ((*op)->common.aml_opcode ==
+					AML_DATA_REGION_OP)) {
+					acpi_ns_delete_children((*op)->common.
+								node);
+					acpi_ns_remove_node((*op)->common.node);
+					(*op)->common.node = NULL;
+					acpi_ps_delete_parse_tree(*op);
+				}
+
 				status2 =
 				    acpi_ps_complete_this_op(walk_state, *op);
 				if (ACPI_FAILURE(status2)) {
@@ -574,6 +590,20 @@ acpi_ps_complete_op(struct acpi_walk_sta
 #endif
 		walk_state->prev_op = NULL;
 		walk_state->prev_arg_types = walk_state->arg_types;
+
+		if (walk_state->parse_flags & ACPI_PARSE_MODULE_LEVEL) {
+			/*
+			 * There was something that went wrong while executing code at the
+			 * module-level. We need to skip parsing whatever caused the
+			 * error and keep going. One runtime error during the table load
+			 * should not cause the entire table to not be loaded. This is
+			 * because there could be correct AML beyond the parts that caused
+			 * the runtime error.
+			 */
+			ACPI_ERROR((AE_INFO,
+				    "Ignore error and continue table load"));
+			return_ACPI_STATUS(AE_OK);
+		}
 		return_ACPI_STATUS(status);
 	}
 
--- a/drivers/acpi/acpica/uterror.c
+++ b/drivers/acpi/acpica/uterror.c
@@ -182,20 +182,20 @@ acpi_ut_prefixed_namespace_error(const c
 	switch (lookup_status) {
 	case AE_ALREADY_EXISTS:
 
-		acpi_os_printf(ACPI_MSG_BIOS_ERROR);
+		acpi_os_printf("\n" ACPI_MSG_BIOS_ERROR);
 		message = "Failure creating";
 		break;
 
 	case AE_NOT_FOUND:
 
-		acpi_os_printf(ACPI_MSG_BIOS_ERROR);
-		message = "Failure looking up";
+		acpi_os_printf("\n" ACPI_MSG_BIOS_ERROR);
+		message = "Could not resolve";
 		break;
 
 	default:
 
-		acpi_os_printf(ACPI_MSG_ERROR);
-		message = "Failure looking up";
+		acpi_os_printf("\n" ACPI_MSG_ERROR);
+		message = "Failure resolving";
 		break;
 	}
 


