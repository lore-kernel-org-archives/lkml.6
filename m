Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651E7C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D7D20869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D7D20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbeKLFyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:54:08 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51702 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbeKLFyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:54:07 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsw-0000oN-D1; Sun, 11 Nov 2018 19:59:06 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsU-0001e7-O2; Sun, 11 Nov 2018 19:58:38 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Saeed Mahameed" <saeedm@mellanox.com>,
        "Alex Vesker" <valex@mellanox.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.862072580@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 205/366] net/mlx5: Fix command interface race in
 polling mode
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Vesker <valex@mellanox.com>

commit d412c31dae053bf30a1bc15582a9990df297a660 upstream.

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
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -560,6 +560,7 @@ static void cmd_work_handler(struct work
 	struct mlx5_cmd_layout *lay;
 	struct semaphore *sem;
 	int alloc_ret;
+	int cmd_mode;
 
 	sem = ent->page_queue ? &cmd->pages_sem : &cmd->sem;
 	down(sem);
@@ -602,6 +603,7 @@ static void cmd_work_handler(struct work
 	set_signature(ent, !cmd->checksum_disabled);
 	dump_command(dev, ent, 1);
 	ktime_get_ts(&ent->ts1);
+	cmd_mode = cmd->mode;
 
 	if (ent->callback)
 		schedule_delayed_work(&ent->cb_timeout_work, cb_timeout);
@@ -611,7 +613,7 @@ static void cmd_work_handler(struct work
 	iowrite32be(1 << ent->idx, &dev->iseg->cmd_dbell);
 	mlx5_core_dbg(dev, "write 0x%x to command doorbell\n", 1 << ent->idx);
 	mmiowb();
-	if (cmd->mode == CMD_MODE_POLLING) {
+	if (cmd_mode == CMD_MODE_POLLING) {
 		poll_timeout(ent);
 		/* make sure we read the descriptor after ownership is SW */
 		rmb();

