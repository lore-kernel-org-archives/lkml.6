Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DAAC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B45214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="qb48qzLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B45214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeJISat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:30:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34011 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeJISas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:30:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id g12-v6so660472pgs.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sy+r8jO0Q8UfjF0drR25FSVUoi9fSGNT9sYCdGAlsHo=;
        b=qb48qzLdrPCcT4dzCpc1qerS3usR4wixuvwV2JYKlwFBA60Tc8F7tf79Djf87xRAU+
         wTCiCYaNekIrm7xCIkmb8FwB1Y0SPmNxkNfj8ihasvqv4Mza1Xh7NY8vtLI2Jw+J0rg4
         RmwbA3Q+cbciTcdoiXcKxFz0GgQkDNVYqwj1+vAyd/Ip+9MpIZRBRmZ8N9azmwBPpEX9
         sPXzhq64U9zE5paxhJh2xC+i2hjTkpt9+DR5K1gv2qSHC92mXGWnXaT6rFYDpYJm9sXv
         bPW8A/z9EPpqfrQ63PDXLa7AF/UyMaknOnSsMyl4w1RWPx5FYaR+eSdYmm1OO16/GPau
         n+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sy+r8jO0Q8UfjF0drR25FSVUoi9fSGNT9sYCdGAlsHo=;
        b=kCuk2dYGrxuSYSJN26pfPZlZQ6I5iNHpzrbkU87v3o4u9bHkjSyO7As77bikccv+XC
         hgrPgl4ueAYyUBwHXPhU470wytudHhDW9XYUBj2Y62x6X0EDNmd9GaIkXuBqTDhraQcs
         QrY0OXiOdPL0lY2dCjaw+mTTxnBNYlb/axpgprXmlD6WNGfkmKN26m6IquX7Ag5clAHa
         jxz8VRAv+EaBHgrtkzXJytcdwRLuiGGeexFuMvSF8zu99nWjFgkc1pu98Mi3V2LaywQU
         2bPzIObaMkPbSxiKpCX2o18Sh+JQJfSxJCx4xXbRP7hwK8KgXWnBx7eZ2ppv+merrcWP
         6utw==
X-Gm-Message-State: ABuFfogmpcgCQMNeoTyJaDsJM6B2fBeGeT5MLL7siVd+DXx3qD9qCE+z
        CzhSFMzyMCS7VhnMMQWndCzIpA==
X-Google-Smtp-Source: ACcGV62eBanY5eJCkX4RbIofpg3vKxVYbAQAAZJC2bHBR3UZtQcZN59gGDtHj+N0YTaMvmMp6KKtpw==
X-Received: by 2002:a63:501:: with SMTP id 1-v6mr24837626pgf.205.1539083661626;
        Tue, 09 Oct 2018 04:14:21 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:14:20 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 20/45] lightnvm: pblk: fix write amplificiation calculation
Date:   Tue,  9 Oct 2018 13:11:50 +0200
Message-Id: <20181009111215.7653-21-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

When the user data counter exceeds 32 bits, the write amplification
calculation does not provide the right value. Fix this by using
div64_u64 in stead of div64.

Fixes: 76758390f83e ("lightnvm: pblk: export write amplification counters to sysfs")
Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index 9fc3dfa168b4..e56eeeeb914e 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -337,7 +337,6 @@ static ssize_t pblk_get_write_amp(u64 user, u64 gc, u64 pad,
 {
 	int sz;
 
-
 	sz = snprintf(page, PAGE_SIZE,
 			"user:%lld gc:%lld pad:%lld WA:",
 			user, gc, pad);
@@ -349,7 +348,7 @@ static ssize_t pblk_get_write_amp(u64 user, u64 gc, u64 pad,
 		u32 wa_frac;
 
 		wa_int = (user + gc + pad) * 100000;
-		wa_int = div_u64(wa_int, user);
+		wa_int = div64_u64(wa_int, user);
 		wa_int = div_u64_rem(wa_int, 100000, &wa_frac);
 
 		sz += snprintf(page + sz, PAGE_SIZE - sz, "%llu.%05u\n",
-- 
2.17.1

