Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EC7C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE5B20645
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TFs2sKBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE5B20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbeLMIkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:40:35 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44179 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbeLMIkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 03:40:35 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so708982pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 00:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=m3cLeHLRBiju9/BiIuYZUnRWafttwm6OywruYFw+J70=;
        b=TFs2sKBA7/Qow4XJfz9tHh5W17kHTFTTrLQmunFeH1/pOFVsHudSVVBKND94q29UAx
         lojB9X4v3q5P9oPcgHEo2Aolwu9fsX4w5ALiua0LlAoBW2N90KHTA1DGL2clHHG2GCAW
         7V2V7IiQzdHH+pjya1P6yMo/PfH4aJKBIwKkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m3cLeHLRBiju9/BiIuYZUnRWafttwm6OywruYFw+J70=;
        b=cWwcTHBvtfPj52w31W8KTtBtYlp09diIWSJiyZAFkK13pXyacpZk59cH+wP3rKsowJ
         ODTTc4+7O+2dB5x1WY6TdrdjrNgn+1e7s8U/Ahzm7YZAYPlfdDg9w05o5Lwj8jQHo4zJ
         nBQFkXQ8VjLkXrWOLCcxzJWVrOOBdWQH9vqdEaV9VwKzXasUccEKgfsAjOZNsOeb4qTz
         M9UcJJYz5i4p7aLdSFyIKonfQHyhoZHGzbx2ZY9G8EEVtpgXhj8WD/AWxR9iEKMz0tp6
         PlNRqhHFQbFEnuZfd9WmNVGAgfr5JCog5ioiMpQq4msj30tQaMeQ6CE19h+L2NOAZJQZ
         0mbg==
X-Gm-Message-State: AA+aEWaGO3L5UZoGsPjS9o4GBShFC3JjCACL6MVPwRkITKbYN6gqyYHO
        gz5vsmTLAUVbGC3m61UGiG++DA==
X-Google-Smtp-Source: AFSGD/UTbVg/iVrhybaQp/mDcbU+BdkBS3ztNJ/iSRElDfMooWONLkAT/5CqZA5Ay3jfRM5KVcR0+Q==
X-Received: by 2002:a63:2f86:: with SMTP id v128mr20326933pgv.407.1544690434284;
        Thu, 13 Dec 2018 00:40:34 -0800 (PST)
Received: from excession.tpe.corp.google.com ([2401:fa00:1:10:b167:8a11:31b5:8daa])
        by smtp.gmail.com with ESMTPSA id d202sm2047340pfd.58.2018.12.13.00.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 00:40:33 -0800 (PST)
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
        david.bild@xaptum.com
Subject: [RESEND PATCH] Allow hwrng to initialize crng.
Date:   Thu, 13 Dec 2018 16:40:17 +0800
Message-Id: <20181213084017.80850-1-louiscollard@chromium.org>
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
 drivers/char/hw_random/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 95be7228f327..99c3e4127949 100644
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

