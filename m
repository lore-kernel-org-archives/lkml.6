Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF279C282CC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55662082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ETR19WTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbfBDPcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:32:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36186 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfBDPcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:32:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YefE3Y15TAtDMZxfEsVIJW0SHOkBlqGSlr5B94p0fjc=; b=ETR19WTYR/eHh8KlxinRZMahC
        Csq9MpMAGvjQavuhuCDbV1cdN3QFi0lEUU0Mm0xIDk8gHN9kx6/3K+gAusuVnFPE0gTS4uX2okMjZ
        vF9ZhadFQ7us9Ku8/zKVELSFI0Y88IE73pL0XppiNJV2jXa2/4dGWLJD2JjfTJsxKQM8QOoXzyg/A
        DIvsIC6NOyNk4uBkwnbd72ELbKIOLWPsR9G94gunlAN7V+llMvEgTSdfflvdlcJaKh7WEuKxjEuJS
        5oeReusUNVKz8yRcuL2zZPiKzaLVsbrVp0FvYwXhV0rjIzRGhJNNdDw+8G7YOFQCo0NxcU+e7oKMA
        7gNj1H+IQ==;
Received: from 089144212163.atnat0021.highway.a1.net ([89.144.212.163] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqgEG-0002Yq-R5; Mon, 04 Feb 2019 15:32:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] acpi: get rid of acpi_sleep_dispatch
Date:   Mon,  4 Feb 2019 16:32:10 +0100
Message-Id: <20190204153210.1817-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need for the array of structs of function pointers when we can just
call the handfull of functions directly.

This could be further cleaned up if acpi_gbl_reduced_hardware was defined
true in the ACPI_REDUCED_HARDWARE case, but that's material for the next
round.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/acpi/acpica/hwxfsleep.c | 96 +++++++--------------------------
 include/acpi/actypes.h          |  9 ----
 2 files changed, 18 insertions(+), 87 deletions(-)

diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index 3f22f7dd4556..f58b78eaec65 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -23,33 +23,6 @@ acpi_hw_set_firmware_waking_vector(struct acpi_table_facs *facs,
 				   acpi_physical_address physical_address64);
 #endif
 
-static acpi_status acpi_hw_sleep_dispatch(u8 sleep_state, u32 function_id);
-
-/*
- * Dispatch table used to efficiently branch to the various sleep
- * functions.
- */
-#define ACPI_SLEEP_FUNCTION_ID         0
-#define ACPI_WAKE_PREP_FUNCTION_ID     1
-#define ACPI_WAKE_FUNCTION_ID          2
-
-/* Legacy functions are optional, based upon ACPI_REDUCED_HARDWARE */
-
-static struct acpi_sleep_functions acpi_sleep_dispatch[] = {
-	{ACPI_STRUCT_INIT(legacy_function,
-			  ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_sleep)),
-	 ACPI_STRUCT_INIT(extended_function,
-			  acpi_hw_extended_sleep)},
-	{ACPI_STRUCT_INIT(legacy_function,
-			  ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake_prep)),
-	 ACPI_STRUCT_INIT(extended_function,
-			  acpi_hw_extended_wake_prep)},
-	{ACPI_STRUCT_INIT(legacy_function,
-			  ACPI_HW_OPTIONAL_FUNCTION(acpi_hw_legacy_wake)),
-	 ACPI_STRUCT_INIT(extended_function,
-			  acpi_hw_extended_wake)}
-};
-
 /*
  * These functions are removed for the ACPI_REDUCED_HARDWARE case:
  *      acpi_set_firmware_waking_vector
@@ -209,53 +182,6 @@ acpi_status acpi_enter_sleep_state_s4bios(void)
 
 ACPI_EXPORT_SYMBOL(acpi_enter_sleep_state_s4bios)
 #endif				/* !ACPI_REDUCED_HARDWARE */
