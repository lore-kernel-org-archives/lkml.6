Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1836C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF23721721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axHW5jqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfAVOGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:06:49 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39150 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbfAVOGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:06:49 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so11823232pfc.6;
        Tue, 22 Jan 2019 06:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QEYg+/ZxIT0kaYcfr4Z2WVw7UzzLxP44eG6nohS8u5Y=;
        b=axHW5jqA33ZE+D2F1TuBDK2YL6dAa5e+U9MYVIm2YA5ZR6e/ar4ukhS7GmOA5Fp/to
         cUBaXVY6rEOc6wp6KZbZ3gjDYtzk1qyi4J7JPOOrdpGRvSG1afYQ4VGOZPnef3lLJU7f
         c2WKZLDYpjsA+qUhw1YOAczyq/CcbRdTFduFdkgqi1cFZxjCBTBh3UCj3AKX0WK/WmgF
         u4YEKtvrbjhVg8VSFI9/VVbBjf82VK4L5uPKyPxzPRu+0Cvtkq/4c34hBocK/3tbfjHT
         gQgqpzGiM2rIZpGT3mI6zkyBQ8Y2ekMsyyKjXOkn90/2giGCf47eldOYwxygCn0+lOjK
         NWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QEYg+/ZxIT0kaYcfr4Z2WVw7UzzLxP44eG6nohS8u5Y=;
        b=cRmhVL5wnIqBM+NIoeGZInI6Gwgc9wdwCM5LUpIKEdL+O8lZbYxchiTwmxFzjEINqv
         D9FxBjn64rJaX8MNIsj2hbMbxFn4nsW1Ikrn9ltIU3hvq68Ia1jsL9qa7t5BQXxdoi56
         JIdJmVyLuYWppTToWHKZBFaZmQB4iFdjOCGu94LJwPZfoKOD9fvmG25lTs0Loze1ipsf
         tK19W23ILoQ+WIj060JbxvIGSCVLhkkGTqBxXkydbwnxJVAVtnNteV5KO6UTp/98zcbA
         vhbHsqs7nj6f3C7Y13NYE0qoQHrsoRkQS1QZA73L5Zxh1Rz84iXfF4/GfTT4N29cYu4H
         U35A==
X-Gm-Message-State: AJcUuke8600l6jIDIfC0+cPGjRv138TeRBiy/7ntSqo1w9NJ7oZQ7pUg
        mp2XT+701gP+bOWu1ecHrGye6Y3aTX0=
X-Google-Smtp-Source: ALg8bN7ypm1x/qbQZAFX9nbZAur5Y8ryIroosGDKAgiWeyEXlNQ5bStMqWmqkgmdYQTa6RmBbU/c3A==
X-Received: by 2002:a62:1b83:: with SMTP id b125mr34855084pfb.42.1548166008195;
        Tue, 22 Jan 2019 06:06:48 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id d18sm22429162pfj.47.2019.01.22.06.06.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 06:06:47 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, corbet@lwn.net
Cc:     linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cpuidle: fix description of exit latency in cpuidle.rst
Date:   Tue, 22 Jan 2019 09:06:44 -0500
Message-Id: <20190122140644.25535-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exit latency is the time from exiting the idle state to execute
the first instruction. This place may be a typo , so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 Documentation/admin-guide/pm/cpuidle.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
index 106379e2619f..3ca2ca60ff91 100644
--- a/Documentation/admin-guide/pm/cpuidle.rst
+++ b/Documentation/admin-guide/pm/cpuidle.rst
@@ -134,7 +134,7 @@ substantial), in order to save more energy than it would save by entering one of
 the shallower idle states instead.  [The "depth" of an idle state roughly
 corresponds to the power drawn by the processor in that state.]  The exit
 latency, in turn, is the maximum time it will take a CPU asking the processor
-hardware to enter an idle state to start executing the first instruction after a
+hardware to exit an idle state to start executing the first instruction after a
 wakeup from that state.  Note that in general the exit latency also must cover
 the time needed to enter the given state in case the wakeup occurs when the
 hardware is entering it and it must be entered completely to be exited in an
-- 
2.17.0

