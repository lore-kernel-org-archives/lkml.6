Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB9EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E912154D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E912154D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731784AbeHWPhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 11:37:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38844 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730955AbeHWPhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 11:37:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id h33-v6so861954edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 05:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x3X8iTmmDVmbZg+GFO8nNpySozOz0j/Bz+kB94r0EDQ=;
        b=JpbAlr8X81uOpH5LpcG91ntFPdL9LW2yRPLap6h4I4KTHoL4K39KD1EkkJqPvE/ltB
         6PI4/ypXdnii4heuB4Xp6UANzYSRNZY3EaqHe+FyqyZKMjMbPya0mAury258aeyu48JV
         N/xkiuaE4DNlaRELvrs+3KJ45l7YeqT4SEL1EyI5nM5lH47lwQmQOTOZVzgi8d4Br4Eh
         bGgvuePD3fhQLZSpJHI2vreOJH3B8P3+RyYlz6vozKLif6wbHJ9XpYzZQdP5XNnNA8Fv
         LwfdQtUkzh/CNiBK8J5i3PJkKKSqLQS+eqkjQEGnk/gHAUAHDejcPHN0Ia9mIQbmo7OH
         1XdA==
X-Gm-Message-State: APzg51BLHmtDt5rL9IJFYS7BEp7MrhAXuxUGC0RfMRjNcWY79edREwVW
        86deh7Fn5wQvEjyb6OK3yrA=
X-Google-Smtp-Source: ANB0Vda6iF8vEY0DK/LMsyJN93ho1ZQKEJo5UUli/HV0fgEThURrntU34PjM4EmQIQHjUnELdHeR/A==
X-Received: by 2002:a50:eb96:: with SMTP id y22-v6mr2361818edr.38.1535026062734;
        Thu, 23 Aug 2018 05:07:42 -0700 (PDT)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id g54-v6sm2575789edb.47.2018.08.23.05.07.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 05:07:41 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        <linux-mm@kvack.org>, xen-devel@lists.xenproject.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH] xen/gntdev: fix up blockable calls to mn_invl_range_start
Date:   Thu, 23 Aug 2018 14:07:07 +0200
Message-Id: <20180823120707.10998-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.18.0
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

Fixes: 93065ac753e4 ("mm, oom: distinguish blockable mode for mmu notifiers")
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 drivers/xen/gntdev.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 57390c7666e5..e7d8bb1bee2a 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -519,21 +519,20 @@ static int mn_invl_range_start(struct mmu_notifier *mn,
 	struct gntdev_grant_map *map;
 	int ret = 0;
 
-	/* TODO do we really need a mutex here? */
 	if (blockable)
 		mutex_lock(&priv->lock);
 	else if (!mutex_trylock(&priv->lock))
 		return -EAGAIN;
 
 	list_for_each_entry(map, &priv->maps, next) {
-		if (in_range(map, start, end)) {
+		if (!blockable && in_range(map, start, end)) {
 			ret = -EAGAIN;
 			goto out_unlock;
 		}
 		unmap_if_in_range(map, start, end);
 	}
 	list_for_each_entry(map, &priv->freeable_maps, next) {
-		if (in_range(map, start, end)) {
+		if (!blockable && in_range(map, start, end)) {
 			ret = -EAGAIN;
 			goto out_unlock;
 		}
-- 
2.18.0

