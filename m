Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B899EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FD0222E2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oqqa4c05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732655AbfBNOuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:50:21 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42840 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439342AbfBNOtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:49:50 -0500
Received: by mail-qt1-f193.google.com with SMTP id b8so7058681qtr.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pAnOVz2Tf8tfyn6B3aYtP2aMoS37wFyp7WQ4pd7h468=;
        b=oqqa4c05/tE/es628OJr0AKarImUFLu26ac/Z2ZYTTtqFs/psM0+eQUYUQoJofhFkW
         wD9y+ej56HVjNfAxvZ5nboB/WZMEhObRwTJcRdf8BwMVUZMXaJFbmkjLSE/wHf4LaKgh
         8GO1ZBrEBfz63r0DJDKGYYhiSd2VQnxKUOq2at73VFQIFbDKwg9XUgM2RHKH5pzhgKAX
         t9XmWVZbDhv+TSxnyiFbqZBtYm0QT0GHBNI5XTWOs27srmfzsYzVM32z3DMhBbReLFWF
         +Y2LQNcgMvio+lC+DxKGCK4wXHbU+SY912+rsCTws1OYuHdW5+F2VlIeNcqU2XzmvF1e
         vtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pAnOVz2Tf8tfyn6B3aYtP2aMoS37wFyp7WQ4pd7h468=;
        b=n6mof3dpja5N6f7S5qTZq/ErgetvGuhpuxiuRUotB9L3EfIZVy8eyWL07fLR7t0DlF
         IDh1i9ktlXqL5TgBDLoalA9mgd4Kofh+qBy82vwxOKTfLJ1Fp+DYLASMFdLbYTnXZDbt
         /328LCkRmTh70lIw9hDqNiazr/fyw7XQ01kLvtg13Mg/fvXqcNhfOnvMK6gEebxkrWo7
         h4ZACLgrbcIzukPiWP4BPWx3hERHL3Bj2ZP8n3bKDtDAbsX0A1KkQnU2+OJvNvaH+bmR
         9RG+yN/MhkBS/rexJd0yJlVwpIK+W+7wwAPNOfts+EdEpu/VUL4khy/ho+Fi6rjC8XLU
         hbKg==
X-Gm-Message-State: AHQUAuZ5hDtrCJXVIypa5Dq9HBG1FfcEZeQ8xHtAh6T5DRD6ZSLwjwLT
        qbG0Tn+RJbADatnY6E7oSlxlbg==
X-Google-Smtp-Source: AHgI3Ia2uIekICFgLPjSDp7jsbXUE+qOpPavV0Iei1TrHkndAodE352FX+21VP3xhYCudJAwVLsGXA==
X-Received: by 2002:a0c:c3d0:: with SMTP id p16mr3259210qvi.47.1550155789277;
        Thu, 14 Feb 2019 06:49:49 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id k66sm1498919qkc.25.2019.02.14.06.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:49:48 -0800 (PST)
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
Subject: [PATCH 4.9 12/16] ARM: clean up per-processor check_bugs method call
Date:   Thu, 14 Feb 2019 09:49:26 -0500
Message-Id: <20190214144930.27539-13-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214144930.27539-1-dave.long@linaro.org>
References: <20190214144930.27539-1-dave.long@linaro.org>
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
index f379f5f849a9..19939e88efca 100644
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

