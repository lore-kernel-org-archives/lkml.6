Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA87C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7157320841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKv7IvQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7157320841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388446AbeHAVAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:00:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37750 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387714AbeHAVAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:00:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so11288899pgq.4;
        Wed, 01 Aug 2018 12:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/YRmqT4C9CxqI1MsWRMLxEa0Dl12XnFTogc0Db1UUOo=;
        b=lKv7IvQ/7/iEDaC/xcq44vED9EAs9FzQI+lMxh76MNmZB0V8NNR7lVtW6Uhlh7oMwH
         hjT/7WDjZQ7c6gJCDfIO/qv7ZJlZ2aflDN2ZWS/jZOOWjhtvF7FoAR/wXJlbQa/zMBF4
         Os3jlUeFgqP25UjLxE2xJCe+us/Mf3b5u2Y1OiOFikqbH9Wnh9SN0q0TsvxIwT11aKBu
         LScpBuda+gBuQFrHzh5O0TD+GDPHHJ+JRRe8oZJMHEerJyT48hsyVFDckRkZkQveVCQh
         XTetWHeehiHHU0zfs0aQhRkCsq/Oh5TlznL+oKRPq+5FarKLy/hGcJ9BWcGbXrwnMIWj
         avOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/YRmqT4C9CxqI1MsWRMLxEa0Dl12XnFTogc0Db1UUOo=;
        b=jiIzc+X+6thSibWRh3nHNH9QMS++T0+d8vrO6uoDLVkE7Lyqtm35BuCYFd6WGFzOJX
         I1ooGmceGJI+A8iykppNZxsK1R29tMHIMsTe4b8AV5QabFyLwaU89BcBwNhQ3cbmlmPY
         7pgv9+jIwIBLwVrtSjHNJ/NVedmLlx6SUTrT0/gL5gYOtfChavQj4uiWwcsAXn+XWF+p
         z4Odno+QC2g/4yKMCbmr1doc7AE7WrJKBA0JqYm8x7AFXbHxmo+PqRRB+bn3L3ik46gs
         ybRHvavaGdJq1xUnnDkoRzPpUS65oUqqQG32OVrxpfR8OY13FcgAXobsln2d2hrPHchg
         jVFQ==
X-Gm-Message-State: AOUpUlEZMS4EiR/MHmm4stPSrANvl0QDe8FxJ6xTP+ahE7Ge8MiJUcko
        e7utTeKJeKMkZ6mOY9JX/lZYfopC
X-Google-Smtp-Source: AAOMgpdcWKKNotURBAvfdIt+TLxB6bGC7F9tFyEtkQqVJNtz8U7d/oEOzmCbAiCWjsCaQuIDqx1Wrg==
X-Received: by 2002:a63:fb07:: with SMTP id o7-v6mr26239583pgh.333.1533150774795;
        Wed, 01 Aug 2018 12:12:54 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-24-5-209-231.hsd1.ca.comcast.net. [24.5.209.231])
        by smtp.googlemail.com with ESMTPSA id u42-v6sm31171336pgn.1.2018.08.01.12.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 12:12:53 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 11/14] media: imx: vdic: rely on VDIC for correct field order
Date:   Wed,  1 Aug 2018 12:12:24 -0700
Message-Id: <1533150747-30677-12-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
References: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prepare_vdi_in_buffers() was setting up the dma pointers as if the
VDIC is always programmed to receive the fields in bottom-top order,
i.e. as if ipu_vdi_set_field_order() only programs BT order in the VDIC.
But that's not true, ipu_vdi_set_field_order() is working correctly.

So fix prepare_vdi_in_buffers() to give the VDIC the fields in whatever
order they were received by the video source, and rely on the VDIC to
sort out which is top and which is bottom.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/staging/media/imx/imx-media-vdic.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-vdic.c b/drivers/staging/media/imx/imx-media-vdic.c
index 482250d..4a89071 100644
--- a/drivers/staging/media/imx/imx-media-vdic.c
+++ b/drivers/staging/media/imx/imx-media-vdic.c
@@ -219,26 +219,18 @@ static void __maybe_unused prepare_vdi_in_buffers(struct vdic_priv *priv,
 
 	switch (priv->fieldtype) {
 	case V4L2_FIELD_SEQ_TB:
-		prev_phys = vb2_dma_contig_plane_dma_addr(prev_vb, 0);
-		curr_phys = vb2_dma_contig_plane_dma_addr(curr_vb, 0) + fs;
-		next_phys = vb2_dma_contig_plane_dma_addr(curr_vb, 0);
-		break;
 	case V4L2_FIELD_SEQ_BT:
 		prev_phys = vb2_dma_contig_plane_dma_addr(prev_vb, 0) + fs;
 		curr_phys = vb2_dma_contig_plane_dma_addr(curr_vb, 0);
 		next_phys = vb2_dma_contig_plane_dma_addr(curr_vb, 0) + fs;
 		break;
+	case V4L2_FIELD_INTERLACED_TB:
 	case V4L2_FIELD_INTERLACED_BT:
+	case V4L2_FIELD_INTERLACED:
 		prev_phys = vb2_dma_contig_plane_dma_addr(prev_vb, 0) + is;
 		curr_phys = vb2_dma_contig_plane_dma_addr(curr_vb, 0);
 		next_phys = vb2_dma_contig_plane_dma_addr(curr_vb, 0) + is;
 		break;
-	default:
-		/* assume V4L2_FIELD_INTERLACED_TB */
-		prev_phys = vb2_dma_contig_plane_dma_addr(prev_vb, 0);
-		curr_phys = vb2_dma_contig_plane_dma_addr(curr_vb, 0) + is;
-		next_phys = vb2_dma_contig_plane_dma_addr(curr_vb, 0);
-		break;
 	}
 
 	ipu_cpmem_set_buffer(priv->vdi_in_ch_p, 0, prev_phys);
-- 
2.7.4

