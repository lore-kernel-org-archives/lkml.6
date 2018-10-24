Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE78ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A6A20831
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A6A20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeJYDM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:12:27 -0400
Received: from anholt.net ([50.246.234.109]:53108 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbeJYDM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:12:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id A1A5710A130F;
        Wed, 24 Oct 2018 11:43:16 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id D5LqaGh83C7H; Wed, 24 Oct 2018 11:43:14 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id B911210A042F;
        Wed, 24 Oct 2018 11:43:14 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 8328D2FE1BF3; Wed, 24 Oct 2018 11:43:13 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 3/3] drm/tinydrm: Fix setting of the column/page end addresses.
Date:   Wed, 24 Oct 2018 11:43:13 -0700
Message-Id: <20181024184313.2967-4-eric@anholt.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181024184313.2967-1-eric@anholt.net>
References: <20181024184313.2967-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the clipped dirty region's x/y happened to align to 256, we would
have set the top 8 bits wrong.  Noticed by inspection, not by
reproducing a bug.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/tinydrm/mipi-dbi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tinydrm/mipi-dbi.c b/drivers/gpu/drm/tinydrm/mipi-dbi.c
index cb3441e51d5f..1bb870021f6e 100644
--- a/drivers/gpu/drm/tinydrm/mipi-dbi.c
+++ b/drivers/gpu/drm/tinydrm/mipi-dbi.c
@@ -240,10 +240,10 @@ static int mipi_dbi_fb_dirty(struct drm_framebuffer *fb,
 
 	mipi_dbi_command(mipi, MIPI_DCS_SET_COLUMN_ADDRESS,
 			 (clip.x1 >> 8) & 0xFF, clip.x1 & 0xFF,
-			 (clip.x2 >> 8) & 0xFF, (clip.x2 - 1) & 0xFF);
+			 ((clip.x2 - 1) >> 8) & 0xFF, (clip.x2 - 1) & 0xFF);
 	mipi_dbi_command(mipi, MIPI_DCS_SET_PAGE_ADDRESS,
 			 (clip.y1 >> 8) & 0xFF, clip.y1 & 0xFF,
-			 (clip.y2 >> 8) & 0xFF, (clip.y2 - 1) & 0xFF);
+			 ((clip.y2 - 1) >> 8) & 0xFF, (clip.y2 - 1) & 0xFF);
 
 	ret = mipi_dbi_command_buf(mipi, MIPI_DCS_WRITE_MEMORY_START, tr,
 				(clip.x2 - clip.x1) * (clip.y2 - clip.y1) * 2);
-- 
2.19.1

