Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DE8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93EAA218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OySYPp7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeLZNhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:37:01 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45310 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbeLZNhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:37:01 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so7875711pfd.12;
        Wed, 26 Dec 2018 05:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KbDUJL2ThReIk3QRep24tGKRwUy5XMoIYYyb8uG18qo=;
        b=OySYPp7lHeGen61rx3QyEHLnrZMs7lwPaojSrXYAC4/2TMxt27Ae4+GcmWOWBdiMR6
         t8GPR+zf/wrWSgzrZ6eXcnQrWfMMpqasThRuNTyVL5JkuUFUjJ3tU/RvyK4xb1RpUe9A
         ugBqkW3DuFG/vciks5W+bkaWb14Cwp6lvQC4QtI7nJiUP/QEeqBKNtdyU1GiLpUMqS5Q
         Lsa73ZOalXu+QbrnwWLDPKUhnH1Lt4Zsd4s9etOpTKlvFi5kTlJ8l35ILHZAjwhzlcp5
         Wz/n0FB8GJuhujlVq4FR2ImHm2NHZnZMrQb+aRNLJ6YbvFRLw5Bnn2Wnq5uDb3+JOy6i
         +DFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KbDUJL2ThReIk3QRep24tGKRwUy5XMoIYYyb8uG18qo=;
        b=MyRRGo3reeTxF5DImygmoR3XyIl8DEhuG8ipAzi8GRlZL0pELHEz4Gm77zrCcaC7eH
         WjK0bgd1Z59xsmKOZYO3/YCpnOfcMiLWrWdX83k+KZPOsd9+sgg1bROunVw49Ju9IKtv
         izJIYEGF0ZLdqXDuupwzQyOCSwe0VfjqND625ygzYTLi2NCMXVI8Si45b6BbUbqGeBX4
         Ax1UD6AahVGQE7mzluPq6BHa0bnTkK5nBotWVbXcEcOx2QTt0QXiAgYr74cfZ8KW5j3v
         98bccjYXi8p65esnYA5XUtBGc3GZKn8fFkAeYDOXZMVUvLUAm5/GdABTUpKKVM8eAKqv
         nmWA==
X-Gm-Message-State: AA+aEWZj+iW/ONcONjAFcfZHy+5sqUQ62MLicjdQcTqz24bjXH6YUm1Y
        AikiGqNxE+MWsXW3b/dCo/Lw77tgp1A=
X-Google-Smtp-Source: ALg8bN7FAb8/917pRHb0eWAsLODsCMWGm6sdvHztqsvIT1S5nY9X7kKoCgbnXSknntaAP1j+hkTU7Q==
X-Received: by 2002:a62:56c7:: with SMTP id h68mr21111535pfj.134.1545831420572;
        Wed, 26 Dec 2018 05:37:00 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id l5sm41701552pgp.82.2018.12.26.05.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 05:36:59 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        gregory.clement@bootlin.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clk: armada-370: fix refcount leak in a370_clk_init()
Date:   Wed, 26 Dec 2018 08:36:58 -0500
Message-Id: <20181226133658.5095-1-tiny.windzz@gmail.com>
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
 drivers/clk/mvebu/armada-370.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mvebu/armada-370.c b/drivers/clk/mvebu/armada-370.c
index 7dedfaa6e152..5c6bbee396b3 100644
--- a/drivers/clk/mvebu/armada-370.c
+++ b/drivers/clk/mvebu/armada-370.c
@@ -175,8 +175,10 @@ static void __init a370_clk_init(struct device_node *np)
 
 	mvebu_coreclk_setup(np, &a370_coreclks);
 
-	if (cgnp)
+	if (cgnp) {
 		mvebu_clk_gating_setup(cgnp, a370_gating_desc);
+		of_node_put(cgnp);
+	}
 }
 CLK_OF_DECLARE(a370_clk, "marvell,armada-370-core-clock", a370_clk_init);
 
-- 
2.17.0

