Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BE7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF2A218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnQuUSOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388026AbeLTRVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:21:19 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34157 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387876AbeLTRUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:20:25 -0500
Received: by mail-ed1-f68.google.com with SMTP id b3so2418440ede.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3rsKFW04x7SNb9/m8whEnCmz/CJYUBzTpBQOd4qbbfs=;
        b=nnQuUSOjJL5b7GSCTpns96jnYGziQCUEVUcPdlNFPsddoann87IV3wjGrZYjHcWAzY
         mR1zPlFxb8qwLcdz+oRpPu2uwoqbwKLIg2iMlFXIrT2BvPVcQqQlawH4OCqI1fkIOqna
         kVat0W/xrJObAFbJ/YdSRlG68L5T0aqBpyawMITxCyM3cWdA90uK7uYnswphbLeY7Ex+
         5sYW/+TSlbGHWo8yiRBABPcWDVehAT/K8s6sJ2bMgtqYaCwBtErsLeh96BPl4xkTogvT
         HcDzjutkt1n1+k5MsPRoXmHzpbdeeEW4epOkEy4UIF/Y1jgVakUoGcXE9MbZKZ7kVt3Y
         EHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3rsKFW04x7SNb9/m8whEnCmz/CJYUBzTpBQOd4qbbfs=;
        b=EOEG03XQ1HnFqLaq3+/UFNlWvGHcz03kmPCVbC/Q9W2B/rSGfP/uPvxfdD/6+NW2Ov
         jNQXe20lVrpysfCO/uj6uChsPpGybVdBtZ0iP0sklLKlLDKq6pbkYugc+NL602/ike7H
         vJmEFL9mBIKFfYjStZIUM5h9DyPULMaTF6pNTjdjYxrWXxu8hEh5+26HMAbE4+iHckyL
         c/xOW0jP4azQAk7TrNuwhP8Ef46TNsJoBtyN5Iu1p3a6DogpcXeYKgwC+PZYETzkAw6f
         sXAV0QCz9E2G2XnB+5oyh7LX5aM7Z8kpHYuTmEgZsLC0tO7aR++5H5xhI9cD6h78ws3N
         yi2A==
X-Gm-Message-State: AA+aEWY7xUOyaY9KGfUJNMGBbW1jWX9qxG9wRKqPmn5QhWk9dRtlB3nA
        TYChoYz3wMlelSRczqn+I6U=
X-Google-Smtp-Source: AFSGD/X09zHB2hJMOhTCWAP6UyTvT2x+Q+UxL/I75V0QaVAwLYDEm2rXEbozXtgp2i69sdCTTl/JaA==
X-Received: by 2002:a50:e610:: with SMTP id y16mr7986506edm.163.1545326423361;
        Thu, 20 Dec 2018 09:20:23 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id o37sm6207723edc.32.2018.12.20.09.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:20:22 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Houlong Wei <houlong.wei@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>, CK Hu <ck.hu@mediatek.com>
Subject: [PATCH v3 12/19] mailbox: mtk-cmdq: Use device-managed registration API
Date:   Thu, 20 Dec 2018 18:19:55 +0100
Message-Id: <20181220172002.9016-13-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181220172002.9016-1-thierry.reding@gmail.com>
References: <20181220172002.9016-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Get rid of some boilerplate driver removal code by using the newly added
device-managed registration API.

Cc: Houlong Wei <houlong.wei@mediatek.com>
Cc: HS Liao <hs.liao@mediatek.com>
Cc: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index f7cc29c00302..d9c3ec3667a8 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -337,7 +337,6 @@ static int cmdq_remove(struct platform_device *pdev)
 {
 	struct cmdq *cmdq = platform_get_drvdata(pdev);
 
-	mbox_controller_unregister(&cmdq->mbox);
 	clk_unprepare(cmdq->clock);
 
 	if (cmdq->mbox.chans)
@@ -524,7 +523,7 @@ static int cmdq_probe(struct platform_device *pdev)
 		cmdq->mbox.chans[i].con_priv = (void *)&cmdq->thread[i];
 	}
 
-	err = mbox_controller_register(&cmdq->mbox);
+	err = devm_mbox_controller_register(dev, &cmdq->mbox);
 	if (err < 0) {
 		dev_err(dev, "failed to register mailbox: %d\n", err);
 		return err;
-- 
2.19.1

