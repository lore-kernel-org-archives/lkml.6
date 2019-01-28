Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E18C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C613D2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691524;
	bh=DrK7gd4romlFTo5A1QWfBEncO8SIRCy5ziPC07ZCprI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EujdVnmkg7GVQvW+HLzLWGafl9J04u+LccijFlY631Ub3E7Xm3sgEm82ZVaLsWPPd
	 os1y3wRMvrGV77grHYED3T99S78EsGmHlW6huykjVQiMRkuVlNPgztYbB3OKa4EIuH
	 ++AaZYun0Y2UOmDk5geO/7GOcYl/hoKCYQAAYHis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbfA1QFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:05:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:51658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731235AbfA1QFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:05:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33E5F2147A;
        Mon, 28 Jan 2019 16:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691515;
        bh=DrK7gd4romlFTo5A1QWfBEncO8SIRCy5ziPC07ZCprI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2HE6scrTLfmIsihll2eKRrmujJVpdLBckpNCIdbwgzx5L4cq8OYj19859K2QWJsui
         HPAOWzkKtyvZF8q4ZY7Svg7GdFK1sZ7IYJmFw5IGKUE+2mBVRg7ueDfUHLvcJZt0lL
         OAa2Worb3Uo4ZLh1CBNLWYAdIZEOOLRDyPGBiDBc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 124/258] Input: rotary-encoder - don't log EPROBE_DEFER to kernel log
Date:   Mon, 28 Jan 2019 10:57:10 -0500
Message-Id: <20190128155924.51521-124-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uwe Kleine-König <uwe@kleine-koenig.org>

[ Upstream commit 0832e93632c61987d504e251b927a2be769dd21a ]

When a driver fails to bind because a resource it still missing it's not
helpful to report this as (usually) probing is repeated later.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/misc/rotary_encoder.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 30ec77ad32c6..d748897bf5e9 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -240,8 +240,10 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 
 	encoder->gpios = devm_gpiod_get_array(dev, NULL, GPIOD_IN);
 	if (IS_ERR(encoder->gpios)) {
-		dev_err(dev, "unable to get gpios\n");
-		return PTR_ERR(encoder->gpios);
+		err = PTR_ERR(encoder->gpios);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "unable to get gpios: %d\n", err);
+		return err;
 	}
 	if (encoder->gpios->ndescs < 2) {
 		dev_err(dev, "not enough gpios found\n");
-- 
2.19.1

