Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AACDC4151A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 18:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD7E21871
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 18:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTZZRGcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfBCSeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 13:34:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41085 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfBCSeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 13:34:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so12182227wrs.8;
        Sun, 03 Feb 2019 10:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77qhx6TtfwS5sMBO0e0ka66KDYr3RLLu1PPTNkCcF2U=;
        b=NTZZRGcQv5j410Fpe34Q+MIps9wyRivFatTRAhA9LeNsbeQGBLKvfpJZZC9tdB55dm
         BGDsUhxBLH2ImoVCWjAeCxmyVUb0w8m8NduRq6Ebyc58hlnVXFj3JV1TBzvE5fYk8A36
         dbq5EO+MoowQYwhokOclCkORFmfT0GtuIozdGJGFQV+tryKP4nxQXgkxuQ4DhEvBOJxw
         AHxkiyQky7Uz4BJMDE+DQK/3+p2XJRmTY9yKDVDRhb1cLGmhSTlf00s4SXRs65MYGCju
         gl4vmTi9Qon48MFgWqvxcQtWQlR5H1fzXLbdRJk2KOYJoNv8T4gfakDdxYUJiqQn5AOm
         j0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77qhx6TtfwS5sMBO0e0ka66KDYr3RLLu1PPTNkCcF2U=;
        b=CVhHX70hSsHuYcv89cbG8FaNSJ3estu2Rap0GONA/0PbqT41/QS6qh3MByubGFOncE
         HwKW4GPKfCrAwbhRXW5vQ7e2fVYuPdrOgV7YIR+69i9OpRNHsijx8h5EyhnKWCwVjGrU
         9mFiIH95h0cSthjvVu6Pu/1rYQ4luKQB/b6ANoj9tN/m7LF5zLHGRocBcuKJGTF7jDQ/
         09VUme4a6JwDVyHdgbXgS+5vVp1HOVmU+qnlA44W/Su9ufWgMkhxoe4v0BjfC0amprZ2
         P1L1UfQP8m+yqyDSETuJhubqQGFaMQJkZcgqqd1s0khO2E2dRfmbgPDE3YNZptS59g82
         /W8w==
X-Gm-Message-State: AJcUukco3/bjWv1ajHTdOLmo0qaMSTlcPI6r5Kcc0zC6kyUWYNJRlgh3
        UWbgED4zN9aIVPtmViVB/EE=
X-Google-Smtp-Source: ALg8bN6agmHAR+5jldoZEOUT7FCGa8zb9EB0t2zU+ijvB6peEoNbRO2DVr5z7hb7A+Lx2qwXxRgFoQ==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr44673157wrr.74.1549218875147;
        Sun, 03 Feb 2019 10:34:35 -0800 (PST)
Received: from localhost.localdomain (ip-37-201-6-149.hsi13.unitymediagroup.de. [37.201.6.149])
        by smtp.googlemail.com with ESMTPSA id z18sm4845741wml.36.2019.02.03.10.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 10:34:34 -0800 (PST)
From:   Kai Renzig <k.renzig@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kai Renzig <k.renzig@gmail.com>
Subject: [PATCH v2] platform/x86: silead_dmi: Add touchscreen platform data for the Chuwi Hi8 Air tablet
Date:   Sun,  3 Feb 2019 19:34:23 +0100
Message-Id: <20190203183423.7661-1-k.renzig@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add touchscreen platform data for the Chuwi Hi8 Air tablet.

Signed-off-by: Kai Renzig <k.renzig@gmail.com>
---
Changes in v2:
 - Fix the firmware filename to match the actual touchscreen controller.

 drivers/platform/x86/touchscreen_dmi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 8c5d47c0aea6..1f66405928a9 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -41,6 +41,20 @@ static const struct ts_dmi_data chuwi_hi8_data = {
 	.properties     = chuwi_hi8_props,
 };
 
+static const struct property_entry chuwi_hi8_air_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1728),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1148),
+	PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl3676-chuwi-hi8-air.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	{ }
+};
+
+static const struct ts_dmi_data chuwi_hi8_air_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= chuwi_hi8_air_props,
+};
+
 static const struct property_entry chuwi_hi8_pro_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-min-x", 6),
 	PROPERTY_ENTRY_U32("touchscreen-min-y", 3),
@@ -497,6 +511,15 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "H1D_S806_206"),
 		},
 	},
+	{
+		/* Chuwi Hi8 Air (CWI543) */
+		.driver_data = (void *)&chuwi_hi8_air_data,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Default string"),
+			DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Hi8 Air"),
+		},
+	},
 	{
 		/* Chuwi Hi8 Pro (CWI513) */
 		.driver_data = (void *)&chuwi_hi8_pro_data,
-- 
2.19.1

