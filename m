Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318EFC6783B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FB02082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR0IPxN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2FB02082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeLJP5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:57:42 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35410 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbeLJP5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:57:42 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so5160188pgs.2;
        Mon, 10 Dec 2018 07:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BCzBEDnhGYv6fZASQRuRyKhaGNE9/GQGK22qyWfyntw=;
        b=PR0IPxN16V6LRWivt8Fva1q+zJj3QkgelDJ6IUNdDdx78gYBQcOQWuHvpwPMS7Ixql
         a02RsPZAAFnBT0w16vJOkN8I9fTDxLOjCPN6ttPXuDJc9Ghd5YY/F9H2LlLG8iiIV2fL
         j6AZn8WRNIsY+cvtUKAMmJeuXlumkM9GlcRiFQqFNKchZaT1rduGHfHpu7ijpgl7od1H
         4ceB3jlqvZ1zl6tEpj+W1onpP8WU4+AtdomNzygU/2Ad/z9sxYumbR4RIkHMmxIFdqJy
         iM+rBp3uMh0yNaEjVFA5wy3fJry67PjZJcOSJ/C4rT21Sefa3R/PDcC2hjHErBjiqfqD
         jGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BCzBEDnhGYv6fZASQRuRyKhaGNE9/GQGK22qyWfyntw=;
        b=tks9wGhbnyGdSQoD4ZKjEi+vu7uRnJGmsZb7c4UzbgIEEefyH7wx8wO5PJR9pqRQJk
         PCc1GvdbraG0htQ8uiLUNwBtzUO5kuiQS7vKNUglVBp0T7TLDn/crpXx8aJxR2We3zcT
         qQXE97SlcYvKNb5WNDUvlJz3HCAdGJJn+s+jPCnXsL2mRlxvbCCXsgEtrlmNLX/pFWIO
         XFF2k0mAg1MfmwxprASVi4MvZ+iCGZyljrdtYRHZJZyHtifEAuvhRK5S3zYckeqbcYwN
         8YVzQpE+YOCVSW/dyJY5SQmoaHXi8u3XOOEA57OCAKQneWPt8Yx9dHtDj2//VEUjw6HU
         Yb4A==
X-Gm-Message-State: AA+aEWaKOBH7e2mrGxHB0rK8JQuW72w1UWL7KRFOiR5axkMQOq3nXuSG
        dhD5PpxncE/AC5r8KNM/v68=
X-Google-Smtp-Source: AFSGD/WTiR73ZsmMFoEiXOhPXHfvgEHX95f7h4Qe14GpKbC0cT+DPS/xt9Rv4m+jNdgAx7QFhBmYLA==
X-Received: by 2002:a63:ee0e:: with SMTP id e14mr11115020pgi.8.1544457461616;
        Mon, 10 Dec 2018 07:57:41 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id x26sm14665000pfn.50.2018.12.10.07.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 07:57:40 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] fjes: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Mon, 10 Dec 2018 10:57:38 -0500
Message-Id: <20181210155738.20721-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/net/fjes/fjes_debugfs.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/fjes/fjes_debugfs.c b/drivers/net/fjes/fjes_debugfs.c
index 30052ebd52bf..7fed88ea27a5 100644
--- a/drivers/net/fjes/fjes_debugfs.c
+++ b/drivers/net/fjes/fjes_debugfs.c
@@ -62,19 +62,7 @@ static int fjes_dbg_status_show(struct seq_file *m, void *v)
 
 	return 0;
 }
-
-static int fjes_dbg_status_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, fjes_dbg_status_show, inode->i_private);
-}
-
-static const struct file_operations fjes_dbg_status_fops = {
-	.owner		= THIS_MODULE,
-	.open		= fjes_dbg_status_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(fjes_dbg_status);
 
 void fjes_dbg_adapter_init(struct fjes_adapter *adapter)
 {
-- 
2.17.0

