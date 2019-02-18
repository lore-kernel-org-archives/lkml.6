Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8095C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D60221736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500995;
	bh=zSoaJq2gNEny0ApVH87UAF1KMY7aq/M5WJMdUvaqit0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gGq3mzjRMLXY2RLn8dAZ5MhG6vENve3S0X0uErK08AtsCcp4SXpi/0aWBKIzLKlEE
	 4l3Pxb7cNU5yjsf7el1RlpToob47O94e3QYwPvtHNn1YG263gpVQLajcgOkBmtfX/6
	 o2s8xWOXpCE1984fifsM12pXb9lHrrynNFsKbe4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbfBRNtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:49:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:56842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729248AbfBRNtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:49:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6774F21906;
        Mon, 18 Feb 2019 13:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497772;
        bh=zSoaJq2gNEny0ApVH87UAF1KMY7aq/M5WJMdUvaqit0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MkxF8eerDrUhjyyByW2t1GGc7hIOgxxB7qDh3tpNyNdB50+pD9ltXlN2Sc21jOWFN
         7jj34bn2K9LGlLJF1Pj5FNnEXRmbjsd5eGS48Foyhumkpn79bL+OyflfvNU0EalJuw
         Y+dHqG10w3+LJDgeStxweqaSUBP+62iM1O+u3PbI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.20 90/92] drm/sched: Always trace the dependencies we wait on, to fix a race.
Date:   Mon, 18 Feb 2019 14:43:33 +0100
Message-Id: <20190218133503.734766720@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Anholt <eric@anholt.net>

commit 82abf33766712d8446ea137a3400165e31bd12c7 upstream.

The entity->dependency can go away completely once we've called
drm_sched_entity_add_dependency_cb() (if the cb is called before we
get around to tracing).  The tracepoint is more useful if we trace
every dependency instead of just ones that get callbacks installed,
anyway, so just do that.

Fixes any easy-to-produce OOPS when tracing the scheduler on V3D with
"perf record -a -e gpu_scheduler:.\* glxgears" and DEBUG_SLAB enabled.

Signed-off-by: Eric Anholt <eric@anholt.net>
Reviewed-by: Christian König <christian.koenig@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/scheduler/sched_entity.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -434,13 +434,10 @@ struct drm_sched_job *drm_sched_entity_p
 
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


