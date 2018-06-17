Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8568CC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 08:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364E6208A5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 08:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="yYn2khpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364E6208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932762AbeFQIwv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 04:52:51 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:43772 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932478AbeFQIwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 04:52:49 -0400
Received: from trochilidae.lan (unknown [37.17.239.3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 74AFE5C037A;
        Sun, 17 Jun 2018 10:52:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1529225568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=CB48aVpV0RgnRWL0sppEAN3vWmirvHvhS94TraMA13g=;
        b=yYn2khpG7QgwV/00vQJnzwqQOmBAXTyvaBwUCaU3T6aIIZ1UYO+pXxOlFtlLlo66MGcSlx
        bU0Od8wNfr1TJbFBVNXHDejPRt9LFo8spnxXIVsi3L6E/jeEDcPAK1Oiv97MQaRTZzSvaC
        Rsf3TKBd43KEdWlh5Ihx9lcUGEkU7q4=
From:   Stefan Agner <stefan@agner.ch>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     Stefan Agner <stefan@agner.ch>, James Zhu <James.Zhu@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: use first uvd instance to avoid clang build error
Date:   Sun, 17 Jun 2018 10:52:12 +0200
Message-Id: <20180617085218.7753-1-stefan@agner.ch>
X-Mailer: git-send-email 2.17.1
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:13030, ipnet:37.17.238.0/23, country:CH];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly use the first uvd instance to avoid a build error when
using clang 6:
drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1148:52: error: expected ')'
                container_of(work, struct amdgpu_device, uvd.inst->idle_work.work);
                                                                 ^
drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1148:3: note: to match this '('
                container_of(work, struct amdgpu_device, uvd.inst->idle_work.work);
                ^
./include/linux/kernel.h:967:21: note: expanded from macro 'container_of'
        ((type *)(__mptr - offsetof(type, member))); })
                           ^
./include/linux/stddef.h:17:32: note: expanded from macro 'offsetof'
                                ^
./include/linux/compiler-gcc.h:170:20: note: expanded from macro
      '__compiler_offsetof'
        __builtin_offsetof(a, b)
                          ^
drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1147:24: error: initializing
      'struct amdgpu_device *' with an expression of incompatible type 'void'
        struct amdgpu_device *adev =
                              ^
2 errors generated.

Fixes: 10dd74eac4db ("drm/amdgpu/vg20:Restruct uvd.inst to support multiple instances")
Cc: James Zhu <James.Zhu@amd.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index bcf68f80bbf0..6666a5888c44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1145,7 +1145,7 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_device *adev =
-		container_of(work, struct amdgpu_device, uvd.inst->idle_work.work);
+		container_of(work, struct amdgpu_device, uvd.inst[0].idle_work.work);
 	unsigned fences = 0, i, j;
 
 	for (i = 0; i < adev->uvd.num_uvd_inst; ++i) {
-- 
2.17.1

