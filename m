Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50FDC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFF52084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cf5+F2kM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFF52084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeLKQU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:20:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37602 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbeLKQUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:20:52 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so7359379pfb.4;
        Tue, 11 Dec 2018 08:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=A3iI1S+Om+sIC+ztdDR4tlO8XcxPCJfL/Men59gIMvQ=;
        b=Cf5+F2kMjt6Muf7oFm1DVU2B3fXKR0uFRgfsMlAQSqF+oSjv+aQezlHZ5LGu66uqaa
         dKmcKTDRuNpS8Qpvxi62p6CeiCFOZceUA6W4jqK3Qph/2SIxDHaeG02mqzNzMWTGQ0wN
         kD/tOAntXfK1DRD9SoU8jqN2Guj3ZJrmd7efycyxYgH7qt18lCJsL/VRtm0W3AMpRvVw
         2iLAqwnLnr2stvfs2BOVxFypUU8Q9MB3cwt0GNHc/u0x4HbwD29DFn/+BkMt95QakBlR
         /7ckqkgH3xuObkxQsNpV3cYoiMHDWKNQni9g1OFleHrl0ruF0g45YW7OEsEdrBg88vEQ
         zLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A3iI1S+Om+sIC+ztdDR4tlO8XcxPCJfL/Men59gIMvQ=;
        b=ugHq1lWssVhC0T42EbtzFtEH6KIaGnMvZZ/gHTVgxEOSmLwj39i1BzJ018B8qii0DH
         6Le4COE3pp25Z5xhE39GFv+JLB0L4fyL5+r/NSOz+SHRzNKZXJl9uqlt9L+hk0OuaExo
         0B0Jologz0t4l9hs4yK6iYHZzjI+Sjt/4ivMpK+0SnajS5kfO7IRJAe6p4+cwMO3897K
         tmSu0rEGf4UsdxL12IFySzAD/7n/ekaXFSsP2fCU1HCibkJyY2SNciJj/HcHAkvBO08+
         SmiZG1crWDOtP2gNy6PVfW01eYNL67e25jxpdy6YsIg1UNO9kk7OzugVnqKnfXU6b5Ez
         5aPw==
X-Gm-Message-State: AA+aEWYnTcjXodZADAesHQ/Sti1ad2Z9W4AQu5lhjHC7z53EEtdt/cBM
        5D4OOIjvENOmCXcURQk7Cy8=
X-Google-Smtp-Source: AFSGD/XHPa9Wb+AjqkSHaNk7ak3PlqBH4vjiGzS9ZiY8k8iQqpuSCMmZXChjCgsrecksj3QzYaoFtQ==
X-Received: by 2002:a65:434d:: with SMTP id k13mr15206919pgq.269.1544545251250;
        Tue, 11 Dec 2018 08:20:51 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id s21sm27425932pfk.133.2018.12.11.08.20.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 08:20:50 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] PM / sleep: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Tue, 11 Dec 2018 11:20:48 -0500
Message-Id: <20181211162048.21906-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 kernel/power/main.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 35b50823d83b..98e76cad128b 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -318,23 +318,12 @@ static int suspend_stats_show(struct seq_file *s, void *unused)
 
 	return 0;
 }
-
-static int suspend_stats_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, suspend_stats_show, NULL);
-}
-
-static const struct file_operations suspend_stats_operations = {
-	.open           = suspend_stats_open,
-	.read           = seq_read,
-	.llseek         = seq_lseek,
-	.release        = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(suspend_stats);
 
 static int __init pm_debugfs_init(void)
 {
 	debugfs_create_file("suspend_stats", S_IFREG | S_IRUGO,
-			NULL, NULL, &suspend_stats_operations);
+			NULL, NULL, &suspend_stats_fops);
 	return 0;
 }
 
-- 
2.17.0

