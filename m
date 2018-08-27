Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F9FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1700208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1700208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeH0PMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:12:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36089 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeH0PMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:12:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id f4-v6so7503831edq.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 04:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=STAowy5i/Ovr7pcwqADRmxoChyUfmhzfp3gxWxxtQrg=;
        b=J08YCnr247GhZxCNMG4tj/i6umcjkASDl/DEhQ8DC9mOee9cT2KzI0nQWJFUt9bZnS
         /m/NwrQIH25wYDzkcqFUEBGhBFtVKBuV50pgu9/enCfbbuN6UCLosElvmRHzCvdkW3GD
         dMWpAAEpIVdXJCEFFntjPe4Cm09RoS6evuJflnXZw3ihJpjj6aULvSQB6Crr9Wj/b15E
         i+ypqkZhjXnSiCbx6hpkmZCJcB9bYdFWWf+s1fGePcr30UOMVBO2wj/hqLPoJGvPe3jQ
         giooUhFEj/a7mDYoC8U6ZhvjcLe0hiAG/bxburf49ZCwfSBYI/wE7esAo/MCg7xWvhf7
         PEtg==
X-Gm-Message-State: APzg51D4Hu7IpPJu896qci0SfdCBdYMFpAW1hFuZi73BPMpRqt1+pK+u
        sV0fxWlifz0jnRRUtdgsddg=
X-Google-Smtp-Source: ANB0VdZZvx39y8SIVRv6LKINEWVt8/gzqt2GkV12tMIsM+z3ubPdS1IMsggZrvMsyFhjO333Ydpw9Q==
X-Received: by 2002:aa7:d28c:: with SMTP id w12-v6mr16823901edq.113.1535369196828;
        Mon, 27 Aug 2018 04:26:36 -0700 (PDT)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id v1-v6sm6454416edf.3.2018.08.27.04.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 04:26:36 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 1/3] xen/gntdev: fix up blockable calls to mn_invl_range_start
Date:   Mon, 27 Aug 2018 13:26:21 +0200
Message-Id: <20180827112623.8992-2-mhocko@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827112623.8992-1-mhocko@kernel.org>
References: <20180827112623.8992-1-mhocko@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

93065ac753e4 ("mm, oom: distinguish blockable mode for mmu notifiers")
has introduced blockable parameter to all mmu_notifiers and the notifier
has to back off when called in !blockable case and it could block down
the road.

The above commit implemented that for mn_invl_range_start but both
in_range checks are done unconditionally regardless of the blockable
mode and as such they would fail all the time for regular calls.
Fix this by checking blockable parameter as well.

Once we are there we can remove the stale TODO. The lock has to be
sleepable because we wait for completion down in gnttab_unmap_refs_sync.

Changes since v1
- pull in_range check into mn_invl_range_start - Juergen

Fixes: 93065ac753e4 ("mm, oom: distinguish blockable mode for mmu notifiers")
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 drivers/xen/gntdev.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 57390c7666e5..b0b02a501167 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -492,12 +492,19 @@ static bool in_range(struct gntdev_grant_map *map,
 	return true;
 }
 
-static void unmap_if_in_range(struct gntdev_grant_map *map,
-			      unsigned long start, unsigned long end)
+static int unmap_if_in_range(struct gntdev_grant_map *map,
+			      unsigned long start, unsigned long end,
+			      bool blockable)
 {
 	unsigned long mstart, mend;
 	int err;
 
+	if (!in_range(map, start, end))
+		return 0;
+
+	if (!blockable)
+		return -EAGAIN;
+
 	mstart = max(start, map->vma->vm_start);
 	mend   = min(end,   map->vma->vm_end);
 	pr_debug("map %d+%d (%lx %lx), range %lx %lx, mrange %lx %lx\n",
@@ -508,6 +515,8 @@ static void unmap_if_in_range(struct gntdev_grant_map *map,
 				(mstart - map->vma->vm_start) >> PAGE_SHIFT,
 				(mend - mstart) >> PAGE_SHIFT);
 	WARN_ON(err);
+
+	return 0;
 }
 
 static int mn_invl_range_start(struct mmu_notifier *mn,
@@ -519,25 +528,20 @@ static int mn_invl_range_start(struct mmu_notifier *mn,
 	struct gntdev_grant_map *map;
 	int ret = 0;
 
-	/* TODO do we really need a mutex here? */
 	if (blockable)
 		mutex_lock(&priv->lock);
 	else if (!mutex_trylock(&priv->lock))
 		return -EAGAIN;
 
 	list_for_each_entry(map, &priv->maps, next) {
-		if (in_range(map, start, end)) {
-			ret = -EAGAIN;
+		ret = unmap_if_in_range(map, start, end, blockable);
+		if (ret)
 			goto out_unlock;
-		}
-		unmap_if_in_range(map, start, end);
 	}
 	list_for_each_entry(map, &priv->freeable_maps, next) {
-		if (in_range(map, start, end)) {
-			ret = -EAGAIN;
+		ret = unmap_if_in_range(map, start, end, blockable);
+		if (ret)
 			goto out_unlock;
-		}
-		unmap_if_in_range(map, start, end);
 	}
 
 out_unlock:
-- 
2.18.0

