Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3651ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF0A205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF0A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbeGTO6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:58:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42920 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731452AbeGTO6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:58:06 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 8DCBF261367
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: [PATCH] vivid: Fix V4L2_FIELD_ALTERNATE new frame check
Date:   Fri, 20 Jul 2018 10:09:16 -0400
Message-Id: <20180720140916.13100-1-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vivid driver will overlay stream time on generated frames. Though,
in interlacing mode V4L2_FIELD_ALTERNATE, each field is separate and
must have the same time to ensure proper render. Though, this time was
only updated every 2 frames as the code was checking against the wrong
counter (frame counter rather then field counter).

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/media/platform/vivid/vivid-kthread-cap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/vivid/vivid-kthread-cap.c b/drivers/media/platform/vivid/vivid-kthread-cap.c
index 3fdb280c36ca..f06003bb8e42 100644
--- a/drivers/media/platform/vivid/vivid-kthread-cap.c
+++ b/drivers/media/platform/vivid/vivid-kthread-cap.c
@@ -477,7 +477,7 @@ static void vivid_fillbuff(struct vivid_dev *dev, struct vivid_buffer *buf)
 
 	/* Updates stream time, only update at the start of a new frame. */
 	if (dev->field_cap != V4L2_FIELD_ALTERNATE ||
-			(buf->vb.sequence & 1) == 0)
+			(dev->vid_cap_seq_count & 1) == 0)
 		dev->ms_vid_cap =
 			jiffies_to_msecs(jiffies - dev->jiffies_vid_cap);
 
-- 
2.17.1

