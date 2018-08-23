Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8CAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D2A2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D2A2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732422AbeHWMJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:09:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49834 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbeHWMJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:09:50 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8FC1E8B1;
        Thu, 23 Aug 2018 08:41:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Ayan Kumar halder <ayan.halder@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 047/324] drm/arm/malidp: Preserve LAYER_FORMAT contents when setting format
Date:   Thu, 23 Aug 2018 09:51:53 +0200
Message-Id: <20180823074958.151831824@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
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

From: Ayan Kumar Halder <ayan.halder@arm.com>

[ Upstream commit ad7fda2e378f4356df621a39655f7c200b495d81 ]

On some Mali-DP processors, the LAYER_FORMAT register contains fields
other than the format. These bits were unconditionally cleared when
setting the pixel format, whereas they should be preserved at their
reset values.

Reported-by: Brian Starkey <brian.starkey@arm.com>
Reported-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/arm/malidp_planes.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -23,6 +23,7 @@
 
 /* Layer specific register offsets */
 #define MALIDP_LAYER_FORMAT		0x000
+#define   LAYER_FORMAT_MASK		0x3f
 #define MALIDP_LAYER_CONTROL		0x004
 #define   LAYER_ENABLE			(1 << 0)
 #define   LAYER_FLOWCFG_MASK		7
@@ -337,7 +338,9 @@ static void malidp_de_plane_update(struc
 	dest_w = plane->state->crtc_w;
 	dest_h = plane->state->crtc_h;
 
-	malidp_hw_write(mp->hwdev, ms->format, mp->layer->base);
+	val = malidp_hw_read(mp->hwdev, mp->layer->base);
+	val = (val & ~LAYER_FORMAT_MASK) | ms->format;
+	malidp_hw_write(mp->hwdev, val, mp->layer->base);
 
 	for (i = 0; i < ms->n_planes; i++) {
 		/* calculate the offset for the layer's plane registers */


