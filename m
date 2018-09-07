Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE377C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D5E2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XjIKEMq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D5E2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeIGWFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:05:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38240 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbeIGWFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:05:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id u11-v6so6881961plq.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F3EScKHq882HmXSXacc/H2P5d85KqjVc6VQWxTmcaqM=;
        b=XjIKEMq7MJDedGI6KTXvY7jaA/GtXddn+4QP/k1WPKX1eZb2QwTmV1pjiJPnB2WrqK
         oibPp4bXq5H0UFsStXyv2yPSzmYkRJ3UNeA9sEatS0/dzCKZRHJzaiQUvDt+1ddZKtkx
         eKUUWVZ6mKfI89iEWovb8Cr05qqKZmnN3PZ5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F3EScKHq882HmXSXacc/H2P5d85KqjVc6VQWxTmcaqM=;
        b=T2D/qUv8Jj6nbOAGW/aRiY4XlGCXvq+Kw52KAbmmGQkvePrRc+66X6CitW23Oqcafx
         UYbSVJydr6kuY+GpnPubIIJXk7eod134rKMpQ6XweL6PgG5nscVjNQDTV+7vYP6x4976
         sZxOPmMaiypRC3M0ncwd117oED/tRTiWbLuySArRFf9vMqv4vYmUMAO31IuCDjimKN+o
         YMP0L8Ayv9N5mfbdiyT76CJsbHKQN17qQxX+8Fqfnp6QjCOryEHmg8NHycxF5M7zoRDJ
         CA2ofMICv3wo3GgnAjc3lLQiK7qJZ7dhpokDLOqHS/bUmyW1iqehu+eN/SSBJeUkC0fw
         bgxw==
X-Gm-Message-State: APzg51AkuS3pzPO8MSkwDBhtCXXXS/LYYvchv4dJRFMmhrZvfTCcAgJW
        Pz7UyaAvlOlsvP9E7/8GY69xmw==
X-Google-Smtp-Source: ANB0VdZP80c28VlbBiynmCZZj//n0X2AwAdo8Ayt1i1Z49+laNR/37RK7uIGFzbqb9nww+nI/4etew==
X-Received: by 2002:a17:902:8e86:: with SMTP id bg6-v6mr9117767plb.108.1536341024871;
        Fri, 07 Sep 2018 10:23:44 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id q80-v6sm12908629pfd.15.2018.09.07.10.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 10:23:43 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Kalle Valo <kvalo@qca.qualcomm.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>,
        <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] ath10k: utilize random MAC address if none is provided
Date:   Fri,  7 Sep 2018 10:21:57 -0700
Message-Id: <20180907172157.203785-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 9d5804662ce1 ("ath10k: retrieve MAC address from system
firmware if provided"), we support pulling our MAC address from system
firmware. Along with this, we should admit that it's possible for system
firmware to be screwed up as well, omitting the MAC address there.

Provide a fallback, such that we choose a randomly-generated MAC
address, with the local assignment bit set.

This is not a preferred mode of operation and really should only serve
the purpose of keeping the system chugging along while someone figures
out what's wrong with the system. Grepping through other wireless
drivers shows very similar fallback logic though, so why not?

  git grep eth_random_addr drivers/net/wireless/

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 97548f96a2f7..484f9c74ce46 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -8325,6 +8325,10 @@ int ath10k_mac_register(struct ath10k *ar)
 	void *channels;
 	int ret;
 
+	if (!is_valid_ether_addr(ar->mac_addr)) {
+		ath10k_warn(ar, "invalid MAC address; choosing random\n");
+		eth_random_addr(ar->mac_addr);
+	}
 	SET_IEEE80211_PERM_ADDR(ar->hw, ar->mac_addr);
 
 	SET_IEEE80211_DEV(ar->hw, ar->dev);
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

