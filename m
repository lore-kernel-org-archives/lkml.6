Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86709C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C1821720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSOpNnu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeLZNma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:42:30 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44240 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbeLZNm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:42:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so7874925pfh.11;
        Wed, 26 Dec 2018 05:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P6n/W1uiBOsiEw6UHJKLxP0YarUNUmHRgutmwheO4Xs=;
        b=mSOpNnu4azDe5ieBenQ8M729RdRywthCmwj7olKsQyiTCpmFMxn4yFL/RqEH3HMVvW
         155ZHzRTmkJuobVOGHTSUyDIMQlaHkjhBLD1JnklkFCxX6XRqMLatJcIGxvHQPSjo2Hd
         w3YyNx3mKlGfmKQYkgDUGUg0yeI/iNi6vVCWPFGv8HCYLn6GJXPfx9jLDLOUekGoRjUK
         BiEQI0FdYy6dJ2ZTGXCk0vOOBozc1gGOZY2BICplwKp32wKQE+8DLKvNYas2wDn0eVY5
         lcXFnAjcMD+M1tAuvWnu9EFLqP2ogLIfaVdd7P0aPvN11Qw5369qksPV2+Y4ATTBZ0ip
         nngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P6n/W1uiBOsiEw6UHJKLxP0YarUNUmHRgutmwheO4Xs=;
        b=PQhx4ETqq9J4L39HP8L9IcabaeqDuxDW+1QWnK5U/NalW9Zhsaq3iqkdnruFmTGy3g
         uSBY+lJPHw0LaOW1l4DLMD3YrObDDrt2ebkr3F1QogH3XeV/Ptb8ttqyXqS97aHmuKvx
         0uWrD/LzbxoO4odAthOTIf8PqeGZC4qUvAO/uh/dpmS7QWY++6wxvAxnigqj79lNUgaD
         ekrcNRMauY9z4AR+VVQuohFaBS7XnUM5K55ppKyl0gOLA8CLd6x0O2COmpLRxrkfCTFx
         AHyDsOJVXCbkP8+XILEvG/8L2Zf/CA4pKgjG8WMEPognuKg6a2/6WXxPXb+eo1Oh51FU
         TrdA==
X-Gm-Message-State: AJcUukfPZHKPYGE5NANlxvnUT9KxwUsApcFiFjyKPBw061odCNKVtlhy
        hgUFnbP0gWHr7Tk3a5bbvtvQNcpEXf0=
X-Google-Smtp-Source: ALg8bN6agRPehym7UHELvgRx+LZYrSiHG96NcGv9VCoWDdR2iSAtYzusNYNgRqx9LllnSS93cgesgw==
X-Received: by 2002:a63:6ac5:: with SMTP id f188mr19138566pgc.165.1545831749191;
        Wed, 26 Dec 2018 05:42:29 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id q75sm51635973pfa.38.2018.12.26.05.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 05:42:28 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        gregory.clement@bootlin.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clk: armada-xp: fix refcount leak in axp_clk_init()
Date:   Wed, 26 Dec 2018 08:42:26 -0500
Message-Id: <20181226134226.5338-1-tiny.windzz@gmail.com>
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
 drivers/clk/mvebu/armada-xp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mvebu/armada-xp.c b/drivers/clk/mvebu/armada-xp.c
index e8f03293ec83..fa1568279c23 100644
--- a/drivers/clk/mvebu/armada-xp.c
+++ b/drivers/clk/mvebu/armada-xp.c
@@ -226,7 +226,9 @@ static void __init axp_clk_init(struct device_node *np)
 
 	mvebu_coreclk_setup(np, &axp_coreclks);
 
-	if (cgnp)
+	if (cgnp) {
 		mvebu_clk_gating_setup(cgnp, axp_gating_desc);
+		of_node_put(cgnp);
+	}
 }
 CLK_OF_DECLARE(axp_clk, "marvell,armada-xp-core-clock", axp_clk_init);
-- 
2.17.0

