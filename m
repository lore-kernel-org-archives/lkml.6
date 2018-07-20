Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BD0ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A222084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A222084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbeGTNOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:14:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34762 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbeGTNOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:14:04 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D5359BBD;
        Fri, 20 Jul 2018 12:26:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Vesker <valex@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 3.18 25/29] net/mlx5: Fix command interface race in polling mode
Date:   Fri, 20 Jul 2018 14:11:20 +0200
Message-Id: <20180720115159.880064240@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720115158.974693829@linuxfoundation.org>
References: <20180720115158.974693829@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Vesker <valex@mellanox.com>

[ Upstream commit d412c31dae053bf30a1bc15582a9990df297a660 ]

The command interface can work in two modes: Events and Polling.
In the general case, each time we invoke a command, a work is
queued to handle it.

When working in events, the interrupt handler completes the
command execution. On the other hand, when working in polling
mode, the work itself completes it.

Due to a bug in the work handler, a command could have been
completed by the interrupt handler, while the work handler
hasn't finished yet, causing the it to complete once again
if the command interface mode was changed from Events to
polling after the interrupt handler was called.

mlx5_unload_one()
        mlx5_stop_eqs()
                // Destroy the EQ before cmd EQ
                ...cmd_work_handler()
                        write_doorbell()
                        --> EVENT_TYPE_CMD
                                mlx5_cmd_comp_handler() // First free
                                        free_ent(cmd, ent->idx)
                                        complete(&ent->done)

        <-- mlx5_stop_eqs //cmd was complete
                // move to polling before destroying the last cmd EQ
                mlx5_cmd_use_polling()
                        cmd->mode = POLL;

                --> cmd_work_handler (continues)
                        if (cmd->mode == POLL)
                                mlx5_cmd_comp_handler() // Double free

The solution is to store the cmd->mode before writing the doorbell.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Alex Vesker <valex@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -480,6 +480,7 @@ static void cmd_work_handler(struct work
 	struct mlx5_core_dev *dev = container_of(cmd, struct mlx5_core_dev, cmd);
 	struct mlx5_cmd_layout *lay;
 	struct semaphore *sem;
+	int cmd_mode;
 
 	sem = ent->page_queue ? &cmd->pages_sem : &cmd->sem;
 	down(sem);
@@ -513,13 +514,14 @@ static void cmd_work_handler(struct work
 	set_signature(ent, !cmd->checksum_disabled);
 	dump_command(dev, ent, 1);
 	ent->ts1 = ktime_get_ns();
+	cmd_mode = cmd->mode;
 
 	/* ring doorbell after the descriptor is valid */
 	wmb();
 	iowrite32be(1 << ent->idx, &dev->iseg->cmd_dbell);
 	mlx5_core_dbg(dev, "write 0x%x to command doorbell\n", 1 << ent->idx);
 	mmiowb();
-	if (cmd->mode == CMD_MODE_POLLING) {
+	if (cmd_mode == CMD_MODE_POLLING) {
 		poll_timeout(ent);
 		/* make sure we read the descriptor after ownership is SW */
 		rmb();


