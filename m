Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6546C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8842520C09
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8842520C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbeHUJxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:53:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56992 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbeHUJxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:53:12 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9FF0A9D7;
        Tue, 21 Aug 2018 06:34:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Przemek <soprwa@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.4 17/22] ACPI: save NVS memory for Lenovo G50-45
Date:   Tue, 21 Aug 2018 08:21:43 +0200
Message-Id: <20180821055140.322455428@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055139.462620042@linuxfoundation.org>
References: <20180821055139.462620042@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Rui <rui.zhang@intel.com>

commit cbc00c1310d34139a63946482b40a6b261a03fb9 upstream.

In commit 821d6f0359b0 (ACPI / sleep: Do not save NVS for new machines to
accelerate S3), to optimize S3 suspend/resume speed, code is introduced
to ignore NVS memory saving during S3 for all the platforms later than
2012.

But, Lenovo G50-45, a platform released in 2015, still needs NVS memory
saving during S3. A quirk is introduced for this platform.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=189431
Tested-by: Przemek <soprwa@gmail.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
[ rjw: Drop unnecessary code ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/sleep.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -124,6 +124,12 @@ void __init acpi_nvs_nosave_s3(void)
 	nvs_nosave_s3 = true;
 }
 
+static int __init init_nvs_save_s3(const struct dmi_system_id *d)
+{
+	nvs_nosave_s3 = false;
+	return 0;
+}
+
 /*
  * ACPI 1.0 wants us to execute _PTS before suspending devices, so we allow the
  * user to request that behavior by using the 'acpi_old_suspend_ordering'
@@ -318,6 +324,19 @@ static struct dmi_system_id acpisleep_dm
 		DMI_MATCH(DMI_PRODUCT_NAME, "K54HR"),
 		},
 	},
+	/*
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=189431
+	 * Lenovo G50-45 is a platform later than 2012, but needs nvs memory
+	 * saving during S3.
+	 */
+	{
+	.callback = init_nvs_save_s3,
+	.ident = "Lenovo G50-45",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "80E3"),
+		},
+	},
 	{},
 };
 


