Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB018C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7162A20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107264;
	bh=5dGOujrYAbTJ3GD2pNQmxI6u7qiysjSa9tmgjQljIp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vzdTDsg0g6HJk6m40RxSBSTayv8t97QRS+wFJYmnwtOtPEBABuYuBIxupm26xG25u
	 8rzUx5TYGnOC3JS3TG47a/6k/1vv0z6GNdb83uY1sfPJXI4nXYRmqXJ+YtsvO50w0M
	 Ud5+cpeeMITLq/1zaoowmMm78M797MjnD7jloXVg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7162A20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbeLFOlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:41:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730108AbeLFOlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:41:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 448FE20892;
        Thu,  6 Dec 2018 14:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107259;
        bh=5dGOujrYAbTJ3GD2pNQmxI6u7qiysjSa9tmgjQljIp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fjJqTW5S+/vPqhUnqM3Udm7aokIZKXwGxCdng75UjJq2cfX67zAYjGOS/JrB73M4/
         sdWoBH7pwPILpEsSX+Zjrj5pnB2yxzwcmypb2Ttgaq5TJc/tse+4PIfHCq0g4TbCHL
         mywSQJqNkj9B2A8h7+6brcAVHfAXP/aP+x7P8OO0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.19 06/41] mtd: nand: Fix memory allocation in nanddev_bbt_init()
Date:   Thu,  6 Dec 2018 15:38:46 +0100
Message-Id: <20181206142950.228646871@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

commit 40b412897ccb4b98b2cfb2a0aaabed58dd9e2086 upstream.

Fix the size of the buffer allocated to store the in-memory BBT.
This bug was previously hidden by a different bug, that was fixed in
commit d098093ba06e ("mtd: nand: Fix nanddev_neraseblocks()").

Fixes: 9c3736a3de21 ("mtd: nand: Add core infrastructure to deal with NAND devices")
Cc: <stable@vger.kernel.org>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/bbt.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/mtd/nand/bbt.c
+++ b/drivers/mtd/nand/bbt.c
@@ -27,7 +27,8 @@ int nanddev_bbt_init(struct nand_device
 	unsigned int nwords = DIV_ROUND_UP(nblocks * bits_per_block,
 					   BITS_PER_LONG);
 
-	nand->bbt.cache = kzalloc(nwords, GFP_KERNEL);
+	nand->bbt.cache = kcalloc(nwords, sizeof(*nand->bbt.cache),
+				  GFP_KERNEL);
 	if (!nand->bbt.cache)
 		return -ENOMEM;
 


