Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B733ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C8D2085A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hM1OvUU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C8D2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbeKDXIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:08:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:47762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731227AbeKDXIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:08:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A60292086C;
        Sun,  4 Nov 2018 13:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339620;
        bh=A6/X4YppExsa6bwHtOV0hd2CFF2T1ib/JdwbcAAfrFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hM1OvUU95uSW1kpyYURjJdERNxOWIwgWla/AR6RpIdHmEYBtgkVUc75Fnegan3JZt
         +Tdikilfq+7vO+9U4GK7A+SuLhIoMDP1pfzbZ8RsK5N8pynArtDeiVC569Wjk7ehMT
         CVOzNh1ZQAepmmoEDuu0gEqNwZ/i/WUhTPVosCW0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 14/30] drm/omap: fix memory barrier bug in DMM driver
Date:   Sun,  4 Nov 2018 08:53:09 -0500
Message-Id: <20181104135325.88524-14-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135325.88524-1-sashal@kernel.org>
References: <20181104135325.88524-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
index df05fe53c399..32901c6fe3df 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -273,6 +273,17 @@ static int dmm_txn_commit(struct dmm_txn *txn, bool wait)
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
-- 
2.17.1

