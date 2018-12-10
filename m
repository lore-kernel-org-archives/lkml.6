Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4F8C67839
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A84A20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efvuR7un"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A84A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeLJQIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:08:50 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44743 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeLJQIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:08:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id k8so5443300pls.11;
        Mon, 10 Dec 2018 08:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9XmuBgo3X/r2heBPeKrEVcmaJh77sahtm1sUcU0lykA=;
        b=efvuR7unTzK/7Xtuhehg7asbFL9aKh/6sJSUI0/QrEvzuvl+wWlEn27q/UZO/jmcfZ
         wnMZ3UYSEM9P3HWG4XAa+K5J+488ZJVboJ2GAQVkIehZ1NtMebwUbqviMtHqA7DPic4+
         ZsXsM6iOXJ5UkmAaSfkypibKw/fbrIWJ52zYYQObqZn72fjnuJrO7hN39Ae30rjBS8UA
         VQMGRDt6QZ7f6JyZ4lair2lBU0CtPbe7udLAPetPr5KaFBPVpgw4aQuZYqXgaKIWZe5m
         yAVzSdv/AFeLiCp2ZQB2b0qeMRaa5kLvQ3EOI7fHNbQYLO2Z3YRjJXOaQ9rml4CwBFqI
         kD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9XmuBgo3X/r2heBPeKrEVcmaJh77sahtm1sUcU0lykA=;
        b=OUL1t1xz0Xv7xwfleskvJw0L/jI1iPJGktzjxpaQyni6NfPV/Zv+VzgHNsUIdmZDU2
         shYHW9FEHli9DnleeIXD/XJT3/nekz5P7wmpy8qp91rRpVql3XEvKX7jvSxLdBBLpvRI
         isk0ABdzIqOM+UPsyntCBZX1Lss+uj2XFo7GS2fJts8uhEg69fSHa1IaPa1x9epvjOCu
         upTWQ7+opPbcLGpN0USGWdkqESv2SJk0mhOkhRjI1Qy3Vo69iQu6Mtv3Q7X4LhPDnlX8
         3XuPjsjkXCCQBm2AwdUj8PtJZy7ObUZt+F8g23wTnIHM9LVQQGDSc1oQydkVfhY5vfxc
         oJOg==
X-Gm-Message-State: AA+aEWYgYrG+JtZfr+KyfNVzlmZbaZE6MZb7oNEOYRZXc+L4j5ZgFdPM
        QrXOwI6OIsX4dJ37d+SDpvo=
X-Google-Smtp-Source: AFSGD/XW3hq4kP7W++hBdqWpLoAnlsqyk7G1JaS2KyUrulKpiY/YyqYmbtZIgrnvSEnlfBMlVFAuUA==
X-Received: by 2002:a17:902:6948:: with SMTP id k8mr12503991plt.2.1544458128260;
        Mon, 10 Dec 2018 08:08:48 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id t67sm22389492pfd.90.2018.12.10.08.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 08:08:47 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] bonding: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Mon, 10 Dec 2018 11:08:45 -0500
Message-Id: <20181210160845.20913-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/net/bonding/bond_debugfs.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bond_debugfs.c
index 3868e1a5126d..1360f1ffe070 100644
--- a/drivers/net/bonding/bond_debugfs.c
+++ b/drivers/net/bonding/bond_debugfs.c
@@ -45,19 +45,7 @@ static int bond_debug_rlb_hash_show(struct seq_file *m, void *v)
 
 	return 0;
 }
-
-static int bond_debug_rlb_hash_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, bond_debug_rlb_hash_show, inode->i_private);
-}
-
-static const struct file_operations bond_debug_rlb_hash_fops = {
-	.owner		= THIS_MODULE,
-	.open		= bond_debug_rlb_hash_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(bond_debug_rlb_hash);
 
 void bond_debug_register(struct bonding *bond)
 {
-- 
2.17.0

