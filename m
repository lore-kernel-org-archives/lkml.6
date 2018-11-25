Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F40BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 17:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0110F20868
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 17:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0110F20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbeKZEAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 23:00:53 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51912 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeKZEAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 23:00:52 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gQxuI-0003AV-KW; Sun, 25 Nov 2018 17:09:18 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/bios/ramcfg: fix missing parentheses when calculating RON
Date:   Sun, 25 Nov 2018 17:09:18 +0000
Message-Id: <20181125170918.8088-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently, the expression for calculating RON is always going to result
in zero no matter the value of ram->mr[1] because the ! operator has
higher precedence than the shift >> operator.  I believe the missing
parentheses around the expression before appying the ! operator will
result in the desired result.

[ Note, not tested ]

Detected by CoveritScan, CID#1324005 ("Operands don't affect result")

Fixes: c25bf7b6155c ("drm/nouveau/bios/ramcfg: Separate out RON pull value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gddr3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gddr3.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gddr3.c
index 60ece0a8a2e1..1d2d6bae73cd 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gddr3.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gddr3.c
@@ -87,7 +87,7 @@ nvkm_gddr3_calc(struct nvkm_ram *ram)
 		WR  = (ram->next->bios.timing[2] & 0x007f0000) >> 16;
 		/* XXX: Get these values from the VBIOS instead */
 		DLL = !(ram->mr[1] & 0x1);
-		RON = !(ram->mr[1] & 0x300) >> 8;
+		RON = !((ram->mr[1] & 0x300) >> 8);
 		break;
 	default:
 		return -ENOSYS;
-- 
2.19.1

