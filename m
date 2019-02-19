Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17E6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B940121773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Ui8JwLFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfBSNb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:31:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45540 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbfBSNb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:31:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so10140949pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 05:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=SuhRi1McCCKuhVtT1M8aSSgDWJl0oelrZ3pPdrtaxj4=;
        b=Ui8JwLFR+fBmSBeWx4FUofOSj9e22bLaZmGCHHaEflxIpNdwb93FrTtO2TD76W4qxF
         Bg+wgcXTVYeihj87xUU/TXCzDBSwrj8A3RDom9VEh0hpn1Hdvpr8Q7qBxK0bQ/bTz48/
         WZiG9m8NVuVQDFXs53Kgpbd2lUhewqCZArFYsjrF/otVtpfQdWOvZZDNTXDYV+kdLOMp
         dvxChxxQjZ3lcowJ8p3eHId5ULyYcISuNeCREkXkc7BoB3kXKsD6oOLVG0oaVdsBPYiT
         sKpFC3bIBJ7TKMNlCZrVW4r3mkxVZ27mVdjkxa/AjQw2n25KVg77ZP3esTFbTM/73H5J
         f3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SuhRi1McCCKuhVtT1M8aSSgDWJl0oelrZ3pPdrtaxj4=;
        b=QUwmvo97Y1Bf2YM5/wpxWcJIA1DIseIr7Tvgr5Z5Oz+2vtjzyr9VWrmcgah+eOvgqh
         2hi5y8tlt1JG2pCPFClhtxhI23tm38WshpePzAOHtX4h/0E+fZvMbqibe9cUdjAYr48J
         R0La0nkLoFizMYkzfQS/jxe57ayDRkMjRSoSV1NayFIL5vV/TZKT/70NZZwZJDOIdmaj
         v0FcNO3V9yE3u+GZ7W7VFgBZq00qFHWJ/cfiAIlWcxe50QC9+a6EL5ebTMqusyqSuG0n
         LTJKfZUjT6064e8F7HppDb2eu35nrBBFiqWKxKHCjl9WLTf7jGPl1Bx/RzW7S5LLfs79
         E7RA==
X-Gm-Message-State: AHQUAub/7TJRQNYiwyvFhkMs3ymBEOfWjx/27+d1rZrgvO9/Kj390ilN
        fyvrwIq5FRndugyvuCmp0n9BfA==
X-Google-Smtp-Source: AHgI3Ia55b9mXmyatzveYV5Oa4Et97q5jAQB6doHMJi12TGy/dUF8ulz1sofuapLkLBpUiW6rGInmw==
X-Received: by 2002:a63:9246:: with SMTP id s6mr23651350pgn.349.1550583088653;
        Tue, 19 Feb 2019 05:31:28 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id 128sm24150238pfx.7.2019.02.19.05.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 05:31:27 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Krystian Garbaciak <krystian.garbaciak@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: da9062: Select maximum current in specific range for set_current_limit
Date:   Tue, 19 Feb 2019 21:31:00 +0800
Message-Id: <20190219133101.20892-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Selecting the minimal value is only true for voltage regulators.
For current regulators the maximum in the given range should be
selected instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/da9062-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index d06e9600fa18..4c5d6ad853f8 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -126,7 +126,7 @@ static int da9062_set_current_limit(struct regulator_dev *rdev,
 	const struct da9062_regulator_info *rinfo = regl->info;
 	int n, tval;
 
-	for (n = 0; n < rinfo->n_current_limits; n++) {
+	for (n = rinfo->n_current_limits - 1; n >= 0; n--) {
 		tval = rinfo->current_limits[n];
 		if (tval >= min_ua && tval <= max_ua)
 			return regmap_field_write(regl->ilimit, n);
-- 
2.17.1

