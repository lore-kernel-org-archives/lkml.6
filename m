Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D6AC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E400208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="If1GAh4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E400208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933303AbeGJNEU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:04:20 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41248 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753168AbeGJNES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:04:18 -0400
Received: by mail-lf0-f66.google.com with SMTP id v22-v6so4726467lfe.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 06:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uHIN3MKxPbo+c7W9ejWFkU9dJZMFUhJns/R6zTKMOYU=;
        b=If1GAh4xgYKGL7xawrDtsA3nJQg7QrKPYdQ4tPPIyI3J1QGDjGNw8YdP4k1kYZJ+sB
         Zy49OKvoWNCSms5+1+o3jOv7vtZFDAReSw5xwB5KfyWL614BEsaRMSuFjdXtLj8BRnFs
         fXWjBxwDF9vz8nnmIF+Ffws4f0t7lvCV/dTYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uHIN3MKxPbo+c7W9ejWFkU9dJZMFUhJns/R6zTKMOYU=;
        b=cUZ775wKQOlrXVRP+4QE05yG7UfziCgOSyM6I0AC1Y1WP2GT1J1+784OH3EpTkBoRb
         V4QYJbGIhYtTgEBC1QquiC6yw4XSquNFuJcm6YNHqnk7ER8jKs5xrZJrTKg6HsIlKyXK
         7/TPThlsimQnlCizhedvmVr0XKOMFpjdsT+cRbX1Dx7L3TG2eq6Xtj+Ubg3KdXbjd012
         PnGNdCVsraYlQ+Gq74yGxk+cCGGkxjZhSeCOOIqUtQQbbJjFMcPJAcFVCDLt3jd1EFzp
         gMeOOAyV5yGngdGYubp4EMoiAtnzPCObBYoFiBgvG+qNi6NMQcgC5zUuDkogDsnKb45V
         RVRA==
X-Gm-Message-State: APt69E0RquR/H5ub2pDLDR4uuxCj4CEaP25TCefW05CVXveWNu3Mo116
        Zg2La2s4EzPod+3BdWNj6SKwx8Eseso=
X-Google-Smtp-Source: AAOMgpf3YK5ZuON+TtWnvqW6EmXBlqMftJdJDpc7erqaWquHYFYjRTsrXN4rgsvdX8EQ5pojck5KZA==
X-Received: by 2002:a19:cf95:: with SMTP id f143-v6mr2955151lfg.101.1531227857377;
        Tue, 10 Jul 2018 06:04:17 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id g16-v6sm1609399lje.1.2018.07.10.06.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 06:04:16 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     davem@davemloft.net, grygorii.strashko@ti.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH] net: ethernet: ti: cpts: break cycle once late ts is matched
Date:   Tue, 10 Jul 2018 16:04:04 +0300
Message-Id: <20180710130404.3437-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The late ts queue can contain a bunch of skbs while hi rate testing,
no need to check all of them if timestamp is already matched.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---

Based on net-next/master

 drivers/net/ethernet/ti/cpts.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index 6f63c8729afc..b4ea58dc8caf 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -114,7 +114,10 @@ static bool cpts_match_tx_ts(struct cpts *cpts, struct cpts_event *event)
 			dev_consume_skb_any(skb);
 			dev_dbg(cpts->dev, "match tx timestamp mtype %u seqid %04x\n",
 				mtype, seqid);
-		} else if (time_after(jiffies, skb_cb->tmo)) {
+			break;
+		}
+
+		if (time_after(jiffies, skb_cb->tmo)) {
 			/* timeout any expired skbs over 1s */
 			dev_dbg(cpts->dev,
 				"expiring tx timestamp mtype %u seqid %04x\n",
-- 
2.17.1

