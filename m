Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CF2C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554852083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EssQLpyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554852083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeHaF7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:59:21 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37464 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbeHaF7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:59:20 -0400
Received: by mail-yb1-f195.google.com with SMTP id f145-v6so330089ybg.4;
        Thu, 30 Aug 2018 18:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rHUzs00gtBEcf/iXCghUQ5cCQKHUCn7Y3ahs7HcS1YY=;
        b=EssQLpyrDxGRJAzRuWy/YJuWpnvt4vsVL2opMZ/12iKE7Tpsb2wt7YhKs3p29chxB3
         SoGVl+CqnoPxteowucNydIkpR6aG77oygw6KhmjKEjVPFx7IDLKM/uI0lv5Kkn1WMCks
         HxhMTSU837YTmCpNj8+CZPcL9pcqzDoYMrJ0OkeiqWKDigan/iSPlBmx502CNvbiFDO4
         uSWt8NEJgxwWfQnSuuQzdXkgbRnc3ocbCh8QlTLa0+iluHa+friudt9TwJZW/KpzhVg2
         8ByHXyrPfknxI1BgKyrySXdJ6mgEtAU8rDg6EVqAjJAXkAdRgZA5gGGeaAzfUnL+B76f
         3BRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rHUzs00gtBEcf/iXCghUQ5cCQKHUCn7Y3ahs7HcS1YY=;
        b=hR/BiM2KgLUE6EUWwOvCIJ0jJ0PPzdnLsgRGybRuWFLGxZZFV5S987lNudlo+PCer6
         J4oCgfT11ayV6boQVOnLx2Bk2ViwkQJLgBplnX4LoqYqH15eThU5eNmcIi2N/J4MBfGZ
         Op0OTC8XMjt+mY8iAZEL+M6lS/40Kh6aX9fbGybvysXS+V7yVUnKfE8sUs5qQ1sTFHEa
         wP6jMQI8HbYwyYBgBG0mnbQNcWazgGAQxMZwKJ224u+6dCIfMpSGJatbDevWEU3Eh6sp
         dEYAVL/R5ywoDx7iWk8avwXhDxtQYWKU86+hRV+HnfT62K8f1Jz9TXrEmveoA+4o0f14
         3iHQ==
X-Gm-Message-State: APzg51A6yDuiwqRheuxhU+t37ZpR9zGG29dNXrev62RcjsxRueCZrtvd
        hvhv6DQr6TcoVzi+8ZAR34U=
X-Google-Smtp-Source: ANB0VdYVlFxUJMRFoaq1Ex+bOIbHV92fmL+4a61YCbVNv8Qf/yzZiuxx+YPWXCRNe7lW/tR8HY9kPg==
X-Received: by 2002:a25:b906:: with SMTP id x6-v6mr7117416ybj.309.1535680458315;
        Thu, 30 Aug 2018 18:54:18 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id j70-v6sm3274084ywb.69.2018.08.30.18.54.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 18:54:17 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH 03/15] blkcg: use tryget logic when associating a blkg with a bio
Date:   Thu, 30 Aug 2018 21:53:44 -0400
Message-Id: <20180831015356.69796-4-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180831015356.69796-1-dennisszhou@gmail.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

There is a very small change a bio gets caught up in a really
unfortunate race between a task migration, cgroup exiting, and itself
trying to associate with a blkg. This is due to css offlining being
performed after the css->refcnt is killed which triggers removal of
blkgs that reach their blkg->refcnt of 0.

To avoid this, association with a blkg should use tryget and fallback to
using the root_blkg.

Fixes: 08e18eab0c579 ("block: add bi_blkg to the bio for cgroups")
Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
Cc: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 block/bio.c          | 3 ++-
 block/blk-throttle.c | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 04969b392c72..4473ccd22987 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1987,7 +1987,8 @@ int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
 {
 	if (unlikely(bio->bi_blkg))
 		return -EBUSY;
-	blkg_get(blkg);
+	if (!blkg_try_get(blkg))
+		return -ENODEV;
 	bio->bi_blkg = blkg;
 	return 0;
 }
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index a3eede00d302..c626e1f7cdcd 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2129,8 +2129,9 @@ static inline void throtl_update_latency_buckets(struct throtl_data *td)
 static void blk_throtl_assoc_bio(struct throtl_grp *tg, struct bio *bio)
 {
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-	if (bio->bi_css)
-		bio_associate_blkg(bio, tg_to_blkg(tg));
+	/* fallback to root_blkg if we fail to get a blkg ref */
+	if (bio->bi_css && bio_associate_blkg(bio, tg_to_blkg(tg)))
+		bio_associate_blkg(bio, bio->bi_disk->queue->root_blkg);
 	bio_issue_init(&bio->bi_issue, bio_sectors(bio));
 #endif
 }
-- 
2.17.1

