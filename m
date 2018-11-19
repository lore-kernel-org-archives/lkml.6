Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C274C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92A0206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yMpxerNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92A0206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733020AbeKTDEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:04:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:37700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732128AbeKTDEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:04:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42B6F206BA;
        Mon, 19 Nov 2018 16:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645627;
        bh=f3GFks9+BvKS9+WeFzOVnWqdhJo8w+tx1t1T25uzFx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yMpxerNO/GiU8AL0atUtjyICrEkE0yxTirfKfI6XSpB9ipf6iguZB475srgAisE09
         HNjBIHFLMlEj9aMTWRGa8B5Ez9zsnBSleC4D/E5X0AB0T3kPG5YrgIVLGvkmJLcJRR
         LEpYLeOBev6VZDImMEKkt1BFcNzGdLCgmDrIX4ww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 028/171] drm: rcar-du: Update Gen3 output limitations
Date:   Mon, 19 Nov 2018 17:27:04 +0100
Message-Id: <20181119162624.350229116@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

[ Upstream commit 2a3181d9cfd6d5aa48f8527708d0c32072072cef ]

The R-Car Gen3 DU utilises the VSP1 hardware for memory access. The
limits on the RPF and WPF in this pipeline are 8190x8190.

Update the supported maximum sizes accordingly.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -516,12 +516,22 @@ int rcar_du_modeset_init(struct rcar_du_
 
 	dev->mode_config.min_width = 0;
 	dev->mode_config.min_height = 0;
-	dev->mode_config.max_width = 4095;
-	dev->mode_config.max_height = 2047;
 	dev->mode_config.normalize_zpos = true;
 	dev->mode_config.funcs = &rcar_du_mode_config_funcs;
 	dev->mode_config.helper_private = &rcar_du_mode_config_helper;
 
+	if (rcdu->info->gen < 3) {
+		dev->mode_config.max_width = 4095;
+		dev->mode_config.max_height = 2047;
+	} else {
+		/*
+		 * The Gen3 DU uses the VSP1 for memory access, and is limited
+		 * to frame sizes of 8190x8190.
+		 */
+		dev->mode_config.max_width = 8190;
+		dev->mode_config.max_height = 8190;
+	}
+
 	rcdu->num_crtcs = hweight8(rcdu->info->channels_mask);
 
 	ret = rcar_du_properties_init(rcdu);


