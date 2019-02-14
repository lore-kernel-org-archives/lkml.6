Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFECFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB6B222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RLOAOGsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404790AbfBNCKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:10:45 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36082 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404352AbfBNCKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:10:43 -0500
Received: by mail-qk1-f194.google.com with SMTP id o125so2722220qkf.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 18:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yWztxODyJk70cOjZaLMqULYccaSLR3ZRrSr0GSnJD8Q=;
        b=RLOAOGsE5nSbSM6/Fdwv4fbbCUUDxoH87XcZiZPt8XPUpEg2LeQDlKEdX9eejNMth4
         D5sjkt3JIQB0/O4sBhzjI4Xv7TxMEI42fBR97qAQ9cEEOuR65FFVZMWXkwlG4nqVNzAA
         EfPJTUnOXNxNhhGH/5tgmpP6UVQJQzNHJNQG11QqTJiwiawxa4GLUSjj/KP/VFlVej/W
         VH/WPb8HzrrPBx/qXezHkdtF475W0RFdZVJpXxwJlA2vwLfNvMv2HhvzF+lq3iAEzPht
         kZ6B1lO/XSu80dqNSmIygnLp8yzaVcaN/IW8WA1AkCzfWWk8IfZjAPiFnb07WJNIi7Cs
         hoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yWztxODyJk70cOjZaLMqULYccaSLR3ZRrSr0GSnJD8Q=;
        b=ZfIWKDjA6jujmuJP+5uVeQVWvRIT6FvH8DcrTNE70Ip1pI6OAMIktB8mAgFNdwrZO2
         gtfPma4SthjAi0WuvrCe/WQ8vqzZo5+4XCzFJdUJgYr8AsuR63e0k70UXBCDqB2HJaxh
         0GGWnP31A4JG5C6Id+n8xy5+dEUixQSrNcKh6OpNgMFS4E9Dwp9SyLCo/7Dcn7S1wbFZ
         csbHaZ7z930Q7XNnQqyLtz9lPnvkV5t5bH2DCQSz7wc0Ptjr8rYfpn+/3/qrG5FeKJdV
         GrditHdbxqtxUzu8+YleIx+rARja7r0oNW0XFd5gZf8gvyHTmX+3k4ka+ZxPjr9qvMHI
         pfxg==
X-Gm-Message-State: AHQUAuZmRuopRc220HIdeM8iyJHlaKuJnKkKAmxNBg+Ixpv0aSJ74Zo4
        lW6+yyEpryUfj0ZpNaoOSpYYJA==
X-Google-Smtp-Source: AHgI3IaOdEJlYGfGZFJ03LySCXK9Oa2itBY1PUrqSCZa559Bzvv8O1a10Md03zQeqa4HrWam4yA2fQ==
X-Received: by 2002:a37:b405:: with SMTP id d5mr980783qkf.162.1550110242675;
        Wed, 13 Feb 2019 18:10:42 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id d63sm1091575qka.22.2019.02.13.18.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 18:10:42 -0800 (PST)
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
Subject: [PATCH 4.14 V2 13/17] ARM: clean up per-processor check_bugs method call
Date:   Wed, 13 Feb 2019 21:10:18 -0500
Message-Id: <20190214021022.5313-14-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214021022.5313-1-dave.long@linaro.org>
References: <20190214021022.5313-1-dave.long@linaro.org>
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

