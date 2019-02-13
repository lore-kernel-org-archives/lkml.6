Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF65C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89053206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yiA5zt26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394836AbfBMVcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:32:52 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38332 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436826AbfBMVcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:32:50 -0500
Received: by mail-qk1-f194.google.com with SMTP id p15so2339164qkl.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IbhWU+vwiJ4ZGll0liBnsU+9mDwJbLZRs9UYNa4vW7U=;
        b=yiA5zt26BcNlSC5TY8vcwZCC8Vzn6Bz6CToYTziIY/wmZs2h7ALzfFg6KxIMMdyQeW
         mXKRScI2MNZrqm1ZVyXeQpzK39pyFV9WPHYHsr4T6o8rot52in5/iEXLwKo0A5m8Gg8v
         9eRtWIrFNIBEV+zhGdBRZJIQe27wW4ts8UK0sE10MeDSdI2YLmav3hO5kiPWcz2Eb+Ac
         h6NqzwKBox2S65KFnSaiwhGDDwib73UMsgOkw5gz4DwEoHdog20jFc4nMFUANhsv1Xow
         7r6tmeC5nloBRPIBUP2/otfZYwqwEVT7hsJ/JGkaMlu/VA1gHYxsLwbFc3JEGj7yeKoS
         UGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IbhWU+vwiJ4ZGll0liBnsU+9mDwJbLZRs9UYNa4vW7U=;
        b=MfVyG5e97BPD7XFCbBJavdTCB6aDm+pzsPEYKpZ12rf4A4PFD9lqcgwxaAyGMW6Wsc
         P6HxPoWoCTnu9A9Y1wTD3O3ue2JF2/xqHxSu431VtZt15WawoOkhcs3/vASC9ujosc0w
         8dgmZEjISNsb4EbIVEieLX4pI3nQE9obehbW5aZbX+8AUTuR+2fMqmc3ZqaXlABi5AWK
         ZhxOxkAxt71anfLcK/gQHzHWcRXgAvcZZfIyM9T1DFGgEsWYcJDEELSFHg7HYTjHiHH/
         XbwvUBFde5hQYDentzjXC9FAE4O85+Xhm6ZP+q4JYEgzRV8lISMWavCXE2H7CFRMdYX1
         9+zg==
X-Gm-Message-State: AHQUAubFGf5h1iwdjTq8x89dHQQUpXY7fIlNWt555zPgQFhr4iKTDaDi
        7xLzwBbFdjxRr1xEJFFlNyLh2A==
X-Google-Smtp-Source: AHgI3IYXQF9N4dCnG9cpRZUOHeWOYrfyw7Sr6gFT+huWsZ0DCuGdVdHQc2a9H39LsIARTX0dB6pvWg==
X-Received: by 2002:ae9:e203:: with SMTP id c3mr220767qkc.270.1550093569019;
        Wed, 13 Feb 2019 13:32:49 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id 8sm382675qtr.7.2019.02.13.13.32.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:32:48 -0800 (PST)
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
Subject: [PATCH 4.19 17/17] ARM: fix the cockup in the previous patch
Date:   Wed, 13 Feb 2019 16:32:23 -0500
Message-Id: <20190213213223.916-18-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213213223.916-1-dave.long@linaro.org>
References: <20190213213223.916-1-dave.long@linaro.org>
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

