Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99763C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7E620868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7E620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbeLGTQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:16:56 -0500
Received: from anholt.net ([50.246.234.109]:57632 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbeLGTQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 14:16:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 2425410A142E;
        Fri,  7 Dec 2018 11:16:55 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Qocy4TmCQFQF; Fri,  7 Dec 2018 11:16:54 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 1B2C110A0A02;
        Fri,  7 Dec 2018 11:16:54 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 8C4F72FE2D16; Fri,  7 Dec 2018 11:16:53 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        christian.koenig@amd.com
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH] drm/sched: Always trace the dependencies we wait on, to fix a race.
Date:   Fri,  7 Dec 2018 11:16:53 -0800
Message-Id: <20181207191653.30118-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The entity->dependency can go away completely once we've called
drm_sched_entity_add_dependency_cb() (if the cb is called before we
get around to tracing).  The tracepoint is more useful if we trace
every dependency instead of just ones that get callbacks installed,
anyway, so just do that.

Fixes any easy-to-produce OOPS when tracing the scheduler on V3D with
"perf record -a -e gpu_scheduler:.\* glxgears" and DEBUG_SLAB enabled.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 4463d3826ecb..e2942c9a11a7 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -440,13 +440,10 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 
 	while ((entity->dependency =
 			sched->ops->dependency(sched_job, entity))) {
+		trace_drm_sched_job_wait_dep(sched_job, entity->dependency);
 
-		if (drm_sched_entity_add_dependency_cb(entity)) {
-
-			trace_drm_sched_job_wait_dep(sched_job,
-						     entity->dependency);
+		if (drm_sched_entity_add_dependency_cb(entity))
 			return NULL;
-		}
 	}
 
 	/* skip jobs from entity that marked guilty */
-- 
2.20.0.rc1

