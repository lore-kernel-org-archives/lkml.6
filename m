Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C81C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E51820672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtVcSaKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E51820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395181AbeKVXjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:39:00 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35691 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391180AbeKVXi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:38:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so1939133pfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 04:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NvORi37yejSIkLk6y0OD0wL76jkqOTihkurM9dCYMsQ=;
        b=QtVcSaKgwzfZuOdMPe2gv793OZev9HwJ2Ee6QVGpnokLSOWYxsHoWUDZIg6NhZkgJz
         LTT99B+oPiyqW4mad5WEdK9i52W7pw6RK2L+UAjC8olmaOEZIbZe1LT1UjKwvc/+JcPF
         8fJK/Cch37lUhV0TSyoI2+RVHGJIpttSXTxcdrV8rHLnO1JPIG5LeyEoDtXLqgRMvqNd
         PY1o7gRvORUPZT3WV2IxI4ZepF6q/9hUoLZINIiPM0f9tiOR/z16+75jbZ/oG7UulqIl
         I8caMm04O9TE+dY6OdNBpzCqGplxNjTEqfFwH9pFZKsJMBfXyyTUE/IxIl/VahfDM8ZO
         2Ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NvORi37yejSIkLk6y0OD0wL76jkqOTihkurM9dCYMsQ=;
        b=jMI03i4YoZ1MCH6/IDgUCIjd8t+AitzSO8nXbJBJCTd1b8Hq9z1Uyiu+QvASiXFu+n
         nnsRLJk6pHjd8moWanpDpp8OYFUF/LyHBHq0ZgvxugNum38G2256zobHofZutENzEgf6
         tWiaCms2ApuMeORLlb+1R0Bz7loIHq+cfiygosjh4rMg7JKOYd0PQQAKhVTLfcl6jSLl
         WNspXKH41iLE/qmg21ohgkFsSTNd0ghFqMbsAyYsLrA/Wql3iROBXGUt4xlTLxGVvQpt
         dSM/+OEzHFu+bLxq8CPXKdbykHPn/x8BocUHSr1Zkovl8LvXoOk0OKvnk4iscjqE2XVw
         NaJw==
X-Gm-Message-State: AA+aEWaGlMm2T6VWZ/fWhl1E+CVrAPrdXaMD3W7R9IsIMH8AikKeT5Km
        8S7TWf/BTKsROJHxhwffffg=
X-Google-Smtp-Source: AFSGD/Uyxmm1uydXk1v0EwwaBn6m3HLHUhGL61MkMobkfsn8InMT21iZaOOUZpYtkMWCohNXFFjA0g==
X-Received: by 2002:a65:47ca:: with SMTP id f10mr10242756pgs.166.1542891584937;
        Thu, 22 Nov 2018 04:59:44 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id f13sm33270098pfa.132.2018.11.22.04.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 04:59:44 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] soc: sunxi: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Thu, 22 Nov 2018 07:59:41 -0500
Message-Id: <20181122125941.24615-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/soc/sunxi/sunxi_sram.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index b4b0f3480bd3..71e3ee4a3f19 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -155,17 +155,7 @@ static int sunxi_sram_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int sunxi_sram_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, sunxi_sram_show, inode->i_private);
-}
-
-static const struct file_operations sunxi_sram_fops = {
-	.open = sunxi_sram_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(sunxi_sram);
 
 static inline struct sunxi_sram_desc *to_sram_desc(const struct sunxi_sram_data *data)
 {
-- 
2.17.0

