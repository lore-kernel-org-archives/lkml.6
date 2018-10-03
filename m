Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B5EC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6D72089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gF6GVm6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B6D72089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeJCWIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:08:41 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:37565 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJCWIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:08:41 -0400
Received: by mail-wr1-f51.google.com with SMTP id u12-v6so6570660wrr.4;
        Wed, 03 Oct 2018 08:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=azXK8WBLvDrbPv69PUwTGJdDYAr2nqqlpnKbIFqwkIo=;
        b=gF6GVm6PuL8cc5zlUHDWcffskx+MhxwoLkawvmkPSDyq0kjCpYtdbHqmtxg2WBx30v
         bDSjER5ljduVYqQAj8gs04pk6LGkyvkEBGyTheWjk87vQ2739TzKTEyl7PQFyUmcSoag
         YI763kJzr45C6gpyBTnT0BYpTQhbb0VN5nGtgxKjOGssWMyjkqZl/OfhrecwyQ9O+Z3d
         0PNZQyOCwqAAUniRbbDrFfwbzOZS/G37dhKpb/3DVi7MJfRhacvcphVCq4IUXcJSSPm8
         1uWxsNNJwdCaW4znwhb2pO23aKgc0K724isrXdKh4FYk79cIHKdXq3i30AKijUIRgwV5
         qSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=azXK8WBLvDrbPv69PUwTGJdDYAr2nqqlpnKbIFqwkIo=;
        b=bYW+OykxPNC+7+BmqQ6pI+/+FHzbaogE/AQp8wBUGdG5BZd/bLK41OykPPok3WcVqe
         ZKfq2ot5Ug2GozCk+gMotZtyC19SqBOrPvKOSihhTfay1L1RuEvZZZisc7ya+r++WEFP
         mWAjssCT/zWZKLnvv00GLXvLa6XAcun+sAVBGDl6O0DnGSzIQlHwa+avZR1iANDMJQfD
         EG8wk5KjnfI14qAEZaExdWYrbAfekvrWCCCP/aLY+h4yUnLRYO5pD4DtCDAFEyh/a8tv
         syUUjGaWfX2T2/j6Qm+qBhbqMBAF437Q4iNR759eP6aJ2jLn1TjIP1r21Hz4sb0uGwDH
         8RIg==
X-Gm-Message-State: ABuFfohKo02bzggm0rDsyLFYCWUhqtzbtZo/mBsXlDh5oemcBzFKQDDW
        HQn7TvBdavrf/gucEgRBm6HHP23O
X-Google-Smtp-Source: ACcGV63igcNXq6vU4kl1gwL7Obg/vNMQZlmDCwbehvnBPi5YAmAaxIjs1jGRsuy2dg5iyJtAvEe3wg==
X-Received: by 2002:adf:fa92:: with SMTP id h18-v6mr1706342wrr.74.1538579988964;
        Wed, 03 Oct 2018 08:19:48 -0700 (PDT)
Received: from pc-ceresoli.dev.aim (45.11.168.109.cust.ip.kpnqwest.it. [109.168.11.45])
        by smtp.gmail.com with ESMTPSA id l140-v6sm3354635wmb.24.2018.10.03.08.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 08:19:47 -0700 (PDT)
From:   Luca Ceresoli <lucaceresoli77@gmail.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>
Subject: [PATCH v3] i2c: mux: remove duplicated i2c_algorithm
Date:   Wed,  3 Oct 2018 17:19:28 +0200
Message-Id: <20181003151928.17713-1-lucaceresoli77@gmail.com>
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

Cc: Peter Rosin <peda@axentia.se>
Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changes v2 -> v3:
 - fix coding style of comment when moving it (Peter Rosin)
 - move the 'algo' member between parent and dev (Peter Rosin)

Changes v1 -> v2:
 - include i2c.h (fixes build failure on i2c-mux-ltc4306)
---
 drivers/i2c/i2c-mux.c   | 38 +++++++++++++++++++-------------------
 include/linux/i2c-mux.h |  2 ++
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index f330690b4125..6ac23004fb2a 100644
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
@@ -263,6 +262,24 @@ struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
 	muxc->deselect = deselect;
 	muxc->max_adapters = max_adapters;
 
+	/*
+	 * Need to do algo dynamically because we don't know ahead of
+	 * time what sort of physical adapter we'll be dealing with.
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
@@ -301,28 +318,11 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
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
index bd74d5706f3b..3d89600d5a9e 100644
--- a/include/linux/i2c-mux.h
+++ b/include/linux/i2c-mux.h
@@ -28,9 +28,11 @@
 #ifdef __KERNEL__
 
 #include <linux/bitops.h>
+#include <linux/i2c.h>
 
 struct i2c_mux_core {
 	struct i2c_adapter *parent;
+	struct i2c_algorithm algo;
 	struct device *dev;
 	unsigned int mux_locked:1;
 	unsigned int arbitrator:1;
-- 
2.17.1

