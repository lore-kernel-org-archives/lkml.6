Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835A5C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7F8206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ExExrwmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7F8206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeI2FDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:03:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37357 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbeI2FDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:03:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id x26-v6so5220583pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 15:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=6QwN1P8EAUZCSU+bo8Aw9X5suKAB9OtOSU/Qjceoo9g=;
        b=ExExrwmUJH3oYJK0mdvnQ700Pe/dK+mYmZehiJBmyG7xLSoiXUJHJWNoJZccIbBXdq
         dulLQz7iIWBWasaYAQesfNgpcNG85mB+FWYyMFuKZzxDdw/I4hGmcVUxoA9byKd0tS9V
         Cdkq7v2TogXGR+AOpyEtggAabJOIuAxZNJ7po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6QwN1P8EAUZCSU+bo8Aw9X5suKAB9OtOSU/Qjceoo9g=;
        b=Jqr+FRkFDvIwQvwx/u19LIaWWmYzOUOOwMZ94tP/7b9ZhvkYJQ9uiOWaurbrd8oyFy
         SZH2ib/0AsGV3VijNUXd4jcQTwCfwXt5WgnsYg/CjuQCFgUkmmJmp7wM40Fq8MpJJe/O
         ++mRRGyWJEBHTdOht1XxmJosoVAAPZmcBZeS4kcs2MyByRT09mifbAEnBsnTnRX+aTO7
         CHfODuKmFqP1DLoZyZUh1IkjGSaV2PdpclttZacCxTo77IfZZz7GJ3w/lrMrW2YEz8IU
         VO1jd6N8rKDHbT9jvqvZ+ZgjRe7KjZN83LNC5pRhuorINwJF9jgXUpYQQ5c2al1Id1i/
         kK2Q==
X-Gm-Message-State: ABuFfohzNiffejdtniWOowgTue/pZBGR5bvaUFJ0fpV7C+1UrcxRFTM2
        zI58D3uKlsFv2KMFpOnS7W+jyw==
X-Google-Smtp-Source: ACcGV62uIdIaMXc9iK+E7YUDiiaOfzfYtYynvoJGw2vR3x4F1aPMJyHVf55tGp+qJZ0E3xmUb5ZbCw==
X-Received: by 2002:a63:5c5d:: with SMTP id n29-v6mr560407pgm.253.1538174258021;
        Fri, 28 Sep 2018 15:37:38 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h19-v6sm13777897pfk.71.2018.09.28.15.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 15:37:36 -0700 (PDT)
Date:   Fri, 28 Sep 2018 15:37:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     nixiaoming <nixiaoming@huawei.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Joel Fernandes <joelaf@google.com>,
        Geliang Tang <geliangtang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] pstore/ram: Fix failure-path memory leak in ramoops_init
Message-ID: <20180928223736.GA39915@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by nixiaoming, with some minor clarifications:

1) memory leak in ramoops_register_dummy():
   dummy_data = kzalloc(sizeof(*dummy_data), GFP_KERNEL);
   but no kfree() if platform_device_register_data() fails.

2) memory leak in ramoops_init():
   Missing platform_device_unregister(dummy) and kfree(dummy_data)
   if platform_driver_register(&ramoops_driver) fails.

I've clarified the purpose of ramoops_register_dummy(), and added a
common cleanup routine for all three failure paths to call.

Reported-by: nixiaoming <nixiaoming@huawei.com>
Cc: stable@vger.kernel.org
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Colin Cross <ccross@android.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
After my local testing I'll send this via the regular pstore tree.
---
 fs/pstore/ram.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index bbd1e357c23d..f4fd2e72add4 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -898,8 +898,22 @@ static struct platform_driver ramoops_driver = {
 	},
 };
 
-static void ramoops_register_dummy(void)
+static inline void ramoops_unregister_dummy(void)
 {
+	platform_device_unregister(dummy);
+	dummy = NULL;
+
+	kfree(dummy_data);
+	dummy_data = NULL;
+}
+
+static void __init ramoops_register_dummy(void)
+{
+	/*
+	 * Prepare a dummy platform data structure to carry the module
+	 * parameters. If mem_size isn't set, then there are no module
+	 * parameters, and we can skip this.
+	 */
 	if (!mem_size)
 		return;
 
@@ -932,21 +946,28 @@ static void ramoops_register_dummy(void)
 	if (IS_ERR(dummy)) {
 		pr_info("could not create platform device: %ld\n",
 			PTR_ERR(dummy));
+		dummy = NULL;
+		ramoops_unregister_dummy();
 	}
 }
 
 static int __init ramoops_init(void)
 {
+	int ret;
+
 	ramoops_register_dummy();
-	return platform_driver_register(&ramoops_driver);
+	ret = platform_driver_register(&ramoops_driver);
+	if (ret != 0)
+		ramoops_unregister_dummy();
+
+	return ret;
 }
 late_initcall(ramoops_init);
 
 static void __exit ramoops_exit(void)
 {
 	platform_driver_unregister(&ramoops_driver);
-	platform_device_unregister(dummy);
-	kfree(dummy_data);
+	ramoops_unregister_dummy();
 }
 module_exit(ramoops_exit);
 
-- 
2.17.1


-- 
Kees Cook
Pixel Security
