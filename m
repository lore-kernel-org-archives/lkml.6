Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A215C5AE5A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238612075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyeq9yRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238612075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030846AbeFST5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:57:16 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52755 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030806AbeFST5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:57:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id p126-v6so2305460wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 12:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/Sa3kA+EAp14LH46GgtV7QPWU5+TByUHKF/FSAx4vn0=;
        b=jyeq9yRbwOoPO/+WI2jkfFrwSzoTgeHpwPGPrgXm7Oeump262CLBjJMKOd/ezKfD1e
         O+6/FHb9CEQqDi71ydVpG64Duh36BSTI0HUndVYjIC7jEbXrWze9mGD1CDqfsh7tv5kj
         q0qauKkU2k8mK9MF7wJvbypYRUsH1fO7gfO94YEYQIea2ZHDi1pLK1ximxyiLPu+PlFT
         F0Wan5gbKFcAPnzjFaZkX5i20m0rV1ZT9CoDX9rQcDajC5/k9ZDjHK14+Z0PCJ1m3vmm
         8HPmeYiyl3BHym15vSb7z8xSVbo+W4XYlWGjJYSpy4iSkf6wMZ1QTwmF5RqF5sw9Vnlw
         mQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/Sa3kA+EAp14LH46GgtV7QPWU5+TByUHKF/FSAx4vn0=;
        b=Xi25QUHZ1u3xdag0tWfWubT5xmI2+S+51sJOIufsutpBKdnGPI/ChMS3nwI/Vl7aA9
         cB5pKeycGeAY2Bob3rDCJrMlvc2YLJCr3Tu0O/FWYO9T4GFI5SOr5cyT330qNoJnDJYe
         nSN7ehMI6cfAOV/oH2tbJXOXEu3TR4HuHMVdUCzDRaiWnrX7j++2NUdL8o6XP835V9Pu
         BfGr1mO7FzpMy+rrBSMePjFMGhaH6HCx6bpLzDeOm/c2R4gk00K/uxmoZSlvduHVZLXG
         EyxbI+0OUjecqZ4yGY94YGZlJ/uPzyi5CxQrBxNo+eHejfYFDCPe5+tq8Q71LkJLpENe
         nJbw==
X-Gm-Message-State: APt69E0yTnPNdecF+KRbKrm3d9iveVy+M70yVjgGbLHLVcc2mpujzAPv
        TQ2hR50u5X4IBSQBxTLtkVXppg==
X-Google-Smtp-Source: ADUXVKJSLjMl4AXTZWv65v4cdGf+weBabPhX7vmAcPdCW+32IpmO8wCQdekavfhBt1MJpBq4ipfrow==
X-Received: by 2002:a1c:d9cb:: with SMTP id q194-v6mr12579728wmg.91.1529438229332;
        Tue, 19 Jun 2018 12:57:09 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id c53-v6sm1105983wrg.12.2018.06.19.12.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 12:57:08 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 9/9] staging: rtl8192u: Correction of spelling mistake in comment.
Date:   Tue, 19 Jun 2018 20:56:05 +0100
Message-Id: <20180619195605.31321-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619195605.31321-1-johnfwhitmore@gmail.com>
References: <20180619195605.31321-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple spelling correction.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 05f0c8130458..35d85e0a45a6 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -879,7 +879,7 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 	/*
 	 * TODO: fill suggested rate adaptive rate index and give firmware info
 	 * using Tx command packet we also shall suggested the first start rate
-	 * set according to our singal strength
+	 * set according to our signal strength
 	 */
 	HT_PickMCSRate(ieee, pOperateMCS);
 
-- 
2.17.1

