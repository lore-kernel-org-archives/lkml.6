Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7479DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4330B218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151233;
	bh=ob8WBPGK9577jJLtUu4bIrLfmkK454rYIHyI8BtSMMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l+0oA18y+/8WBfoSIBBq0ZoKpZcZeuGr/mkq6noHm9rvexu/D2qYJqueLG0vNoLsl
	 G0FOdGfLwgVxAuZF3STLStpvIFzYrXhKdNfihkTmqaxvXwzrgMZyoHxWjj0B7D5gTS
	 ik4SPWKHl7pZUwa7MN7BvnIuGnC4lh52mG4e54cY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbeLRQkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:40:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727153AbeLRQk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:40:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50B67218A3;
        Tue, 18 Dec 2018 16:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151228;
        bh=ob8WBPGK9577jJLtUu4bIrLfmkK454rYIHyI8BtSMMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wm0ss/VgRisLWCyxbxisNPnSu9NR+FIVzYIpqvkMD5qVK7jNezUXhone+yNdrQVFl
         4t1a15W2P/BVBWQy9wdyMMDqLKCw4by5sHLDz8CP/KA+GGyf1x6qi+fdfd3pWNnBrI
         7lZ9Np36L36Piu/dxz5Pyv12oV/iE0XF3l5CuNtY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 18/44] mmc: core: use mrq->sbc when sending CMD23 for RPMB
Date:   Tue, 18 Dec 2018 17:39:30 +0100
Message-Id: <20181218163929.631069185@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit a44f7cb937321d4961bfc8f28912126b06e701c5 upstream.

When sending out CMD23 in the blk preparation, the comment there
rightfully says:

	 * However, it is not sufficient to just send CMD23,
	 * and avoid the final CMD12, as on an error condition
	 * CMD12 (stop) needs to be sent anyway. This, coupled
	 * with Auto-CMD23 enhancements provided by some
	 * hosts, means that the complexity of dealing
	 * with this is best left to the host. If CMD23 is
	 * supported by card and host, we'll fill sbc in and let
	 * the host deal with handling it correctly.

Let's do this behaviour for RPMB as well, and not send CMD23
independently. Otherwise IP cores (like Renesas SDHI) may timeout
because of automatic CMD23/CMD12 handling.

Reported-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Clément Péron <peron.clem@gmail.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/block.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -472,7 +472,7 @@ out:
 static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 			       struct mmc_blk_ioc_data *idata)
 {
-	struct mmc_command cmd = {};
+	struct mmc_command cmd = {}, sbc = {};
 	struct mmc_data data = {};
 	struct mmc_request mrq = {};
 	struct scatterlist sg;
@@ -550,10 +550,15 @@ static int __mmc_blk_ioctl_cmd(struct mm
 	}
 
 	if (idata->rpmb) {
-		err = mmc_set_blockcount(card, data.blocks,
-			idata->ic.write_flag & (1 << 31));
-		if (err)
-			return err;
+		sbc.opcode = MMC_SET_BLOCK_COUNT;
+		/*
+		 * We don't do any blockcount validation because the max size
+		 * may be increased by a future standard. We just copy the
+		 * 'Reliable Write' bit here.
+		 */
+		sbc.arg = data.blocks | (idata->ic.write_flag & BIT(31));
+		sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
+		mrq.sbc = &sbc;
 	}
 
 	if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd.arg) == EXT_CSD_SANITIZE_START) &&


