Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CB0C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C1020862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C1020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbeG1WfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 18:35:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:64574 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730941AbeG1WfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 18:35:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jul 2018 14:07:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,415,1526367600"; 
   d="scan'208";a="61514203"
Received: from bartok.jf.intel.com ([10.54.75.128])
  by orsmga006.jf.intel.com with ESMTP; 28 Jul 2018 14:07:25 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     linux-acpi@vger.kernel.org, rafael@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        oleksandr@natalenko.name, torvalds@linux-foundation.org,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH] ACPICA: AML Parser: ignore control method status in module-level code
Date:   Sat, 28 Jul 2018 14:05:19 -0700
Message-Id: <20180728210519.20195-1-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous change in the AML parser code blindly set all non-successful
dispatcher statuses to AE_OK. This approach is incorrect because
successful control method invocations from module-level return
AE_CTRL_TRANSFER. Overwriting AE_OK to this status causes the AML
parser to think that there was no return value from the control
method invocation.

fixes: 73c2a01c52b6 (ACPICA: AML Parser: ignore dispatcher error status during table load)

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Tested-by: Linus Torvalds <torvalds@linux-foundation.org>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/psloop.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index ee840be150b5..44f35ab3347d 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -709,15 +709,20 @@ acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
 			} else
 			    if ((walk_state->
 				 parse_flags & ACPI_PARSE_MODULE_LEVEL)
+				&& status != AE_CTRL_TRANSFER
 				&& ACPI_FAILURE(status)) {
 				/*
-				 * ACPI_PARSE_MODULE_LEVEL means that we are loading a table by
-				 * executing it as a control method. However, if we encounter
-				 * an error while loading the table, we need to keep trying to
-				 * load the table rather than aborting the table load. Set the
-				 * status to AE_OK to proceed with the table load. If we get a
-				 * failure at this point, it means that the dispatcher got an
-				 * error while processing Op (most likely an AML operand error.
+				 * ACPI_PARSE_MODULE_LEVEL flag means that we are currently
+				 * loading a table by executing it as a control method.
+				 * However, if we encounter an error while loading the table,
+				 * we need to keep trying to load the table rather than
+				 * aborting the table load (setting the status to AE_OK
+				 * continues the table load). If we get a failure at this
+				 * point, it means that the dispatcher got an error while
+				 * processing Op (most likely an AML operand error) or a
+				 * control method was called from module level and the
+				 * dispatcher returned AE_CTRL_TRANSFER. In the latter case,
+				 * leave the status alone, there's nothing wrong with it.
 				 */
 				status = AE_OK;
 			}
-- 
2.17.1

