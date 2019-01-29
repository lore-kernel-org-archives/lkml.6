Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF92CC282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840BA2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="rIc++Xlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfA2DCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 22:02:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41591 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfA2DCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 22:02:13 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so8964239pfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 19:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=72dDdZJ5A4m6E5P3LyHYLFeZ/0gErIEm2c23v8DYUGg=;
        b=rIc++Xlpag/VrgZSALJBc3AazDoIBtSLjFXkq3j8gQqGetivtebFlbG0sqYzVut1fQ
         qVLHT52X+UyIrUTpuSTuShexqaQXYDC2x9pVbeCDPFQA/ImBn0dMGlC5fi4RNopTfbGs
         z8FSpu5H00shK6EpLf4Uj4Wv3xXWenvjAIITzhdN+P3oJwz3B6oKC8AsxcyRfzU1WoYR
         6P/+AiRDGeDWGNi5Ui4+esPcYBMDKkup7b2huxnApuwezkFkzbl9YVI0EyvCPJi5Smj/
         YxZWt0j2Jie1Vb437QD3Ly/oRI0DfUjXdBO55lmqih17mV2sz+oHlL/+AuHARrgdqlwa
         8Rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=72dDdZJ5A4m6E5P3LyHYLFeZ/0gErIEm2c23v8DYUGg=;
        b=gD8ilSUP7/ySpJtYSnd/+2pQzdqw342UIz9z4h72IkzWVhdDAi2akBbiHyIojxQGOM
         KdUpKV+K+LnAB/wNJ+FH7OhNAE2FKXlibR9GuVK4udwzzkr20BEMF5mVZF/CS3hezZf4
         +8mtUlT8tIfzwc/CAfsZyAXu/Top/dCnwmJv6Vjq9IfWc1cLHIivLIGvvt6OnXziKhch
         nCsPGrlKw0gm5GdLCJwoRr1iRIKoHk0iJlQckUsJOGc0FuhPjDYTV4soTOVmduDHTwGY
         jHhXGGXvncw3YP/HBM6ngxAQWythDzyvdMAafkqWcjgiB8teXU4Xyk3J9Iv4sj4iPZTz
         ARKQ==
X-Gm-Message-State: AJcUukency2FzS6N0d3YZfxzeumub0PFHlF2ujUXxXo5MX5BF7BmjYo2
        Wzi8G/h4l4AW1hpH3qr0tLqYkA==
X-Google-Smtp-Source: ALg8bN5GF/4pCc+yG+boGQli8CDXUiHq25VCe3OtsFekld983NjHwRKcVDthHBnEw5kPsQHDAC2HDw==
X-Received: by 2002:a62:5301:: with SMTP id h1mr24210826pfb.17.1548730932277;
        Mon, 28 Jan 2019 19:02:12 -0800 (PST)
Received: from localhost.localdomain (36-239-242-165.dynamic-ip.hinet.net. [36.239.242.165])
        by smtp.gmail.com with ESMTPSA id i4sm58807646pfj.82.2019.01.28.19.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 19:02:11 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: lochnagar: Fix n_voltages setting for VDDCORE
Date:   Tue, 29 Jan 2019 11:01:56 +0800
Message-Id: <20190129030156.2024-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With current n_voltages setting, regulator_list_voltage will return
-EINVAL when selector >=57. The highest selector is 0x41, so the
n_voltages should be 0x41+1, i.e. 66.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/lochnagar-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/lochnagar-regulator.c b/drivers/regulator/lochnagar-regulator.c
index 4962d13659aa..ff97cc50f2eb 100644
--- a/drivers/regulator/lochnagar-regulator.c
+++ b/drivers/regulator/lochnagar-regulator.c
@@ -194,7 +194,7 @@ static const struct regulator_desc lochnagar_regulators[] = {
 		.name = "VDDCORE",
 		.supply_name = "SYSVDD",
 		.type = REGULATOR_VOLTAGE,
-		.n_voltages = 57,
+		.n_voltages = 66,
 		.ops = &lochnagar_vddcore_ops,
 
 		.id = LOCHNAGAR_VDDCORE,
-- 
2.17.1

