Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68F4C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B09B20857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/VonqPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B09B20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbeKIIEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:04:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:60676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731223AbeKIHkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:40:52 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6421D208A3;
        Thu,  8 Nov 2018 22:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714602;
        bh=CZonvM1giLyZtX4yAjpYEpi0AspAo2dwquZhBcqC5gU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/VonqPWZIomTyIMX1FOfujyw9D6awFhhHgVUnx+0HYY3wQ8minPxLWr8+BpLVSfz
         8heCh1GfFfn19z3GIi/S4s9HWJZ7LmdaKPbyYSnYKFsWI02/9MIM3L4VLwlC66/b4v
         w4h4M5QsF2iZWUm9q3y7SpsLK0ugDlcX9MqNZyLc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prarit Bharava <prarit@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 039/171] ACPI: sysfs: Make ACPI GPE mask kernel parameter cover all GPEs
Date:   Thu,  8 Nov 2018 13:50:09 -0800
Message-Id: <20181108215130.269428592@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 0f27cff8597d86f881ea8274b49b63b678c14a3c ]

The acpi_mask_gpe= kernel parameter documentation states that the range
of mask is 128 GPEs (0x00 to 0x7F).  The acpi_masked_gpes mask is a u64 so
only 64 GPEs (0x00 to 0x3F) can really be masked.

Use a bitmap of size 0xFF instead of a u64 for the GPE mask so 256
GPEs can be masked.

Fixes: 9c4aa1eecb48 (ACPI / sysfs: Provide quirk mechanism to prevent GPE flooding)
Signed-off-by: Prarit Bharava <prarit@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/kernel-parameters.txt |  1 -
 drivers/acpi/sysfs.c                | 26 ++++++++------------------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index f9f67be8d3c3..c708a50b060e 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -313,7 +313,6 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			This facility can be used to prevent such uncontrolled
 			GPE floodings.
 			Format: <int>
-			Support masking of GPEs numbered from 0x00 to 0x7f.
 
 	acpi_no_auto_serialize	[HW,ACPI]
 			Disable auto-serialization of AML methods
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index cf05ae973381..a36d0739dbfe 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -724,14 +724,8 @@ end:
  * interface:
  *   echo unmask > /sys/firmware/acpi/interrupts/gpe00
  */
-
-/*
- * Currently, the GPE flooding prevention only supports to mask the GPEs
- * numbered from 00 to 7f.
- */
-#define ACPI_MASKABLE_GPE_MAX	0x80
-
-static u64 __initdata acpi_masked_gpes;
+#define ACPI_MASKABLE_GPE_MAX	0xFF
+static DECLARE_BITMAP(acpi_masked_gpes_map, ACPI_MASKABLE_GPE_MAX) __initdata;
 
 static int __init acpi_gpe_set_masked_gpes(char *val)
 {
@@ -739,7 +733,7 @@ static int __init acpi_gpe_set_masked_gpes(char *val)
 
 	if (kstrtou8(val, 0, &gpe) || gpe > ACPI_MASKABLE_GPE_MAX)
 		return -EINVAL;
-	acpi_masked_gpes |= ((u64)1<<gpe);
+	set_bit(gpe, acpi_masked_gpes_map);
 
 	return 1;
 }
@@ -751,15 +745,11 @@ void __init acpi_gpe_apply_masked_gpes(void)
 	acpi_status status;
 	u8 gpe;
 
-	for (gpe = 0;
-	     gpe < min_t(u8, ACPI_MASKABLE_GPE_MAX, acpi_current_gpe_count);
-	     gpe++) {
-		if (acpi_masked_gpes & ((u64)1<<gpe)) {
-			status = acpi_get_gpe_device(gpe, &handle);
-			if (ACPI_SUCCESS(status)) {
-				pr_info("Masking GPE 0x%x.\n", gpe);
-				(void)acpi_mask_gpe(handle, gpe, TRUE);
-			}
+	for_each_set_bit(gpe, acpi_masked_gpes_map, ACPI_MASKABLE_GPE_MAX) {
+		status = acpi_get_gpe_device(gpe, &handle);
+		if (ACPI_SUCCESS(status)) {
+			pr_info("Masking GPE 0x%x.\n", gpe);
+			(void)acpi_mask_gpe(handle, gpe, TRUE);
 		}
 	}
 }
-- 
2.17.1



