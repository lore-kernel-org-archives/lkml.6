Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CA0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218A02229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="utApWRdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439393AbfBNOuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:50:05 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37916 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407306AbfBNOt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:49:56 -0500
Received: by mail-qt1-f194.google.com with SMTP id 2so7101912qtb.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WbXTq/rv4PTCxNmHyDWfQL5ZTTgJSJ1C6Vt+iGpdItk=;
        b=utApWRduTafCEFGv8UAoII0fePrHnB33bW4J/MQptc0lsPlgbmsQ1qtVb9MMnHkiUL
         jrG56n4yCy1KuQKwHn4C7PKyJQXFEZS5hgjDLQURUyl00zgciW4Q5N1OzrNmK8McMQ2H
         uINaH6/BILlntPaPi7xE7VW8OK3XLqrFyJ/lgNq97H8EUNjVLBQRLzU5ObT0bNF1+rOy
         6aX6UGmbyx9RygbF1jSSymTia1hAYqBrytu/G1gDS/NyR/XF/3TSdVWJ88UERuGSf3Jp
         +VOBXow+YpZ41THXI4CWgyBRMzm1xG1vbBWtviB8faOYMxJG2JXS85I4nlF/SnF4cy1R
         Kwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WbXTq/rv4PTCxNmHyDWfQL5ZTTgJSJ1C6Vt+iGpdItk=;
        b=RZTVmXDdHQphDVrFlB2j42E+E1GembMr6UZk9S9suVlsAMdZEdn+zQImaZg+nIBOYK
         77sxrcUBFcHmCo9cV4sLUM2bgV0rKdU/y7DlcVrSMeEKn6+zZ6X6aL8SmnPydmM3bbhn
         L4NuhrBqjtRu/NrYGzLCOcVtJ0yeowPmgD31CkDQb5+os81/TXWGQo8B3QE2UXGfUrQY
         tdNroHKNnqnsbcte4K6tHhU18Tf9DX+PQ+NBoMsCu7znZoBMIMKOk+XvsZhiuH7Ck3En
         ulSJo2OZeIL44TyRi+QJUx0KHmD0P6PtKfjQl8owAAxfHPyDE1jM0fEYGnmGH+kdKs3W
         /WnQ==
X-Gm-Message-State: AHQUAuYsgc/GSa6WXmBY2Uxn/58QyCm9KWLL7vMlta7CNA0Rdsu4dM/S
        mtxzDHcyTNjkNEsg0SOFe1zC4g==
X-Google-Smtp-Source: AHgI3IbFz1iUbRoxfRgmOdWkz41vaur9A+BtxGrF6mFztB6uoGLcDn0JYna6uhIqtASfYo0eIOjmPg==
X-Received: by 2002:ac8:b0e:: with SMTP id e14mr3403862qti.336.1550155794878;
        Thu, 14 Feb 2019 06:49:54 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id k66sm1498919qkc.25.2019.02.14.06.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:49:54 -0800 (PST)
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
Subject: [PATCH 4.9 16/16] ARM: fix the cockup in the previous patch
Date:   Thu, 14 Feb 2019 09:49:30 -0500
Message-Id: <20190214144930.27539-17-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214144930.27539-1-dave.long@linaro.org>
References: <20190214144930.27539-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit d6951f582cc50ba0ad22ef46b599740966599b14 upstream.

The intention in the previous patch was to only place the processor
tables in the .rodata section if big.Little was being built and we
wanted the branch target hardening, but instead (due to the way it
was tested) it ended up always placing the tables into the .rodata
section.

Although harmless, let's correct this anyway.

Fixes: 3a4d0c2172bc ("ARM: ensure that processor vtables is not lost after boot")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/mm/proc-macros.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 7be1d7921342..f8bb65032b79 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -279,7 +279,7 @@
  * If we are building for big.Little with branch predictor hardening,
  * we need the processor function tables to remain available after boot.
  */
-#if 1 // defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
+#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
 	.section ".rodata"
 #endif
 	.type	\name\()_processor_functions, #object
@@ -317,7 +317,7 @@ ENTRY(\name\()_processor_functions)
 	.endif
 
 	.size	\name\()_processor_functions, . - \name\()_processor_functions
-#if 1 // defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
+#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
 	.previous
 #endif
 .endm
-- 
2.17.1

