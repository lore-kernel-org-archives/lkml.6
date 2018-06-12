Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C0155C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CCD208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80CCD208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933762AbeFLRXg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:23:36 -0400
Received: from www.osadl.org ([62.245.132.105]:58253 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754209AbeFLRXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:23:35 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w5CHMdrw021809;
        Tue, 12 Jun 2018 19:22:46 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 2/2] media: stm32-dcmi: add mandatory of_node_put() in success path
Date:   Tue, 12 Jun 2018 19:22:18 +0200
Message-Id: <1528824138-19089-2-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1528824138-19089-1-git-send-email-hofrat@osadl.org>
References: <1528824138-19089-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The endpoint allocated by of_graph_get_next_endpoint() needs an of_node_put()
in both error and success path. As  ep  is not used the refcount decrement
can be right after the last use of  ep.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit 37404f91ef8b ("[media] stm32-dcmi: STM32 DCMI camera interface driver")
---

Problem located with an experimental coccinelle script

Patch was compile tested with: x86_64_defconfig, MEDIA_SUPPORT=y
MEDIA_CAMERA_SUPPORT=y, V4L_PLATFORM_DRIVERS=y, OF=y, COMPILE_TEST=y
CONFIG_VIDEO_STM32_DCMI=y
(There are a number of sparse warnings - not related to the changes though)

Patch is on top of "[PATCH 1/2] media: stm32-dcmi: drop unneceeary while(1)
loop" against 4.17.0 (localversion-next is next-20180608)

 drivers/media/platform/stm32/stm32-dcmi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index 70b81d2..542d148 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -1610,10 +1610,9 @@ static int dcmi_graph_parse(struct stm32_dcmi *dcmi, struct device_node *node)
 		return -EINVAL;
 
 	remote = of_graph_get_remote_port_parent(ep);
-	if (!remote) {
-		of_node_put(ep);
+	of_node_put(ep);
+	if (!remote)
 		return -EINVAL;
-	}
 
 	/* Remote node to connect */
 	dcmi->entity.node = remote;
-- 
2.1.4

