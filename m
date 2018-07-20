Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2777BECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D771720856
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dQ7by6O8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D771720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbeGTCd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 22:33:59 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35170 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731283AbeGTCd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 22:33:58 -0400
Received: by mail-pl0-f68.google.com with SMTP id w3-v6so4437343plq.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 18:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Eo7sVi41YgrsYz9DtX5IlTRqkFuBHV0AkwX0j3bW0Ik=;
        b=dQ7by6O89TB4RoqM9aJLiSQuK8ev9fl0gaox7aDzL/HtubQPtvAXYxHEdMg8EGMKBf
         qx637bYraG3Ld31w3vnVoiPX/TPm3aKi4gAUOjIoX9IQeymPEYdOhHKcoZMegYLP1/B7
         AtdklPrIzFgWp0OaqXbfwc/lgW4DxQx2WOHLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Eo7sVi41YgrsYz9DtX5IlTRqkFuBHV0AkwX0j3bW0Ik=;
        b=b+OZvUhTn+gEoV2nep78T94qHgvSkJpAgNnHBszf1yrKaB7Cq9bRQzlDxY/J1PCtd3
         hiPSMj1w51T4al+u4LKwkVgAJNxufS7DJyb/S0PDUYT3u8FPu0pwgi+RNNCQEbCKnQKW
         KdCST7rOQ+A6ajJe6WaRpALvwfr+jMjG1c1q1fGsEqJ+UI5rS1jqR8eDXRpa8w3V1spX
         OdlMAkk0SpBaBe2LF3giGStmGjegH5YG6xlUQ0HdLybii1hsSMNK1mVN+TJYkD3BIxmZ
         ar40GNOgCT8CLiY0brpmzZKxXXstEeLaLgcK5aLxi01vRfHxOvRowFO7asSlZowuuNYr
         82Cg==
X-Gm-Message-State: AOUpUlGNCXyj3VfTF89LE2XnWICh9DnlsG00bxchCSwzSwRP7/EfXAl0
        jPEi5xD0/OnOkjIjB9HXViDrCA==
X-Google-Smtp-Source: AAOMgpehqex3CdPtq7x1lmo5gSlZSsXhmW9uDjpdFKiyv1OLAtxjBqF+gpehdqzV2BPb8z8UqeyKMw==
X-Received: by 2002:a17:902:704c:: with SMTP id h12-v6mr77168plt.237.1532051287584;
        Thu, 19 Jul 2018 18:48:07 -0700 (PDT)
Received: from localhost.localdomain (fs76eedbeb.tkyc508.ap.nuro.jp. [118.238.219.235])
        by smtp.gmail.com with ESMTPSA id 203-v6sm475868pgb.14.2018.07.19.18.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 18:48:07 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 8/9] efi/cper: Use consistent types for UUIDs
Date:   Fri, 20 Jul 2018 10:47:25 +0900
Message-Id: <20180720014726.24031-9-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720014726.24031-1-ard.biesheuvel@linaro.org>
References: <20180720014726.24031-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The commit

  2f74f09bce4f ("efi: parse ARM processor error")

brought inconsistency in UUID types which are used across the CPER.

Fix this by moving to use guid_t API everywhere.

Cc: Tyler Baicar <tbaicar@codeaurora.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/cper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index b73fc4cab083..a7902fccdcfa 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -472,7 +472,7 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 		else
 			goto err_section_too_small;
 #if defined(CONFIG_ARM64) || defined(CONFIG_ARM)
-	} else if (!uuid_le_cmp(*sec_type, CPER_SEC_PROC_ARM)) {
+	} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 		struct cper_sec_proc_arm *arm_err = acpi_hest_get_payload(gdata);
 
 		printk("%ssection_type: ARM processor error\n", newpfx);
-- 
2.17.1

