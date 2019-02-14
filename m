Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E45CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B989222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TUmqxXJ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404979AbfBNCKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:10:51 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36050 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404949AbfBNCKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:10:49 -0500
Received: by mail-qt1-f195.google.com with SMTP id p25so4907917qtb.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 18:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IbhWU+vwiJ4ZGll0liBnsU+9mDwJbLZRs9UYNa4vW7U=;
        b=TUmqxXJ3ic22OfhEe89ZDRixUCnlvjj9uB5CneITxJzkkMRs4WQJb72VlX96SnADhP
         VTB2pHS0k0VrzNbJ7NecCcw5rLmo7jkFZRwzJimwbIRLJl2JzmXmG8mHtxbI3Hs3lKVj
         x0Kr2EK1MrrrxyR4tumbtse4V110OGsowoYFJSivydgnmPQLPQHAHuXcM9nDmtTmeJCE
         V9hOmEexPi2D2xMW5MBKQvah2oQRMMgRYFkjWpILEKE8wRbimcDYjzJSxWMZvLIoqcrL
         BYhm701/zHf+FaO2fUGdcFVKYR3zbgk2FPE98KatEzZ5cbJkeNOnp1N2z9IFznpLXwQq
         y5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IbhWU+vwiJ4ZGll0liBnsU+9mDwJbLZRs9UYNa4vW7U=;
        b=e3OI3CNJoZCV5yXrMSq8M5InAaCDEmSRqhSOzY3AGZ7WzVA1XunDbA8w24AA+/biD9
         jkfqELFv3kcf4be8MPC3KVWLb4afms9bjvs10RUPD6aXVzPXvu2Ui41BSpGcMkFvQeQV
         wdp2UsF9hHfk49shX74nx9VOjbfh9uJ61im5JUi/EHRrodYBG86tQqwRvJ3x7CpTaLX8
         oeeho9BAR51bUuiL6pcKvqPm6Ys1uKQlMN4yulYRSASifAEw9OXHZJgyq5thuf3/1Ecb
         SbM6yVQ3Ve5N6PjlwUhK9nhEjfbCCfN3ww7jmsdBDr3lywhzmToqr5PrWUWcpXovKiem
         RFWQ==
X-Gm-Message-State: AHQUAubvUP4EqV1n3wLi2Hm+ztA8ewXDRjUloAq+UEvHoH47rxWg3lA1
        BACgluFoX7DuHpc/xohi+lJaAQ==
X-Google-Smtp-Source: AHgI3IZCqQEjW8+70aks9hLHT5DqKugLFWu2fQpvtcz0+1TLoEgwjoykFxfZCRsuGgFtLTftI4KRhg==
X-Received: by 2002:ac8:27ba:: with SMTP id w55mr1061465qtw.228.1550110248059;
        Wed, 13 Feb 2019 18:10:48 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id d63sm1091575qka.22.2019.02.13.18.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 18:10:47 -0800 (PST)
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
Subject: [PATCH 4.14 V2 17/17] ARM: fix the cockup in the previous patch
Date:   Wed, 13 Feb 2019 21:10:22 -0500
Message-Id: <20190214021022.5313-18-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214021022.5313-1-dave.long@linaro.org>
References: <20190214021022.5313-1-dave.long@linaro.org>
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
index 19516fbc2c55..5461d589a1e2 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -278,7 +278,7 @@
  * If we are building for big.Little with branch predictor hardening,
  * we need the processor function tables to remain available after boot.
  */
-#if 1 // defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
+#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
 	.section ".rodata"
 #endif
 	.type	\name\()_processor_functions, #object
@@ -316,7 +316,7 @@ ENTRY(\name\()_processor_functions)
 	.endif
 
 	.size	\name\()_processor_functions, . - \name\()_processor_functions
-#if 1 // defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
+#if defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
 	.previous
 #endif
 .endm
-- 
2.17.1

