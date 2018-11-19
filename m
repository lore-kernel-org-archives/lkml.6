Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0780CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1ECA2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3K4gexC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1ECA2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403821AbeKTDRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:17:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389985AbeKTDRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:17:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94202213A2;
        Mon, 19 Nov 2018 16:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646410;
        bh=ItSBBT2Dea4xR6oed6nqT92ZyMryNuepIje46B6Hib4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q3K4gexCFZqV1+Nd9MOYHM6ZnzltoULkbjJTU4Zz2xFU762aFjvbdefvw1mXHKIyV
         xOVtjhlG1455NGH2RmOCcFAw1wNbKNUFYrI8BVMnvwU/uiQo7Do+3oGg8nxkuq01gg
         zNjXMiwMVRzslZ5l8xn68vuORPuvGHupkkR5zgVM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 05/83] drm/omap: fix memory barrier bug in DMM driver
Date:   Mon, 19 Nov 2018 17:28:31 +0100
Message-Id: <20181119162613.079335549@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.046511542@linuxfoundation.org>
References: <20181119162612.046511542@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

[ Upstream commit 538f66ba204944470a653a4cccc5f8befdf97c22 ]

A DMM timeout "timed out waiting for done" has been observed on DRA7
devices. The timeout happens rarely, and only when the system is under
heavy load.

Debugging showed that the timeout can be made to happen much more
frequently by optimizing the DMM driver, so that there's almost no code
between writing the last DMM descriptors to RAM, and writing to DMM
register which starts the DMM transaction.

The current theory is that a wmb() does not properly ensure that the
data written to RAM is observable by all the components in the system.

This DMM timeout has caused interesting (and rare) bugs as the error
handling was not functioning properly (the error handling has been fixed
in previous commits):

 * If a DMM timeout happened when a GEM buffer was being pinned for
   display on the screen, a timeout error would be shown, but the driver
   would continue programming DSS HW with broken buffer, leading to
   SYNCLOST floods and possible crashes.

 * If a DMM timeout happened when other user (say, video decoder) was
   pinning a GEM buffer, a timeout would be shown but if the user
   handled the error properly, no other issues followed.

 * If a DMM timeout happened when a GEM buffer was being released, the
   driver does not even notice the error, leading to crashes or hang
   later.

This patch adds wmb() and readl() calls after the last bit is written to
RAM, which should ensure that the execution proceeds only after the data
is actually in RAM, and thus observable by DMM.

The read-back should not be needed. Further study is required to understand
if DMM is somehow special case and read-back is ok, or if DRA7's memory
barriers do not work correctly.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -273,6 +273,17 @@ static int dmm_txn_commit(struct dmm_txn
 	}
 
 	txn->last_pat->next_pa = 0;
+	/* ensure that the written descriptors are visible to DMM */
+	wmb();
+
+	/*
+	 * NOTE: the wmb() above should be enough, but there seems to be a bug
+	 * in OMAP's memory barrier implementation, which in some rare cases may
+	 * cause the writes not to be observable after wmb().
+	 */
+
+	/* read back to ensure the data is in RAM */
+	readl(&txn->last_pat->next_pa);
 
 	/* write to PAT_DESCR to clear out any pending transaction */
 	dmm_write(dmm, 0x0, reg[PAT_DESCR][engine->id]);


