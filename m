Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE5FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE81921570
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MvJ+Bt0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE81921570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeI0PIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:08:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36238 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbeI0PIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:08:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id n23-v6so1177485wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 01:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VxRTYSwbB2m9KxrX9xxpY79O1ZkMCQToVtuc67/7tNk=;
        b=MvJ+Bt0IuUYpPBLf2pOUOmlZ0MQuENxD1uRruMePcdsJmL8hGYmL6UneFZ/CsBNYVh
         NYde3rKDpTTKsXN0rDQwX77izbJfu87TsLs0/bivhuzH+Ob5J3hJRRGw3Mh6nLKfeVxp
         YtW7B/XsTPc/BGZ7Xey9v5ZvZgSawN3GWVH/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VxRTYSwbB2m9KxrX9xxpY79O1ZkMCQToVtuc67/7tNk=;
        b=ocrHoGnAkZDbmLuORsVRyYiqB5Ut/sOKiEPkCpoiiqRU841jgmh+AGzew/7UapnuZk
         Pd985wjx047y/TBW/U16KiW/Jc+jVtWYVyUxXyhZBC+XWUKPBwALP4bayu+yEo9PG4hy
         /z5omiMU/MftZEv7wY2Py9bMHkNmaA3BBSJNv0F87NKWow+z1+Tn56rr679mxVJH+7A/
         4wvQzo8jsRM5Fi07a57agbwE/fBgE5mSjfhOpiW5exESrrmOYyLJ1HTUn3VhsSwHS0aK
         yyn2BDnvXCthmnS80+A7ZJ8EBcr8qSOSPj/pJUN0SU3Cq132Sg4nEtKdFztXRpl5RF6/
         zfQw==
X-Gm-Message-State: ABuFfoiwBr7LsQkBWqJ2eLrw7sFRsA/kU37Ez9/q4Qb+5LYr546/MJQ2
        OqBJe7rC0lb64PgvJ6XTYNi5YLbzKQM=
X-Google-Smtp-Source: ACcGV61Xxs9dqEbb25NXJMqezsOXKV1L1v/V4yfG7o46f5E5LQwvPGwCr5gLTlKXO/wT5O+RGhJJSw==
X-Received: by 2002:a1c:5505:: with SMTP id j5-v6mr1031824wmb.146.1538038261852;
        Thu, 27 Sep 2018 01:51:01 -0700 (PDT)
Received: from rev03.home ([2a01:cb1d:112:6f00:546e:3c44:5966:2f5e])
        by smtp.gmail.com with ESMTPSA id p11-v6sm1304055wrd.74.2018.09.27.01.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 01:51:01 -0700 (PDT)
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
Subject: [PATCH 04/11] efi/libstub: arm: support building with clang
Date:   Thu, 27 Sep 2018 10:50:31 +0200
Message-Id: <20180927085039.8391-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180927085039.8391-1-ard.biesheuvel@linaro.org>
References: <20180927085039.8391-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Strachan <astrachan@google.com>

When building with CONFIG_EFI and CONFIG_EFI_STUB on ARM, the libstub
Makefile would use -mno-single-pic-base without checking it was
supported by the compiler. As the ARM (32-bit) clang backend does not
support this flag, the build would fail.

This changes the Makefile to check the compiler's support for
-mno-single-pic-base before using it, similar to c1c386681bd7 ("ARM:
8767/1: add support for building ARM kernel with clang").

Signed-off-by: Alistair Strachan <astrachan@google.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 14c40a7750d1..c51627660dbb 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -16,7 +16,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -O2 \
 cflags-$(CONFIG_ARM64)		:= $(subst -pg,,$(KBUILD_CFLAGS)) -fpie \
 				   $(DISABLE_STACKLEAK_PLUGIN)
 cflags-$(CONFIG_ARM)		:= $(subst -pg,,$(KBUILD_CFLAGS)) \
-				   -fno-builtin -fpic -mno-single-pic-base
+				   -fno-builtin -fpic \
+				   $(call cc-option,-mno-single-pic-base)
 
 cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
 
-- 
2.18.0

