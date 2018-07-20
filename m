Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33455ECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFAC120673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 01:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X601e6O+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAC120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbeGTCPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 22:15:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46871 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730691AbeGTCPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 22:15:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id p23-v6so5315005pgv.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 18:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=APANcmPUTm2nAx84a6zGaL0+tCas/4g6ONyL++OfM1I=;
        b=X601e6O+36P4BYGyccJcPSHHM5zBiXgmNr0feTLAVOa6tsHX3swp2iT8mOJ6GxFnel
         LFNGDxQa0aCYenJxVNh+cQV1im3XqRfU1BR27l0p4IbRblCGa7iw6D1QPvnQp/cVf9YH
         /8nwZXAVtylkK5YDvEHTLfdXjUCcdqNrFeEGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=APANcmPUTm2nAx84a6zGaL0+tCas/4g6ONyL++OfM1I=;
        b=Eg3LbMt75vrUkSNudVxcT3KJPcMKlwUzktQnWtwOHLdZ4nO+B0ju6Y74ZJfXMWm0Pz
         bY7B344yziEmSs3yGpfZNM3+ZMW/tXzaZQV+KSk5//oHHrf4GHgLbur4ALAaMsHwzkuD
         TdqMaA3teT6TCTlLbXNmuB9MXTmBZfnVGmxeD2y8bRVdyUheMaz8eSuous+8KahEPiSO
         4f0kVVgVLVrjUASgmOXzGD+8dMo6TLIFHhJYD5ZN+fvF8tv53dlefdSUdg7jl+Ob43C8
         rz+qxqrFN40HsuOJEUMyMNxN8RMvYRVzXTQ5iZ0W0DKD3o0ke5A6+eSwOy/3VKKCnWkv
         lq/Q==
X-Gm-Message-State: AOUpUlFLyX4qFQF0jL8jYHaQQZ7rdoFF4TD8+OIEJFUyVFbtZ9uK6kZa
        uVMcP8tyeafyWOFWUNsigJdFZQ==
X-Google-Smtp-Source: AAOMgpeZL28r4EA33zmCAxzJ026O13f7bRWcHUwxolexkwiaKb/lq9uQ88k3ntFXxLSFurBKtjrDqg==
X-Received: by 2002:a63:6441:: with SMTP id y62-v6mr51362pgb.240.1532050153889;
        Thu, 19 Jul 2018 18:29:13 -0700 (PDT)
Received: from localhost.localdomain (fs76eedbeb.tkyc508.ap.nuro.jp. [118.238.219.235])
        by smtp.gmail.com with ESMTPSA id u11-v6sm572058pfd.117.2018.07.19.18.29.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 18:29:12 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 1/1] x86/efi: Access EFI MMIO data as unencrypted when SEV is active
Date:   Fri, 20 Jul 2018 10:28:46 +0900
Message-Id: <20180720012846.23560-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720012846.23560-1-ard.biesheuvel@linaro.org>
References: <20180720012846.23560-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brijesh Singh <brijesh.singh@amd.com>

SEV guest fails to update the UEFI runtime variables stored in the
flash. commit 1379edd59673 ("x86/efi: Access EFI data as encrypted
when SEV is active") unconditionally maps all the UEFI runtime data
as 'encrypted' (C=1). When SEV is active the UEFI runtime data marked
as EFI_MEMORY_MAPPED_IO should be mapped as 'unencrypted' so that both
guest and hypervisor can access the data.

Fixes: 1379edd59673 ("x86/efi: Access EFI data as encrypted ...")
Cc: <stable@vger.kernel.org> # 4.15.x
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/platform/efi/efi_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 77873ce700ae..5f2eb3231607 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -417,7 +417,7 @@ static void __init __map_region(efi_memory_desc_t *md, u64 va)
 	if (!(md->attribute & EFI_MEMORY_WB))
 		flags |= _PAGE_PCD;
 
-	if (sev_active())
+	if (sev_active() && md->type != EFI_MEMORY_MAPPED_IO)
 		flags |= _PAGE_ENC;
 
 	pfn = md->phys_addr >> PAGE_SHIFT;
-- 
2.17.1

