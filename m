Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339B6C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93F0217BF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93F0217BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbeHDLDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:03:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48248 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbeHDLDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:03:01 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C0E2FBBF;
        Sat,  4 Aug 2018 09:03:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 4.17 28/31] drm/vc4: Reset ->{x, y}_scaling[1] when dealing with uniplanar formats
Date:   Sat,  4 Aug 2018 11:01:03 +0200
Message-Id: <20180804082634.237085587@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082632.304529527@linuxfoundation.org>
References: <20180804082632.304529527@linuxfoundation.org>
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

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit a6a00918d4ad8718c3ccde38c02cec17f116b2fd upstream.

This is needed to ensure ->is_unity is correct when the plane was
previously configured to output a multi-planar format with scaling
enabled, and is then being reconfigured to output a uniplanar format.

Fixes: fc04023fafec ("drm/vc4: Add support for YUV planes.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20180724133601.32114-1-boris.brezillon@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vc4/vc4_plane.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -319,6 +319,9 @@ static int vc4_plane_setup_clipping_and_
 			vc4_state->x_scaling[0] = VC4_SCALING_TPZ;
 		if (vc4_state->y_scaling[0] == VC4_SCALING_NONE)
 			vc4_state->y_scaling[0] = VC4_SCALING_TPZ;
+	} else {
+		vc4_state->x_scaling[1] = VC4_SCALING_NONE;
+		vc4_state->y_scaling[1] = VC4_SCALING_NONE;
 	}
 
 	vc4_state->is_unity = (vc4_state->x_scaling[0] == VC4_SCALING_NONE &&


