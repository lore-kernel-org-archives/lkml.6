Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06085C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2087E2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2087E2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbeLCUO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:14:57 -0500
Received: from anholt.net ([50.246.234.109]:53288 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbeLCUO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:14:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 6254C10A12C6;
        Mon,  3 Dec 2018 12:14:55 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id uHojUlnKaulw; Mon,  3 Dec 2018 12:14:54 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 03AFD10A0388;
        Mon,  3 Dec 2018 12:14:54 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 842112FE2D16; Mon,  3 Dec 2018 12:14:53 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        christian.koenig@amd.com
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH] drm/sched: Fix a use-after-free when tracing the scheduler.
Date:   Mon,  3 Dec 2018 12:14:53 -0800
Message-Id: <20181203201453.25773-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With DEBUG_SLAB (poisoning on free) enabled, I could quickly produce
an oops when tracing V3D.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

I think this patch is correct (though maybe a bigger refactor could
avoid the extra get/put?), but I've still got this with "vblank_mode=0
perf record -a -e v3d:.\* -e gpu_scheduler:.\* glxgears".  Any ideas?

[  139.842191] Unable to handle kernel NULL pointer dereference at virtual address 00000020
[  139.850413] pgd = eab7bb57
[  139.854424] [00000020] *pgd=80000040004003, *pmd=00000000
[  139.860523] Internal error: Oops: 206 [#1] SMP ARM
[  139.865340] Modules linked in:
[  139.868404] CPU: 0 PID: 1161 Comm: v3d_render Not tainted 4.20.0-rc4+ #552
[  139.875287] Hardware name: Broadcom STB (Flattened Device Tree)
[  139.881228] PC is at perf_trace_drm_sched_job_wait_dep+0xa8/0xf4
[  139.887243] LR is at 0xe9790274
[  139.890388] pc : [<c06e715c>]    lr : [<e9790274>]    psr: a0050013
[  139.896662] sp : ed21dec0  ip : ed21dec0  fp : ed21df04
[  139.901893] r10: ed267478  r9 : 00000000  r8 : ff7bde04
[  139.907123] r7 : 00000000  r6 : 00000063  r5 : 00000000  r4 : c1208448
[  139.913659] r3 : c1265690  r2 : ff7bf660  r1 : 00000034  r0 : ff7bf660
[  139.920196] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  139.927339] Control: 30c5383d  Table: 68fa3b40  DAC: fffffffd
[  139.933095] Process v3d_render (pid: 1161, stack limit = 0xb3c84b1b)
[  139.939457] Stack: (0xed21dec0 to 0xed21e000)
[  139.943821] dec0: 20050013 ffffffff eb9700cc 00000000 ec0e8e80 00000000 eb9700cc e9790274
[  139.952009] dee0: 00000000 e2f59345 eb970078 eba8f680 c12ae00c c1208478 00000000 e8c2b048
[  139.960197] df00: eb9700cc c06e92e4 c06e8f04 00000000 80050013 ed267478 eb970078 00000000
[  139.968385] df20: ed267578 c0e45ae0 e9093080 c06e831c ed267630 c06e8120 c06e77d4 c1208448
[  139.976573] df40: ee2e8acc 00000001 00000000 ee2e8640 c0272ab4 ed21df54 ed21df54 e2f59345
[  139.984762] df60: ed21c000 ed1b4800 ed2d7840 00000000 ed21c000 ed267478 c06e8084 ee935cb0
[  139.992950] df80: ed1b4838 c0249b44 ed21c000 ed2d7840 c02499e4 00000000 00000000 00000000
[  140.001138] dfa0: 00000000 00000000 00000000 c02010ac 00000000 00000000 00000000 00000000
[  140.009326] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[  140.017514] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[  140.025707] [<c06e715c>] (perf_trace_drm_sched_job_wait_dep) from [<c06e92e4>] (drm_sched_entity_pop_job+0x394/0x438)
[  140.036332] [<c06e92e4>] (drm_sched_entity_pop_job) from [<c06e8120>] (drm_sched_main+0x9c/0x298)
[  140.045221] [<c06e8120>] (drm_sched_main) from [<c0249b44>] (kthread+0x160/0x168)
[  140.052716] [<c0249b44>] (kthread) from [<c02010ac>] (ret_from_fork+0x14/0x28)

 drivers/gpu/drm/scheduler/sched_entity.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 4463d3826ecb..0d4fc86089cb 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -440,13 +440,15 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 
 	while ((entity->dependency =
 			sched->ops->dependency(sched_job, entity))) {
-
+		dma_fence_get(entity->dependency);
 		if (drm_sched_entity_add_dependency_cb(entity)) {
 
 			trace_drm_sched_job_wait_dep(sched_job,
 						     entity->dependency);
+			dma_fence_put(entity->dependency);
 			return NULL;
 		}
+		dma_fence_put(entity->dependency);
 	}
 
 	/* skip jobs from entity that marked guilty */
-- 
2.20.0.rc1

