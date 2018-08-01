Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F215C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D742920840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D742920840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbeHAUYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:24:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45784 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403829AbeHATDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:32 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B28AE12E7;
        Wed,  1 Aug 2018 17:11:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.17 336/336] ACPICA: AML Parser: ignore control method status in module-level code
Date:   Wed,  1 Aug 2018 18:51:11 +0200
Message-Id: <20180801165041.883886494@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
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

commit 460a53106ac39b74625d1104d9a113e0f3716c18 upstream.

Previous change in the AML parser code blindly set all non-successful
dispatcher statuses to AE_OK. That approach is incorrect, though,
because successful control method invocations from module-level
return AE_CTRL_TRANSFER. Overwriting AE_OK to this status causes the
AML parser to think that there was no return value from the control
method invocation.

Fixes: 92c0f4af386 (ACPICA: AML Parser: ignore dispatcher error status during table load)
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Tested-by: Linus Torvalds <torvalds@linux-foundation.org>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/acpica/psloop.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -709,15 +709,20 @@ acpi_status acpi_ps_parse_loop(struct ac
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


