Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9CFC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E8221A14
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UjIgmeJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E8221A14
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933677AbeGCJXB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:23:01 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45499 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932388AbeGCJW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:22:59 -0400
Received: by mail-qt0-f194.google.com with SMTP id y5-v6so924640qti.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 02:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6Iu7TZ1mb769VLJMGzyuXq8+1crxGus9llCmVOXsn3A=;
        b=UjIgmeJvug3McynvszMzkLeEq3SxImAeNxRVwU5yiDIBO96XWaeVRbtmpWeHoswxD8
         9vIZlJziupUty474wG+woIF0psJjconMWRLN7AdWhhmiA8nh1X051CElMbfoMgT3C1lN
         qEJUxQANXmtCoTuLu8y/h28hjn7ohUK1QJ5FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6Iu7TZ1mb769VLJMGzyuXq8+1crxGus9llCmVOXsn3A=;
        b=hBKvj7SBWVmQwwy17VBC0mySi3h/z6xrkXD2YeUWR1a7wp4kDcpg9rqUiU109mKN7+
         c0GnTVoNx/grYHfosPCaRg+5X6o3PLuCfQkT+TPJmLwlYfuxkOQQehGEJrlEj1jBvF8l
         7+6ocXiQf7GMEC6u8pbZ/Fi/X5rcnVkzYJxd73ZX+bqxZcXcZdWPS7V+ZAo+GLjutZZO
         dmG+ov1VTc00GaDXj/1AaWKFU1SqD7SW2lDUqm5/1d76ekljRr/z8727HP0MrO70Jpxr
         KH5jA1xL20BeOdIPrPauGgGXQp65kwdgNI+b9akrIREIJwvIeXW9dSEX5oEcenjucBkY
         d5rg==
X-Gm-Message-State: APt69E0gorTDXRWcAnSzyDwp5fmgK8GV3YBrv+3lmakPw74N7tgsCpwO
        mlKmY527F0QDiFYzeMH43L7hbA==
X-Google-Smtp-Source: AAOMgpfuVsu4cUc5lEHSPPV4yJVZIflVbRHhOjuT5MAfaY85buPTtZ2SshPbjgIa80eA/+I1fSB6YA==
X-Received: by 2002:a0c:b40c:: with SMTP id u12-v6mr3632356qve.58.1530609778385;
        Tue, 03 Jul 2018 02:22:58 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k10-v6sm417856qtm.6.2018.07.03.02.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jul 2018 02:22:57 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     rafael@kernel.org, lenb@kernel.org, andy.shevchenko@gmail.com
Cc:     ray.jui@broadcom.com, vladimir.olovyannikov@broadcom.com,
        vikram.prakash@broadcom.com, scott.branden@broadcom.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [RFC PATCH] ACPI: bus: match of_device_id using acpi device
Date:   Tue,  3 Jul 2018 14:52:40 +0530
Message-Id: <1530609760-8919-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides a function, to get of_device_id after
matching with ACPI device _DSD object compatible property
in the case driver does not contain acpi_device_id list
and driver probe called for ACPI device ID PRP0001 with
compatible property match with of_device_id compatible.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/acpi/bus.c   | 23 +++++++++++++++++++++++
 include/linux/acpi.h | 10 ++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 84b4a62..e676bf7 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -830,6 +830,29 @@ const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
 }
 EXPORT_SYMBOL_GPL(acpi_match_device);
 
+/**
+ * acpi_match_of_device_id - Match a struct device in given of_device_id list
+ * @ids: Array of struct of_device_id object to match against.
+ * @dev: The device structure to match.
+ *
+ * Check if @dev has a valid ACPI handle and if there is a struct acpi_device
+ * object for that handle and use that object to match against a given list of
+ * device IDs.
+ *
+ * Return a pointer to the first matching ID on success or %NULL on failure.
+ */
+const
+struct of_device_id *acpi_match_of_device_id(const struct of_device_id *ids,
+					     const struct device *dev)
+{
+	const struct of_device_id *id = NULL;
+
+	__acpi_match_device(acpi_companion_match(dev), NULL, ids, NULL, &id);
+	return id;
+}
+EXPORT_SYMBOL_GPL(acpi_match_of_device_id);
+
+
 const void *acpi_device_get_match_data(const struct device *dev)
 {
 	const struct acpi_device_id *match;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4b35a66..2f24800 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -589,6 +589,10 @@ extern int acpi_nvs_for_each_region(int (*func)(__u64, __u64, void *),
 const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
 					       const struct device *dev);
 
+const
+struct of_device_id *acpi_match_of_device_id(const struct of_device_id *ids,
+					     const struct device *dev);
+
 const void *acpi_device_get_match_data(const struct device *dev);
 extern bool acpi_driver_match_device(struct device *dev,
 				     const struct device_driver *drv);
@@ -775,6 +779,12 @@ static inline const struct acpi_device_id *acpi_match_device(
 	return NULL;
 }
 
+static inline const struct of_device_id *acpi_match_of_device_id(
+	const struct of_device_id *ids, const struct device *dev)
+{
+	return NULL;
+}
+
 static inline const void *acpi_device_get_match_data(const struct device *dev)
 {
 	return NULL;
-- 
2.7.4

