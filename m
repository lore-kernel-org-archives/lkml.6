Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01B5C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9499920840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9499920840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387695AbeHAUXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:23:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46070 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404123AbeHATDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:33 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 60E55106A;
        Wed,  1 Aug 2018 17:01:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 157/336] drm/nouveau/fifo/gk104-: poll for runlist update completion
Date:   Wed,  1 Aug 2018 18:48:12 +0200
Message-Id: <20180801165035.132944210@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
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

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit 4f2fc25c0f8bcc8db1b8a7b21e88c3d7f35c5acb ]

Newer HW doesn't appear to send this event, which will cause long delays
in runlist updates if they don't complete immediately.

RM doesn't use these events anywhere, and an NVGPU commit message notes
that polling is the preferred method even on HW that supports the event.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c
@@ -155,10 +155,10 @@ gk104_fifo_runlist_commit(struct gk104_f
 				    (target << 28));
 	nvkm_wr32(device, 0x002274, (runl << 20) | nr);
 
-	if (wait_event_timeout(fifo->runlist[runl].wait,
-			       !(nvkm_rd32(device, 0x002284 + (runl * 0x08))
-				       & 0x00100000),
-			       msecs_to_jiffies(2000)) == 0)
+	if (nvkm_msec(device, 2000,
+		if (!(nvkm_rd32(device, 0x002284 + (runl * 0x08)) & 0x00100000))
+			break;
+	) < 0)
 		nvkm_error(subdev, "runlist %d update timeout\n", runl);
 unlock:
 	mutex_unlock(&subdev->mutex);


