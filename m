Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71611C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEC5218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gApHwAt+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388194AbeLTTkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:40:15 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45355 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387597AbeLTTkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 14:40:14 -0500
Received: by mail-ed1-f67.google.com with SMTP id d39so2706815edb.12;
        Thu, 20 Dec 2018 11:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dgCexQ3bCpZSgzxPkdB++jeUw0b0M8FP6amHupayE60=;
        b=gApHwAt+u6yafQLlA1QrM0s/DJD2S4mBoCmuyhlTUL3KLnr4SVuEq7OhIbDN0w8SI3
         emma2X2lgiQ0TvGpoLJjdVPrVyr2yXUuprKGKIPgVAhum5GGrAxwWKiWsBuWtbZXhLIt
         Qoqdp0xfULpVcooPfdJFYC8jpJc2Pnt4KW9ZmM/15zXe/Fwj0nXQf1ErUwCkTBlhMP6L
         l+EnnB5BLCXgbFxARdW9ZInUbL6NQtVV2EzX57XjZgvwMfm1PVpdyLx2IU1hT4B5U4Tx
         os5VY1PZC7xAu0q/RJ17g9IrPPJHNfMZA7IimhlbPFn+i29Der70BXN8r8OJX00U3w9v
         tBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dgCexQ3bCpZSgzxPkdB++jeUw0b0M8FP6amHupayE60=;
        b=VWBvLU1GY5oEIlADGvS99tWfT4T32TNvtzvebkXI7UW0zxBCHuOZRMEYtDrKcvs1kG
         yT8EdnCBmel/pjRdPU+ftdN2OmISC9jaBCXx5lcLsqEg5+y//m/+sxVk8K9qpU30xhE8
         LcU+0KRmVqRw8/MgDwsO5m+T6MylBl1X4oWXvQXD7bspE0U6LTJlaXM2SPcVxOLs0uce
         esRTDrs2iJtfhlCaaN/5sGa1Wvsrn5/uuoxqgEWtLjJrKJ0T9tPIjA8m76EvTXsihOrg
         DkuIDRRwb4zDUoKjz2pKAnn4+FHPSDXsveBkBG96jKijWkym+d51sNh0tMxnZGmzL+y0
         9Kfw==
X-Gm-Message-State: AA+aEWYQOan76L/3z3yu2ntFWLBRgpD90qMHi/IjGAnTodWqXyXIMSA8
        7k9m01qlATI5d0LkkSFW8MFCfBPQ
X-Google-Smtp-Source: AFSGD/U+ZdPRT4Q8/qRlT5PK6Lo0RPi+xD+7sjUiURO5blY9bZMpWXrWgRmnWZKpJJ3uBcs/du/91g==
X-Received: by 2002:a50:87d9:: with SMTP id 25mr24396934edz.259.1545334811509;
        Thu, 20 Dec 2018 11:40:11 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id q16sm6236030eds.60.2018.12.20.11.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:40:10 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ACPI / tables: Add an ifdef around amlcode and dsdt_amlcode
Date:   Thu, 20 Dec 2018 12:38:56 -0700
Message-Id: <20181220193856.7833-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/acpi/tables.c:715:14: warning: unused variable 'amlcode'
[-Wunused-variable]
static void *amlcode __attribute__ ((weakref("AmlCode")));
             ^
drivers/acpi/tables.c:716:14: warning: unused variable 'dsdt_amlcode'
[-Wunused-variable]
static void *dsdt_amlcode __attribute__ ((weakref("dsdt_aml_code")));
             ^
2 warnings generated.

The only uses of these variables are hiddem behind CONFIG_ACPI_CUSTOM_DSDT
so do the same thing here.

Fixes: 82e4eb4e9653 ("ACPI / tables: add DSDT AmlCode new declaration name support")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/acpi/tables.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index ccb90eff00e5..48eabb6c2d4f 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -712,8 +712,10 @@ acpi_os_physical_table_override(struct acpi_table_header *existing_table,
 					  table_length);
 }
 
+#ifdef CONFIG_ACPI_CUSTOM_DSDT
 static void *amlcode __attribute__ ((weakref("AmlCode")));
 static void *dsdt_amlcode __attribute__ ((weakref("dsdt_aml_code")));
+#endif
 
 acpi_status
 acpi_os_table_override(struct acpi_table_header *existing_table,
-- 
2.20.1

