Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30100C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 07:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E944A2171F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 07:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COGqILbs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbeLOHT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 02:19:58 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41585 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbeLOHT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 02:19:57 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so3743330plm.8;
        Fri, 14 Dec 2018 23:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2Ho9mPcb+gfsO2zLEEYDLsbkm4vBTX6RheAN23jNnaI=;
        b=COGqILbssYODlu3sLQv7JoB3C3K6QJYSKixyvZAWAvTFGz01TtRBK1nXnfcYFzh/9v
         FTyxoBnx3f+0jQW8Jwqc6bm/YrERNh7hviRHyruYKAe9Fi9aEscw1+bdx3PURSU/21lP
         e9crmvtMns4K3oVUNisPzLcNJpM9+xjhwKGPRw1SpLk9LSWpyAmxeEaSaVa7VY73hfGd
         yMBv4qg3JIbfJJpXtqQXOfuuXXGYO/hEcZRcBDMFtS1mKmXejNdR2klYbGXbJYtmUeW1
         ypl3NZlJvzjBwth+dF/wj581LjPwyISccjaoIZcurAyisglE99+yx8I5JJjxf6jDxuyX
         weHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2Ho9mPcb+gfsO2zLEEYDLsbkm4vBTX6RheAN23jNnaI=;
        b=LrPL0zdC02A1blqa9Yy0+uFLYgb0gDG3K2h0Ci0IylzkOwULmSR4XPkQi1R1iJOmfO
         8GKWjP/3B1ROb1m/WnHEMNshg1iSsfr11IToRbq0Vx8R3rEMahfcCP4vYqfNmzfy97HS
         svXkmSYr0Sw1KTh4UszFIgRCHSVjDatwO/cBcIfdQts0+hF/KBMNPAS5KBgzrU/UvXrE
         OphIjJtPnwtyOpgfoO0tw4DhY5cdcipFldNnvae5B7X/YKkvSTHdcc38fOAKJGaAxw32
         84Vy1p/DQE1z6kdYvnW/hTiSmsgVRWzcbaG0B6XH2u6deJYANSkXppxV3TUbB42ypCbK
         eb+Q==
X-Gm-Message-State: AA+aEWbz+LnhcoBOm1nO5W3CrOXB2EN5WIlAdBRzT/DngJ0ZgtUWWF/4
        3TH/areu+dYE+3ylz1iONiM=
X-Google-Smtp-Source: AFSGD/VgbCPWcL/XRImiAyi8T5iGc5zClTrse91/CoZfjWxWovcmo8Qot22R3udGAWZSc7+lP5IGAQ==
X-Received: by 2002:a17:902:3124:: with SMTP id w33mr5632309plb.241.1544858396902;
        Fri, 14 Dec 2018 23:19:56 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id e9sm8661335pff.5.2018.12.14.23.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 23:19:56 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] ipconfig: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat, 15 Dec 2018 02:19:53 -0500
Message-Id: <20181215071953.25930-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 net/ipv4/ipconfig.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 88212615bf4c..fcb817d0eb24 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -1361,18 +1361,7 @@ static int ntp_servers_seq_show(struct seq_file *seq, void *v)
 	}
 	return 0;
 }
-
-static int ntp_servers_seq_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ntp_servers_seq_show, NULL);
-}
-
-static const struct file_operations ntp_servers_seq_fops = {
-	.open		= ntp_servers_seq_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ntp_servers_seq);
 #endif /* CONFIG_PROC_FS */
 
 /*
-- 
2.17.0

