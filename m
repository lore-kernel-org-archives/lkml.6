Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15636C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96CC20873
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="THTBRY5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbeL0TBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 14:01:44 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40099 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeL0TBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 14:01:37 -0500
Received: by mail-ed1-f67.google.com with SMTP id g22so15931568edr.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 11:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lELMYxGBq1wtuJWcpqHPQ/HdXwW1NxaQ8FdwNt6SqtQ=;
        b=THTBRY5VIJFxdEBovHezMJXVb1V2sUUyVCFlLcR5L58BGTNcGGqowUhxJ45svP58Jq
         ASgENUBMus/b96vj56w8k03CG/6cjJ6LqX0C7z25S3lhUkgYWRHvdu9f1QOfA/0yg421
         0qK1dcESMdiaopjlZF9fJJmZ/1SZsghcNhGQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lELMYxGBq1wtuJWcpqHPQ/HdXwW1NxaQ8FdwNt6SqtQ=;
        b=ALFNkYSqKWgE0sVIi4ho1f/l/JF+y+Q9jc35Q9Zw7oHbcPy+B19cYzNIoob4wFiys3
         g3nM2qB02Aiz0nqNKSYOwj2FuylmOIbuS4tbVx4OycGUJWvZ8Onq2cM4q8smVhPyOXjz
         mQp0WNP41Dm+tPMRaHvVVwfUnL4GeU8SlB6aNGJ+sAipK9iMgwaVwb/jCfcmcnrXGOLX
         WGWSrBSb5jYNTZsQJY3KI//iwR3/sMp4QRrYWMabpITsA5+aqLEyxYHySH96NB0Q3RWn
         Q15mnHWzmdPC0oWf/+aNYLkVA+ClXTk5g02A3czhObJgtb2aJ9QOXFmXG7LQ5mdbMpcb
         M7GQ==
X-Gm-Message-State: AA+aEWbyOVhZ8SmSiFasLktBKqqnPMo2jnSy0HG0MWlzwIyy0jbONlcX
        QlWNavLQZ2SHeEoWuXFMBRy6yQ==
X-Google-Smtp-Source: AFSGD/VhPscy6On4Hdr5ewZoIrn+ZgnqhjXtwh+LLAGc0IM/cI23LOyBAbRLWGiJwYZ+a9EuBxrPbQ==
X-Received: by 2002:a17:906:1604:: with SMTP id m4-v6mr16471470ejd.167.1545937295497;
        Thu, 27 Dec 2018 11:01:35 -0800 (PST)
Received: from chuckie.home ([2a01:cb1d:112:6f00:6488:e12:eb9c:4813])
        by smtp.gmail.com with ESMTPSA id v14sm11224376edq.74.2018.12.27.11.01.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 11:01:34 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>
Subject: [RFC PATCH 2/2] optee: add ACPI support
Date:   Thu, 27 Dec 2018 20:01:22 +0100
Message-Id: <20181227190122.23149-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181227190122.23149-1-ard.biesheuvel@linaro.org>
References: <20181227190122.23149-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for devices that expose the presence of OPTEE via device
object in the ACPI namespace.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/tee/optee/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 61ea65cfaedd..94b2fd08b446 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -14,6 +14,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/acpi.h>
 #include <linux/arm-smccc.h>
 #include <linux/errno.h>
 #include <linux/io.h>
@@ -689,12 +690,21 @@ static const struct of_device_id optee_dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, optee_dt_match);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id optee_acpi_match[] = {
+	{ "LNRO0020" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, optee_acpi_match);
+#endif
+
 static struct platform_driver optee_driver = {
 	.probe  = optee_probe,
 	.remove = optee_remove,
 	.driver = {
 		.name = "optee",
 		.of_match_table = optee_dt_match,
+		.acpi_match_table = ACPI_PTR(optee_acpi_match),
 	},
 };
 module_platform_driver(optee_driver);
-- 
2.19.2

