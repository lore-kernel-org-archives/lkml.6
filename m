Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A27C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D7620870
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sweptlaser-com.20150623.gappssmtp.com header.i=@sweptlaser-com.20150623.gappssmtp.com header.b="ffSkBNAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbfA3QPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:15:11 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33870 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731698AbfA3QPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:15:02 -0500
Received: by mail-it1-f194.google.com with SMTP id x124so5013itd.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 08:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sweptlaser-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=n87F7pJdSAtJ20hpmsYWm9ZL9IJl9q5DpuciH9mrZRU=;
        b=ffSkBNAzzIiEUJmsYX+I5tnojD3JHR82Kc1PkiH4ldQHewkA/E7BbKs2srQeYk92FS
         rHJquQ/YcD6pBLRfe1Or2/1SS4G5ttZk9QOdVlwAy8DKC80OCIbz4XNyKkGwWvcRGwO/
         UTCXNqAZyutfJqnurBHQp7WKh5ZdgBpkj66m6QDkOAGIKBW3/YBmYAj9Z8WiknF/25Je
         QZo14vAPqObZiykfDJ+qVkRzBp2cyHaGDwh2771MxGi1T7MkvzicjWz2Cde7fRrmJYsB
         KSJphr+kqfsmj4XUTXbYAK5K1Rs6uPd567owpo+kw1hQoqhP181UiWSzWakTnyvLOWMR
         C1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=n87F7pJdSAtJ20hpmsYWm9ZL9IJl9q5DpuciH9mrZRU=;
        b=VcJgVK+q4L87US6KM7picGGbErc2yZV5gVToFZupTU3TyQp6vz3WD/JUhCkkF4qo6r
         UIwegO9KU5PcBM4y6KBGK6VQrWoZuSSvwXWxBItgvrTXpbkpBsfcCd4uG0g/Nik7VODm
         ysCZZ+8BovcNOIIxm1Ti6S4TiE/vNuALsvDiK0MiI0C13WTBjghV1lrd/+ve6G/Ln9Xi
         BkS7i9nnwzK+eqV2Bo4mfUFpQCftXLj+UE2sYBsjoQHxEhHMHniYjzCYdhJ3354OzR2p
         gq8bvNOsapOxdSVwA4WrDIVtfN2hnl5/5GgCjE0szPH8amYBC9r5rCxvSO6BOK8Mt4cx
         Md3w==
X-Gm-Message-State: AJcUukdrA6XdbkKENhLx7CrPQVmeqNWeL/ZTFt6iNJa0q59cIwWtAr+a
        N60w0pRhWdy1DsrfuRKhfaMkkTyFUsU=
X-Google-Smtp-Source: ALg8bN4Df2QrWGqk+vY9br1bN78QbHHZPRfEdqF5QezwnZ1JVYbG7onJkyimZHh0HZ8fwTdRWdWoAQ==
X-Received: by 2002:a24:7fce:: with SMTP id r197mr15788297itc.4.1548864901826;
        Wed, 30 Jan 2019 08:15:01 -0800 (PST)
Received: from yngvi.hq.sweptlaser.com ([63.147.146.226])
        by smtp.googlemail.com with ESMTPSA id 15sm838678iog.59.2019.01.30.08.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 08:15:01 -0800 (PST)
From:   Jeremy Gebben <jgebben@sweptlaser.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH resend 2/3] hwmon: (lm85) Document the LM96000 as supported
Date:   Wed, 30 Jan 2019 09:14:46 -0700
Message-Id: <20190130161447.19946-2-jgebben@sweptlaser.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190130161447.19946-1-jgebben@sweptlaser.com>
References: <20190129212920.27921-1-jgebben@sweptlaser.com>
 <20190130161447.19946-1-jgebben@sweptlaser.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been supported as a generic lm85 for quite some time.

Signed-off-by: Jeremy Gebben <jgebben@sweptlaser.com>
---
 Documentation/hwmon/lm85 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/lm85 b/Documentation/hwmon/lm85
index 7c49feaa79d2..9f3a945d1b80 100644
--- a/Documentation/hwmon/lm85
+++ b/Documentation/hwmon/lm85
@@ -3,9 +3,13 @@ Kernel driver lm85
 
 Supported chips:
   * National Semiconductor LM85 (B and C versions)
-    Prefix: 'lm85'
+    Prefix: 'lm85b' or 'lm85c'
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
     Datasheet: http://www.national.com/pf/LM/LM85.html
+  * Texas Instruments LM96000
+    Prefix: 'lm85'
+    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+    Datasheet: http://www.ti.com/lit/ds/symlink/lm96000.pdf
   * Analog Devices ADM1027
     Prefix: 'adm1027'
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
-- 
2.17.1

