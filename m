Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C30DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2158D20660
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KgIZy+9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2158D20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeLAI0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:26:32 -0500
Received: from mail-qk1-f227.google.com ([209.85.222.227]:44168 "EHLO
        mail-qk1-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAI0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 03:26:32 -0500
Received: by mail-qk1-f227.google.com with SMTP id n12so3999981qkh.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 13:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/GL+vMwLEIx6YDK73nJMetbGD8d1zqFOPKI/7jt3NQk=;
        b=KgIZy+9tT+i7CRlxDSpmevqvb5hOzzAGGtSt630tiSG5GWXAg+Igk5RwTIqlbRJqpF
         MCjpvRuwW65f+ChecqqQDKPMX3v2s7PdXNqAFDp0feLpNolEspChYH4doA/DyRTCrJJr
         B6fv4x8cn6k0U6ctr13njCHIX2xCvFMo0VEqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/GL+vMwLEIx6YDK73nJMetbGD8d1zqFOPKI/7jt3NQk=;
        b=eYrPfmDRWhjte6mZPHaIW47b+PWxfdALQFuLC9DrdbtsqEiksYa1sZt9vSJGC9uOl2
         M5k+WEcnHfWyP2HzoL9tKqADd7kR6quAqdIKzwHjOl81Ytxno0bfDY7Mbcka0PcqfV1j
         YlLvOVyNtiAsn2u3a2L+FJ6k1sHM1o55qietAReHrsVZ2stiQ9KybxNDTYi5lBtnyDxK
         7265hksVGy+imYWmz12Pxqv2rcpQ7n7cheUAha9rOBULom7zZNMfL0LPwQJ4M9ja17IO
         hpKLl2EAmXO2ZbY0ds+0BLJB0865d6aPB/qEt09dlt2mxbvowuYja9EuMFuMmmaWyn3U
         DeaA==
X-Gm-Message-State: AA+aEWbmKYh+n5mtLMEPWKirQuAGbRDQ+4wYPt8wlBwH/efUjOLpUrHK
        B435+j11oqveizuiP9T3Q04f07e+RV3BEIZASSZQ75tOaOGdkA==
X-Google-Smtp-Source: AFSGD/V3rh2gprbZGHlBnGABRuJs6fcglYLreFmaeWERf5YqH4/j23cDyJ5yG3piSvJwtqeAQDAlXiIlgZFf
X-Received: by 2002:a37:484c:: with SMTP id v73mr6585358qka.196.1543612555734;
        Fri, 30 Nov 2018 13:15:55 -0800 (PST)
Received: from c7-smtp.dev.purestorage.com ([192.30.188.252])
        by smtp-relay.gmail.com with ESMTPS id h21sm513995qkj.9.2018.11.30.13.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 13:15:55 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from roland-x1-yoga.digitalvampire.org (roland-x1-yoga.purestorage.com [10.202.102.176])
        by c7-smtp.dev.purestorage.com (Postfix) with ESMTPS id 5378D2191E;
        Fri, 30 Nov 2018 14:15:54 -0700 (MST)
From:   Roland Dreier <roland@purestorage.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/hpet: Remove unused FSEC_PER_NSEC define
Date:   Fri, 30 Nov 2018 13:15:53 -0800
Message-Id: <20181130211553.5450-1-roland@purestorage.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FSEC_PER_NSEC macro has had zero users since commit ab0e08f15d23
("x86: hpet: Cleanup the clockevents init and register code").

Signed-off-by: Roland Dreier <roland@purestorage.com>
---
 arch/x86/kernel/hpet.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index b0acb22e5a46..dfd3aca82c61 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -21,10 +21,6 @@
 
 #define HPET_MASK			CLOCKSOURCE_MASK(32)
 
-/* FSEC = 10^-15
-   NSEC = 10^-9 */
-#define FSEC_PER_NSEC			1000000L
-
 #define HPET_DEV_USED_BIT		2
 #define HPET_DEV_USED			(1 << HPET_DEV_USED_BIT)
 #define HPET_DEV_VALID			0x8
-- 
2.19.1

