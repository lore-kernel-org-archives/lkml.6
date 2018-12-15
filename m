Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22A3C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 07:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8292920672
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 07:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3CeH+hZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbeLOHWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 02:22:21 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34753 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbeLOHWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 02:22:21 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so3768202plz.1;
        Fri, 14 Dec 2018 23:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xNSQnLp2ea1UJjtMX5kv0ypQi79onHL2a/igC8HRsrE=;
        b=i3CeH+hZC8i4s3hA3MTygU6Qa9RqRpWIp43U734ZciNoSVfaw0u9IW3BrFuruEsFP/
         jbPUgqRQAYq1gNA7Up/xWzvSaow47L4G+wC2SVl5FiER+oT5pmj24rggAQq0NtgPWD35
         gJbxAr4R1gp56ib5i3BlRaMNUSByOUjdegle8QxVcVULJXmPgVbLFoG/yLYf2FXB0+Cb
         0IOie6umI3z9JzO3DVg9OMrnwxud0QCkLM6GU6zD7vdp6KGDfmpWs5vfjnpSNFBPHBP1
         MT8l/LVzi36b60H+NnDcynooR8n+XMtWilWH1fyCRwWRByMUbDRvNT2IlPJb638Cts70
         CxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xNSQnLp2ea1UJjtMX5kv0ypQi79onHL2a/igC8HRsrE=;
        b=KVV1MBK8S/Bl1IuP2jfAiAvZFHKARRhH475Ra5CEh7An0a257IBN6j+WZ0uuta2JsC
         oeTvrrNDOMYNIKhm8GFozqxlPcsBUOhM5RHZ/nLHmxE4SGLO/4SUcW0ZBZNGHgVl9x+G
         Ek0dlD+Hcy6d56HQV6gpyhCq0V71VPhEmI3tM1Ewj1GW9EFQRyaYfVNb2gg23EERuM/o
         m+nq23bc9qUP79K5/PcG56vRoME4OmQ0Av6x42/uirOR/khQSeu+W5ekwftemEXppO08
         Ckk9/nBNBeEkro67ZNI1QYu6jpxm1UMm5U5B5gV84Jlaz2RM5khPKhbJvXmzWVzmpdJ/
         1g0g==
X-Gm-Message-State: AA+aEWZ0NswU9IEQ3HcUawGe2d0nAzfWvG37uidBgEXG5CFNJmJC94Sk
        PtvNlkKJV8YGcOT3MIN7pIBYkAPPIKE=
X-Google-Smtp-Source: AFSGD/Xr3NiL/VDa9o5FushEkh3TT9+3wB5GheOwgyGbADGkLi48cu06bO80VnawtUOeQHxba6Xyvw==
X-Received: by 2002:a17:902:47aa:: with SMTP id r39mr5542068pld.219.1544858539576;
        Fri, 14 Dec 2018 23:22:19 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id r83sm12121143pfc.115.2018.12.14.23.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 23:22:18 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     alex.aring@gmail.com, jukka.rissanen@linux.intel.com,
        davem@davemloft.net
Cc:     linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] 6lowpan: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat, 15 Dec 2018 02:22:17 -0500
Message-Id: <20181215072217.26085-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 net/6lowpan/debugfs.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/net/6lowpan/debugfs.c b/net/6lowpan/debugfs.c
index 24915e0bb9ea..6c152f9ea26e 100644
--- a/net/6lowpan/debugfs.c
+++ b/net/6lowpan/debugfs.c
@@ -232,18 +232,7 @@ static int lowpan_context_show(struct seq_file *file, void *offset)
 
 	return 0;
 }
-
-static int lowpan_context_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, lowpan_context_show, inode->i_private);
-}
-
-static const struct file_operations lowpan_context_fops = {
-	.open		= lowpan_context_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(lowpan_context);
 
 static int lowpan_short_addr_get(void *data, u64 *val)
 {
-- 
2.17.0

