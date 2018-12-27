Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DDEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 16:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B4220879
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 16:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiURFLvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbeL0Q1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 11:27:15 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35006 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731108AbeL0Q1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 11:27:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so9335012pfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 08:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=C4owL0Q5cdICQJysAq8wkZCFPkIVra+RBhh8CoohHrE=;
        b=aiURFLvrSs5+d6+pBgqG893JwqFbxkvJc8hwYm2wL6q71AWEie7Wx56I1WMtsNcYNB
         4BascNSqT3rThLyHRbCK8A/f4g3eZ9OXXSBSy/jSokopqPkcr+KTsezCakquFtxV193y
         sJwTu4cLUu5YCYoE4aF+f4HENJuAJEXaxsamFIa71o22SPy1U9aoLP1NH0UwrR2iLYau
         zxge8vzxavboxqI4A46N8GV6JsXD0JInqRSP1GDCrCekqGrawQ1VL/82yTMbtsHwXwse
         Yos0LKGVNbD9prxRnThenFbLnN/EtHlvMiP55fH2x+HVbFN6fdPoOPCTsu1LWMQd4j5q
         rKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C4owL0Q5cdICQJysAq8wkZCFPkIVra+RBhh8CoohHrE=;
        b=qS4JXetidjenNpyMyi1kGqJ9quiz58043PEqJKAUKsf1HsLwrqLWA29Lf6EcSDWSwO
         Ea724mWkgokekg9sr15dkt4+2rQ0V60S3qDWjkedji5VR00ZFEshpWzlBLom87+jkt3i
         jTE+XhskyINsOC4zYVBTQqHzlbeCZ6FAm1d7tOmSlYyjEQZ2zIK7GMMcRwzvfdOcld93
         lM9aywhNbkZPZBBFzHwSq3CGCW0PvicGpSCzIF4CiN6OGL6Jk/x7Z8R+a93ZOgUHQSuV
         W64daImAlj0chqpan3fAJ/suX1xdSNJpz7ce4FTYed3YwfLd1jBcWjIoxsFEYNDKZuxM
         5EMA==
X-Gm-Message-State: AJcUukfGDyQUpQxS1L43hIhjRMRCK/f6ZdPlJJ0FgoACYotUFu0NAik0
        CFyHlU2fLsmqkB9TIK0f5TI=
X-Google-Smtp-Source: ALg8bN7XRLfvUCcO6fQkb/e3DL+HY/CccMRiu9DCH0qf83OAUv9OMoShGl2rV/cvurzQcZ7YXdNZ6w==
X-Received: by 2002:a65:590b:: with SMTP id f11mr23311831pgu.60.1545928034277;
        Thu, 27 Dec 2018 08:27:14 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 125sm74431154pfx.159.2018.12.27.08.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 08:27:13 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] csky: fix refcount leak in setup_smp()
Date:   Thu, 27 Dec 2018 11:27:11 -0500
Message-Id: <20181227162711.7346-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_node_by_type() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/csky/kernel/smp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 36ebaf9834e1..adec56df613b 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -139,11 +139,17 @@ void __init setup_smp(void)
 	int cpu;
 
 	while ((node = of_find_node_by_type(node, "cpu"))) {
-		if (!of_device_is_available(node))
+		if (!of_device_is_available(node)) {
+			of_node_put(node);
 			continue;
+		}
 
-		if (of_property_read_u32(node, "reg", &cpu))
+		if (of_property_read_u32(node, "reg", &cpu)) {
+			of_node_put(node);
 			continue;
+		}
+
+		of_node_put(node);
 
 		if (cpu >= NR_CPUS)
 			continue;
-- 
2.17.0

