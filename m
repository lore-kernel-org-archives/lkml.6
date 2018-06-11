Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 54B41C07D5E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B38208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 16:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B38208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933829AbeFKQq7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 12:46:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49497 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933267AbeFKQq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 12:46:57 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fSPy1-0005Vl-R1; Mon, 11 Jun 2018 16:46:53 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] drm/i915/guc: fix GEM_BUG_ON check
Date:   Mon, 11 Jun 2018 17:46:53 +0100
Message-Id: <20180611164653.13691-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check for level being less than zero always false because flags
is currently unsigned and can never be negative. Fix this by making
flags a s32.

Detected by CoverityScan, CID#1468363 ("Macro compares unsigned to 0")

Signed-off-by: Colin Ian King <colin.king@canonical.com>

---
V2: Make flags s32 rather than remove the GEM_BUG_ON check, thanks to
Ville Syrjälä for spotting the mistake in my first attempt.
---
 drivers/gpu/drm/i915/intel_guc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/intel_guc.c b/drivers/gpu/drm/i915/intel_guc.c
index 116f4ccf1bbd..fb31f5004bcf 100644
--- a/drivers/gpu/drm/i915/intel_guc.c
+++ b/drivers/gpu/drm/i915/intel_guc.c
@@ -206,7 +206,7 @@ void intel_guc_fini(struct intel_guc *guc)
 static u32 get_log_control_flags(void)
 {
 	u32 level = i915_modparams.guc_log_level;
-	u32 flags = 0;
+	s32 flags = 0;
 
 	GEM_BUG_ON(level < 0);
 
-- 
2.17.0

