Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D24ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4401320671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=markrailton-com.20150623.gappssmtp.com header.i=@markrailton-com.20150623.gappssmtp.com header.b="I2u+1skL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4401320671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=markrailton.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbeGSX51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:57:27 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38517 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbeGSX51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:57:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id t2-v6so8289644edr.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 16:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=markrailton-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=DpbbLnEiEG1VZ1UOyL2vfbQqx/Hozh6UHDvKj8++4lQ=;
        b=I2u+1skLKL51ToIs5OAj7doasN2urhsYj1i5kT5L0jnfB4damZLipfO8uGYCub3zvC
         /AB0QGIdSFOYVauP3vLoaWJQOPPXH2ktJDzNadOk4WdgHV2Y94GkBbiYqqilCDCDC6Ft
         cTZC/aWsVU2bR0iA6yK9hXcM2LRdkDaUDWLzXLZHcFjt8Xd3dybLJexQRaYSdpI1R3mC
         5dXILiiHp60cM7Cy0jm3i7xfTPJ9c4FZmp0Z1zxmfk0b6rhoDx74bLBPiJebBiw/H7tA
         q4UhZfNL8cK2/CKYBYM+EL7ALIQbbdIVAx4632DOo+j90yw4CkmZTFViDi/11xrK+KDw
         ov0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DpbbLnEiEG1VZ1UOyL2vfbQqx/Hozh6UHDvKj8++4lQ=;
        b=D2iZtip760heLXUj5BxVmr86DX2O74UldzuJOpIl5CMR7qs1U7rQqsh6NIxD8uE2Xc
         VeczIXcR1WPHEI0K5NIO4BTEePpgqpEHSTyQ4Wr2nEt/iere66sJkAmvktNNzEUCijPf
         zkqA0l7tKWklRca30EC0AhoMMknty0lqYj0huOh9dfHiEohZJESQUcGnR/RUHwahrBws
         G7qhxB1y4wwZDRTDci60qr802hW839jzd1OAg5TPXy80kPgoOGyfSiug/7n4T1ivM6ER
         PIy8PBy0435qF08NElJl4YcV15WLk/NAQHOtfRM1ZFU7NmYdeaMA8p037IWT8Kc1qSDc
         rt0g==
X-Gm-Message-State: AOUpUlH2G6gAm00brLX1tlef00m2WLYBiwSEXSN0e5Y87DE8ptyPhO/q
        G/xcdrZfVta6ZFqOFO9scf0MTQ==
X-Google-Smtp-Source: AAOMgpeC8Q5yd+ivtF9ierFAnklJ14w+4zZyBsXihXItJxRihLooGetD1ZJHFq8RdHMBKMHCZDYKtw==
X-Received: by 2002:a50:8818:: with SMTP id b24-v6mr31655edb.274.1532041927828;
        Thu, 19 Jul 2018 16:12:07 -0700 (PDT)
Received: from localhost.localdomain ([109.255.141.80])
        by smtp.gmail.com with ESMTPSA id d15-v6sm347858edq.31.2018.07.19.16.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 16:12:07 -0700 (PDT)
From:   Mark Railton <mark@markrailton.com>
To:     inaky.perez-gonzalez@intel.com, davem@davemloft.net
Cc:     linux-wimax@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Railton <mark@markrailton.com>
Subject: [PATCH] net: wimax: stack: fixed multi line comment issue
Date:   Fri, 20 Jul 2018 00:11:46 +0100
Message-Id: <20180719231146.24532-1-mark@markrailton.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moved end of comment to it's own line per guide

Signed-off-by: Mark Railton <mark@markrailton.com>
---
 net/wimax/stack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wimax/stack.c b/net/wimax/stack.c
index 5db731512014..73dba9c077bb 100644
--- a/net/wimax/stack.c
+++ b/net/wimax/stack.c
@@ -486,7 +486,8 @@ int wimax_dev_add(struct wimax_dev *wimax_dev, struct net_device *net_dev)
 	d_fnstart(3, dev, "(wimax_dev %p net_dev %p)\n", wimax_dev, net_dev);
 
 	/* Do the RFKILL setup before locking, as RFKILL will call
-	 * into our functions. */
+	 * into our functions.
+	 */
 	wimax_dev->net_dev = net_dev;
 	result = wimax_rfkill_add(wimax_dev);
 	if (result < 0)
-- 
2.17.1

