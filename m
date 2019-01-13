Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86BAC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 14:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6B92084C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 14:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="onJu+9em"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfAMOSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 09:18:14 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39735 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfAMOSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 09:18:14 -0500
Received: by mail-pf1-f195.google.com with SMTP id r136so9137668pfc.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 06:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=hXMoK136IGxcg3/dyumo6oJ8D4WIEYAtrVupg3DSiJE=;
        b=onJu+9emzocjjZOUyzTd8gr4QXBxTFm5JKqLLVgEfbrY6I7+hqf5y/rIr6CEFxGuZK
         vRJWO/U4LrtqYJlaarsGuKVC8yXV9M4YjHjZYkCBCt5w6im9nh3IoklfvyYiFkeF+BDm
         HoO0slaFTGssijDr2kYYYdnnTRSBuZoCuSbPjlvnYlatNgKfNK7q1d3VJeSQZI6y+XrK
         0+BujJUDCCsJQoJGLsaHhagm57yFbTw6gbSEI94O3ndnDuHLDWXIgQvpCHBES+g3aooQ
         +pbkMbfTeKd9eMP3Zi139XJ3vO4Yfx/VYJDKkAKGTG89bsPtX5krUxSjO5SqRbypy638
         ms/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hXMoK136IGxcg3/dyumo6oJ8D4WIEYAtrVupg3DSiJE=;
        b=FlkIzu8WM7BJTPOSyy+0JiXq53RmIj7mn/j/nrau72YD5Y4d2rcyrcvX+5N9FOIg0z
         1up7wYWXMNeZe1dSUK3g6192r4kEf4opaTuUA198XjhXRL7rAkVveYHjIhs14S94PYW0
         jvSuhKF+AdQBMc1ky6SzCR089+xI1fvCNRG4jWnI4zR7Cy4O8FCyLgvS+r0cbamYzAe8
         Z7ePh8JO6DXe976LHoM57U4K+edbYbnwp7hKG5WKEqvd/DJzRqmkGZVMMOdry2WcPViV
         lGz4N/YbHVvdvaPtBJu+ahs07gFPEqJu0txICCqxoRQRUyPfNJY1dZqJPtZahTkZ1mNr
         eDPw==
X-Gm-Message-State: AJcUukfMwFCQPr7uJsrShpoRu6KExUSq5Jusc5NJvRRa5xqY+2mCj0q1
        MKgVN08a8L3svVpI+/QtYY+Quw==
X-Google-Smtp-Source: ALg8bN7xPPq1CtszkTD9dzHulBx+GAijV5VnufMGtMRek5jNCoPkdSImLUwkHoOlTCsZpz5Oe97uBA==
X-Received: by 2002:a65:624c:: with SMTP id q12mr9708456pgv.379.1547389092784;
        Sun, 13 Jan 2019 06:18:12 -0800 (PST)
Received: from localhost.localdomain (36-239-240-185.dynamic-ip.hinet.net. [36.239.240.185])
        by smtp.gmail.com with ESMTPSA id 7sm277070124pfm.8.2019.01.13.06.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 06:18:11 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chen Feng <puck.chen@hisilicon.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: hi655x: Removed unused ctrl_regs field from struct hi655x_regulator
Date:   Sun, 13 Jan 2019 22:17:46 +0800
Message-Id: <20190113141746.6256-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ctrl_regs field is not used at all, remove it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/hi655x-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/hi655x-regulator.c b/drivers/regulator/hi655x-regulator.c
index 36ae54b53814..bba24a6fdb1e 100644
--- a/drivers/regulator/hi655x-regulator.c
+++ b/drivers/regulator/hi655x-regulator.c
@@ -28,7 +28,6 @@
 struct hi655x_regulator {
 	unsigned int disable_reg;
 	unsigned int status_reg;
-	unsigned int ctrl_regs;
 	unsigned int ctrl_mask;
 	struct regulator_desc rdesc;
 };
-- 
2.17.1

