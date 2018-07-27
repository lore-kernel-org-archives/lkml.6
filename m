Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0DEC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E542089A
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E542089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389158AbeG0LLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:11:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53190 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbeG0LLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:11:44 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A96D0BBD;
        Fri, 27 Jul 2018 09:50:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.17 55/66] ACPICA: AML Parser: ignore dispatcher error status during table load
Date:   Fri, 27 Jul 2018 11:45:48 +0200
Message-Id: <20180727093815.227850545@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
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

From: Schmauss, Erik <erik.schmauss@intel.com>

commit 73c2a01c52b657f4a0ead6c95f64c5279efbd000 upstream.

The dispatcher and the executer process the parse nodes During table
load. Error status from the evaluation confuses the AML parser. This
results in the parser failing to complete parsing of the current
scope op which becomes problematic. For the incorrect AML below, _ADR
never gets created.

definition_block(...)
{
   Scope (\_SB)
   {
     Device (PCI0){...}
     Name (OBJ1, 0x0)
     OBJ1 = PCI0 + 5 // Results in an operand error.
   } // \_SB not closed

   // parser looks for \_SB._SB.PCI0, results in AE_NOT_FOUND error
   // Entire scope block gets skipped.
   Scope (\_SB.PCI0)
   {
       Name (_ADR, 0x0)
   }
}

Fix the above error by properly completing the initial \_SB scope
after an error by clearing errors that occur during table load. In
the above case, this means that OBJ1 = PIC0 + 5 is skipped.

Fixes: 5088814a6e93 (ACPICA: AML parser: attempt to continue loading table after error)
Link: https://bugzilla.kernel.org/show_bug.cgi?id=200363
Tested-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Cc: 4.17+ <stable@vger.kernel.org> # 4.17+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/acpica/psloop.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -497,6 +497,18 @@ acpi_status acpi_ps_parse_loop(struct ac
 			status =
 			    acpi_ps_create_op(walk_state, aml_op_start, &op);
 			if (ACPI_FAILURE(status)) {
+				/*
+				 * ACPI_PARSE_MODULE_LEVEL means that we are loading a table by
+				 * executing it as a control method. However, if we encounter
+				 * an error while loading the table, we need to keep trying to
+				 * load the table rather than aborting the table load. Set the
+				 * status to AE_OK to proceed with the table load.
+				 */
+				if ((walk_state->
+				     parse_flags & ACPI_PARSE_MODULE_LEVEL)
+				    && status == AE_ALREADY_EXISTS) {
+					status = AE_OK;
+				}
 				if (status == AE_CTRL_PARSE_CONTINUE) {
 					continue;
 				}
@@ -694,6 +706,20 @@ acpi_status acpi_ps_parse_loop(struct ac
 			    acpi_ps_next_parse_state(walk_state, op, status);
 			if (status == AE_CTRL_PENDING) {
 				status = AE_OK;
+			} else
+			    if ((walk_state->
+				 parse_flags & ACPI_PARSE_MODULE_LEVEL)
+				&& ACPI_FAILURE(status)) {
+				/*
+				 * ACPI_PARSE_MODULE_LEVEL means that we are loading a table by
+				 * executing it as a control method. However, if we encounter
+				 * an error while loading the table, we need to keep trying to
+				 * load the table rather than aborting the table load. Set the
+				 * status to AE_OK to proceed with the table load. If we get a
+				 * failure at this point, it means that the dispatcher got an
+				 * error while processing Op (most likely an AML operand error.
+				 */
+				status = AE_OK;
 			}
 		}
 


