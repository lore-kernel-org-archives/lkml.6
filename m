Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794F6C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B84921720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uzLaENZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbeLZNsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:48:10 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36210 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbeLZNsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:48:10 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so7894040pfc.3;
        Wed, 26 Dec 2018 05:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xs9bgwKVYqdbWfG93XdilpjgOed1rR2CFtz8b0OXHO0=;
        b=uzLaENZ6BQGEuE0BgwOFvAxZBYyDZjSHYbmzcvWkzboYj1/yjSya3G2m9ojsQ8fcsE
         rf8X7fpetNowRBu/ZlnK6rr86xFWOGZ9BUGYkQbEb4IAxui6o9sxVWa5mbMFb5zefWZ6
         W4t+nJLZ3r7NVF6ZKS8ASvRBB1vwp7a9M6gB2ybQ4nHLMiR9+YuTgekT6b7H0GsFQZaA
         6iMbMN6lj/dgZBGCrOypZoVzMaWjkH7/0ABR1erYbG6NhGbhALLvIDp1uQbj8LKQza/4
         atc6TbP3hdSzspHYypJJ0/ynZQzvh09rR95+L9Goerqzp9HEbfKJ0n32SY9r3DGowN64
         kAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xs9bgwKVYqdbWfG93XdilpjgOed1rR2CFtz8b0OXHO0=;
        b=LtctxkcyEX5c1ou8iFIzJv8015vgexGCO6n7yzAHJ9PBbIUzFEcQV/GAldTvlNklMQ
         433vROkPql7CUH5ZpV8hGAnmyJ8DAP9vaTVse9uFxQ4ImgHN0PNJUWZzCSInrk0u9R21
         3ukvD8F3jC1sw2j1p/wIT5O5JJ4TwCgx9I6vUCVqvJPggBSXzvApLoOEPRQ2xE+rLV7e
         z8Rpfoo2tbMBoWLRvVmWzX80XrCl1Ozgn/H8slecHSptfglgwen55cDUOQE+80BLXsaH
         6xwrzHhSGInXM+lnSpPgMhx/c91S0hTMoOw0d7d5kxpWATiPIQDyPFOoLnHB+1M9HqsG
         nqVg==
X-Gm-Message-State: AJcUukd3xIZ6AqYUbE5Qa/xZFGkp0rXRE2/4WEpJfFZPjYeGqZdl9Tee
        Lp/SMmM0qE5sQ3dHBSUgeDE=
X-Google-Smtp-Source: ALg8bN7bPq0z6y1+sNcTCiR1E9RghEudDh5Ri31cI2UMU/VSCI2B14+RCBtijm+pnOJOXWRUcgRMZw==
X-Received: by 2002:a63:7a09:: with SMTP id v9mr19053049pgc.112.1545832088543;
        Wed, 26 Dec 2018 05:48:08 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id m9sm41120620pgd.32.2018.12.26.05.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 05:48:07 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        gregory.clement@bootlin.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clk: mv98dx3236: fix refcount leak in mv98dx3236_clk_init()
Date:   Wed, 26 Dec 2018 08:48:05 -0500
Message-Id: <20181226134805.5447-1-tiny.windzz@gmail.com>
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
 drivers/clk/mvebu/mv98dx3236.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mvebu/mv98dx3236.c b/drivers/clk/mvebu/mv98dx3236.c
index 0a74cf7a7725..1c8ab4f834ba 100644
--- a/drivers/clk/mvebu/mv98dx3236.c
+++ b/drivers/clk/mvebu/mv98dx3236.c
@@ -172,7 +172,9 @@ static void __init mv98dx3236_clk_init(struct device_node *np)
 
 	mvebu_coreclk_setup(np, &mv98dx3236_core_clocks);
 
-	if (cgnp)
+	if (cgnp) {
 		mvebu_clk_gating_setup(cgnp, mv98dx3236_gating_desc);
+		of_node_put(cgnp);
+	}
 }
 CLK_OF_DECLARE(mv98dx3236_clk, "marvell,mv98dx3236-core-clock", mv98dx3236_clk_init);
-- 
2.17.0

