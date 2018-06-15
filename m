Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 80FB6C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410BF208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410BF208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965698AbeFONUX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:20:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:16380 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936144AbeFONUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:20:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 06:20:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,227,1526367600"; 
   d="scan'208";a="47355779"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jun 2018 06:20:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6FB1F477; Fri, 15 Jun 2018 16:20:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 4/5] Input: gpio-keys - Switch to bitmap_zalloc()
Date:   Fri, 15 Jun 2018 16:20:16 +0300
Message-Id: <20180615132017.23889-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615132017.23889-1-andriy.shevchenko@linux.intel.com>
References: <20180615132017.23889-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to bitmap_zalloc() to show clearly what we are allocating.
Besides that it returns pointer of bitmap type instead of opaque void *.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/input/keyboard/gpio_keys.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 052e37675086..492a971b95b5 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -196,7 +196,7 @@ static ssize_t gpio_keys_attr_show_helper(struct gpio_keys_drvdata *ddata,
 	ssize_t ret;
 	int i;
 
-	bits = kcalloc(BITS_TO_LONGS(n_events), sizeof(*bits), GFP_KERNEL);
+	bits = bitmap_zalloc(n_events, GFP_KERNEL);
 	if (!bits)
 		return -ENOMEM;
 
@@ -216,7 +216,7 @@ static ssize_t gpio_keys_attr_show_helper(struct gpio_keys_drvdata *ddata,
 	buf[ret++] = '\n';
 	buf[ret] = '\0';
 
-	kfree(bits);
+	bitmap_free(bits);
 
 	return ret;
 }
@@ -240,7 +240,7 @@ static ssize_t gpio_keys_attr_store_helper(struct gpio_keys_drvdata *ddata,
 	ssize_t error;
 	int i;
 
-	bits = kcalloc(BITS_TO_LONGS(n_events), sizeof(*bits), GFP_KERNEL);
+	bits = bitmap_zalloc(n_events, GFP_KERNEL);
 	if (!bits)
 		return -ENOMEM;
 
@@ -284,7 +284,7 @@ static ssize_t gpio_keys_attr_store_helper(struct gpio_keys_drvdata *ddata,
 	mutex_unlock(&ddata->disable_lock);
 
 out:
-	kfree(bits);
+	bitmap_free(bits);
 	return error;
 }
 
-- 
2.17.1

