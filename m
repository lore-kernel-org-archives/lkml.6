Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF0BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 11:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53AB020850
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 11:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfBWLxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 06:53:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38430 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfBWLxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 06:53:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so5091629wrw.5;
        Sat, 23 Feb 2019 03:53:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9tjbUZRarjwm9AkVNVQkUwi4vwQIYXsUsYTQdPeGP8=;
        b=m5dJulmsPouarOPj8frkI6uoU8kdnH390+WmS1ZIaz18F2HSRwtC8XyeAOOxZjg4G0
         gCzT5WYJjn2CxjYzqiNHH+53E7+HSaLKSRvHJw997YAkjdmIdbNw9I/ct4KbFsrYrXWG
         ZNcjkW7iGx58qSF/EBj21jO9LCk5N7K3wjHLUcy8fiumiwIjubM9lM9+n87evAKY6KHS
         7blqiE1lvm87dX4HK/y0eloU9VDwoyK9rACxfmzmZ63xc+cHIK4hYXDdKiBXBdE9OW3i
         8YKa2p3CUOS+KNr9gUPUfMTixobLxztq5KeI9PLssdgvSSMkLcuu1Wx1pfPPhK1xmmVN
         /CLQ==
X-Gm-Message-State: AHQUAuac6NCnXDKRG+UulmrYSFqj5JLSZ1IxFF108ZKUwIHsBGoRKSyC
        G0FuMCFe2cGhmDR1ta6S3cc=
X-Google-Smtp-Source: AHgI3IZ2OC3+vH6z4vFgxNqfes78neSCAB1+PUkSHxL95cKSYhN8QK8qUYeFMyGMGg18GpVvRxUpcA==
X-Received: by 2002:a5d:5042:: with SMTP id h2mr6345352wrt.12.1550922813202;
        Sat, 23 Feb 2019 03:53:33 -0800 (PST)
Received: from timur-laptop.fritz.box (dslb-146-060-168-212.146.060.pools.vodafone-ip.de. [146.60.168.212])
        by smtp.gmail.com with ESMTPSA id d206sm6466324wmc.11.2019.02.23.03.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Feb 2019 03:53:32 -0800 (PST)
From:   Timur Celik <mail@timurcelik.de>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Timur Celik <mail@timurcelik.de>
Subject: [PATCH] tun: fix blocking read
Date:   Sat, 23 Feb 2019 12:53:13 +0100
Message-Id: <20190223115313.15064-1-mail@timurcelik.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves setting of the current state into the loop. Otherwise
the task may end up in a busy wait loop if none of the break conditions
are met.

Signed-off-by: Timur Celik <mail@timurcelik.de>
---
 drivers/net/tun.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index fed298c0cb39..d291762b9e9d 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2167,9 +2167,9 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
 	}
 
 	add_wait_queue(&tfile->wq.wait, &wait);
-	current->state = TASK_INTERRUPTIBLE;
 
 	while (1) {
+		set_current_state(TASK_INTERRUPTIBLE);
 		ptr = ptr_ring_consume(&tfile->tx_ring);
 		if (ptr)
 			break;
@@ -2185,7 +2185,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
 		schedule();
 	}
 
-	current->state = TASK_RUNNING;
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&tfile->wq.wait, &wait);
 
 out:
-- 
2.20.1

