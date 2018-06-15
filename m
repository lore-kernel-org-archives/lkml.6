Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43313C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8F420896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IfRPxcLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8F420896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756398AbeFOSNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:13:22 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46970 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756357AbeFOSNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:13:19 -0400
Received: by mail-lf0-f65.google.com with SMTP id j13-v6so15867249lfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 11:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lDdZ+12ye4H9JsUdu5+2AMHnLkdkF7ofjKyzEJiIn2U=;
        b=IfRPxcLIjhv5rwWKSEbqR8yid/fsoVD0RlGYDA8BZvMFAvGlGS3ySmbjDHH/b3zATR
         GOhQRiE7qg996XWPlSZM0O2Jh9frRJTK7+8fhCbT1awNz07XIvykBmgSn4bxMCoZC2Io
         836LWsaT4GzWqYFJoU82a4rck2sQEzcyDRSj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lDdZ+12ye4H9JsUdu5+2AMHnLkdkF7ofjKyzEJiIn2U=;
        b=RrErCqS9CjhzAneR+ZuUupzqnfNKLFNkkvvpqNy2WFkpR8MoZi5x6CB86LsIUR9hZF
         MouR9YvisXMZpijCQ6k6QCNBFJM6ez+KLQEGbPop7Z4DSDNZ9NP2mX2EGStNhfHEQsbI
         NVk7w1DAAzC5MXphDq4+ZkwsjT64vDL5YcoFMJ3yaLoNhwaYV99XWRS7Q1EJ6rfN3KGC
         wXdx3Xlq92fjJYy6groXw4HI6//Q1vmPDTCpN1zqMPiV35eYM3uNwkL98S0EyqRSIYjs
         2jeGkVFdR6mRwUOLwXDTBtB1gy/2agj5/Dao56NeGYbKq793EB+t8uVaqq9+dmRMS9QH
         PIug==
X-Gm-Message-State: APt69E2raCk3AvCPQ9iO+1NpGQAkpEhjPOpV+LXj1vd4gLGKzkHJvxhF
        1/pzSCMbMmiLz5Z8wdtEQQqgZA==
X-Google-Smtp-Source: ADUXVKIyfVxT+4j3uCDrfSe2I4gG40pwz2p8pKq5AuuiKNIIRb4Kk4QclGTG/KmWNts74yoadOking==
X-Received: by 2002:a19:ed0e:: with SMTP id y14-v6mr1873369lfy.91.1529086397755;
        Fri, 15 Jun 2018 11:13:17 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id h4-v6sm1543260ljc.8.2018.06.15.11.13.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 11:13:17 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     corbet@lwn.net, akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, vinicius.gomes@intel.com,
        henrik@austad.us, jesus.sanchez-palencia@intel.com,
        ilias.apalodimas@linaro.org, p-varis@ti.com, spatton@ti.com,
        francois.ozog@linaro.org, yogeshs@ti.com, nsekhar@ti.com,
        andrew@lunn.ch, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v3 net-next 2/6] net: ethernet: ti: cpdma: fit rated channels in backward order
Date:   Fri, 15 Jun 2018 21:13:06 +0300
Message-Id: <20180615181310.10437-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615181310.10437-1-ivan.khoronzhuk@linaro.org>
References: <20180615181310.10437-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to TRM tx rated channels should be in 7..0 order,
so correct it.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/davinci_cpdma.c | 31 ++++++++++++-------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
index cdbddf16dd29..19bb63902997 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -406,37 +406,36 @@ static int cpdma_chan_fit_rate(struct cpdma_chan *ch, u32 rate,
 	struct cpdma_chan *chan;
 	u32 old_rate = ch->rate;
 	u32 new_rmask = 0;
-	int rlim = 1;
+	int rlim = 0;
 	int i;
 
-	*prio_mode = 0;
 	for (i = tx_chan_num(0); i < tx_chan_num(CPDMA_MAX_CHANNELS); i++) {
 		chan = ctlr->channels[i];
-		if (!chan) {
-			rlim = 0;
+		if (!chan)
 			continue;
-		}
 
 		if (chan == ch)
 			chan->rate = rate;
 
 		if (chan->rate) {
-			if (rlim) {
-				new_rmask |= chan->mask;
-			} else {
-				ch->rate = old_rate;
-				dev_err(ctlr->dev, "Prev channel of %dch is not rate limited\n",
-					chan->chan_num);
-				return -EINVAL;
-			}
-		} else {
-			*prio_mode = 1;
-			rlim = 0;
+			rlim = 1;
+			new_rmask |= chan->mask;
+			continue;
 		}
+
+		if (rlim)
+			goto err;
 	}
 
 	*rmask = new_rmask;
+	*prio_mode = rlim;
 	return 0;
+
+err:
+	ch->rate = old_rate;
+	dev_err(ctlr->dev, "Upper cpdma ch%d is not rate limited\n",
+		chan->chan_num);
+	return -EINVAL;
 }
 
 static u32 cpdma_chan_set_factors(struct cpdma_ctlr *ctlr,
-- 
2.17.1

