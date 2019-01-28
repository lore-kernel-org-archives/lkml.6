Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421E0C282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1331F20844
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693569;
	bh=amVhMmo0slh86opU78w4vcTHqRIXMF9qPBn697czCaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OL2ySeEUkTV0xTmFXK0/mcTUxcskce1Bf2FMFrdK51+/Ms464N8RMnQkNNri8aMQJ
	 8gJctigMQpIYkASx6slWXBUuLzMOBtaKDgFwiKuc+uqArN/4I+Wb3MChiiV0Ws+AK4
	 pWXxluYxUB6xKxuJh8jxztO+KqKPKBkB556eTpbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390064AbfA1Qj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:39:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389745AbfA1QYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:24:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2D0B2173C;
        Mon, 28 Jan 2019 16:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692674;
        bh=amVhMmo0slh86opU78w4vcTHqRIXMF9qPBn697czCaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pf2X/TvDSKk+Ug5w8X2dZKCfxH1+gbzFwBZvd9aOEhPf/6kRVrWsPRlA5nM/+CUIJ
         b1kKmG47y6TUOmTQ98Fq84Hgx8Ls0rAWdgIOMJya7eLTeg0hsI8IFaTt1PxIBK6NCs
         WNA60EbzyVhZTljbStdq6Sw2oOEXXEx6SUEqHtjw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Young Xiao <YangX92@hotmail.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 22/80] sunvdc: Do not spin in an infinite loop when vio_ldc_send() returns EAGAIN
Date:   Mon, 28 Jan 2019 11:23:03 -0500
Message-Id: <20190128162401.58841-22-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162401.58841-1-sashal@kernel.org>
References: <20190128162401.58841-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Young Xiao <YangX92@hotmail.com>

[ Upstream commit a11f6ca9aef989b56cd31ff4ee2af4fb31a172ec ]

__vdc_tx_trigger should only loop on EAGAIN a finite
number of times.

See commit adddc32d6fde ("sunvnet: Do not spin in an
infinite loop when vio_ldc_send() returns EAGAIN") for detail.

Signed-off-by: Young Xiao <YangX92@hotmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/sunvdc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 4b911ed96ea3..31219fb9e7f4 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -40,6 +40,8 @@ MODULE_VERSION(DRV_MODULE_VERSION);
 #define WAITING_FOR_GEN_CMD	0x04
 #define WAITING_FOR_ANY		-1
 
+#define	VDC_MAX_RETRIES	10
+
 static struct workqueue_struct *sunvdc_wq;
 
 struct vdc_req_entry {
@@ -419,6 +421,7 @@ static int __vdc_tx_trigger(struct vdc_port *port)
 		.end_idx		= dr->prod,
 	};
 	int err, delay;
+	int retries = 0;
 
 	hdr.seq = dr->snd_nxt;
 	delay = 1;
@@ -431,6 +434,8 @@ static int __vdc_tx_trigger(struct vdc_port *port)
 		udelay(delay);
 		if ((delay <<= 1) > 128)
 			delay = 128;
+		if (retries++ > VDC_MAX_RETRIES)
+			break;
 	} while (err == -EAGAIN);
 
 	if (err == -ENOTCONN)
-- 
2.19.1

