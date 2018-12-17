Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DFAC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4686B206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJLWYhWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388549AbeLQSCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:02:23 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40052 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732476AbeLQSCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:02:22 -0500
Received: by mail-ed1-f68.google.com with SMTP id g22so5486368edr.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 10:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3UizkdkN0o9xnFgf0i3mdX9CPUyBVCA0xiH0LvZg15o=;
        b=jJLWYhWMc8Nf6kueqq417Icl80VNSh6rawjfdMnkh5kEvTDN/No8UHMbuzV6MR2AER
         9po5Bx7x2hZ566LpKbxpRNfC7HRDsqKlreCN4pAUquXFChMPRg9HQkAkkCFQLwVKiYQo
         OXkPQjadB42gj3DTQSHKp/UZjqss6p58/2XRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3UizkdkN0o9xnFgf0i3mdX9CPUyBVCA0xiH0LvZg15o=;
        b=UYHg7PeL4uYG02tKMfYXkesuVjWhIGDgMkonzfz5wRcKEfXCA3tc8SCpdn39Sp4W4P
         6pwz1dYpf5Ha/I+juixPJuYVd0NsbldwMSdBMBK22gwa9b2c1IaXrvJphGfmjwXS1vNY
         fRTEBDABO4ZzQ+KVqJe60H4Q2BD+56mtFYy2M31Rvw9sSSIJmGF9JTr6GpToOGsoLA5N
         Rgq3JDAsOcc9WJXG9mcN8m6Zo26OMsgrWkzJdSerGz67HUfxWa5Xo09ggW5KPcAxdjBZ
         8bhxL/1nIjsvPVxvgub9ASTqGguMWfJoGCj+2L30yNC/9J01qAbDKQJo4CSHcatG690k
         A0+w==
X-Gm-Message-State: AA+aEWa1uMQemiduffgUOYHmXCNRcOP39q3FJyji5xqIX1YuXlwchVNg
        tZ+UKCVRWFDjzCryop6WpOqOBxkjWdVItxyU
X-Google-Smtp-Source: AFSGD/W4Jg6rm0VynX3fifBbf5k2E6PYBo6NjQEoFJrzq7RdcPJwIcFLObR1PzCke4CmwhlZ2ejoWQ==
X-Received: by 2002:a17:906:6b99:: with SMTP id l25-v6mr10622266ejr.154.1545069740215;
        Mon, 17 Dec 2018 10:02:20 -0800 (PST)
Received: from mba13.arnhem.chello.nl (dhcp-077-251-017-237.chello.nl. [77.251.17.237])
        by smtp.gmail.com with ESMTPSA id j8sm3947678ede.55.2018.12.17.10.02.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 10:02:19 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>, Qian Cai <cai@gmx.us>
Subject: [PATCH 2/2] efi: efi_guid_t must be 64-bit aligned
Date:   Mon, 17 Dec 2018 19:02:14 +0100
Message-Id: <20181217180214.9436-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181217180214.9436-1-ard.biesheuvel@linaro.org>
References: <20181217180214.9436-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

The UEFI Specification Version 2.7 Errata A defines:

"EFI_GUID
128-bit buffer containing a unique identifier value.
Unless otherwise specified, aligned on a 64-bit boundary."

Before this patch efi_guid_t was 8-bit aligned.

Note that this could potentially trigger alignment faults during
EFI runtime services calls on 32-bit ARM, given that it does not
permit load/store double or load/store multiple instructions to
operate on memory addresses that are not 32-bit aligned.

Cc: <stable@vger.kernel.org> # v4.9+, or earlier if possible
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/efi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 100ce4a4aff6..e6480c805932 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -48,7 +48,7 @@ typedef u16 efi_char16_t;		/* UNICODE character */
 typedef u64 efi_physical_addr_t;
 typedef void *efi_handle_t;
 
-typedef guid_t efi_guid_t;
+typedef guid_t efi_guid_t __aligned(8);
 
 #define EFI_GUID(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7) \
 	GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)
-- 
2.17.1

