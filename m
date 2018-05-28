Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423818AbeE1LJs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:09:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423301AbeE1LJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:09:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Smart <james.smart@broadcom.com>,
        Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 127/272] nvme_fc: fix abort race on teardown with lld reject
Date: Mon, 28 May 2018 12:02:40 +0200
Message-Id: <20180528100251.791786807@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit b12740d316fa89f3f6191b71f986cf3b9383d379 ]

Another abort race: An io request is started, becomes active,
and is attempted to be started with the lldd. At the same time
the controller is stopped/torndown and an itterator is run to
abort the ios. As the io is active, it is added to the outstanding
aborted io count.  However on the original io request thread, the
driver ends up rejecting the io due to the condition that induced
the controller teardown. The driver reject path didn't check whether
it was in the outstanding io count. This left the count outstanding
stopping controller teardown.

Correct by, in the driver reject case, setting the state to
inactive and checking whether it was in the outstanding io count.

Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/fc.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2191,7 +2191,7 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl
 	struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
 	struct nvme_command *sqe = &cmdiu->sqe;
 	u32 csn;
-	int ret;
+	int ret, opstate;
 
 	/*
 	 * before attempting to send the io, check to see if we believe
@@ -2269,6 +2269,9 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl
 					queue->lldd_handle, &op->fcp_req);
 
 	if (ret) {
+		opstate = atomic_xchg(&op->state, FCPOP_STATE_COMPLETE);
+		__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
+
 		if (!(op->flags & FCOP_FLAGS_AEN))
 			nvme_fc_unmap_data(ctrl, op->rq, op);
 
