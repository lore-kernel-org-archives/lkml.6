Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B1DC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE29206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE29206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbeJBUNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:13:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33308 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbeJBUNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:13:17 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EBD91266;
        Tue,  2 Oct 2018 13:29:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>,
        Eric Anholt <eric@anholt.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 129/228] drm/vc4: plane: Expand the lower bits by repeating the higher bits
Date:   Tue,  2 Oct 2018 06:23:46 -0700
Message-Id: <20181002132508.170541633@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Maxime Ripard <maxime.ripard@bootlin.com>

[ Upstream commit 3257ec797d3a8c5232389eb1952d4451e80f3931 ]

The vc4 HVS uses an internal RGB888 representation of the frames, and will
by default expand formats using a lower depth using zeros.

This causes an issue when we try to use other compositing software such as
pixman that fill the missing bits by repeating the higher significant bits.
As such, we can't check the display output in a reliable way by doing a
software composition and an hardware one and compare both.

To prevent this, force the same behaviour so that we can do such things.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Eric Anholt <eric@anholt.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20180517133759.25626-1-maxime.ripard@bootlin.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/vc4/vc4_plane.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -543,6 +543,7 @@ static int vc4_plane_mode_set(struct drm
 	/* Control word */
 	vc4_dlist_write(vc4_state,
 			SCALER_CTL0_VALID |
+			VC4_SET_FIELD(SCALER_CTL0_RGBA_EXPAND_ROUND, SCALER_CTL0_RGBA_EXPAND) |
 			(format->pixel_order << SCALER_CTL0_ORDER_SHIFT) |
 			(format->hvs << SCALER_CTL0_PIXEL_FORMAT_SHIFT) |
 			VC4_SET_FIELD(tiling, SCALER_CTL0_TILING) |


