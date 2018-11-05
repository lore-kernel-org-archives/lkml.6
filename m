Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74C9C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F0920685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhHXnwi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F0920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbeKFAK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:10:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41081 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbeKFAK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:10:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id e22-v6so4536575pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 06:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2B7uMq8TqOBuAo7vU8+IMU1kjMIN9Kqw1L+asdWIuHQ=;
        b=jhHXnwi5N3/L7zBLT3i/y/rO8BSQ6O8PFmse5gtSTVsbMoUbT4PVUDiVzQ4ckcnEkB
         dcrpGyA3hilxNjRqYsReykOqJf+GFpgA3t9AzPOO+1GJDMVbu3UB0+S+WC95LaRFBvqK
         v5GCgaLm1L18Jk2KudnVwnmg9p52Sj6MypiRKh/Gy8saCceAeHGgn1kuzqB0HPm7JbEK
         jZZiXF55f/NUZGokNiiVPt3TrBUCUz6N5F86FObO04OTDqYGIjTti16LiXEheTzj+V1+
         LO9zgsYTeaFpGoJMOpv0IvRsvwkJud2L79UnzoH/+rxrMriGiX0pehDXxSXyFQSCIB8r
         iVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2B7uMq8TqOBuAo7vU8+IMU1kjMIN9Kqw1L+asdWIuHQ=;
        b=dne4+/Au6M1bQ5gGgjQQibRKxkjCoKZR/6u7kwVBcySGZVp4gX8a87+6eamuyd+Au2
         6dJycjFAnesimycBvdEXeCzDkLf1Aoz9HAsEmHi/aaSkCIblaZQ7CJot1Pd0kQAlnvia
         1/RLBNacdpd0eH7IbV8yEfowswC8zU7RKxKMXwICrQrNUw92vS9/Ab9UHrNywvJkDprM
         68i7uo5aMJJG18eiXOb99czKUfVLDXUA21Dpu0rZ/Wm/9eDHKFwuXwayXIPgogb1/hNN
         ylQlBl7KMGjPsot63Z5ghC8Q3Idt6SlNlepJNwnB3/xq3G7L/WVaIcaHT9ZstnwmfYlG
         9Ejg==
X-Gm-Message-State: AGRZ1gKErLDKUHwb/qx3nc/dEfQU3qMsBjBHHUFGsyLAO6GkUrkZi5Ji
        FE2tL1+oIS4FfosbDnCEGfA=
X-Google-Smtp-Source: AJdET5c+p64hChEXHWkpMFitn4qV3I8r3BonAN+kHb2NbL0DiRovQvbY//NAb++dn+M8vyVvfMCjKA==
X-Received: by 2002:a62:1693:: with SMTP id 141-v6mr22992293pfw.183.1541429454756;
        Mon, 05 Nov 2018 06:50:54 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id e204-v6sm8594336pfh.68.2018.11.05.06.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 06:50:54 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] MIPS: math-emu: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Mon,  5 Nov 2018 09:50:49 -0500
Message-Id: <20181105145049.6336-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/mips/math-emu/me-debugfs.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/mips/math-emu/me-debugfs.c b/arch/mips/math-emu/me-debugfs.c
index 62566385ce0e..58798f527356 100644
--- a/arch/mips/math-emu/me-debugfs.c
+++ b/arch/mips/math-emu/me-debugfs.c
@@ -183,17 +183,7 @@ static int fpuemustats_clear_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int fpuemustats_clear_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, fpuemustats_clear_show, inode->i_private);
-}
-
-static const struct file_operations fpuemustats_clear_fops = {
-	.open                   = fpuemustats_clear_open,
-	.read			= seq_read,
-	.llseek			= seq_lseek,
-	.release		= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(fpuemustats_clear);
 
 static int __init debugfs_fpuemu(void)
 {
-- 
2.17.0

