Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E186C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04A021871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kN/2bOyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfADJ6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 04:58:25 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46733 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbfADJ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 04:58:24 -0500
Received: by mail-ed1-f67.google.com with SMTP id o10so31244846edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 01:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=h+Rf+jAwqRnDHxDwfVstrC8MiBhsGyo9qIPQ48nJo/A=;
        b=kN/2bOyyitvBG50l4dxdoLPLeJY+bnGWVNBPhozL2pP2E7+2PA60xSohrja3Ias29n
         YZTuQH2cckAu717LEgmGF5kMI1V4+IAdpVaQWtbCR6zFY47AAh9gKLergEF04vHsgicS
         Tvr4Tm6YbfEDqtQ+9nRcnWv4jfDY6u/yIIGZ62zRzpjS37+5H02kB+lisKKbgm02C6/b
         9VPojaYhaHjJ2aeNsSrdz3oA+RhiuKRDZnOtZ5CvWSJLrJl2MRCdKy4c4F3ihRsHkosf
         WGselI1x8j+NycMNSldDcFsZKHf34h/VoNQnRwrlomsw/vshrXHpYndEffJapVIVgpwv
         nLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h+Rf+jAwqRnDHxDwfVstrC8MiBhsGyo9qIPQ48nJo/A=;
        b=IWLuw1hkRhc8y4wfe18VGLLmvCSMIhKAxDcDz1FoF0+B/A3PYxTy4JaomjOXQtNtJo
         86+SBTaZgaV58wntD+1cRZniKj71uDEje/qSL0eNq81C14XibSC00trCILZ7wTC5Woaj
         55sSSzMTKr0XAqVzGPemmaCpzVGNZ2qEOyAcoDsGNwQ/BetHr4mSPOo6w4+J7855rCoa
         Dk1Nzdo9rfWiFjfAg7NIapT34ezwlAgVQYut+DifBe4JtDFqN4eLBvQJT0EWN0oZsjR5
         sb9cBQ/VE/KH1BE2wybjZKcEq0A4FkIFN7Oyb2UCu6fLmjdWoSz7svwrz2p2djZ+Oxo7
         vWyA==
X-Gm-Message-State: AA+aEWbuBzNc7SM6mDE6GkqwSIqzOx9pgqTeXcfbUaDvRC3iksuX28j1
        zeKN6re6zYG4PXNRIOKxK+Fq7w==
X-Google-Smtp-Source: AFSGD/U+tvfODn5sU/FW74Zikyssyqk7OlLdENLg8vcSWA2wchRBS9n2WQreMVm5lcoGkRk59OBTmw==
X-Received: by 2002:aa7:cf88:: with SMTP id z8mr46484192edx.208.1546595902550;
        Fri, 04 Jan 2019 01:58:22 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id j23sm22386663edr.89.2019.01.04.01.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Jan 2019 01:58:21 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     benh@kernel.crashing.org, mark.rutland@arm.com, mpe@ellerman.id.au,
        paulus@samba.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] powerpc: build dtb even without COMPILE_TEST
Date:   Fri,  4 Jan 2019 09:58:17 +0000
Message-Id: <1546595897-33291-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wanted to test the virtex440-ml507 qemu machine and found that the dtb
for it was not builded.
All powerpc DTB are only built when CONFIG_OF_ALL_DTBS is set which depend on
COMPILE_TEST.
But building DTB is not related to a "compile build test".

So this patch made building of DTB independent of COMPILE_TEST (by
depending only on the PPC arch)
A better selection of which DTB to build could be done in the future
like that do the ARM arch.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/powerpc/boot/dts/Makefile     | 2 +-
 arch/powerpc/boot/dts/fsl/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/Makefile b/arch/powerpc/boot/dts/Makefile
index fb335d05aae8..3a73cf41585b 100644
--- a/arch/powerpc/boot/dts/Makefile
+++ b/arch/powerpc/boot/dts/Makefile
@@ -3,4 +3,4 @@
 subdir-y += fsl
 
 dtstree		:= $(srctree)/$(src)
-dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
+dtb-$(CONFIG_PPC) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
diff --git a/arch/powerpc/boot/dts/fsl/Makefile b/arch/powerpc/boot/dts/fsl/Makefile
index 3bae982641e9..27c5ca3a35be 100644
--- a/arch/powerpc/boot/dts/fsl/Makefile
+++ b/arch/powerpc/boot/dts/fsl/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 dtstree		:= $(srctree)/$(src)
-dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
+dtb-$(CONFIG_PPC) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
-- 
2.19.2

