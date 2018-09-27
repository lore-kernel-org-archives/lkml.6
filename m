Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E15C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEED2157C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MxmXSZVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEED2157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeI0PIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:08:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33099 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbeI0PIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:08:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id f10-v6so1692414wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 01:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TfIdZcBS7cb/g0U3CKumXnOhft7wKZSPUCftG/nZTIU=;
        b=MxmXSZVp9aZeoV7cZf9KfayGE16KbjJtimG5liLaZNVP2zRf2ka2NLhsepqy2hQH5D
         VL/D1UATC2OZdEDtaH9HRBuuTL/QPFCktrwVSqgaW1FLpdj1GTBrlfTBpxFBSIzwHRqc
         NlBi66GGIhZQeDCYg19m3yCWKfjxjyU9ajlIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TfIdZcBS7cb/g0U3CKumXnOhft7wKZSPUCftG/nZTIU=;
        b=okVus9TFWUlIi+6Da+Fa7zmJvBcX5zYJS6w6je3ozrJm48E/pft8YpxFk///IEUOJT
         i11Kpq4I2ndMp05jzboJAOmNPXsuJx9ocHlzq+uQybgNXupOQsMIQdH/gSKHvfDp0SDL
         bIP1emdNzl0j/K5XubsUZgGskHhXeZk4jZdyysK14UgMMksev4Ibw5qrXnDT1nHOIvHV
         V36GL8JTFLLeZ0mScPKsbk6SxFnhXxzemBPGxLIU5r2soms2b6Js/S0DJ5CBhDnJUxrk
         fZ00Mw3wu83dnubYdQRcc0WDYs5LUH+uGACHFuA3hyuWr1arx1HM3a3dlVUCBDn8vtrA
         JQ2g==
X-Gm-Message-State: ABuFfoivT7tznwVjPVZ0pe8fR/X6TyZKoC2qFdQKX7OGYpcm0911bmXT
        R2OV+feMuUqACiRtHdG6yX4LnnvBaqg=
X-Google-Smtp-Source: ACcGV62lpj0tO23totT9GMhswf5PW9PtiG4HFA4bMpYhxLRzCnmGH5WnlKYypepbQ8S6upGA5SIvRA==
X-Received: by 2002:adf:ffc3:: with SMTP id x3-v6mr8154410wrs.137.1538038272552;
        Thu, 27 Sep 2018 01:51:12 -0700 (PDT)
Received: from rev03.home ([2a01:cb1d:112:6f00:546e:3c44:5966:2f5e])
        by smtp.gmail.com with ESMTPSA id p11-v6sm1304055wrd.74.2018.09.27.01.51.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 01:51:11 -0700 (PDT)
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
Subject: [PATCH 11/11] x86: boot: Fix EFI stub alignment
Date:   Thu, 27 Sep 2018 10:50:38 +0200
Message-Id: <20180927085039.8391-12-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180927085039.8391-1-ard.biesheuvel@linaro.org>
References: <20180927085039.8391-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Hutchings <ben@decadent.org.uk>

We currently align the end of the compressed image to a multiple of
16.  However, the PE-COFF header included in the EFI stub says that
the file alignment is 32 bytes, and when adding an EFI signature to
the file it must first be padded to this alignment.

sbsigntool commands warn about this:

  warning: file-aligned section .text extends beyond end of file
  warning: checksum areas are greater than image size. Invalid section table?

Worse, pesign -at least when creating a detached signature- uses the
hash of the unpadded file, resulting in an invalid signature if
padding is required.

Avoid both these problems by increasing alignment to 32 bytes when
CONFIG_EFI_STUB is enabled.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/boot/tools/build.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index d4e6cd4577e5..bf0e82400358 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -391,6 +391,13 @@ int main(int argc, char ** argv)
 		die("Unable to mmap '%s': %m", argv[2]);
 	/* Number of 16-byte paragraphs, including space for a 4-byte CRC */
 	sys_size = (sz + 15 + 4) / 16;
+#ifdef CONFIG_EFI_STUB
+	/*
+	 * COFF requires minimum 32-byte alignment of sections, and
+	 * adding a signature is problematic without that alignment.
+	 */
+	sys_size = (sys_size + 1) & ~1;
+#endif
 
 	/* Patch the setup code with the appropriate size parameters */
 	buf[0x1f1] = setup_sectors-1;
-- 
2.18.0

