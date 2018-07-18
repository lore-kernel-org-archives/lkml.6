Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7384CECDFBC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A1520850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlWTortO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A1520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbeGRMZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:25:25 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:44348 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730862AbeGRMZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:25:24 -0400
Received: by mail-yb0-f196.google.com with SMTP id l16-v6so1697415ybk.11;
        Wed, 18 Jul 2018 04:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gvLDZTu3mNAiz+EgKRgTt9hMPHar6ksAVZMnG3tg2L8=;
        b=AlWTortOx5BXy75jpqiyWliqZ16Egrsp4AYcUH6tt3ZbDhcY/6YecfGhhQGpOMjo+g
         tqyGPRZN8i1kKh0+9b5qy36JKKJ6W0Kb36GPrVMr9SfMnMdJ97ID8OxR6RDhHbJazyV8
         SBygzAueZN43Azr74uWePC5BQhyR86nZ+26+X+xycbU6aP1e56DNOKTKeW2CdqT5hSRK
         jLlYKj3QEN8eJChL1HXsbKYKewaddkavDI/bqcp2uEkPDGAwD6vPQ4+/P/lMDajYG7kP
         AD1/sd50BXPj4+Rf4MJT55zLzIGKyDLIml5NY5ydte1nikozPVj0UKfEwQi6TZroMgfp
         tsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=gvLDZTu3mNAiz+EgKRgTt9hMPHar6ksAVZMnG3tg2L8=;
        b=WIFJwwQqGIDlXTIr1zcx0JlFt97P6Ja/iF+jkrWj0ZZ/PVPOboPvtUDp8wRerWR/Ya
         6hBf81m1Q6IauzT6kuY6qDWwRhGeX/vRrn7KIjB1nYbvXAm0ulD34hamwVZPeAGwEYHr
         hyRKGmduQ5FjWl+cecbsYgqSuirM2ovuLUbSJcN9ryeZ2RZ2TSxwxnod/08J/RzsKWoc
         pVn11S1YyJ2IExKuGfyrR0uW/PdT+D+hTEuLCHfb3VR/tfCMP5WJjc+EOCH++7sHYgG6
         +Iab6/exVoBlS1mpWOLfivKBu4VNSLez8k+R5iqMw8VBaGUYHBmiRNmWTVUBgWT4bdUB
         /5sw==
X-Gm-Message-State: AOUpUlEC3pac/vZoSJxb7lH7ZuEXsbTLBS/uJjn2X+qTDbYEREVBhcvt
        3uVz1ceESquEEmqw1HQULuJKHeCf
X-Google-Smtp-Source: AAOMgpfvbGuWGcGfqa+phfrseVS5zp8Vv10ssabZUPTazmuXggH4zCt4pOhh3UpiNOUsYunFfaqlcA==
X-Received: by 2002:a25:9392:: with SMTP id a18-v6mr2878355ybm.503.1531914471393;
        Wed, 18 Jul 2018 04:47:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:c229])
        by smtp.gmail.com with ESMTPSA id 133-v6sm1617294ywu.64.2018.07.18.04.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 04:47:50 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     michaelcallahan@fb.com, newella@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-api@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/6] block: Add part_stat_read_accum to read across field entries.
Date:   Wed, 18 Jul 2018 04:47:37 -0700
Message-Id: <20180718114741.2580313-3-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718114741.2580313-1-tj@kernel.org>
References: <20180718114741.2580313-1-tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Callahan <michaelcallahan@fb.com>

Add a part_stat_read_accum macro to genhd.h to read and sum across
field entries.  For example to sum up the number read and write
sectors completed.  In addition to being ar reasonable cleanup by
itself this will make it easier to add new stat fields in the future.

tj: Refreshed on top of v4.17.

Signed-off-by: Michael Callahan <michaelcallahan@fb.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/block/drbd/drbd_receiver.c | 3 +--
 drivers/block/drbd/drbd_worker.c   | 4 +---
 drivers/md/md.c                    | 3 +--
 include/linux/genhd.h              | 4 ++++
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index a36a30795c43..75f6b47169e6 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2674,8 +2674,7 @@ bool drbd_rs_c_min_rate_throttle(struct drbd_device *device)
 	if (c_min_rate == 0)
 		return false;
 
-	curr_events = (int)part_stat_read(&disk->part0, sectors[0]) +
-		      (int)part_stat_read(&disk->part0, sectors[1]) -
+	curr_events = (int)part_stat_read_accum(&disk->part0, sectors) -
 			atomic_read(&device->rs_sect_ev);
 
 	if (atomic_read(&device->ap_actlog_cnt)
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 5e793dd7adfb..b8f77e83d456 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -1690,9 +1690,7 @@ void drbd_rs_controller_reset(struct drbd_device *device)
 	atomic_set(&device->rs_sect_in, 0);
 	atomic_set(&device->rs_sect_ev, 0);
 	device->rs_in_flight = 0;
-	device->rs_last_events =
-		(int)part_stat_read(&disk->part0, sectors[0]) +
-		(int)part_stat_read(&disk->part0, sectors[1]);
+	device->rs_last_events = (int)part_stat_read_accum(&disk->part0, sectors);
 
 	/* Updating the RCU protected object in place is necessary since
 	   this function gets called from atomic context.
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 994aed2f9dff..dabe36723d60 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8046,8 +8046,7 @@ static int is_mddev_idle(struct mddev *mddev, int init)
 	rcu_read_lock();
 	rdev_for_each_rcu(rdev, mddev) {
 		struct gendisk *disk = rdev->bdev->bd_contains->bd_disk;
-		curr_events = (int)part_stat_read(&disk->part0, sectors[0]) +
-			      (int)part_stat_read(&disk->part0, sectors[1]) -
+		curr_events = (int)part_stat_read_accum(&disk->part0, sectors) -
 			      atomic_read(&disk->sync_io);
 		/* sync IO will cause sync_io to increase before the disk_stats
 		 * as sync_io is counted when a request starts, and
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 6cb8a5789668..19f36fa10995 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -353,6 +353,10 @@ static inline void free_part_stats(struct hd_struct *part)
 
 #endif /* CONFIG_SMP */
 
+#define part_stat_read_accum(part, field)				\
+	(part_stat_read(part, field[0]) +				\
+	 part_stat_read(part, field[1]))
+
 #define part_stat_add(cpu, part, field, addnd)	do {			\
 	__part_stat_add((cpu), (part), field, addnd);			\
 	if ((part)->partno)						\
-- 
2.17.1