-/*******************************************************************************
- *
- * FUNCTION:    acpi_hw_sleep_dispatch
- *
- * PARAMETERS:  sleep_state         - Which sleep state to enter/exit
- *              function_id         - Sleep, wake_prep, or Wake
- *
- * RETURN:      Status from the invoked sleep handling function.
- *
- * DESCRIPTION: Dispatch a sleep/wake request to the appropriate handling
- *              function.
- *
- ******************************************************************************/
-static acpi_status acpi_hw_sleep_dispatch(u8 sleep_state, u32 function_id)
-{
-	acpi_status status;
-	struct acpi_sleep_functions *sleep_functions =
-	    &acpi_sleep_dispatch[function_id];
-
-#if (!ACPI_REDUCED_HARDWARE)
-	/*
-	 * If the Hardware Reduced flag is set (from the FADT), we must
-	 * use the extended sleep registers (FADT). Note: As per the ACPI
-	 * specification, these extended registers are to be used for HW-reduced
-	 * platforms only. They are not general-purpose replacements for the
-	 * legacy PM register sleep support.
-	 */
-	if (acpi_gbl_reduced_hardware) {
-		status = sleep_functions->extended_function(sleep_state);
-	} else {
-		/* Legacy sleep */
-
-		status = sleep_functions->legacy_function(sleep_state);
-	}
-
-	return (status);
-
-#else
-	/*
-	 * For the case where reduced-hardware-only code is being generated,
-	 * we know that only the extended sleep registers are available
-	 */
-	status = sleep_functions->extended_function(sleep_state);
-	return (status);
-
-#endif				/* !ACPI_REDUCED_HARDWARE */
-}
 
 /*******************************************************************************
  *
@@ -362,7 +288,12 @@ acpi_status acpi_enter_sleep_state(u8 sleep_state)
 		return_ACPI_STATUS(AE_AML_OPERAND_VALUE);
 	}
 
-	status = acpi_hw_sleep_dispatch(sleep_state, ACPI_SLEEP_FUNCTION_ID);
+#if !ACPI_REDUCED_HARDWARE
+	if (!acpi_gbl_reduced_hardware)
+		status = acpi_hw_legacy_sleep(sleep_state);
+	else
+#endif
+		status = acpi_hw_extended_sleep(sleep_state);
 	return_ACPI_STATUS(status);
 }
 
@@ -388,8 +319,12 @@ acpi_status acpi_leave_sleep_state_prep(u8 sleep_state)
 
 	ACPI_FUNCTION_TRACE(acpi_leave_sleep_state_prep);
 
-	status =
-	    acpi_hw_sleep_dispatch(sleep_state, ACPI_WAKE_PREP_FUNCTION_ID);
+#if !ACPI_REDUCED_HARDWARE
+	if (!acpi_gbl_reduced_hardware)
+		status = acpi_hw_legacy_wake_prep(sleep_state);
+	else
+#endif
+		status = acpi_hw_extended_wake_prep(sleep_state);
 	return_ACPI_STATUS(status);
 }
 
@@ -413,7 +348,12 @@ acpi_status acpi_leave_sleep_state(u8 sleep_state)
 
 	ACPI_FUNCTION_TRACE(acpi_leave_sleep_state);
 
-	status = acpi_hw_sleep_dispatch(sleep_state, ACPI_WAKE_FUNCTION_ID);
+#if !ACPI_REDUCED_HARDWARE
+	if (!acpi_gbl_reduced_hardware)
+		status = acpi_hw_legacy_wake(sleep_state);
+	else
+#endif
+		status = acpi_hw_extended_wake(sleep_state);
 	return_ACPI_STATUS(status);
 }
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 2590627dbfcc..9b11d07e4363 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -885,15 +885,6 @@ typedef u8 acpi_adr_space_type;
 #define ACPI_ENABLE_EVENT                       1
 #define ACPI_DISABLE_EVENT                      0
 
-/* Sleep function dispatch */
-
-typedef acpi_status (*acpi_sleep_function) (u8 sleep_state);
-
-struct acpi_sleep_functions {
-	acpi_sleep_function legacy_function;
-	acpi_sleep_function extended_function;
-};
-
 /*
  * External ACPI object definition
  */
-- 
2.20.1

