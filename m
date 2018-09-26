Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804A8C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0FA2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F+f/LTpn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0FA2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbeIZJgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 05:36:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43147 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeIZJgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 05:36:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id j26-v6so12615424pfi.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 20:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zZBmsP5oO4UuC2hC+KXG/IKvs6WIY2otf7jRBtBAZ8E=;
        b=F+f/LTpnl8QT+P8uhnkPgBWN+k8ow+V1na64InfTfzwNsPLkO+QEracGOvwAtY7/jU
         2l1p7u+CvRlBZEkxbeqtpZehWJR4AeHWugZoaKiDfNiNrecOATfAyRR/AC9DT4iuwAA2
         n6vHKwhUZFvhSLtSswmCUw/cQ3Tpv4J9toHgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zZBmsP5oO4UuC2hC+KXG/IKvs6WIY2otf7jRBtBAZ8E=;
        b=tAvOroxse7eoBo70AvfhwLEpeJwAF+7rEP2+2prUMRbeQwK75ENqSsGJFlFjDl9R28
         tnX6+AIeNXWp/lrfBHzqS64Z1rg2Cb/0/pvo0YPK4eptkQUVE45YV9t19538OgWtbmLT
         B1JdkqixIALNF0VDZ/RGDH2bjzQ5tKqojXp4T6ZmQXLeBdEHvWjtT3HRucfMp+XahVcN
         7J31VPgZsWcLVZGw4QoPLtq1WdA9aGLvzxbXtvQ3NvQPLlwpR6hFAxvFswmUsm+v8jjY
         Hk+rT6N1Xvlp32003SAH1SBQtV+tEc0Wuj643CA3lCenj+zVzxQRYD91x+9uRY1i66Na
         DetA==
X-Gm-Message-State: ABuFfohzQCzmg9GqAoeqVNPTAjfNzreCk+df8bP4om4H8JRaMumTxh8S
        3M/yX6cV5cnKw14JEyctOujFamrgmYc=
X-Google-Smtp-Source: ACcGV63yguLyqlvnt4KY2vRi+GlIOk1AqjNXeqp3n03YDL4UrNAGYMVrC62bXcQpHVgBYU7h7W7PzA==
X-Received: by 2002:a62:5343:: with SMTP id h64-v6mr4041255pfb.226.1537932318541;
        Tue, 25 Sep 2018 20:25:18 -0700 (PDT)
Received: from excession.tpe.corp.google.com ([2401:fa00:1:10:199d:5882:860a:4adb])
        by smtp.gmail.com with ESMTPSA id c80-v6sm4262620pfc.109.2018.09.25.20.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Sep 2018 20:25:17 -0700 (PDT)
From:   Louis Collard <louiscollard@chromium.org>
To:     linux-integrity@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        apronin@chromium.org, Jason Gunthorpe <jgg@ziepe.ca>,
        david.bild@xaptum.com
Subject: [PATCH] Allow hwrng to initialize crng.
Date:   Wed, 26 Sep 2018 11:24:55 +0800
Message-Id: <20180926032455.224600-1-louiscollard@chromium.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some systems, for example embedded systems, do not generate
enough entropy on boot through interrupts, and boot may be blocked for
several minutes waiting for a call to getrandom to complete.

Currently, random data is read from a hwrng when it is registered,
and is loaded into primary_crng. This data is treated in the same
way as data that is device-specific but otherwise unchanging, and
so primary_crng cannot become initialized with the data from the
hwrng.

This change causes the data initially read from the hwrng to be
treated the same as subsequent data that is read from the hwrng if
it's quality score is non-zero.

The implications of this are:

The data read from hwrng can cause primary_crng to become
initialized, therefore avoiding problems of getrandom blocking
on boot.

Calls to getrandom (with GRND_RANDOM) may be using entropy
exclusively (or in practise, almost exclusively) from the hwrng.

Regarding the latter point; this behavior is the same as if a
user specified a quality score of 1 (bit of entropy per 1024 bits)
so hopefully this is not too scary a change to make.

This change is the result of the discussion here:
https://patchwork.kernel.org/patch/10453893/

Signed-off-by: Louis Collard <louiscollard@chromium.org>
---
 drivers/char/hw_random/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index aaf9e5afaad4..47f358aa0c3d 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -24,6 +24,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <crypto/chacha20.h>
 
 #define RNG_MODULE_NAME		"hw_random"
 
@@ -64,13 +65,17 @@ static size_t rng_buffer_size(void)
 static void add_early_randomness(struct hwrng *rng)
 {
 	int bytes_read;
-	size_t size = min_t(size_t, 16, rng_buffer_size());
+	/* Read enough to initialize crng. */
+	size_t size = 2*CHACHA20_KEY_SIZE;
 
 	mutex_lock(&reading_mutex);
 	bytes_read = rng_get_data(rng, rng_buffer, size, 1);
 	mutex_unlock(&reading_mutex);
 	if (bytes_read > 0)
-		add_device_randomness(rng_buffer, bytes_read);
+		/* Allow crng to become initialized, but do not add
+		 * entropy to the pool.
+		 */
+		add_hwgenerator_randomness(rng_buffer, bytes_read, 0);
 }
 
 static inline void cleanup_rng(struct kref *kref)
-- 
2.13.5

