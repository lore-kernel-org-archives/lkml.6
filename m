Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090F2C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7A920847
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TT5fhev9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE7A920847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbeKBA41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:56:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33590 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeKBA41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:56:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id i62-v6so1679855pfi.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 08:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+DXyXu+3FN346qfNwuLZJrjQXpEgFC8GgqCpR02Dv+o=;
        b=TT5fhev9yXGk8UICUbLQ5gzY7+O5EdQxy5U+KNkidACTEhzAsoPB/ReoJsICMlr0uv
         M3wlpKcabdyZLFPymQ8NXG95vYKB3LdvEnOLSS27kAdypdfhoGQiuN5heTGDWw67Dyl8
         YEYp3dD0AgjYpPD9t4F7Hwu7fKD6QoH+ez7wMC60wo3rnyspEV4SZ22g62p4VPIPBVIO
         wrV73ouQ7tuewFRmw94NEuAFgknxnrYVGic62FbDD3Vu1deC801wGNM7bHDPe5Bmnvgy
         Qb9+k0OtOZDVz4g0sWHXhAacvZOZfAMiyDozF5+HSRmz+iTartxqfgVs9IhHDnSl+n12
         Upxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+DXyXu+3FN346qfNwuLZJrjQXpEgFC8GgqCpR02Dv+o=;
        b=CPONj/GVJPpf1yKZt00G5UQVuHyGG+SlnG+7kh5O6Jf25TO3E1huSObneUiJq657g7
         7jPxgifd+hYCyqZ7FpuCj+OlzCSh3DTSFNp/+Z/6Wqw+v9SSVilrIZZnXyKDKlkrb5Mr
         joqOQ8xMYAuYzwOAbQ7y0cfPHkzRcVxXvHGnLPm1xbnkQf/ifLdo0RkoD3QM5L1fBSv6
         WqPOgmrMV1aMfEI9Pvxh81tJ3PgthDD7iHfneK84zrVxT+Ru7d1Mt0geSl6RWWJOPw0m
         LnuzKrBGSBxXbJxp2ir6FStK6a2D+9I70g+68v1M+FNSw6QTRktnSP54KyYOe8XOHExy
         uPug==
X-Gm-Message-State: AGRZ1gL7Jfs3pFbOOj26TJOw6FZsIFdcrn8lej93/pTptgpjxuy/cn2I
        FeC89eayzpdlD/vAivYxuqU=
X-Google-Smtp-Source: AJdET5dLkmjORxUWhkw2c68Mn8rdcGjXPuNPK+rz47fI2lg2YI4s6AA3GkWYbdDEEjlWlsrLFMNFGA==
X-Received: by 2002:a63:4384:: with SMTP id q126mr7609705pga.160.1541087575251;
        Thu, 01 Nov 2018 08:52:55 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id q7-v6sm25478253pgv.78.2018.11.01.08.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 08:52:54 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] staging: vt6655: fix small typo
Date:   Thu,  1 Nov 2018 11:52:51 -0400
Message-Id: <20181101155251.23330-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/staging/vt6655/baseband.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index f0b163473426..b5ba0c76fb43 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -13,7 +13,7 @@
  *
  * Functions:
  *      BBuGetFrameTime        - Calculate data frame transmitting time
- *      BBvCaculateParameter   - Caculate PhyLength, PhyService and Phy Signal
+ *      BBvCalculateParameter   - Calculate PhyLength, PhyService and Phy Signal
  *                               parameter for baseband Tx
  *      BBbReadEmbedded         - Embedded read baseband register via MAC
  *      BBbWriteEmbedded        - Embedded write baseband register via MAC
-- 
2.17.0

