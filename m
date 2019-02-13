Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B860BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C06222CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w4LDUYdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfBMVcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:32:50 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40411 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436795AbfBMVco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:32:44 -0500
Received: by mail-qk1-f194.google.com with SMTP id y16so2336560qki.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yWztxODyJk70cOjZaLMqULYccaSLR3ZRrSr0GSnJD8Q=;
        b=w4LDUYdIBqi9i2H0zziVwl6xNlsb4JOGyxns0NY9Sc4Sp2k3RVUCaQDCson84MAuNS
         dRrE+nsabr/JWzpawl59qNV0Rj3XRFptqCq7GHaFyFep2yisjAv/8tQyTPg9CURB+5Vy
         f+CSRuDeeOTu4XfRZsxf8pgRoyd0Y0TtogDnA1QSohGyrujR0FYqxQ1RsRukw/Se6Rcu
         c6P2wxurSjaA4iTmYvrHrE7mJxjK/kneUktI/h5rl3XsZK5n+QpdYw/aC5gvjhbJCNd2
         n/IPbUKeQ8Zg9s4j9q7qpLRPTkX+c9bVuTCuam0GKeyiGo3vBe4BH753ytTMXL5oj0FH
         TLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yWztxODyJk70cOjZaLMqULYccaSLR3ZRrSr0GSnJD8Q=;
        b=SWoX43tVMITQXhKW53zF06IEhvmHTETIzPqFLepxpUYtHQOtjfS6BosJYDqnSRiBaU
         da3FJx0uQyV6c3SMxLSFRGLZKTMec3NA1Tag9bUzTqQQPKdteBn7W5tuRv7A+Y6Jz/Oi
         oJyiGByfsd9Vw8WJPUL68uSM6t5/1gm5Bi263kmovL16ibi4IyC4tJG1s3eYLB+k0Wj8
         CJTPkTxi8ZVE32c8SqodSiFql5c3tPnus6T4OQ224JoKfY8d59JlsgdvHTrc7uPjPXiE
         FOeYXaXXz6nFbsAF2A2YPgTBwrH84BsiBwuRZzMrpzGAktE3MPN0ccPK9gz3/N2puIBW
         YqnQ==
X-Gm-Message-State: AHQUAuZ5X2mqBSKNiUujvoRpiKwx3fTIlP0qwstR/gLJKsxPYJXsvkxC
        QXz6BcladRMAHece3bAqvG/+6Q==
X-Google-Smtp-Source: AHgI3Iajkc5bd5I0MEuJUUPhXGht8qFhAq1IUEOOB3PAMLsj1uf6kgzkrqxuyR9KOY1mOkKL47TcJg==
X-Received: by 2002:a37:cf9d:: with SMTP id v29mr189595qkl.259.1550093563621;
        Wed, 13 Feb 2019 13:32:43 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id 8sm382675qtr.7.2019.02.13.13.32.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:32:43 -0800 (PST)
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
Subject: [PATCH 4.19 13/17] ARM: clean up per-processor check_bugs method call
Date:   Wed, 13 Feb 2019 16:32:19 -0500
Message-Id: <20190213213223.916-14-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213213223.916-1-dave.long@linaro.org>
References: <20190213213223.916-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit 945aceb1db8885d3a35790cf2e810f681db52756 upstream.

Call the per-processor type check_bugs() method in the same way as we
do other per-processor functions - move the "processor." detail into
proc-fns.h.

Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/include/asm/proc-fns.h | 1 +
 arch/arm/kernel/bugs.c          | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
index e25f4392e1b2..30c499146320 100644
--- a/arch/arm/include/asm/proc-fns.h
+++ b/arch/arm/include/asm/proc-fns.h
@@ -99,6 +99,7 @@ extern void cpu_do_suspend(void *);
 extern void cpu_do_resume(void *);
 #else
 #define cpu_proc_init			processor._proc_init
+#define cpu_check_bugs			processor.check_bugs
 #define cpu_proc_fin			processor._proc_fin
 #define cpu_reset			processor.reset
 #define cpu_do_idle			processor._do_idle
diff --git a/arch/arm/kernel/bugs.c b/arch/arm/kernel/bugs.c
index 7be511310191..d41d3598e5e5 100644
--- a/arch/arm/kernel/bugs.c
+++ b/arch/arm/kernel/bugs.c
@@ -6,8 +6,8 @@
 void check_other_bugs(void)
 {
 #ifdef MULTI_CPU
-	if (processor.check_bugs)
-		processor.check_bugs();
+	if (cpu_check_bugs)
+		cpu_check_bugs();
 #endif
 }
 
-- 
2.17.1

