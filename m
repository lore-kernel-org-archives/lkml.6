Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFA6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DC622503
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="clmez9xx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DC622503
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbeKLXyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 18:54:01 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45451 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729799AbeKLXx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 18:53:59 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so7669161ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 06:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ptTfOSQyCB/JKI5iUqiF7XIw7qg/C6KDpM/4pJWB2AA=;
        b=clmez9xx5QWXWPD0lxnzvDNp2V1csaKIT3JNcZxCbncE2f2WaTt7yWQNdyP9DNN6ma
         tYo7kN/r+ngkY2f1WVvP9p1tgd/5pkA/xO3Fv4F7FhW86F4K7oau3Bzfooo0qmfqtDBr
         dPmk2aA6eS23KzkbXkZhTS2Kl3TBpMRhoWT8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ptTfOSQyCB/JKI5iUqiF7XIw7qg/C6KDpM/4pJWB2AA=;
        b=eAj/3XhtJbtk+pSXsvPZmNftMHQahVMBT8k4VqSG8nCLxy4vqR54z1o5lZaP5FBjG8
         4Wy9/8KA7PEV/FWjXY30evYeIPqG1Ptv0G1UWHDY3xJOV8WsPoLczJkulkF0zQK3HXxs
         jArKVmcEcnwD6F+2DTjIBp62LW43jd3VJ98p0YIcC3dFK9uoo5MIfT7azg91Nc4FxUbx
         XShcw3j6+HDHY4ce9ksvWNKQtZC6xqLu4vxaFq51K5mK8H3EDOjXtECtAdicVN8lABB3
         CouHESc2hbmga5qU3qB5cIa1Z5IxkcojHVCjz8H1MjV+6a7tdMtnR01Q21IH67kHxdfQ
         EPKw==
X-Gm-Message-State: AGRZ1gJKCF9IaCAJZ93Hmogk5N4x6EeVCFd7Lpkb6y7MpDNMmvPlPQTY
        NEhI/U0dVsntkCZKttzdBZUs1w==
X-Google-Smtp-Source: AJdET5cCAroILxLwDYlKvmkbiy5AgZtBV+shM1SBHykC5htNWgAef8Jg81ApNboM0+832JWVcc6nUQ==
X-Received: by 2002:a2e:92:: with SMTP id e18-v6mr830728lji.130.1542031233740;
        Mon, 12 Nov 2018 06:00:33 -0800 (PST)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id 26-v6sm3546387lje.18.2018.11.12.06.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 06:00:32 -0800 (PST)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 2/4] net: ethernet: ti: cpts: purge staled skbs from txq
Date:   Mon, 12 Nov 2018 16:00:21 +0200
Message-Id: <20181112140023.12407-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181112140023.12407-1-ivan.khoronzhuk@linaro.org>
References: <20181112140023.12407-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The overflow event is running with 1 jiffy in case if txq is not
empty, but it can be emptied completely only if next tx event
consumes skb or deletes staled skb from the txq. In case of staled
skb, that can happen for some unpredictable reason (the ts event was
lost or timed out), the overflow event can be generated quite long
time consuming CPU w/o reason before next tx event happens. To avoid
it, purge txq before increasing overflow event rate.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpts.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index dac4c528a1ff..63232b35024e 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -86,6 +86,25 @@ static int cpts_purge_events(struct cpts *cpts)
 	return removed ? 0 : -1;
 }
 
+static void cpts_purge_txq(struct cpts *cpts)
+{
+	struct cpts_skb_cb_data *skb_cb;
+	struct sk_buff *skb, *tmp;
+	int removed = 0;
+
+	skb_queue_walk_safe(&cpts->txq, skb, tmp) {
+		skb_cb = (struct cpts_skb_cb_data *)skb->cb;
+		if (time_after(jiffies, skb_cb->tmo)) {
+			__skb_unlink(skb, &cpts->txq);
+			dev_consume_skb_any(skb);
+			++removed;
+		}
+	}
+
+	if (removed)
+		dev_dbg(cpts->dev, "txq cleaned up %d\n", removed);
+}
+
 static bool cpts_match_tx_ts(struct cpts *cpts, struct cpts_event *event)
 {
 	struct sk_buff *skb, *tmp;
@@ -292,8 +311,11 @@ static long cpts_overflow_check(struct ptp_clock_info *ptp)
 	spin_lock_irqsave(&cpts->lock, flags);
 	ts = ns_to_timespec64(timecounter_read(&cpts->tc));
 
-	if (!skb_queue_empty(&cpts->txq))
-		delay = CPTS_SKB_TX_WORK_TIMEOUT;
+	if (!skb_queue_empty(&cpts->txq)) {
+		cpts_purge_txq(cpts);
+		if (!skb_queue_empty(&cpts->txq))
+			delay = CPTS_SKB_TX_WORK_TIMEOUT;
+	}
 	spin_unlock_irqrestore(&cpts->lock, flags);
 
 	pr_debug("cpts overflow check at %lld.%09ld\n",
-- 
2.17.1

