Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82AFC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7092087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkaHll6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7092087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbeLDLK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:10:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:59440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbeLDLJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:09:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7C1C2146D;
        Tue,  4 Dec 2018 11:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921772;
        bh=GYj5TomYszyqPvo9DjJKUhHthdEskvscHjAC0/27suo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IkaHll6f/Hw9R4IInaML7uPSN5gQZfUljPAtU4Kc6CB0l0XpAHNIM4nNvjLAM1Bpk
         Ek7iuHZkwwIk3kAuZdQKoQkoq7Hb+uLfzjAMZppe48ZJfW67XjVyLALP25AoF+wHU3
         iixFcRjYcaR97if6jLFr3zu4ic1/+6JNhNrmtOhY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alistair Strachan <astrachan@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 4.9 43/50] efi/libstub: arm: support building with clang
Date:   Tue,  4 Dec 2018 11:50:38 +0100
Message-Id: <20181204103716.659675370@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103714.485546262@linuxfoundation.org>
References: <20181204103714.485546262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alistair Strachan <astrachan@google.com>

(commit 41f1c48420709470c51ee0e54b6fb28b956bb4e0 upstream)

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
[ND: adjusted due to missing commit ce279d374ff3 ("efi/libstub:
 Only disable stackleak plugin for arm64")]
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/efi/libstub/Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -12,7 +12,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__K
 
 cflags-$(CONFIG_ARM64)		:= $(subst -pg,,$(KBUILD_CFLAGS)) -fpie
 cflags-$(CONFIG_ARM)		:= $(subst -pg,,$(KBUILD_CFLAGS)) \
-				   -fno-builtin -fpic -mno-single-pic-base
+				   -fno-builtin -fpic \
+				   $(call cc-option,-mno-single-pic-base)
 
 cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
 


