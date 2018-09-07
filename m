Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D97C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22ECB20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22ECB20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbeIHB7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:59:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42730 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbeIHB7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:59:20 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3ED31F07;
        Fri,  7 Sep 2018 21:16:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.18 083/145] ACPICA: Clear status of all events when entering sleep states
Date:   Fri,  7 Sep 2018 23:09:09 +0200
Message-Id: <20180907210911.051367559@linuxfoundation.org>
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

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit f317c7dc12b73eb9d67fdae404563deb907dcfb7 upstream.

Commit fa85015c0d95 (ACPICA: Clear status of all events when entering
S5) made the sleep state entry code in ACPICA clear the status of all
ACPI events when entering S5 to fix a functional regression reported
against commit 18996f2db918 (ACPICA: Events: Stop unconditionally
clearing ACPI IRQs during suspend/resume).  However, it is reported
now that the regression also affects system states other than S5 on
some systems and causes them to wake up from sleep prematurely.

For this reason, make the code in question clear the status of all
ACPI events when entering all sleep states (in addition to S5) to
avoid the premature wakeups (this may cause some wakeup events to
be missed in theory, but the likelihood of that is small and the
change here simply restores the previous behavior of the code).

Fixes: 18996f2db918 (ACPICA: Events: Stop unconditionally clearing ACPI IRQs during suspend/resume)
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: 4.17+ <stable@vger.kernel.org> # 4.17+: fa85015c0d95 ACPICA: Clear status ...
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/acpica/hwsleep.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -56,14 +56,9 @@ acpi_status acpi_hw_legacy_sleep(u8 slee
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
-	/*
-	 * If the target sleep state is S5, clear all GPEs and fixed events too
-	 */
-	if (sleep_state == ACPI_STATE_S5) {
-		status = acpi_hw_clear_acpi_status();
-		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
-		}
+	status = acpi_hw_clear_acpi_status();
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
 	}
 	acpi_gbl_system_awake_and_running = FALSE;
 


