Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C25C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B0F20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bsGImkMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B0F20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756229AbeFSGq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:46:27 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40831 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755536AbeFSGoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:44:12 -0400
Received: by mail-pl0-f67.google.com with SMTP id t12-v6so10397328plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 23:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oQBxjbhd3sorzsMaJwszGFfBNGkMSm+1QnH1URdsLGE=;
        b=bsGImkMY0YQk+qC/DMf4ZWW82ZNqGj0m/RmAzznQP/SqxLo85JmXW+bGukd2Py81mJ
         NJq3/y/OrRE5BiufK0c/G2RWf8xbPV9V6YA0PhvhThoHNkqfu8T/kcMV7haRHqLOpUqT
         Myn7Mo6OWE/tHptsgB9uMtXPrFh6U2gPNvu2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oQBxjbhd3sorzsMaJwszGFfBNGkMSm+1QnH1URdsLGE=;
        b=UFjzp/1ykkhFlNu+8YuKTsz870Cuau+jaqaGSPFy+vp+wYN+dArtM+aEJkROQd2MEL
         12PI1cJ5JRSyjQh+NAJnk+l/uThhPoe5hpms4OzZLvN2YizoxugiNDVDPTB3XqiuZsRN
         nmR2GdKZXands9CvV0zX1pEFYiRJBQZybYbaEh9JbGZ39JnDR3KQ3uLl1p1QuvBPapV9
         YkbDavN+Knkytcxx5NYItQKyUwLdNZ7eryfekkVe8kZZvfocEIMst8rEGXbh+b9uTyc2
         0aoV1So5piR7jf4Tdla77B0v0aF7cCjSG0EtvUnHrdnewQEI3CqmggOQgLmgFPoehhtf
         gaMQ==
X-Gm-Message-State: APt69E0lRIPWh8I1bznAQDByRBv2KKLoSfFBrOrusnWBlqZLlyjbfESN
        1KsNK4vYNgL91dJ7sA7arhCiNQ==
X-Google-Smtp-Source: ADUXVKLynddqdeTat6wj960ZnMvhIjLrGp4GTefuqwtw2o86/2WlLDJGYHNca/7+mjGwrfTZC8+PKQ==
X-Received: by 2002:a17:902:1e4:: with SMTP id b91-v6mr17386973plb.155.1529390651996;
        Mon, 18 Jun 2018 23:44:11 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id e68-v6sm32031601pfl.65.2018.06.18.23.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 23:44:11 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org
Cc:     tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 2/4] efi/arm: map UEFI memory map even w/o runtime services enabled
Date:   Tue, 19 Jun 2018 15:44:22 +0900
Message-Id: <20180619064424.6642-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180619064424.6642-1-takahiro.akashi@linaro.org>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under the current implementation, UEFI memory map will be mapped and made
available in virtual mappings only if runtime services are enabled.
But in a later patch, we want to use UEFI memory map in acpi_os_ioremap()
to create mappings of ACPI tables using memory attributes described in
UEFI memory map.

So, as a first step, arm_enter_runtime_services() will be modified
so that UEFI memory map will be always accessible.

See a relevant commit:
    arm64: acpi: fix alignment fault in accessing ACPI tables

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/arm-runtime.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 5889cbea60b8..30ac5c82051e 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -115,6 +115,13 @@ static int __init arm_enable_runtime_services(void)
 		return 0;
 	}
 
+	mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
+
+	if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
+		pr_err("Failed to remap EFI memory map\n");
+		return 0;
+	}
+
 	if (efi_runtime_disabled()) {
 		pr_info("EFI runtime services will be disabled.\n");
 		return 0;
@@ -127,13 +134,6 @@ static int __init arm_enable_runtime_services(void)
 
 	pr_info("Remapping and enabling EFI services.\n");
 
-	mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
-
-	if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
-		pr_err("Failed to remap EFI memory map\n");
-		return -ENOMEM;
-	}
-
 	if (!efi_virtmap_init()) {
 		pr_err("UEFI virtual mapping missing or invalid -- runtime services will not be available\n");
 		return -ENOMEM;
-- 
2.17.0

