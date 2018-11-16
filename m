Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF97C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D922087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D922087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeKQGcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:32:14 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46187 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeKQGcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 01:32:14 -0500
Received: by mail-oi1-f196.google.com with SMTP id x202so9264479oif.13;
        Fri, 16 Nov 2018 12:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ckIGt+t31hqc36+/zUIB6Q7DzmOj5anOWtQImTp00WU=;
        b=IBG2FwaOWy37ctVgOwdh5buBtrX/tqmgdXmIij4VE57VIzIVAuuBXyCZySd3h96pzh
         5aMSEYOB2gQPfv1/7OijlZi8dPO2LGjdPpxQ1Ps6AQwoPiaypffkElHEDGHPejPdwUdn
         KYoQwg/GU0jtavR/6iISVcZCT+WixF6ECsDlNfpXcGFseafyZdtz7VgQy3GioMIT3pdk
         Sb4/DLmQb9Ee1QTJAY8zaLYpZFHoFKf7uXYYQfP/c1NsOBCEK7AVTu+5Ejw6n9JtJ0sy
         eQLT0K/O56H8nZhpvkDMCoMXieDVl/nh71H3DQNeeVBqN+ZU+rFgWNmg2Vk2SL6I3Hwk
         di4g==
X-Gm-Message-State: AGRZ1gI51nXywH4514yZ/lSHbDkvyDWjV+yd4wHKKaLyUyLCypwb2L94
        sMIyDFAxaddBKbCok+606w==
X-Google-Smtp-Source: AJdET5dSNOMOsVXy22zuy3q9PaIlMm+nrQk2E8eEuP3c2H3i2dDP3FnWxSrOlP5gJj1yRTwpFnwqcA==
X-Received: by 2002:aca:f1d6:: with SMTP id p205-v6mr1887737oih.332.1542399503021;
        Fri, 16 Nov 2018 12:18:23 -0800 (PST)
Received: from localhost.localdomain (mobile-166-173-62-28.mycingular.net. [166.173.62.28])
        by smtp.googlemail.com with ESMTPSA id l18sm27348235otb.68.2018.11.16.12.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 12:18:22 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86: olpc: Remove calling of_platform_bus_probe
Date:   Fri, 16 Nov 2018 14:18:20 -0600
Message-Id: <20181116201820.10065-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT core will probe the DT by default now, so the OLPC platform code
calling of_platform_bus_probe is not necessary. The algorithm for what
nodes are probed is a little different in how compatible is handled, but
since OLPC uses compatible strings for matching it is not affected by
this difference.

Also, only the battery node located at the root level gets a device
created as the dcon is a PCI device and the RTC device is created in
olpc-xo1-rtc.c.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/x86/platform/olpc/olpc_dt.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc_dt.c b/arch/x86/platform/olpc/olpc_dt.c
index 24d2175a9480..b4ab779f1d47 100644
--- a/arch/x86/platform/olpc/olpc_dt.c
+++ b/arch/x86/platform/olpc/olpc_dt.c
@@ -19,7 +19,6 @@
 #include <linux/kernel.h>
 #include <linux/memblock.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/of_pdt.h>
 #include <asm/olpc.h>
 #include <asm/olpc_ofw.h>
@@ -285,20 +284,3 @@ void __init olpc_dt_build_devicetree(void)
 	pr_info("PROM DT: Built device tree with %u bytes of memory.\n",
 			prom_early_allocated);
 }
-
-/* A list of DT node/bus matches that we want to expose as platform devices */
-static struct of_device_id __initdata of_ids[] = {
-	{ .compatible = "olpc,xo1-battery" },
-	{ .compatible = "olpc,xo1-dcon" },
-	{ .compatible = "olpc,xo1-rtc" },
-	{},
-};
-
-static int __init olpc_create_platform_devices(void)
-{
-	if (machine_is_olpc())
-		return of_platform_bus_probe(NULL, of_ids, NULL);
-	else
-		return 0;
-}
-device_initcall(olpc_create_platform_devices);
-- 
2.19.1

