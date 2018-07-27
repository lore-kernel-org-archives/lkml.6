Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0221FC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F6220895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F6220895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732909AbeG0LI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:08:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51582 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730963AbeG0LI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:08:57 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1AE88898;
        Fri, 27 Jul 2018 09:47:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH 4.17 24/66] net/mlx5: E-Switch, UBSAN fix undefined behavior in mlx5_eswitch_mode
Date:   Fri, 27 Jul 2018 11:45:17 +0200
Message-Id: <20180727093811.899216452@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Saeed Mahameed <saeedm@mellanox.com>

[ Upstream commit 443a858158d35916e572b75667ca4924a6af2182 ]

With debug kernel UBSAN detects the following issue, which might happen
when eswitch instance is not created, fix this by testing the eswitch
pointer before returning the eswitch mode, if not set return mode =
SRIOV_NONE.

[   32.528951] UBSAN: Undefined behaviour in drivers/net/ethernet/mellanox/mlx5/core/eswitch.c:2219:12
[   32.528951] member access within null pointer of type 'struct mlx5_eswitch'
[   32.528951] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.0-rc3-dirty #181
[   32.528951] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.0-0-g63451fca13-prebuilt.qemu-project.org 04/01/2014
[   32.528951] Call Trace:
[   32.528951]  dump_stack+0xc7/0x13b
[   32.528951]  ? show_regs_print_info+0x5/0x5
[   32.528951]  ? __pm_runtime_use_autosuspend+0x140/0x140
[   32.528951]  ubsan_epilogue+0x9/0x49
[   32.528951]  ubsan_type_mismatch_common+0x1f9/0x2c0
[   32.528951]  ? ucs2_as_utf8+0x310/0x310
[   32.528951]  ? device_initialize+0x229/0x2e0
[   32.528951]  __ubsan_handle_type_mismatch+0x9f/0xc9
[   32.528951]  ? __ubsan_handle_divrem_overflow+0x19b/0x19b
[   32.578008]  ? ib_device_get_by_index+0xf0/0xf0
[   32.578008]  mlx5_eswitch_mode+0x30/0x40
[   32.578008]  mlx5_ib_add+0x1e0/0x4a0

Fixes: 57cbd893c4c5 ("net/mlx5: E-Switch, Move representors definition to a global scope")
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -2221,6 +2221,6 @@ free_out:
 
 u8 mlx5_eswitch_mode(struct mlx5_eswitch *esw)
 {
-	return esw->mode;
+	return ESW_ALLOWED(esw) ? esw->mode : SRIOV_NONE;
 }
 EXPORT_SYMBOL_GPL(mlx5_eswitch_mode);


