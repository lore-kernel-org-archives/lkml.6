Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C01AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BFC421720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDsuUKce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeLZNuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:50:17 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38862 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbeLZNuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:50:17 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so7600155pgc.5;
        Wed, 26 Dec 2018 05:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aTl+epCJJC/bZRtJORTZFQIJDy9UzwaofzAUK0n5vRQ=;
        b=kDsuUKceEsow/fN0cKesf77qhLZzAp19lZLWMdCTG9qRsFHQRoouHvhJd/kgQAcgrs
         lk2HyJIMXnupCdA+eqGlvh5qtW9jU99wtSyDS2iWbz8vbQCGMQBh7Dhgdz+FhWiZ0Z8x
         qFjMZpDMsNNMouxcFWuaqkCjKz6o0tMkSwz2MzV7IEncpiXd4RCog74hfarhItPlVD5I
         ejYMt2xUm00EILHXXZlU9memjfTu8F8pRLIlp0eKR8wo8R1xwgKiSKoIBtFV86nifpkY
         fmnN9IMGkKoToJ/au13zob4bySWgtQy0owVAFhvxLQmy+M5DFd0zBuIpo9Ji+SwpdQ79
         ntGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aTl+epCJJC/bZRtJORTZFQIJDy9UzwaofzAUK0n5vRQ=;
        b=uQN340/II2jg0fOfQHlYPY3LTtyMl18n11TRASlf03MOcifLfr8vWWrbDSKZfV3b/j
         I6ZgmjVo7XUY9wopUhjVbHFWC0a37c659VnfOLGG+Lj3lYXtIsLOokYfynKzKQgNqR2z
         cSzmZuPQp1Elup+MbGJktDmCHugkYfCuJ9MWnYX6sseBcfPFFaGysbfed2yBPzsu5ozA
         JZV8CRnX4ggBk72/RD7dQFQUsjbjuB0z6360Y3R7feMtzZCigeUJdGtd50iTUBG7VRwq
         boyzg52Inuo3vPTdSVrOPS0/F6VUnH5DgfevCRNu3vyFPkVBYiJ0FQNvc+a6575fiwl+
         Fp8Q==
X-Gm-Message-State: AJcUukeGLTn/SfCOG/I+ezJ+conyzeLYt2CnoDSP0pEkjeSPjZNJDMpK
        mkRKFulO5+1lf2cYbGfNoHs=
X-Google-Smtp-Source: ALg8bN5vlVUX9ZiKhvkp77LknRNjMqQvDp1tjtV6SZHcr1PkzoB6/sD+6FL0Z6GyOhMrsjyBjx50qQ==
X-Received: by 2002:a63:9041:: with SMTP id a62mr18609079pge.163.1545832216852;
        Wed, 26 Dec 2018 05:50:16 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id a18sm44700682pgj.30.2018.12.26.05.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 05:50:16 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     gregory.clement@bootlin.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clk: dove: fix refcount leak in dove_clk_init()
Date:   Wed, 26 Dec 2018 08:50:13 -0500
Message-Id: <20181226135013.5580-1-tiny.windzz@gmail.com>
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
 drivers/clk/mvebu/dove.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mvebu/dove.c b/drivers/clk/mvebu/dove.c
index e0dd99f36bf4..0bd09d33f9cf 100644
--- a/drivers/clk/mvebu/dove.c
+++ b/drivers/clk/mvebu/dove.c
@@ -188,10 +188,14 @@ static void __init dove_clk_init(struct device_node *np)
 
 	mvebu_coreclk_setup(np, &dove_coreclks);
 
-	if (ddnp)
+	if (ddnp) {
 		dove_divider_clk_init(ddnp);
+		of_node_put(ddnp);
+	}
 
-	if (cgnp)
+	if (cgnp) {
 		mvebu_clk_gating_setup(cgnp, dove_gating_desc);
+		of_node_put(cgnp);
+	}
 }
 CLK_OF_DECLARE(dove_clk, "marvell,dove-core-clock", dove_clk_init);
-- 
2.17.0

