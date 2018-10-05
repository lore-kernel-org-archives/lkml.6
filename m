Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC21BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7812064E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7812064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbeJERuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 13:50:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47789 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727581AbeJERuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 13:50:10 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 85F504585B483;
        Fri,  5 Oct 2018 18:51:47 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.399.0; Fri, 5 Oct 2018 18:51:42 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        David Airlie <airlied@linux.ie>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/arm/malidp: remove set but not used variable 'afbc_superblock_size'
Date:   Fri, 5 Oct 2018 11:03:13 +0000
Message-ID: <1538737393-112861-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/arm/malidp_drv.c: In function 'malidp_verify_afbc_framebuffer_size':
drivers/gpu/drm/arm/malidp_drv.c:318:6: warning:
 variable 'afbc_superblock_size' set but not used [-Wunused-but-set-variable]
  u32 afbc_superblock_size = 0, afbc_superblock_height = 0;

It never used since be introduced in
commit 3dae1c0919d8 ("drm/arm/malidp: Implemented the size validation for AFBC framebuffers")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/arm/malidp_drv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 9021485..1b0ede6 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -315,7 +315,7 @@ static void malidp_atomic_commit_tail(struct drm_atomic_state *state)
 	int n_superblocks = 0;
 	const struct drm_format_info *info;
 	struct drm_gem_object *objs = NULL;
-	u32 afbc_superblock_size = 0, afbc_superblock_height = 0;
+	u32 afbc_superblock_height = 0;
 	u32 afbc_superblock_width = 0, afbc_size = 0;
 
 	switch (mode_cmd->modifier[0] & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) {
@@ -333,9 +333,6 @@ static void malidp_atomic_commit_tail(struct drm_atomic_state *state)
 	n_superblocks = (mode_cmd->width / afbc_superblock_width) *
 		(mode_cmd->height / afbc_superblock_height);
 
-	afbc_superblock_size = info->cpp[0] * afbc_superblock_width *
-		afbc_superblock_height;
-
 	afbc_size = ALIGN(n_superblocks * AFBC_HEADER_SIZE, 128);
 
 	if (mode_cmd->width * info->cpp[0] != mode_cmd->pitches[0]) {

