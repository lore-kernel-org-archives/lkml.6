Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC8DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC4A20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P0cMxS1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC4A20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731860AbeG0AOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 20:14:09 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45758 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731729AbeG0AOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 20:14:09 -0400
Received: by mail-pl0-f68.google.com with SMTP id j8-v6so1437755pll.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 15:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B+ViF1JjYMbTF6gXyeRxJ3LRFCPpPvWE0v13usRTUV0=;
        b=P0cMxS1OsT+cK7uW3MW08b5ER/NocR6nhJIR60ZIhlDAhtOvKbl/Z1nvQEQtS6HxdI
         bR5bTI5MWu0Pwrz44p0KxPsjL919Jfuh+BHOC6BcpLegswcN/pR/7cEcrxLeybXF+6z4
         tE7TZvZJX8A17ZrRPCAdF5nYF067fCIyAG3ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B+ViF1JjYMbTF6gXyeRxJ3LRFCPpPvWE0v13usRTUV0=;
        b=KoomY8t518AcyR+J3ACPqKQJJRKIZ454hd2e7NDRGntsA9MQ34uPD0BkuR9i1DPHH2
         ccgl9YJelxZmbMOGF9JoTPhXBgNs8TEuCiKpj07FTC3ircSZO4mXqqNur1/gKO4+iKyf
         qGOupB4pdUdNXrqRxrpQ/BEAKZipMpOC+B88fxVkV36uiW6UbK7iOG6QAGy6T2wv0sQA
         LbJwvyXw880HkUgJ7dLLEwavmlN9uVzd1A3QwLan9T33opd+pVt0nmXF2y3T4dQNz5sL
         iXZep9dbyelNxVIZiks98LjcS/IJxx30DYYOEMOR4ywABg2UOxDRMfO6xhVjFe9VgxiY
         GQuA==
X-Gm-Message-State: AOUpUlF2aRC32PXz4AhkATtEc6HHTbcb6x9P4qE9ZVKpKG4LYK6iPx94
        kGJFgUlorsUJszf6rAbkefnNQ9aXt7g=
X-Google-Smtp-Source: AAOMgpd7qRZnlzzRNFENMXj2vt1KJLwjSJjWncUL8CgXpI1arIGpm1len+CoL+5CSEFBUffmJ7KlZw==
X-Received: by 2002:a17:902:760b:: with SMTP id k11-v6mr3615951pll.91.1532645713196;
        Thu, 26 Jul 2018 15:55:13 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:0:1000:1501:f407:8d12:c205:7153])
        by smtp.gmail.com with ESMTPSA id 84-v6sm8015348pfj.33.2018.07.26.15.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 15:55:12 -0700 (PDT)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        dianders@chromium.org, dtor@chromium.org,
        venkateswarlu.v.vinjamuri@intel.corp-partner.google.com,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH] i2c: enable async suspend/resume on i2c devices
Date:   Thu, 26 Jul 2018 15:55:08 -0700
Message-Id: <20180726225508.74612-1-dbasehore@chromium.org>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables the async suspend property for i2c devices. This reduces
the suspend/resume time considerably on platforms with multiple i2c
devices (such as a trackpad or touchscreen).

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/i2c/i2c-core-base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 1ba40bb2b966..3382bb7e1dcc 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -749,6 +749,7 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	client->dev.of_node = info->of_node;
 	client->dev.fwnode = info->fwnode;
 
+	device_enable_async_suspend(&client->dev);
 	i2c_dev_set_name(adap, client, info);
 
 	if (info->properties) {
-- 
2.18.0.345.g5c9ce644c3-goog

