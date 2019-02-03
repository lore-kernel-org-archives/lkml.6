Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CC4C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A0D218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfBCNzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:55:45 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54504 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729070AbfBCNyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:54:43 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIEL-0003tr-VR; Sun, 03 Feb 2019 13:54:42 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9p-0007N6-Qb; Sun, 03 Feb 2019 14:50:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Avri Altman" <avri.altman@wdc.com>,
        "Masaharu Hayakawa" <masaharu.hayakawa.ry@renesas.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "=?UTF-8?Q?Cl=C3=A9ment=20?= =?UTF-8?Q?P=C3=A9ron?=" 
        <peron.clem@gmail.com>,
        "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
        "Niklas =?UTF-8?Q?S=C3=B6derlund?=" 
        <niklas.soderlund+renesas@ragnatech.se>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.258544182@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 258/305] mmc: core: use mrq->sbc when sending CMD23
 for RPMB
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mmc/card/block.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -449,7 +449,7 @@ static int mmc_blk_ioctl_cmd(struct bloc
 	struct mmc_blk_ioc_data *idata;
 	struct mmc_blk_data *md;
 	struct mmc_card *card;
-	struct mmc_command cmd = {0};
+	struct mmc_command cmd = {}, sbc = {};
 	struct mmc_data data = {0};
 	struct mmc_request mrq = {NULL};
 	struct scatterlist sg;
@@ -539,10 +539,15 @@ static int mmc_blk_ioctl_cmd(struct bloc
 	}
 
 	if (is_rpmb) {
-		err = mmc_set_blockcount(card, data.blocks,
-			idata->ic.write_flag & (1 << 31));
-		if (err)
-			goto cmd_rel_host;
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

