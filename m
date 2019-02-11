Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B087C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A99E214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="VlkGnrQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfBKM1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:27:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35625 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfBKM0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:26:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so17076739wmt.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DCvcInryiKJ5GrPJy1j5iG1WoHmXy8a7aJkXnmpsZFc=;
        b=VlkGnrQj+iKhYagW+8NaIpzxzLiX0jmOsaP1qvF3EGXmjioAW3T1GIW7BxVORPvcYV
         upa14VKaebAjMFNy5HWv6HchTmjP4DYWOXUE8QGLa+ZsxrGH2RdrcuyAEOr8YoWBWxo9
         YBrJGI1wYtxqsHB0N3eUoKj1h7UHieFwrPCUopUQtY9ya7ybPGMSxMDfaDUUSAKsEKSX
         F5wvLI4Fuz3HC1a1wtaMlRoam+jD+63Iye/OrWmj5jiTp0rFU1ZlT1L90qISv8v72msw
         E8YDxc33MLFq3W79cjiIxYy/KR2/6pWOM7LbHlSdg6MPjpCmmDfdCdWdQLlG6+lJJls/
         UVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DCvcInryiKJ5GrPJy1j5iG1WoHmXy8a7aJkXnmpsZFc=;
        b=mRmguMqcwa9fS4Rbzg1Ust2OKXD9J6zXngapAK5roD6zrPe2k4kRUh5zkaKwqnR8oE
         Q7ygGsfY3qbQk7TR4cCst9j11wvz4xSHPl0ny5l2LUqfmzwTlpFiEsYoT1dDzkYzJiw6
         tif9xGV/P04f0Fudm6X8vqvKM/Z4Cgi7UnKsERzq5ptnHNFy+R0UtNLDBSfICqAZxIwy
         uNUPWp8cP7UVb1HGS9Mw8MpYwAO8dgUCYRqRnxttdi460hsvIvfC4Pvf7S5crLyYCqcc
         mGwjcLky0/rSKJOb+zmStdQa2QGP0/MVX90dyDuTbqONQe77vozH/zOKopuKD3Qk12l0
         Cw6A==
X-Gm-Message-State: AHQUAubqJvL+lXgsLUc6ljjh8S+G4BO64re5Xwp9eLvCELHVtopLMYkM
        XyK3Yds67hMA2hoO20Ij4Yl2Xw==
X-Google-Smtp-Source: AHgI3IbHzd9R2IslrKIbcbpFUurSzD1upkfLg0b+KbF5FD6TzSPo8J2Q/fh80YsGTJ6isj8xoALnTA==
X-Received: by 2002:a1c:6c01:: with SMTP id h1mr8987592wmc.113.1549888009977;
        Mon, 11 Feb 2019 04:26:49 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:26:49 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 30/33] ARM: davinci: cp-intc: drop GPL license boilerplate
Date:   Mon, 11 Feb 2019 13:26:03 +0100
Message-Id: <20190211122606.8662-31-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Replace the GPLv2 license boilerplate with an SPDX identifier and add
myself as a second author.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 4bbf0eba1920..2040c974689a 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -1,13 +1,11 @@
-/*
- * TI Common Platform Interrupt Controller (cp_intc) driver
- *
- * Author: Steve Chen <schen@mvista.com>
- * Copyright (C) 2008-2009, MontaVista Software, Inc. <source@mvista.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Author: Steve Chen <schen@mvista.com>
+// Copyright (C) 2008-2009, MontaVista Software, Inc. <source@mvista.com>
+// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+// Copyright (C) 2019, Texas Instruments
+//
+// TI Common Platform Interrupt Controller (cp_intc) driver
 
 #include <linux/export.h>
 #include <linux/init.h>
-- 
2.20.1

