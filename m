Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC5FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906FE20843
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="do1wyfYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906FE20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbeKAIKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:10:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731171AbeKAIKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:10:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30B2120840;
        Wed, 31 Oct 2018 23:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027430;
        bh=l6sxa+HhpljehsLY5Yd9wCHuwwfQHoUUfUHZ5GteZ/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=do1wyfYjCeocWKxtj2RIIMOtF6MDkcOj9Pdm+etQCcajx5tuJlILu45xeJx3XFJWw
         lSPB3AB1mSlUoQ6a/R2Fg2TCqKOg/jpikON8v/vPHWY+/kwUX6TTynl2k+dl+EprTr
         9jg2vEoUvfjl7IG7flZo0tRRmMZ4B93NHXlDxLxA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 47/73] RDMA/bnxt_re: Fix recursive lock warning in debug kernel
Date:   Wed, 31 Oct 2018 19:09:22 -0400
Message-Id: <20181031230948.29203-47-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230948.29203-1-sashal@kernel.org>
References: <20181031230948.29203-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Selvin Xavier <selvin.xavier@broadcom.com>

[ Upstream commit d455f29f6d76a5f94881ca1289aaa1e90617ff5d ]

Fix possible recursive lock warning. Its a false warning as the locks are
part of two differnt HW Queue data structure - cmdq and creq. Debug kernel
is throwing the following warning and stack trace.

[  783.914967] ============================================
[  783.914970] WARNING: possible recursive locking detected
[  783.914973] 4.19.0-rc2+ #33 Not tainted
[  783.914976] --------------------------------------------
[  783.914979] swapper/2/0 is trying to acquire lock:
[  783.914982] 000000002aa3949d (&(&hwq->lock)->rlock){..-.}, at: bnxt_qplib_service_creq+0x232/0x350 [bnxt_re]
[  783.914999]
but task is already holding lock:
[  783.915002] 00000000be73920d (&(&hwq->lock)->rlock){..-.}, at: bnxt_qplib_service_creq+0x2a/0x350 [bnxt_re]
[  783.915013]
other info that might help us debug this:
[  783.915016]  Possible unsafe locking scenario:

[  783.915019]        CPU0
[  783.915021]        ----
[  783.915034]   lock(&(&hwq->lock)->rlock);
[  783.915035]   lock(&(&hwq->lock)->rlock);
[  783.915037]
 *** DEADLOCK ***

[  783.915038]  May be due to missing lock nesting notation

[  783.915039] 1 lock held by swapper/2/0:
[  783.915040]  #0: 00000000be73920d (&(&hwq->lock)->rlock){..-.}, at: bnxt_qplib_service_creq+0x2a/0x350 [bnxt_re]
[  783.915044]
stack backtrace:
[  783.915046] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.19.0-rc2+ #33
[  783.915047] Hardware name: Dell Inc. PowerEdge R730/0599V5, BIOS 1.0.4 08/28/2014
[  783.915048] Call Trace:
[  783.915049]  <IRQ>
[  783.915054]  dump_stack+0x90/0xe3
[  783.915058]  __lock_acquire+0x106c/0x1080
[  783.915061]  ? sched_clock+0x5/0x10
[  783.915063]  lock_acquire+0xbd/0x1a0
[  783.915065]  ? bnxt_qplib_service_creq+0x232/0x350 [bnxt_re]
[  783.915069]  _raw_spin_lock_irqsave+0x4a/0x90
[  783.915071]  ? bnxt_qplib_service_creq+0x232/0x350 [bnxt_re]
[  783.915073]  bnxt_qplib_service_creq+0x232/0x350 [bnxt_re]
[  783.915078]  tasklet_action_common.isra.17+0x197/0x1b0
[  783.915081]  __do_softirq+0xcb/0x3a6
[  783.915084]  irq_exit+0xe9/0x100
[  783.915085]  do_IRQ+0x6a/0x120
[  783.915087]  common_interrupt+0xf/0xf
[  783.915088]  </IRQ>

Use nested notation for the spin_lock to avoid this warning.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 8d91733009a4..ad74988837c9 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -311,8 +311,17 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 		bnxt_qplib_release_cq_locks(qp, &flags);
 		break;
 	default:
-		/* Command Response */
-		spin_lock_irqsave(&cmdq->lock, flags);
+		/*
+		 * Command Response
+		 * cmdq->lock needs to be acquired to synchronie
+		 * the command send and completion reaping. This function
+		 * is always called with creq->lock held. Using
+		 * the nested variant of spin_lock.
+		 *
+		 */
+
+		spin_lock_irqsave_nested(&cmdq->lock, flags,
+					 SINGLE_DEPTH_NESTING);
 		cookie = le16_to_cpu(qp_event->cookie);
 		mcookie = qp_event->cookie;
 		blocked = cookie & RCFW_CMD_IS_BLOCKING;
-- 
2.17.1

