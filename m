Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11194C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D558B2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="miavcMRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407357AbfBNOvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:51:19 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43921 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407285AbfBNOtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:49:40 -0500
Received: by mail-qt1-f193.google.com with SMTP id y4so7064859qtc.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zCTqVlx5Etjzo5hueWu7ypOoXoXF8xnytS5XFeEjaGs=;
        b=miavcMRKjxTTt1NnXSs9S5SIgv6tQi9tuaM3o7X7tprvmlvmHyoXop5aflXJXeIkxx
         do6zn2NQHvlyFLkcgrVE8GxZj3wMi/CVz+CAeO2sqXb6/JH+94dcqoo6axIotNkQff+y
         nS0SpEGNhIyWDYBl0wL/nOf4e/jaDpfvwpp1OV/osZTnnbxkBW83unDmtBBHN/lQA1w6
         9pC94Au9Z8viUxDsy4X6o/h3vdSZrDOs3mAZ8WYwEDDgb7YDGS3LA1ga3UIJ4UFLuCRp
         wz7fH4hU0moX1giYjpcsYQlvD6N7pgpZWQN/iAIubXQpPjWD3vN9huAkB0S0ACkixiWv
         n+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zCTqVlx5Etjzo5hueWu7ypOoXoXF8xnytS5XFeEjaGs=;
        b=K8adXS4FImQZJW9LnE8VG9tB7oHegKRuFtC6b+fEuZ8ETBzs4WH6XkIZBUTsSlBUJo
         x9DI5Mzi1B0e7mqZ3eJOG+Tmy3kLkhK3XneK935UyKoDOenqJtroMBwQAHH6TK9KtQk2
         gwdSc8hw8DksgL/BPwLey/GxQ704D6Fjc2q/4CbRXuYp+ONlLz2Mm7S5uS5z+KOwAtfN
         dtwh3hHtXjD9/FInNaHnbVCqjI2Wyxel6jgwnTu4Zvj6xAzPFzYaz7BNMy0X6JHDIWLs
         DN8yUs35agY6POspSZGvX6YTMDSFM63XHfj7atxzsU1ye+pb7KoMw/cphgi7ieFQwP1n
         cm0Q==
X-Gm-Message-State: AHQUAuaOAvxikv/1Fn+e5GFvjesBZHPHwkRsHzRKM+EOf2pLhiJ9uLbz
        hoyFEoc/VoW0YSqG5UnJumclTg==
X-Google-Smtp-Source: AHgI3IYuyKJfKTx5XoJwsHlZqWG3Jx+9E8LTTDtKIppzoB5eOlCS7mWVYLojIewdtsIltstdjCU/kQ==
X-Received: by 2002:ac8:26ea:: with SMTP id 39mr3372612qtp.351.1550155779753;
        Thu, 14 Feb 2019 06:49:39 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id k66sm1498919qkc.25.2019.02.14.06.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:49:39 -0800 (PST)
From:   David Long <dave.long@linaro.org>
To:     stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4.9 05/16] ARM: 8794/1: uaccess: Prevent speculative use of the current addr_limit
Date:   Thu, 14 Feb 2019 09:49:19 -0500
Message-Id: <20190214144930.27539-6-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214144930.27539-1-dave.long@linaro.org>
References: <20190214144930.27539-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

Commit 621afc677465db231662ed126ae1f355bf8eac47 upstream.

A mispredicted conditional call to set_fs could result in the wrong
addr_limit being forwarded under speculation to a subsequent access_ok
check, potentially forming part of a spectre-v1 attack using uaccess
routines.

This patch prevents this forwarding from taking place, but putting heavy
barriers in set_fs after writing the addr_limit.

Porting commit c2f0ad4fc089cff8 ("arm64: uaccess: Prevent speculative use
of the current addr_limit").

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/include/asm/uaccess.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 7b17460127fd..9ae888775743 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -99,6 +99,14 @@ extern int __put_user_bad(void);
 static inline void set_fs(mm_segment_t fs)
 {
 	current_thread_info()->addr_limit = fs;
+
+	/*
+	 * Prevent a mispredicted conditional call to set_fs from forwarding
+	 * the wrong address limit to access_ok under speculation.
+	 */
+	dsb(nsh);
+	isb();
+
 	modify_domain(DOMAIN_KERNEL, fs ? DOMAIN_CLIENT : DOMAIN_MANAGER);
 }
 
-- 
2.17.1

