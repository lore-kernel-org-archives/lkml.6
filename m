Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8436C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8D72089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8D72089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbeIZOeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:34:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41744 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIZOeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:34:17 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g555Y-0006s1-TB; Wed, 26 Sep 2018 08:22:28 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau/bios/dp: Make array vsoff static, shrinks object size
Date:   Wed, 26 Sep 2018 09:22:28 +0100
Message-Id: <20180926082228.12635-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array vsoff on the stack but instead make it
static. Makes the object code smaller by 67 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
   5753	    112	      0	   5865	   16e9 drm/nouveau/nvkm/subdev/bios/dp.o

After:
   text	   data	    bss	    dec	    hex	filename
   5622	    176	      0	   5798	   16a6 drm/nouveau/nvkm/subdev/bios/dp.o

(gcc version 8.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/dp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/dp.c
index 3133b28f849c..b099d1209be8 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/dp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/dp.c
@@ -212,7 +212,7 @@ nvbios_dpcfg_match(struct nvkm_bios *bios, u16 outp, u8 pc, u8 vs, u8 pe,
 	u16 data;
 
 	if (*ver >= 0x30) {
-		const u8 vsoff[] = { 0, 4, 7, 9 };
+		static const u8 vsoff[] = { 0, 4, 7, 9 };
 		idx = (pc * 10) + vsoff[vs] + pe;
 		if (*ver >= 0x40 && *ver <= 0x41 && *hdr >= 0x12)
 			idx += nvbios_rd08(bios, outp + 0x11) * 40;
-- 
2.17.1

