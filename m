Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB003C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952AF20685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjil0DgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952AF20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbeKFAB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:01:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45429 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbeKFABz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:01:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so3882693pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 06:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=n++Fu/HQ2R9725AKHsB+KM3nGDAxDbpJGzA/OfH8pFg=;
        b=Pjil0DgUOC/1zRy68yweJ0li1EX0foiBzudsOw6QfNy0m5tdE+iPj59l9Y7udAwzZc
         XaHkg2oWCDKjQ9kBd44qgGjZAqwT5JYyRXttOabx+Q8lGyEc1GmeXI8RhHzMTG5U44Ex
         k/h+9Tt/BACyr/ue560IybJm+9WQZqCmUjW/4ZEN6ou+a7dgKQfb6g+b8nsNPlHRpK+x
         96Fm4TkLNuMg50R8RMHUlCj87L1A0S4xBNdlyl04nX5DOkCq5UzRVORmP0hlFCm55hK+
         UBZl2FOYsUeGIUdmajD2F7LMc9R2Q4GCfLdFIM0Y3CXOTrmwMcokFIXRamnQtsRV1RTp
         pf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n++Fu/HQ2R9725AKHsB+KM3nGDAxDbpJGzA/OfH8pFg=;
        b=CweRjZ9/657liEPeap82BdouebnpOk4teN9Q1GNaClboGMAPKnX9t04pZmlGtRy9jS
         FiG6rC0Sv8ijcKICZdCVUTM0IZ8ebdO7Egdu3MjWjPHB/n2LX0Sfw5MB2HcuA0OkRo1D
         deMCBlILu5Z9LC31QGqt8Ha9w3GS0X1rIy2TKHQeU2R5Y/tXj9rM6fqSnKW5mlUlDzz3
         ePll8/Kwwsl9QxPUlNHaCdgR6Z04LdPyFxE8CSUvySCH2yIh/4nVvk31RiKjNMApFcVW
         z19e9E5P0ooPlu+ucMKn4pt7kMJ6PG7Ye9JkDKTSERn2uv0V1HGWG1hEYsjGcHAkLm1j
         koqg==
X-Gm-Message-State: AGRZ1gJjv3CzD7J9GvrRIrSYOR2D/kz3NnFAjRRQXJ8klXHbCrJxjqOw
        6vljZQMNiX052fqyo/rEhVc=
X-Google-Smtp-Source: AJdET5cEwQO9j7HOZlSka73m6Fhngfw6F/oRL59f9wYem6R2nQP4RkAYG8xD42dZYG5Jheqw8YHjuw==
X-Received: by 2002:a62:995c:: with SMTP id d89-v6mr22061106pfe.11.1541428913606;
        Mon, 05 Nov 2018 06:41:53 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id d24-v6sm29887827pfe.40.2018.11.05.06.41.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 06:41:53 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     jaegeuk@kernel.org, yuchao0@huawei.com
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] f2fs: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Mon,  5 Nov 2018 09:41:48 -0500
Message-Id: <20181105144148.6131-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 fs/f2fs/debug.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 214a968962a1..ef827c0d0379 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -428,18 +428,7 @@ static int stat_show(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int stat_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, stat_show, inode->i_private);
-}
-
-static const struct file_operations stat_fops = {
-	.owner = THIS_MODULE,
-	.open = stat_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(stat);
 
 int f2fs_build_stats(struct f2fs_sb_info *sbi)
 {
-- 
2.17.0

