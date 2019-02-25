Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446B4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1061B20989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AP31cvDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfBYGu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 01:50:58 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36971 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfBYGu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 01:50:57 -0500
Received: by mail-pg1-f193.google.com with SMTP id q206so4030771pgq.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 22:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DlhuYm7lEFT/d5+8ok6R/t5CWe4qZ+5HUIyf9sTH8IM=;
        b=AP31cvDx6a8aHKUBN9/qcPrhVapsik3G4yDVdB5n4jAmQRgpMKOR63inTX9fxFiymw
         Y/wx4J6ydcOD9zPSzVJZ8uXOQRqtRjJzDFtFJtaIOnYhWqG3O3LczbuOe6r2c0EeyDky
         Dhq90+08IC8Mf7UgY2C2Y8ehdD8r1vj0V76VqMY3BN11X7LK8oXmnpUTvtqaSakTPHvy
         LbcOFsP19YW6Q3sHI3Wd8MNbRuVg7Tcai5pLOWrztICiaczKMocEsS8ISAZXWUhfn+ct
         VRdpWnMOoPG1fbz3J1L7HtcE/esU3Ya+6YYpa2EtjAlSPQWSezGx+qJ5SN+NEcmVLcMK
         0z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DlhuYm7lEFT/d5+8ok6R/t5CWe4qZ+5HUIyf9sTH8IM=;
        b=sm4xKWqaIay8VqlyicjwEHFhGGhh0fbsBosLASovNpb+eWfJtHT+LHws3M3jnnKy3i
         pWtyTonqc+R/P2lGyV5oJQyZxfcYtHTix4UZqIlzA/A3t9dMTsxz6/Yt8gEOJPiENroB
         vj5FfK2hoErWppFk3RLdU0C2YHttUH7Xnu7PRjJHO0O7OCtVq4VgrdrPv0YOzrGkPt0M
         hAgHN7KqPfea34iVDRgj7l3FHsAzeCAL06CEodbgzO0KDrpbcyTs5JBXsxoP3l5enL+m
         OxwB30dNMihnwpzXg1KWIJnIUxFPYKLAMlcLOeOScXmWPqC9NIudV/5uO8l5SxKB/yZm
         YzHg==
X-Gm-Message-State: AHQUAuZzZM1cFwWwFOMbjmH+p0tmurSZjlPfKboBAVH3ix04HeUDKl5u
        PWuAQgJHYA3UBWqdVauHExc+uA==
X-Google-Smtp-Source: AHgI3IYrRRPg2qRufhiuBb25xluuH4Glswado4i+RM+6MtMhxAaVUhql2J2xrXdEYV+/ZJSoi0xvrw==
X-Received: by 2002:a63:6bc6:: with SMTP id g189mr17761292pgc.427.1551077456778;
        Sun, 24 Feb 2019 22:50:56 -0800 (PST)
Received: from localhost.localdomain ([116.75.87.120])
        by smtp.gmail.com with ESMTPSA id f16sm9990021pgg.20.2019.02.24.22.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 22:50:56 -0800 (PST)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     andy.gross@linaro.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH v4 1/5] base: soc: Add serial_number attribute to soc
Date:   Mon, 25 Feb 2019 12:20:40 +0530
Message-Id: <20190225065044.11023-2-vaishali.thakkar@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190225065044.11023-1-vaishali.thakkar@linaro.org>
References: <20190225065044.11023-1-vaishali.thakkar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add new attribute named "serial_number" as a standard interface for
user space to acquire the serial number of the device.

For ST-Ericsson SoCs this is exposed by the cryptically named "soc_id"
attribute, but this provides a human readable standardized name for this
property.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Changes since v3:
	- Add Greg's Reviewed-by
Changes since v2:
	- None
Changes since v1:
	- Make comment more clear for the case when serial
	  number is not available
---
 Documentation/ABI/testing/sysfs-devices-soc | 7 +++++++
 drivers/base/soc.c                          | 7 +++++++
 include/linux/sys_soc.h                     | 1 +
 3 files changed, 15 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-soc b/Documentation/ABI/testing/sysfs-devices-soc
index 6d9cc253f2b2..ba3a3fac0ee1 100644
--- a/Documentation/ABI/testing/sysfs-devices-soc
+++ b/Documentation/ABI/testing/sysfs-devices-soc
@@ -26,6 +26,13 @@ Description:
 		Read-only attribute common to all SoCs. Contains SoC family name
 		(e.g. DB8500).
 
+What:		/sys/devices/socX/serial_number
+Date:		January 2019
+contact:	Bjorn Andersson <bjorn.andersson@linaro.org>
+Description:
+		Read-only attribute supported by most SoCs. Contains the SoC's
+		serial number, if available.
+
 What:		/sys/devices/socX/soc_id
 Date:		January 2012
 contact:	Lee Jones <lee.jones@linaro.org>
diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 10b280f30217..b0933b9fe67f 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -33,6 +33,7 @@ static struct bus_type soc_bus_type = {
 
 static DEVICE_ATTR(machine,  S_IRUGO, soc_info_get,  NULL);
 static DEVICE_ATTR(family,   S_IRUGO, soc_info_get,  NULL);
+static DEVICE_ATTR(serial_number, S_IRUGO, soc_info_get,  NULL);
 static DEVICE_ATTR(soc_id,   S_IRUGO, soc_info_get,  NULL);
 static DEVICE_ATTR(revision, S_IRUGO, soc_info_get,  NULL);
 
@@ -57,6 +58,9 @@ static umode_t soc_attribute_mode(struct kobject *kobj,
 	if ((attr == &dev_attr_revision.attr)
 	    && (soc_dev->attr->revision != NULL))
 		return attr->mode;
+	if ((attr == &dev_attr_serial_number.attr)
+	    && (soc_dev->attr->serial_number != NULL))
+		return attr->mode;
 	if ((attr == &dev_attr_soc_id.attr)
 	    && (soc_dev->attr->soc_id != NULL))
 		return attr->mode;
@@ -77,6 +81,8 @@ static ssize_t soc_info_get(struct device *dev,
 		return sprintf(buf, "%s\n", soc_dev->attr->family);
 	if (attr == &dev_attr_revision)
 		return sprintf(buf, "%s\n", soc_dev->attr->revision);
+	if (attr == &dev_attr_serial_number)
+		return sprintf(buf, "%s\n", soc_dev->attr->serial_number);
 	if (attr == &dev_attr_soc_id)
 		return sprintf(buf, "%s\n", soc_dev->attr->soc_id);
 
@@ -87,6 +93,7 @@ static ssize_t soc_info_get(struct device *dev,
 static struct attribute *soc_attr[] = {
 	&dev_attr_machine.attr,
 	&dev_attr_family.attr,
+	&dev_attr_serial_number.attr,
 	&dev_attr_soc_id.attr,
 	&dev_attr_revision.attr,
 	NULL,
diff --git a/include/linux/sys_soc.h b/include/linux/sys_soc.h
index bed223b70217..2a13bc033bd6 100644
--- a/include/linux/sys_soc.h
+++ b/include/linux/sys_soc.h
@@ -12,6 +12,7 @@ struct soc_device_attribute {
 	const char *machine;
 	const char *family;
 	const char *revision;
+	const char *serial_number;
 	const char *soc_id;
 	const void *data;
 };
-- 
2.17.1

