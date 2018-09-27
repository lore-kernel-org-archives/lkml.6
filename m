Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80830C004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364E82159D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bGgdhQcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364E82159D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeI0PIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:08:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40374 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbeI0PIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:08:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id o2-v6so5067806wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 01:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e0MW/cO/rHunfkzsEHUdpPLgA85W8krihEUCPuzlC88=;
        b=bGgdhQcjPRB3zwnlm4BsD6QNoc7DoaayYxqXj3tpGnCxA4BFot+1qmklGZkf8vt0f8
         FUZ9h7MlEKozRybDDRiH5Rnowhy8H+LwMW+SzPKg/XYkL7G9rdxHf+zLGAVgk60moYnt
         RHe5qMGqHcSGij07vTPWKQB2USWjUmIc+avkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e0MW/cO/rHunfkzsEHUdpPLgA85W8krihEUCPuzlC88=;
        b=Ii6XiSS8nDQAlnG1cI4c/aknaebrN35MW1ZM0QOMXO4MncumC67Bxdiwc8xaj5hd/D
         9dFF4aGs3Q0tbaclLTV8Af56GEbfIhv535w9f7NfVbRydX0dG1Zp/NPmla2UUmPvEQNq
         DLzO9ar25N63RbQVAlMC5RNBOXSqTtE/4lkFq/ayUV1ntABMyQT5YPagsdJhTMuZ8P3H
         Q1nm8Qf08rcSvxT01evpaRwdc1DwrjkWqnVrMF1iToZrJHk581ek0ImQfyKtxXU6smDS
         Et4D9Tsd8ke4B4tdvrK1AdmkyP5r3e10KcdaCbP7IgrU8zCZyRUjAiwJNgVBQq+3fBM9
         jaeg==
X-Gm-Message-State: ABuFfogbKAGEYcTLZam/WCU8DpgY81kKg3VYNIE5bY4p2n8/TSi3OzQ6
        kv8+AoE8i+fSRo2SSG507tSKlT6Rtlw=
X-Google-Smtp-Source: ACcGV62jSvhSRrwmqWqlvZ79NLv4A68iBfD6wiyVfmP6sNsATEFuqdcMjaXcE5mFAfeLuK85/CRMAw==
X-Received: by 2002:a1c:4d09:: with SMTP id o9-v6mr6766505wmh.134.1538038263329;
        Thu, 27 Sep 2018 01:51:03 -0700 (PDT)
Received: from rev03.home ([2a01:cb1d:112:6f00:546e:3c44:5966:2f5e])
        by smtp.gmail.com with ESMTPSA id p11-v6sm1304055wrd.74.2018.09.27.01.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 01:51:02 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Alistair Strachan <astrachan@google.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ivan Hu <ivan.hu@canonical.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Robinson <pbrobinson@redhat.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 05/11] efi/efi_test: add exporting ResetSystem runtime service
Date:   Thu, 27 Sep 2018 10:50:32 +0200
Message-Id: <20180927085039.8391-6-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180927085039.8391-1-ard.biesheuvel@linaro.org>
References: <20180927085039.8391-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Hu <ivan.hu@canonical.com>

Add exporting the UEFI runtime service ResetSystem for upper application or test
tools to use.

Signed-off-by: Ivan Hu <ivan.hu@canonical.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/test/efi_test.c | 27 +++++++++++++++++++++++++++
 drivers/firmware/efi/test/efi_test.h | 10 ++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/firmware/efi/test/efi_test.c b/drivers/firmware/efi/test/efi_test.c
index 41c48a1e8baa..769640940c9f 100644
--- a/drivers/firmware/efi/test/efi_test.c
+++ b/drivers/firmware/efi/test/efi_test.c
@@ -542,6 +542,30 @@ static long efi_runtime_get_nexthighmonocount(unsigned long arg)
 	return 0;
 }
 
+static long efi_runtime_reset_system(unsigned long arg)
+{
+	struct efi_resetsystem __user *resetsystem_user;
+	struct efi_resetsystem resetsystem;
+	void *data = NULL;
+
+	resetsystem_user = (struct efi_resetsystem __user *)arg;
+	if (copy_from_user(&resetsystem, resetsystem_user,
+						sizeof(resetsystem)))
+		return -EFAULT;
+	if (resetsystem.data_size != 0) {
+		data = memdup_user((void *)resetsystem.data,
+						resetsystem.data_size);
+		if (IS_ERR(data))
+			return PTR_ERR(data);
+	}
+
+	efi.reset_system(resetsystem.reset_type, resetsystem.status,
+				resetsystem.data_size, (efi_char16_t *)data);
+
+	kfree(data);
+	return 0;
+}
+
 static long efi_runtime_query_variableinfo(unsigned long arg)
 {
 	struct efi_queryvariableinfo __user *queryvariableinfo_user;
@@ -682,6 +706,9 @@ static long efi_test_ioctl(struct file *file, unsigned int cmd,
 
 	case EFI_RUNTIME_QUERY_CAPSULECAPABILITIES:
 		return efi_runtime_query_capsulecaps(arg);
+
+	case EFI_RUNTIME_RESET_SYSTEM:
+		return efi_runtime_reset_system(arg);
 	}
 
 	return -ENOTTY;
diff --git a/drivers/firmware/efi/test/efi_test.h b/drivers/firmware/efi/test/efi_test.h
index 9812c6a02b40..5f4818bf112f 100644
--- a/drivers/firmware/efi/test/efi_test.h
+++ b/drivers/firmware/efi/test/efi_test.h
@@ -81,6 +81,13 @@ struct efi_querycapsulecapabilities {
 	efi_status_t		*status;
 } __packed;
 
+struct efi_resetsystem {
+	int			reset_type;
+	efi_status_t		status;
+	unsigned long		data_size;
+	efi_char16_t		*data;
+} __packed;
+
 #define EFI_RUNTIME_GET_VARIABLE \
 	_IOWR('p', 0x01, struct efi_getvariable)
 #define EFI_RUNTIME_SET_VARIABLE \
@@ -108,4 +115,7 @@ struct efi_querycapsulecapabilities {
 #define EFI_RUNTIME_QUERY_CAPSULECAPABILITIES \
 	_IOR('p', 0x0A, struct efi_querycapsulecapabilities)
 
+#define EFI_RUNTIME_RESET_SYSTEM \
+	_IOW('p', 0x0B, struct efi_resetsystem)
+
 #endif /* _DRIVERS_FIRMWARE_EFI_TEST_H_ */
-- 
2.18.0

