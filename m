Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B24C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDC020672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D5+Xz1G/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEDC020672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeLMJS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:18:56 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37570 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeLMJS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:18:56 -0500
Received: by mail-pg1-f195.google.com with SMTP id 80so775976pge.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 01:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LNSa3KiH1ZL0pwlhIbt5LEsdkwR+MuAQ2Tqqh2Nb6jk=;
        b=D5+Xz1G/TtOhctI8i9iw6O01K4ZlYJYuxze9D25tctDp6gDiz4p5U3EUp2IOTXFYtP
         IUISvHL1n1L4bmE5RQa2qb1rp1exwRt2CZendLiY5luv9aRL6z76zwtHWlEzybY0iAy1
         qH3v96jyaE4Hex9kCfyItkkpYcslnvQs+Hbgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LNSa3KiH1ZL0pwlhIbt5LEsdkwR+MuAQ2Tqqh2Nb6jk=;
        b=pSP0ppbI6vm1XGlil6oxCOD0MRJV8S++ohk+YHNxQDv8KEEb/c5tU7GgXDvIat2zX7
         OJ75sQlDzQ1aCh32YSyi6sWBtgTKmzOXEg3c48kDvLOMCJJNlJU+y07icBxI5VD67HHl
         +REigRY43gNfbggTuN6v+K798S7UfHwuxs1SbVFXNn1qbimSawurbWdTcObZmvxxD9bY
         tUW0i3/DhH00WPvy64M0Fcxl8XRuZKd+W6FMJ34RuF9HQ3QGc00E8hHARdCtJPO5sCz8
         cgpRjUvghQsaqFC0NDx7iRjkWuccqD8JBgXDUuQbgZZQ5vRDT+L2T79SfpbHw3mKVucA
         J1+g==
X-Gm-Message-State: AA+aEWYQpU3CiHJazn+n1LiBTqF2r/iit7QeVxWBV6qcGFtlZK3WNdQI
        Qnii2zHQQCU0Hay8UAGf66hHaW4heiY=
X-Google-Smtp-Source: AFSGD/UgQH8CE4cQUvodDmvdUeuwX5jkIJhN51sFqvSwCBUcqpXlCMDKMCuOdZABX9YM3Jf5haAlHA==
X-Received: by 2002:a63:9749:: with SMTP id d9mr18209125pgo.415.1544692734840;
        Thu, 13 Dec 2018 01:18:54 -0800 (PST)
Received: from excession.tpe.corp.google.com ([2401:fa00:1:10:b167:8a11:31b5:8daa])
        by smtp.gmail.com with ESMTPSA id i123sm2683186pfg.164.2018.12.13.01.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 01:18:54 -0800 (PST)
From:   Louis Collard <louiscollard@chromium.org>
To:     linux-crypto@vger.kernel.org
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gary R Hook <gary.hook@amd.com>, Michael Buesch <m@bues.ch>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Louis Collard <louiscollard@chromium.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, apronin@chromium.org,
        jarkko.sakkinen@linux.intel.com, linux@mniewoehner.de,
        david.bild@xaptum.com, tytso@mit.edu
Subject: [PATCH v2] Allow hwrng to initialize crng.
Date:   Thu, 13 Dec 2018 17:18:48 +0800
Message-Id: <20181213091848.81327-1-louiscollard@chromium.org>
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
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/hw_random/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 95be7228f327..7736e1a96321 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -24,6 +24,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <crypto/chacha20.h>
 
 #define RNG_MODULE_NAME		"hw_random"
 
@@ -64,13 +65,19 @@ static size_t rng_buffer_size(void)
 static void add_early_randomness(struct hwrng *rng)
 {
 	int bytes_read;
-	size_t size = min_t(size_t, 16, rng_buffer_size());
+	/* Read enough to initialize crng. */
+	size_t size = min_t(size_t,
+			    2*CHACHA20_KEY_SIZE,
+			    rng_buffer_size());
 
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

