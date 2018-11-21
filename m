Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52839C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17374214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czVoTK3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17374214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbeKUXJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:09:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35051 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbeKUXJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:09:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id c126so5588966wmh.0;
        Wed, 21 Nov 2018 04:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YoJCFkiCKgSJThridSlyfziMlNx/aunHriyi/AbHbEI=;
        b=czVoTK3x2AwXq03697ECxzrycMQu1bHrSr+y7tRrHbPV33u+8jSxDok4eNK3/Sp/3Y
         79e/bYNVfUlvBFGLqAptWlIWzy2vxWphx3Y1ncBkI076hpKWVhLNCkWKIdO0BrlJWoyc
         40/yt03XhzRAB8f3Jkk0MyEUdYCl3WPUebqrdJAe+98fEH8kbx7Yqgh6JZQPW9BmQst2
         ASLfdxa1DotgqfCz8V9IvHhS8Dr0ZRSNh+skbvCHrojXOdqpxz+eCpMxAzCaA+9oaeQw
         mhiayVwf16J5iitiXRGfO8ZLqx0+LtOxy1R4KBq347wNDgi7fwTcTAQYjbLdfAgidWfS
         JBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YoJCFkiCKgSJThridSlyfziMlNx/aunHriyi/AbHbEI=;
        b=K8HMU4oFTv/wCEqQY+Ke34ye1+rMF3BkKr6x/0ZdqtocN3hixCpn/iQJV1pBEHCvdI
         DJBHL1QnKisj7yXa3P/ZP71PA9PEnCLhaojjc7NC3WlninHTo0l7Ktaz6D8lppS7BA9/
         hq52hClah+IPZ6Zg11xD3XqzRufSXNuZJgeV8u8unQ79Zm0qR1Rcj7ogCdWQ1rEGMUsl
         nnQn5tIilTvA8sys9YJDQD0ogebd8Avhmq/4eNmof513cGm+Odp37RBONHHmHnbli54o
         eOeYiVYY2D+BgniiAdmxs2gvqm+QvpsLtJWSNeDQiLCT4WEbgNl6cRU5P8M3Rr10AKoK
         69ew==
X-Gm-Message-State: AA+aEWY0GJjSYD40zrOfRHb+hJgVSIAITCdvBYL/uU+uD3w1j3d0kcYG
        iFM26Isw6j3AuPVO1loRWlkHJg35qhs=
X-Google-Smtp-Source: AFSGD/XNniRHJJjvmKFWdZXyqvZnVhlQgBBtBQx7T4CU3/BcschCvjoq1DC6rqAmfunlpQ9q70yxZQ==
X-Received: by 2002:a1c:6a08:: with SMTP id f8mr5477632wmc.4.1542803725883;
        Wed, 21 Nov 2018 04:35:25 -0800 (PST)
Received: from cperon-Latitude-7490.lan (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id 125-v6sm1212506wmr.22.2018.11.21.04.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 04:35:25 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2] pwm: kconfig: enable kona pwm to be built for cygnus arch
Date:   Wed, 21 Nov 2018 13:35:08 +0100
Message-Id: <20181121123508.25119-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cygnus architecture use a Kona PWM. This is already present
in the device tree but can't be built actually. Hence, allow the
Kona PWM to be built for Cygnus arch.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/pwm/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 27e5dd47a01f..982f4059f4e8 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -88,7 +88,9 @@ config PWM_BCM_IPROC
 
 config PWM_BCM_KONA
 	tristate "Kona PWM support"
-	depends on ARCH_BCM_MOBILE
+	depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS || COMPILE_TEST
+	depends on HAVE_CLK && HAS_IOMEM
+	default ARCH_BCM_CYGNUS
 	help
 	  Generic PWM framework driver for Broadcom Kona PWM block.
 
-- 
2.19.1

