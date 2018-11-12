Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E85CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EA722503
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oncwbz3m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EA722503
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbeKLXx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 18:53:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45443 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbeKLXx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 18:53:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so7669042ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 06:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V8urvcUPQ+tQ49xmHAyRhENzIqUDbp30F6VIaNi0cmM=;
        b=Oncwbz3msYxF0pCpdIkqihPgvA1zWrHwsLawVWOtl7nYzIC8cCRAnkbfiqwXg4lPCt
         rOkYSpuhVI/+SasxBFxCsun7E7XXlniVR19EjQODPey02KPgeh//3Dtu/MGbULnq46C4
         gy8Wi2F6RP9u8dzzVKLg6divoITuDy13+yUdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V8urvcUPQ+tQ49xmHAyRhENzIqUDbp30F6VIaNi0cmM=;
        b=dPyOchpR6qpSgojfJ245cLHFlaE3c6wNgS/mE1+1fAhyiDLvRFYTswaqUgGeqKK46O
         oqcS6p96MAf/x6/Zmc8Yz5fCQ1YwJFWaxrukFW6l3G63Gc4KcP5uONDsP1hwrQDl5ye0
         orqoLUZOcHTqqTziXGOJcShsdPdj3eP+aBV6h1m14MBCDcGS2pJHWSX66M0XGOpKxVft
         tfJvowhX04Il7jKmmwZtnkUokjrmJgbBeHY/VpRFT7OpT5Dpa3c9RStTcEWbNV8jRy4K
         KNPnCfgATuFgjEwt/jb2UAbubY36b3sucIFOMyyYnqCBc0qg0/PE9p5agFj61Ng6CzFm
         3hVg==
X-Gm-Message-State: AGRZ1gLaKYadfPuvnrXlQu2GsoD7FhRQET5UmX3LWHwmVzwnMci+3JbD
        cRdYs32j2owzLcEmYwMcvAnD5A==
X-Google-Smtp-Source: AJdET5esmymXT6fLXCa7Mj961u2D4j/pvGFlzbCQIuZ3/vnb6Sk+cD2gszp79f2n05jGMW5mH0oWZw==
X-Received: by 2002:a2e:810b:: with SMTP id d11-v6mr661164ljg.143.1542031232259;
        Mon, 12 Nov 2018 06:00:32 -0800 (PST)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id 26-v6sm3546387lje.18.2018.11.12.06.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 06:00:31 -0800 (PST)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 1/4] net: ethernet: ti: cpts: correct debug for expired txq skb
Date:   Mon, 12 Nov 2018 16:00:20 +0200
Message-Id: <20181112140023.12407-2-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181112140023.12407-1-ivan.khoronzhuk@linaro.org>
References: <20181112140023.12407-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The msgtype and seqid that is smth that belongs to event for
comparison but not for staled txq skb.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpts.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index b96b93c686bf..dac4c528a1ff 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -119,9 +119,7 @@ static bool cpts_match_tx_ts(struct cpts *cpts, struct cpts_event *event)
 
 		if (time_after(jiffies, skb_cb->tmo)) {
 			/* timeout any expired skbs over 1s */
-			dev_dbg(cpts->dev,
-				"expiring tx timestamp mtype %u seqid %04x\n",
-				mtype, seqid);
+			dev_dbg(cpts->dev, "expiring tx timestamp from txq\n");
 			__skb_unlink(skb, &cpts->txq);
 			dev_consume_skb_any(skb);
 		}
-- 
2.17.1

