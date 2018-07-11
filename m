Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89381C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3062083C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tcv2EhEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3062083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732693AbeGKJoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:44:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45399 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732649AbeGKJoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:44:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id c4-v6so4782333wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 02:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZqeNzGml4afcm1ZwxUqSeHEL0c5jVKB8hlqShvm+ZHg=;
        b=Tcv2EhEEOtrXUYNV09XvwqVSoCBg//nX/8XAtsntwXu2BZ5E53pgKDFOOvodUN+Vz9
         2NuIHbzOFyrs+i9vTuaSGUqbHHNtOKZgRKPzxhSYO/fpXlvM4emXy7+wvOkUbPXle5Yk
         92f3gmWOfPyoc8YAcxPJG5Qvwj/ksOzSIKXQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZqeNzGml4afcm1ZwxUqSeHEL0c5jVKB8hlqShvm+ZHg=;
        b=YO3iaIW1qQzs7WLZNRHOVssDQLjqMarJ6iA6xHZn2Xhyab17USfX3yPYK7gCo42vIv
         sNX3slAEXZCFLF6roHhOe0R6/p01FxqfDjERfJnV0jDP4Nud3zS68q4GjTDazfXByicA
         u7Myls9+HQHBz64pJlhL8ToFYXWAIj6jxvFl8b0qWMg1v0yFMJZTl/Pt0XlbdNKG4Kko
         BvWZddheu9uL5E6Bd5ZSvoSZZ6VTABYjgdT+GRqDIvx33QXmnArzUcnxeVqJFFaloPYE
         EILDYCBX9ddF9RZAxGSdF3dt/FKZrbUrgoN3irdnw0ZHGcZ8S4kBLcYi6CaLBzu2GqGM
         /e8w==
X-Gm-Message-State: APt69E0I4NhoX0nb3K2LwhlrFV3LsdKuAme2Gw674T+2sXv5A8Tl815l
        Db7h+ZQnI2upcxCk8gr2XTMFFg==
X-Google-Smtp-Source: AAOMgpcix3T3m2Rxv/kztTN1hnToysdho8LMD2P1JF7T6isIC1HUIJRHG+is4/or4PAxZnb56KdMoA==
X-Received: by 2002:adf:c321:: with SMTP id n30-v6mr19899750wrf.235.1531302055747;
        Wed, 11 Jul 2018 02:40:55 -0700 (PDT)
Received: from localhost.localdomain (33.153.69.91.rev.sfr.net. [91.69.153.33])
        by smtp.gmail.com with ESMTPSA id t124-v6sm1641311wmt.29.2018.07.11.02.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 02:40:55 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] efi: Remove the declaration of efi_late_init() as the function is unused
Date:   Wed, 11 Jul 2018 11:40:37 +0200
Message-Id: <20180711094040.12506-6-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711094040.12506-1-ard.biesheuvel@linaro.org>
References: <20180711094040.12506-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

Commit 7b0a911478c74 (efi/x86: Move the EFI BGRT init code to early
init code), removed the implementation and all the references to
efi_late_init() but the function is still declared at
include/linux/efi.h. Hence, remove the unnecessary declaration.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/efi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 8ba0cdd244b2..e190652f5ef9 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -988,14 +988,12 @@ extern void efi_memmap_walk (efi_freemem_callback_t callback, void *arg);
 extern void efi_gettimeofday (struct timespec64 *ts);
 extern void efi_enter_virtual_mode (void);	/* switch EFI to virtual mode, if possible */
 #ifdef CONFIG_X86
-extern void efi_late_init(void);
 extern void efi_free_boot_services(void);
 extern efi_status_t efi_query_variable_store(u32 attributes,
 					     unsigned long size,
 					     bool nonblocking);
 extern void efi_find_mirror(void);
 #else
-static inline void efi_late_init(void) {}
 static inline void efi_free_boot_services(void) {}
 
 static inline efi_status_t efi_query_variable_store(u32 attributes,
-- 
2.17.1

