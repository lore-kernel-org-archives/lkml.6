Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0137BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B712E20652
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B712E20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbeH3ACG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:02:06 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42659 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbeH3ACG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:02:06 -0400
Received: by mail-oi0-f65.google.com with SMTP id k81-v6so5279515oib.9;
        Wed, 29 Aug 2018 13:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jt/i35Yq2dS6q3X2LXQAODCxkJRBBRyHrJUa8VUL1ew=;
        b=e/Wdrap0VURI3R5V5XjMfotvhjiCzLA0gsYvBfnZyZblEWCLTeFcabaf+gfa7Jsv6P
         2zcFS9M20c4dalX4geF9hWwMwKMPGifIvnwL1IdPrxe3ugYwXi8hXwlznBbMPTBC1MNs
         dveKmoPR5uvmSGUAh7xHykde6h8heuhysqsWKRK9AHVhxrBdXiPyBlP8ikjT+sa0Czvi
         OMT6H+HqR4YuT3DVWxjeQauprTZJ/7cbhJLRYtEt695EC0wuMBPMjQT93j3j2z6F6jTP
         ynHbYrayqpBDgLHxyF46/geLsPJQLHSWiXd6Q5PbfjYo8m53PY5/jvYOBCdZ2z13Lk13
         qT9Q==
X-Gm-Message-State: APzg51BW0QsIgsPF8QdRORv/jNvF+KI+tG7JHZ2OUhBMfQRf+JQgCCwo
        xx2itUgs/n3oZnS2jO/KhBnagHQ=
X-Google-Smtp-Source: ANB0VdaLtIqElrtBqKhfru4Br+Y3iVobq1BJ0vroW1lvvGz43gXaRB9yAIbxNB8UhbeQBcB0Z6IvKA==
X-Received: by 2002:aca:4e50:: with SMTP id c77-v6mr4021291oib.254.1535573018233;
        Wed, 29 Aug 2018 13:03:38 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm8695994oig.48.2018.08.29.13.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:03:37 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH] sbus: Use of_get_child_by_name helper
Date:   Wed, 29 Aug 2018 15:03:37 -0500
Message-Id: <20180829200337.15352-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the of_get_child_by_name() helper instead of open coding searching
for the '/options' node. This removes directly accessing the name
pointer as well.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/sbus/char/openprom.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/sbus/char/openprom.c b/drivers/sbus/char/openprom.c
index 7b31f19ade83..050879a2ddef 100644
--- a/drivers/sbus/char/openprom.c
+++ b/drivers/sbus/char/openprom.c
@@ -715,22 +715,13 @@ static struct miscdevice openprom_dev = {
 
 static int __init openprom_init(void)
 {
-	struct device_node *dp;
 	int err;
 
 	err = misc_register(&openprom_dev);
 	if (err)
 		return err;
 
-	dp = of_find_node_by_path("/");
-	dp = dp->child;
-	while (dp) {
-		if (!strcmp(dp->name, "options"))
-			break;
-		dp = dp->sibling;
-	}
-	options_node = dp;
-
+	options_node = of_get_child_by_name(of_find_node_by_path("/"), "options");
 	if (!options_node) {
 		misc_deregister(&openprom_dev);
 		return -EIO;
-- 
2.17.1

