Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA6BC282DB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1BC2146E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xc+QCRFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfBBJmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 04:42:15 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43845 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfBBJle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 04:41:34 -0500
Received: by mail-ed1-f68.google.com with SMTP id f9so7433609eds.10
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 01:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O2XzZIsl3vvBFchu48mWrW+Bva6lWuZ8ML/K496KFP0=;
        b=Xc+QCRFSH4rqU01My7TyOmCVs82S37Gb0U7UVb81L0TmzDKVp8+pcJ2GFBFc8va+6e
         AaUZ5V2dYbFTTxdtn+JqRTVL6YdqY01wU8MGQU+B49KXGri7yYJCRO+P0qWdmu13XECE
         hkRppfRYCgn3xjhy4ITLLr4rYe/BvRaH1K3Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O2XzZIsl3vvBFchu48mWrW+Bva6lWuZ8ML/K496KFP0=;
        b=XG23/YCFkLzQLFkwrwt0lNzq9h3OKg+IIToF0BX+bQq8tglWYVPvIv/IuVlZS/TeWG
         7GGD+t92P0cQDcA/QUOXyTXmf2tSvEyJHeydtnNoDbNteCGJdK3ylXJ5y4ULUXWdL2jN
         YiLlBoqoQoiwUDXzAxmiSsGpzx8rJgvwTFMd9ZjjVePpHxHVXH8qGgYt1qxopp8uthc+
         mSSMnFq9Ruw85VLtW406SdTHaCMQpjr7/UynRboM4KrvcLSjYGwc/Pd0oKdYU5XGhkXx
         RWv81r14+dHv2shcOSweelQt4o+Kqum48l3hd2K2WSzMSZvXd6mr65dCvFy1h4MplXhG
         P2Hw==
X-Gm-Message-State: AJcUukcsnCDXf5TkqYhe9xtQ9saM0s48GMwC/uRrrLQfTc0qlYy00Mu6
        3ffScxGC8V75v5QHfH4voS6+mw==
X-Google-Smtp-Source: ALg8bN5rysf8XoX6bZUBmLKiC0Tx22T/9EbeNyEe4ESqI3iqQ4k6d9kntOHqO5kk+s5YEGfYe/k2Xw==
X-Received: by 2002:aa7:d9d6:: with SMTP id v22mr41768865eds.265.1549100492978;
        Sat, 02 Feb 2019 01:41:32 -0800 (PST)
Received: from mba13.c.hoisthospitality.com ([109.236.135.164])
        by smtp.gmail.com with ESMTPSA id l41sm2608824eda.83.2019.02.02.01.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 01:41:32 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH 04/10] efi: use 32-bit alignment for efi_guid_t
Date:   Sat,  2 Feb 2019 10:41:13 +0100
Message-Id: <20190202094119.13230-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190202094119.13230-1-ard.biesheuvel@linaro.org>
References: <20190202094119.13230-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UEFI spec and EDK2 reference implementation both define EFI_GUID as
struct { u32 a; u16; b; u16 c; u8 d[8]; }; and so the implied alignment
is 32 bits not 8 bits like our guid_t. In some cases (i.e., on 32-bit ARM),
this means that firmware services invoked by the kernel may assume that
efi_guid_t* arguments are 32-bit aligned, and use memory accessors that
do not tolerate misalignment. So let's set the minimum alignment to 32 bits.

Note that the UEFI spec as well as some comments in the EDK2 code base
suggest that EFI_GUID should be 64-bit aligned, but this appears to be
a mistake, given that no code seems to exist that actually enforces that
or relies on it.

Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Leif Lindholm <leif.lindholm@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/efi.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 45ff763fba76..be08518c2553 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -48,7 +48,20 @@ typedef u16 efi_char16_t;		/* UNICODE character */
 typedef u64 efi_physical_addr_t;
 typedef void *efi_handle_t;
 
-typedef guid_t efi_guid_t;
+/*
+ * The UEFI spec and EDK2 reference implementation both define EFI_GUID as
+ * struct { u32 a; u16; b; u16 c; u8 d[8]; }; and so the implied alignment
+ * is 32 bits not 8 bits like our guid_t. In some cases (i.e., on 32-bit ARM),
+ * this means that firmware services invoked by the kernel may assume that
+ * efi_guid_t* arguments are 32-bit aligned, and use memory accessors that
+ * do not tolerate misalignment. So let's set the minimum alignment to 32 bits.
+ *
+ * Note that the UEFI spec as well as some comments in the EDK2 code base
+ * suggest that EFI_GUID should be 64-bit aligned, but this appears to be
+ * a mistake, given that no code seems to exist that actually enforces that
+ * or relies on it.
+ */
+typedef guid_t efi_guid_t __aligned(__alignof__(u32));
 
 #define EFI_GUID(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7) \
 	GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)
-- 
2.17.1

