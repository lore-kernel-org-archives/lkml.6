Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5090AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005882087C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgUbwxBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005882087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932915AbeGCFpW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 01:45:22 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41343 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932778AbeGCFpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 01:45:20 -0400
Received: by mail-pg0-f66.google.com with SMTP id l65-v6so426116pgl.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 22:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vzo8Jd6ZMxwfZBeJe62MpEy1JDC5Z1V3JQv4SPE1WCY=;
        b=NgUbwxBeMh49M+bBK+nWb86UsCPuWD3pUXlokp6A+kT/w55MX/p/7mcEefl9UfQnMl
         nGxNwoER91r9g28NvcWyFC6zx9jdtW8NEfwCPpAWp0TBcANo2cARh66VymbYLIZcneTg
         gVfx1ClluyUUKDcWvA/iiApmssIvJK7LP5PzKyccFKDzbF+iNw4mI6oSU/saBfuypv4p
         n8POVJr1xJFZkjUvh4HcC0e1oxJ2OcX2ze4YcHOTn78OE7dIaXIQOdmU4eIDcWSZFOnZ
         CRIHb5q1ef4KTB7Bu50Rj2CxSwdaw10ujFIJTNNUjKadhOUkQVhhp0N3UYEM0PVtseGZ
         AnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vzo8Jd6ZMxwfZBeJe62MpEy1JDC5Z1V3JQv4SPE1WCY=;
        b=pKaRELz8BpIvYGRbOC/kjwozuQSjVnY7p034jSm3ArskUPHS7TbqlsvVd+HN827Bnm
         lT16nBw5L/aXZhbgzZioLcDyurUPKF740cseY0hgVGP+vHD0NVGBGAvplyN/LKznNZ53
         Fr6oqCov+glT8VwLS8K0mvO79JMW6Z8oYngrKFk4tXpGSWDPqjYhzRfsvj/S0AOwZhzA
         MZtReLCgB186Fl6mo9GtrQeHqHZJC7X7Oxg3xzjpyn32cja2a09OvTAb+Se1oX2O47Jn
         EibcIEYx9at2y21dI1N98+i9/7Ua0RFHYe2Me8LSLFjpEgy+hkO5wzWD/SzMNKmE4Opa
         DdoA==
X-Gm-Message-State: APt69E3aEVHqiRszF1EslHFjHq6pU6QQnBuNI4TKmxqAcKkFZziUE/V8
        LDwBqWgZ3X47ro++PRwIYiuOFg==
X-Google-Smtp-Source: AAOMgpdzO56VKlnLHn+0W6XBY3ZtTSa4VoxfVCmW7qreu55Bx3SkFfxYdN1jAnKsAgxFTyhjAGnNEA==
X-Received: by 2002:a62:a05:: with SMTP id s5-v6mr20527313pfi.147.1530596720123;
        Mon, 02 Jul 2018 22:45:20 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-67-170-212-194.hsd1.ca.comcast.net. [67.170.212.194])
        by smtp.gmail.com with ESMTPSA id h75-v6sm784780pfh.86.2018.07.02.22.45.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 22:45:19 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, y2038@lists.linaro.org, davem@davemloft.net
Subject: [PATCH 2/6] sparc: Make thread_info.h available directly
Date:   Mon,  2 Jul 2018 22:44:18 -0700
Message-Id: <20180703054422.12089-3-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180703054422.12089-1-deepa.kernel@gmail.com>
References: <20180703054422.12089-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux/compat.h was including this indirectly for
asm/compat.h dependencies.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: davem@davemloft.net
---
 arch/sparc/include/asm/compat.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index 4eb51d2dae98..1b991cfcdd76 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -5,6 +5,8 @@
  * Architecture specific compatibility types
  */
 #include <linux/types.h>
+#include <linux/thread_info.h>
+#include <asm/thread_info.h>
 
 #define COMPAT_USER_HZ		100
 #define COMPAT_UTS_MACHINE	"sparc\0\0"
-- 
2.17.1

