Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50574C43143
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED66520839
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED66520839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbeIKEBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 00:01:21 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46007 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeIKEBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 00:01:21 -0400
Received: by mail-qk1-f193.google.com with SMTP id z125-v6so15571919qkb.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 16:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lG4a74foRPg/cJ4nTIXdpwEt8H603V+g/flSIfe1ZW8=;
        b=Au34caarrbUlMC/e/dLapOzeoUYWeh8eBZUlWrDuTfTGcOKGtGM3XiMytQGJWYrpdx
         3VQN9RRGiyzVxKd6W4J/uWpHKHUMxTIZVKvDKmgVdOMSwCl44sDNGHMjj/e/1qgk/3AL
         Bi1VNr2NidrE6CpsUJMS/kJ7yW437Mv0BO2Kv3mwZ7ul/MP0Cv/cY1eccHQDDLyMsBS1
         Q1A1bGroBvrQNA5jneLFfuLB4rJ/tum8aUdX9ulo6JAUj51Rqy/VTlE14VNcoSiJSi44
         wxlck02gViqSG0WF1AxapWfGa3qNuk1TSL1cDo3kjKECiMW5802qzd3SlDAMiCM5fXYs
         eDWg==
X-Gm-Message-State: APzg51D9eSzjhp01uc+9KvzauHMG8A1o8zj88mnGTkAxWUXm8DH2Xgi4
        iiD9uyCPLRnBBMop5rma2yynYg==
X-Google-Smtp-Source: ANB0VdZesbzN+OPrAzibOBmjk+MCGrCMXLxauoytAlp2I+/mCCv4upHoAfZ+DfGMTp31A4HK0K8Vng==
X-Received: by 2002:a37:3309:: with SMTP id z9-v6mr16741371qkz.172.1536620702780;
        Mon, 10 Sep 2018 16:05:02 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::42c3])
        by smtp.gmail.com with ESMTPSA id t36-v6sm10921006qtc.45.2018.09.10.16.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 16:05:01 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Laura Abbott <labbott@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: kgdbts: Fix restrict error
Date:   Mon, 10 Sep 2018 16:04:56 -0700
Message-Id: <20180910230456.9220-1-labbott@redhat.com>
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
Refactor the code to only do the copy when needed.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/misc/kgdbts.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
index 6193270e7b3d..4447ad68ea39 100644
--- a/drivers/misc/kgdbts.c
+++ b/drivers/misc/kgdbts.c
@@ -1061,20 +1061,23 @@ static void kgdbts_run_tests(void)
 	configured = 0;
 }
 
-static int kgdbts_option_setup(char *opt)
+static void kgdbts_set_verbose(void)
 {
-	if (strlen(opt) >= MAX_CONFIG_LEN) {
-		printk(KERN_ERR "kgdbts: config string too long\n");
-		return -ENOSPC;
-	}
-	strcpy(config, opt);
-
 	verbose = 0;
 	if (strstr(config, "V1"))
 		verbose = 1;
 	if (strstr(config, "V2"))
 		verbose = 2;
+}
 
+static int kgdbts_option_setup(char *opt)
+{
+	if (strlen(opt) >= MAX_CONFIG_LEN) {
+		printk(KERN_ERR "kgdbts: config string too long\n");
+		return -ENOSPC;
+	}
+	strcpy(config, opt);
+	kgdbts_set_verbose();
 	return 0;
 }
 
@@ -1086,9 +1089,7 @@ static int configure_kgdbts(void)
 
 	if (!strlen(config) || isspace(config[0]))
 		goto noconfig;
-	err = kgdbts_option_setup(config);
-	if (err)
-		goto noconfig;
+	kgdbts_set_verbose();
 
 	final_ack = 0;
 	run_plant_and_detach_test(1);
-- 
2.17.1

