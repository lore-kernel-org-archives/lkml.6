Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C974BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A96216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eed2e68h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A96216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeI0T44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:56:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46201 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeI0T44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:56:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id z3-v6so2624806wrr.13;
        Thu, 27 Sep 2018 06:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vuQYRhz9Q3pCbPMngoZ2BMnmEYcfJjdx348+mA45lLw=;
        b=eed2e68hWAMcore+ICqY3iwhwhBJzDkBz54TEC8wRv2hNI9j3mOx0KP8UQK8rUqlgA
         cAUDu9RhjohVBtXRjPBdQWS6SM1cNL70+bnorVpcAMdgsgTf3a93fioYrK0uGeAtG8aU
         7DaMh4bNnqeGGMBsMGr5OHw/jG84tAmbRMOOTMDjtTBaGz6HT+yxlGu6MG0ujtBhyw1B
         2008FMsPPaCFhqqr+P+NWnKTiBQ2Vc+XXG84c1y4eFrGhIB5M+LqZ4wZzoVQiVYVZONX
         N0BBYF/YOCJi294nhQ4N7g981QkfvmUQ/lt7jGtzCuBB27f63z8nF0e6Nz4tIrphPmFh
         yJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vuQYRhz9Q3pCbPMngoZ2BMnmEYcfJjdx348+mA45lLw=;
        b=b6XuBt0pGMRmkYriL9iFhZYUOxsZja7J3VU89U+aIkGylgnoea4KodqXBxXoqpWRRG
         la/qcGAZor+puD9Qk8e1UKEpSRX8VEML1YkgYbjkRTHD4vQxcprpXO4LSu+zRhAw0rDQ
         EPRPVT7PvAiEoCTZU7/7alwoim87Bf/6sdp2LSO2GJiL9UTpdCUt7ZJZlBSGE8x43LNe
         CQZ0mBU9ALG4Fbsvo7flo1F/16M7OrpAuu0A+ucM8g2QC3WEwodLUQbOHiUIRUQ48nQ3
         NsWdrnxbJlB6QKpva1DVhQ3wFfWVkkrS8yho4hLX5ahq9ck0CNqei24kSQHLwfnM8PG9
         1gFA==
X-Gm-Message-State: ABuFfoifjWXpgJaMl/YHKVmoDwZFjbEF99BvGE1TNnzp/+tGh9/t7pCA
        77hPZd5Fe66EZ9dffEwKl3V3bguG
X-Google-Smtp-Source: ACcGV63UJuybuAaUVus3W1zAIJ+AVRY4EkLzvOOr9lHwRiQ8FwfeCygHMAF+x7qg/IZkclQhpPUK/w==
X-Received: by 2002:adf:ee06:: with SMTP id y6-v6mr741949wrn.318.1538055515495;
        Thu, 27 Sep 2018 06:38:35 -0700 (PDT)
Received: from pc-ceresoli.dev.aim (45.11.168.109.cust.ip.kpnqwest.it. [109.168.11.45])
        by smtp.gmail.com with ESMTPSA id z141-v6sm2244724wmc.3.2018.09.27.06.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 06:38:34 -0700 (PDT)
From:   Luca Ceresoli <lucaceresoli77@gmail.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2] i2c: mux: remove duplicated i2c_algorithm
Date:   Thu, 27 Sep 2018 15:38:15 +0200
Message-Id: <20180927133815.19089-1-lucaceresoli77@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ceresoli <luca@lucaceresoli.net>

i2c-mux instantiates one i2c_algorithm for each downstream adapter.
However these algorithms are all identical, depending only on the
parent adapter.

Avoid duplication by hoisting the i2c_algorithm from the adapters to
the i2c_mux_core object, and reuse it in all the adapters.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changes v1 -> v2:
 - include i2c.h (fixes build failure on i2c-mux-ltc4306)
---
 drivers/i2c/i2c-mux.c   | 37 ++++++++++++++++++-------------------
 include/linux/i2c-mux.h |  2 ++
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index f330690b4125..2b0cc2ad0a17 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -30,7 +30,6 @@
 /* multiplexer per channel data */
 struct i2c_mux_priv {
 	struct i2c_adapter adap;
-	struct i2c_algorithm algo;
 	struct i2c_mux_core *muxc;
 	u32 chan_id;
 };
@@ -263,6 +262,23 @@ struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
 	muxc->deselect = deselect;
 	muxc->max_adapters = max_adapters;
 
+	/* Need to do algo dynamically because we don't know ahead
+	 * of time what sort of physical adapter we'll be dealing with.
+	 */
+	if (parent->algo->master_xfer) {
+		if (muxc->mux_locked)
+			muxc->algo.master_xfer = i2c_mux_master_xfer;
+		else
+			muxc->algo.master_xfer = __i2c_mux_master_xfer;
+	}
+	if (parent->algo->smbus_xfer) {
+		if (muxc->mux_locked)
+			muxc->algo.smbus_xfer = i2c_mux_smbus_xfer;
+		else
+			muxc->algo.smbus_xfer = __i2c_mux_smbus_xfer;
+	}
+	muxc->algo.functionality = i2c_mux_functionality;
+
 	return muxc;
 }
 EXPORT_SYMBOL_GPL(i2c_mux_alloc);
@@ -301,28 +317,11 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	priv->muxc = muxc;
 	priv->chan_id = chan_id;
 
-	/* Need to do algo dynamically because we don't know ahead
-	 * of time what sort of physical adapter we'll be dealing with.
-	 */
-	if (parent->algo->master_xfer) {
-		if (muxc->mux_locked)
-			priv->algo.master_xfer = i2c_mux_master_xfer;
-		else
-			priv->algo.master_xfer = __i2c_mux_master_xfer;
-	}
-	if (parent->algo->smbus_xfer) {
-		if (muxc->mux_locked)
-			priv->algo.smbus_xfer = i2c_mux_smbus_xfer;
-		else
-			priv->algo.smbus_xfer = __i2c_mux_smbus_xfer;
-	}
-	priv->algo.functionality = i2c_mux_functionality;
-
 	/* Now fill out new adapter structure */
 	snprintf(priv->adap.name, sizeof(priv->adap.name),
 		 "i2c-%d-mux (chan_id %d)", i2c_adapter_id(parent), chan_id);
 	priv->adap.owner = THIS_MODULE;
-	priv->adap.algo = &priv->algo;
+	priv->adap.algo = &muxc->algo;
 	priv->adap.algo_data = priv;
 	priv->adap.dev.parent = &parent->dev;
 	priv->adap.retries = parent->retries;
diff --git a/include/linux/i2c-mux.h b/include/linux/i2c-mux.h
index bd74d5706f3b..5a4ffca99f5d 100644
--- a/include/linux/i2c-mux.h
+++ b/include/linux/i2c-mux.h
@@ -28,6 +28,7 @@
 #ifdef __KERNEL__
 
 #include <linux/bitops.h>
+#include <linux/i2c.h>
 
 struct i2c_mux_core {
 	struct i2c_adapter *parent;
@@ -36,6 +37,7 @@ struct i2c_mux_core {
 	unsigned int arbitrator:1;
 	unsigned int gate:1;
 
+	struct i2c_algorithm algo;
 	void *priv;
 
 	int (*select)(struct i2c_mux_core *, u32 chan_id);
-- 
2.17.1

