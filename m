Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23987C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 12:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E332E2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 12:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Jh49nRsi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfASMlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 07:41:47 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43797 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbfASMlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 07:41:46 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so7350526pgk.10
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 04:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Vt6QtbkBofI+weR/bHCG2VfYvHAXKmYQs+P/Cvuc3LU=;
        b=Jh49nRsi7typbM+GIDhbM88Pn2mCxRrzfmHiv5GV+G1Vn4zrSQMiuA44uLHK3TptDW
         MpDKeJ6VqxzUsDE3iaWiJRxc/0H1EX2p/uRrxF4CLLbje3PdSMgy3yWV6ayNELAGlT/D
         +u8Jjv2ywzmiPmO+SgiLIjpnzXt6mdMbM+zKq+MVAj9uW6hYLtar7M0TpbkgPNPjOMHr
         9nyuUCQT+4lN2xbtU8EkOo/Tnd6vcvnH3XgQwavXuxcRsuouo6dln83RCxx5bmRc3vpz
         367c/3CCB2PSgE3CSnjKtDYnH9HQF+6j7aUDmKPisux5Y+no++Qiy4OhNqulyuGpy6pv
         uAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vt6QtbkBofI+weR/bHCG2VfYvHAXKmYQs+P/Cvuc3LU=;
        b=pwirKKp7XqgmuNd/h0fD9/TUBDdy9seuRGLp4EBAy3o75imvBWEXuMfgo7l5TOoSyE
         Y4kA0e7pgtaeYex3QjMQ5UkIrxtzHb4zgah7YHEd7kS3sua41rqlLjygafAdxh6PxQX+
         G0ov6dYtAV3wtQuj3W7uqgqyEwlpX0L1YHJZ7DDNFj7lkW7YK6MXC/DakDf/bVUH0Ui4
         zqGaPXaQ6Vod2sI8ub8pe305FDUV6xS7rFq+7LcgnJvSlsvUsnoUAL60AqHzlBXcHsir
         TAXOSs+IB0x2ikM0hSibRRNXbzui/A4M1N7mATYgmfGbcRctNeo/1Xm7zOmNWHuJaul1
         S+DA==
X-Gm-Message-State: AJcUukfHGiZqMY9hx9GZA3gntoD6LDJbsEe+6mmz8j/E4eGziPA1z/sX
        1WF65BLOxnNUPKocAjN7BUvm9JndNaw=
X-Google-Smtp-Source: ALg8bN6srwVK4BgHWItkDYViUjpZKyQ/ADjZgy8SM8IgkwGKX8lS3pNaR6p3fSoPcEPXgccqeoELUQ==
X-Received: by 2002:a63:4b25:: with SMTP id y37mr22035777pga.181.1547901705937;
        Sat, 19 Jan 2019 04:41:45 -0800 (PST)
Received: from localhost.localdomain (118-171-134-87.dynamic-ip.hinet.net. [118.171.134.87])
        by smtp.gmail.com with ESMTPSA id s130sm14208050pgc.60.2019.01.19.04.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 04:41:45 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: twl: Use of_device_get_match_data()
Date:   Sat, 19 Jan 2019 20:41:35 +0800
Message-Id: <20190119124135.23902-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_device_get_match_data() to simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/twl-regulator.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 884c7505ed91..402ea43c77d1 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -576,14 +576,9 @@ static int twlreg_probe(struct platform_device *pdev)
 	struct regulator_init_data	*initdata;
 	struct regulation_constraints	*c;
 	struct regulator_dev		*rdev;
-	const struct of_device_id	*match;
 	struct regulator_config		config = { };
 
-	match = of_match_device(twl_of_match, &pdev->dev);
-	if (!match)
-		return -ENODEV;
-
-	template = match->data;
+	template = of_device_get_match_data(&pdev->dev);
 	if (!template)
 		return -ENODEV;
 
-- 
2.17.1

