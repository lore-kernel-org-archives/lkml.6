Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099CBC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 10:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA05B20837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 10:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxPdZqee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA05B20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeLIKtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 05:49:41 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46093 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbeLIKtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 05:49:41 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so3978009pfe.13;
        Sun, 09 Dec 2018 02:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TmWHtMeJzI8vVlByFpCms/DOmRHKGofFb/GbDBbrb88=;
        b=mxPdZqeeoLJu4CNGAnwvPo1E73SLSI6lN/nPdslAGH50nC8MYKGg28hVeucQ3JsTIT
         sd8NzsSIkcPX5DI17xwzUb668NnBel21DKLbsuTHvL/hujgDBB9hJWnb2AxEvmOcgWPc
         FBSPfGU0+rQSORzubnZSefM11sKeiJttn8On80WTGNfGxqpKWWZGYYgEDA3iyA5Mp4Yz
         c227O2q9gJiZjUhq1gIoKWFPsHScRrWXpq6LxMVLpE5SFTWEr5UFbYyH95S0Lrb+cAym
         jq+gmpZH463MRiR3jl7THr/0gRTW88aP8r9ZLyFJk0mvJ1bix4u11Oqvsne8EoP9uxU1
         9zSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TmWHtMeJzI8vVlByFpCms/DOmRHKGofFb/GbDBbrb88=;
        b=pi0SwR37ajuPCgbbF4ODwK66+KZxFbjV87DfbxKufBGNO5Zid80g8z2e6LQMMfhqXM
         JsJ5iUs5NC09QDVY6LRLTqI4RL8oXW6LgariBXxPIKt/+cA+TucGypskbkjWTjzMsrCo
         ph+yc6+MUhWo6THm3ILb2GhLDwH1gHBSmynMvRvwO2XCZnoz7vt8iJOqJxjFBtCxBD2v
         6+dyU3z71uZEoGpyYnR6fWr0UNsqRweZgpLJMbCcs4WxQeCi5TMwS8XNdieP7j14h+/s
         2ysGHE4El1uuL5FliMlqrnQsRo8AgmuPsyHBc9CdAFcxfPS043i86Dc9H7gWKIUxyAGp
         7a/A==
X-Gm-Message-State: AA+aEWbWAvVhJsV+gYaqlEEaVAR/rkKKpNyKO7NXdniFsnHfwLcD3snY
        2gz+4ZK14P8EdV6Rv6qE65E=
X-Google-Smtp-Source: AFSGD/WvDwi2fL35V+9Mg3cDvK/CTFT/0uDJAf9SKwpqpRagCUy1shv3bh4y0de1mreY0evEvLulxg==
X-Received: by 2002:a62:6e07:: with SMTP id j7mr8661564pfc.135.1544352580455;
        Sun, 09 Dec 2018 02:49:40 -0800 (PST)
Received: from localhost.localdomain ([27.59.76.117])
        by smtp.googlemail.com with ESMTPSA id z14sm9711617pgv.47.2018.12.09.02.49.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:49:39 -0800 (PST)
From:   Hardik Singh Rathore <hardiksingh.k@gmail.com>
To:     linux@roeck-us.net
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>
Subject: [PATCH] Watchdog: remove outdated comment
Date:   Sun,  9 Dec 2018 16:17:26 +0530
Message-Id: <20181209104726.15610-1-hardiksingh.k@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lock field doesn't exist in watchdog_device structure.
It was added by commit f4e9c82f64b5 ("watchdog: Add Locking support")
and removed by commit b4ffb1909843
("watchdog: Separate and maintain variables based on variable lifetime")

Signed-off-by: Hardik Singh Rathore <hardiksingh.k@gmail.com>
---
 include/linux/watchdog.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 44985c4a1e86..417d9f37077a 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -90,9 +90,6 @@ struct watchdog_ops {
  *
  * The driver-data field may not be accessed directly. It must be accessed
  * via the watchdog_set_drvdata and watchdog_get_drvdata helpers.
- *
- * The lock field is for watchdog core internal use only and should not be
- * touched.
  */
 struct watchdog_device {
 	int id;
-- 
2.17.1

