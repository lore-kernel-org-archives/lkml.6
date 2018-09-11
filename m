Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD9AC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8FF2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8FF2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeIKWob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:44:31 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33387 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbeIKWob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:44:31 -0400
Received: by mail-qk1-f195.google.com with SMTP id z78-v6so17313662qka.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 10:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xRIEVH4la4u2DmG4dm9X5bSHpkLA+BrFW+4ziQO1LTQ=;
        b=o4P9IENDBE9vwTqtd5XO/QI4F8vgtIQ3Eq+JC0HWsXuuIDsCYQe1BlU1eGeuxOl9pj
         uiXxfoAAJ9xqRY9KSiA83IoPPUyXYVXf8jIbX0VQIYFtqCM5SYGxkImd0Ek/rfvsc3on
         T7ux+XPPMd2OGuubnvkLB2cS9zG+ivIKN7lHe5xk6NMNBHp/nPxT9dpNxK4JwX0HMxJS
         7aBOUkakRhtoqgH+0XNuxvlZ4qLRPTv5JRz3ya1Yxj6nQgGAlLKEuCAQgvcutvpLxW2k
         gX6tCEa1TbQVkBRv4D6ATOzAXQFOz7pBXnvYSDcI/zffTCWrUc9sLzz7k3OCV7t84wa3
         CCTQ==
X-Gm-Message-State: APzg51BD/DWcD2Gtx9kS9q3a42OYXuTOOBT7otcDvjunXDwgJyc0oi71
        zO835rjYMrbzZoxHLBEQhRUZWg==
X-Google-Smtp-Source: ANB0VdZrEeFr+DJ7edyNXK3V8FzKCzkt+w/758f9Fc4egsM3FUXRaRsgQqrcrBVuBG5wR4llZae2FA==
X-Received: by 2002:ae9:dc43:: with SMTP id q64-v6mr20140113qkf.62.1536687848406;
        Tue, 11 Sep 2018 10:44:08 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::42c3])
        by smtp.gmail.com with ESMTPSA id b3-v6sm13288306qtb.80.2018.09.11.10.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 10:44:07 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Laura Abbott <labbott@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCHv2] misc: kgdbts: Fix restrict error
Date:   Tue, 11 Sep 2018 10:44:03 -0700
Message-Id: <20180911174403.32088-1-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kgdbts current fails when compiled with restrict:

drivers/misc/kgdbts.c: In function ‘configure_kgdbts’:
drivers/misc/kgdbts.c:1070:2: error: ‘strcpy’ source argument is the same as destination [-Werror=restrict]
  strcpy(config, opt);
  ^~~~~~~~~~~~~~~~~~~

As the error says, config is being used in both the source and destination.
Refactor the code to avoid the extra copy and put the parsing closer to
the actual location.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: Refactored to move the verbose setting into kgbts_run_tests per
suggestion of Daniel Thompson
---
 drivers/misc/kgdbts.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
index 6193270e7b3d..de20bdaa148d 100644
--- a/drivers/misc/kgdbts.c
+++ b/drivers/misc/kgdbts.c
@@ -985,6 +985,12 @@ static void kgdbts_run_tests(void)
 	int nmi_sleep = 0;
 	int i;
 
+	verbose = 0;
+	if (strstr(config, "V1"))
+		verbose = 1;
+	if (strstr(config, "V2"))
+		verbose = 2;
+
 	ptr = strchr(config, 'F');
 	if (ptr)
 		fork_test = simple_strtol(ptr + 1, NULL, 10);
@@ -1068,13 +1074,6 @@ static int kgdbts_option_setup(char *opt)
 		return -ENOSPC;
 	}
 	strcpy(config, opt);
-
-	verbose = 0;
-	if (strstr(config, "V1"))
-		verbose = 1;
-	if (strstr(config, "V2"))
-		verbose = 2;
-
 	return 0;
 }
 
@@ -1086,9 +1085,6 @@ static int configure_kgdbts(void)
 
 	if (!strlen(config) || isspace(config[0]))
 		goto noconfig;
-	err = kgdbts_option_setup(config);
-	if (err)
-		goto noconfig;
 
 	final_ack = 0;
 	run_plant_and_detach_test(1);
-- 
2.17.1

