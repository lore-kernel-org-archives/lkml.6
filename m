Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9F4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9AC20877
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NxGCGonp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9AC20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbeGKJoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:44:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38573 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbeGKJoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:44:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so1814093wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 02:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/q/sznLHl7/eGa0nIgn7Rl1zB0oOPHdHKcT0/DG3mmI=;
        b=NxGCGonpLZkmEeIDuPLeFHFtG5j80zMXTsEdiu3XivE5TKiuVWSIUI1ib2zjAkHu8d
         o+UZKoVk7w28ELVveptunwB0A2QHj7W4En5PRKSdi+ZY4VcPdxrnKPliS2KPYKfxcTZQ
         /LAGI59Nup92sQrs/86h4c7DbjHbT35EBHPUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/q/sznLHl7/eGa0nIgn7Rl1zB0oOPHdHKcT0/DG3mmI=;
        b=YcGv02nAA/rvAvQttJP00RHSPQo4ZWWlUie/k2dOIJ0lkgRMIk+6AP78T4MiChrQaF
         vSJj5NFN5BoE2pEDOwBzlSeVWsgBo/uiUC23NpaXY0F5zGkUwwKEWJruaU5TduouU+E/
         N6d68WpgrmQdQr5XS3+XHpGoOI9bUrWzHheqUcmqpPpSsvzdeplQcE0u/DlWE16DDpIS
         9CGfc39rE2g3OfyC572l1ixoO9RRCcPbcIB2gSOIOtcYcEkGWKMSArH6X3U9C18O9ejt
         1/9Pk0vP+N61lumkOhZgPXZxgi7lYm9G7Njj9PdSlmmBFVLUiZW6TI0deIwEYrtINVPD
         wpMg==
X-Gm-Message-State: APt69E3EA6+IFo66GdyseJk+yre8Wg8t9a4RP9tvo8tzimgrSkKPBUTf
        T8wRvTg8MbZQa3TyC3NRBb1a8aMbpOQ=
X-Google-Smtp-Source: AAOMgpcwkv+ijTbI35cW8UOvK0DgrdgOQifAXA2tMmuVGKuHw2N1eESh8UdnoY54bhUzlNwnf9L6Cw==
X-Received: by 2002:a1c:c14:: with SMTP id 20-v6mr18591887wmm.117.1531302051627;
        Wed, 11 Jul 2018 02:40:51 -0700 (PDT)
Received: from localhost.localdomain (33.153.69.91.rev.sfr.net. [91.69.153.33])
        by smtp.gmail.com with ESMTPSA id t124-v6sm1641311wmt.29.2018.07.11.02.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 02:40:50 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] efi/x86: Use non-blocking SetVariable() for efi_delete_dummy_variable()
Date:   Wed, 11 Jul 2018 11:40:34 +0200
Message-Id: <20180711094040.12506-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711094040.12506-1-ard.biesheuvel@linaro.org>
References: <20180711094040.12506-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

Presently, efi_delete_dummy_variable() uses set_variable() which might
block and hence kernel prints stack trace with a warning "bad:
scheduling from the idle thread!". So, make efi_delete_dummy_variable()
use set_variable_nonblocking(), which, as the name suggests doesn't
block.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/platform/efi/quirks.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 36c1f8b9f7e0..6af39dc40325 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -105,12 +105,11 @@ early_param("efi_no_storage_paranoia", setup_storage_paranoia);
 */
 void efi_delete_dummy_variable(void)
 {
-	efi.set_variable((efi_char16_t *)efi_dummy_name,
-			 &EFI_DUMMY_GUID,
-			 EFI_VARIABLE_NON_VOLATILE |
-			 EFI_VARIABLE_BOOTSERVICE_ACCESS |
-			 EFI_VARIABLE_RUNTIME_ACCESS,
-			 0, NULL);
+	efi.set_variable_nonblocking((efi_char16_t *)efi_dummy_name,
+				     &EFI_DUMMY_GUID,
+				     EFI_VARIABLE_NON_VOLATILE |
+				     EFI_VARIABLE_BOOTSERVICE_ACCESS |
+				     EFI_VARIABLE_RUNTIME_ACCESS, 0, NULL);
 }
 
 /*
-- 
2.17.1

