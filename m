Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7806C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 13:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486BE204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 13:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkfDTMA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486BE204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeIISpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 14:45:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41739 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeIISpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 14:45:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id h79-v6so9149605pfk.8;
        Sun, 09 Sep 2018 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2GcLjICpawdKjLsfLPHlHovMjN9S8wKtiVa3vm/KPbo=;
        b=QkfDTMA0cZuzKTVNZjzoyhQJto1Vvmhh4CzivAqJVA4TrggsnP2UrWE4pkYpC9srfR
         WKwvm3CGRxNn0p4paCpB6UHgvYCCDA1/o03J+kfO2D+cTD5+mWgYud8hHBSa8POQYYUz
         viK2IbZagCwFzCdLnTj7IB0+EKGX0j4HeI3pQHXgOe3bGWHVEUkUzSnbAAjhrSCz3w3F
         fgygBOAZ3fV1n4qKpBqp/RjrdTyKGLYGxX9Kc1U86mwiIu0nEqBmBBFtfoRwyfo3XoqE
         B8cXCdkYuDAJ+DZY9hlA0T5M94Mce3IXpWa/4VxWkcEm8jPBUrklR+Fa/3fKfpO0nOqn
         eykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2GcLjICpawdKjLsfLPHlHovMjN9S8wKtiVa3vm/KPbo=;
        b=J4QEoJqIGgTVF0SjU5ToOOIacmRnMZXakC53U6yOhPMD8/NniD5GjXiSsbPxOwP+ra
         +ICwzX1PESnPR9770lpKbZ6+HNK5TLO4QHWO8cZPlC/6WVbu/xGVg5aS/+YNuyGpHrVS
         8CR1AIpeCogh4U11BgPZfWJMjFX3kx1CnX8ruCu9hHy52NLU2yXq7EaMBuiX3yFYSEGi
         XxVzVGbCI9vevuEry5AntkCU+OteG0/f2ZZewW1IS7IFQylRi5Te7CUJ2NXlEJNv7Otv
         jIzYUE/T+KigOFwFRH/CnTayzY3J1vgPnUQjdFY3UjKcdvUcVUi2adL6tSfM+8ws6+OR
         ZjVg==
X-Gm-Message-State: APzg51B5Hc3wA2vGrYy58ouWDI7Px0bzqfx5OSQ6yIsoblucPmB4R2IQ
        Wr7ZT0L2JAGB0y9vH42z958=
X-Google-Smtp-Source: ANB0Vdbw5XEujuQ+HwIA/a34pvMYDzkxyced1GcpT2IPGN8uou6I1fB+fYiVAhxIQqXa1uKa7d51bw==
X-Received: by 2002:a63:be4a:: with SMTP id g10-v6mr17889541pgo.378.1536501322881;
        Sun, 09 Sep 2018 06:55:22 -0700 (PDT)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by smtp.gmail.com with ESMTPSA id y85-v6sm20633820pfa.170.2018.09.09.06.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 06:55:21 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 8BFF9200700; Sun,  9 Sep 2018 22:55:19 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        sgruszka@redhat.com, johannes.berg@intel.com,
        netdev@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] linux-next :cfg80211: Fix warnings while make xmldocs
Date:   Sun,  9 Sep 2018 22:55:18 +0900
Message-Id: <20180909135518.29527-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During 4.19-rc1 merger period, 38cb87ee47fb8 was merged.
In the patch, one of an argument "*ptr" was removed from
the function. But in the comment of the function "@ptr"
still exist. Which causes 109 lines of following warning
during "make xmldocs"

./include/net/cfg80211.h:4869: warning: Excess function
 parameter 'ptr' description in 'reg_query_regdb_wmm'

After apply this patch and make xmldocs does not show
this message any more.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 include/net/cfg80211.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8ebabc9873d1..4de121e24ce5 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4852,8 +4852,6 @@ const char *reg_initiator_name(enum nl80211_reg_initiator initiator);
  *
  * @alpha2: the ISO/IEC 3166 alpha2 wmm rule to be queried.
  * @freq: the freqency(in MHz) to be queried.
- * @ptr: pointer where the regdb wmm data is to be stored (or %NULL if
- *	irrelevant). This can be used later for deduplication.
  * @rule: pointer to store the wmm rule from the regulatory db.
  *
  * Self-managed wireless drivers can use this function to  query
-- 
2.19.0.rc2

