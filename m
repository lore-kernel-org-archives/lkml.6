Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C97C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19045214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="twNArmFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeLZNO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:14:56 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34051 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeLZNOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:14:55 -0500
Received: by mail-pg1-f194.google.com with SMTP id j10so7582785pga.1;
        Wed, 26 Dec 2018 05:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lFWCE1B1dfSwy09MHSL0bxc2yqdm+6b/a1GFBjXDMco=;
        b=twNArmFw+wBS0MjrIXfLQe4rVq9BgSO6DgZH88durpjkXWwA2TNpBYETOw/7YCXsFM
         +0h89AgZqdjtlPDhZX7aXUU/ryY1UhXD4WU8MfaGQKsfEeRpVqgkqHWHVQisIhyRYHXD
         AgDuooIyLSf1Aep+UoAH/1iQ/vKXRClY4PwX/giTd0WllWdrnRjoudsxPoz+ndMRxiUS
         Bpc8n8MhZQkt2IRQJ9VMDVADC6uzhVeMCb/W+rDk8s0P0UuRtjA4/twcZmIkDLcHzo4/
         LUYvYO6yx4bXkvAiTXUtaeoO3inudycvV1qdiGNhl5rSeC2xhfWLZgyE/ZAa0shI0C/7
         qevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lFWCE1B1dfSwy09MHSL0bxc2yqdm+6b/a1GFBjXDMco=;
        b=nGjw9TMbsaifFrOesG1j2Nb4dRFO7g+EzB2c4lCxaUSQdPpmG/PKKAklUYJdv9hgu4
         m5iMLdqLZ6/Ghk8uiup6KY3e3petTHbCdmRseNb35HSiZM+m20dXtDS+tZ87kbxiM4RV
         ecyVTMkl6MTvFM81zhJza1VJM8i4xe1w6Xb/JCruV2BhjOixXeLZ4JP66GREB3M9R3P0
         R026dTtFJ/oTAMgZqTcRKkqTyG7FuzsaiUhyHIjwvKar+sofw6vonGsXHqgnhqljM7uW
         aHICnDmPMJ2rlFepjS7QlwJKeK0O3R3uAgNutMtdQwX1zCd18KRxveJKhfxke0OvnWkM
         KFkg==
X-Gm-Message-State: AA+aEWYDcWLATwf5wFT9t/bNxgOV5NU/ShnbSGyn4b1JGZkYmX2IpPeK
        xm9793R3bAc/R7OYSOyhr1w=
X-Google-Smtp-Source: AFSGD/WmXzwcdOIYtRs+cLr2Aaw6aknUqLvktww8uOR5I0LMB1wNp0PWIyK6oLcutiZLi9k5AaUDfw==
X-Received: by 2002:a62:1542:: with SMTP id 63mr20308947pfv.230.1545830095162;
        Wed, 26 Dec 2018 05:14:55 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id m3sm28915013pfi.102.2018.12.26.05.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 05:14:54 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clk: qoriq: fix refcount leak in clockgen_init()
Date:   Wed, 26 Dec 2018 08:14:42 -0500
Message-Id: <20181226131442.4462-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/clk/clk-qoriq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 4c30b6e799ed..97a0029a1cca 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -1389,6 +1389,7 @@ static void __init clockgen_init(struct device_node *np)
 				pr_err("%s: Couldn't map %pOF regs\n", __func__,
 				       guts);
 			}
+			of_node_put(guts);
 		}
 
 	}
-- 
2.17.0

