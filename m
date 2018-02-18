Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbeBRWDj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 17:03:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751642AbeBRWBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 17:01:50 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] ASoC: Intel: sst: Fix error-code check in sst_pause_stream()
Date: Sun, 18 Feb 2018 23:01:38 +0100
Message-Id: <20180218220146.22485-2-hdegoede@redhat.com>
In-Reply-To: <20180218220146.22485-1-hdegoede@redhat.com>
References: <20180218220146.22485-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value returned by sst_prepare_and_post_msg() is a negated SST_ERR_*
value, so we must check for -SST_ERR_INVALID_STREAM_ID. Note that
sst_pause_resume() already has the correct check.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/atom/sst/sst_stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_stream.c b/sound/soc/intel/atom/sst/sst_stream.c
index 7ee6aeb7e0af..b082b0922a7a 100644
--- a/sound/soc/intel/atom/sst/sst_stream.c
+++ b/sound/soc/intel/atom/sst/sst_stream.c
@@ -253,7 +253,7 @@ int sst_pause_stream(struct intel_sst_drv *sst_drv_ctx, int str_id)
 		if (retval == 0) {
 			str_info->prev = str_info->status;
 			str_info->status = STREAM_PAUSED;
-		} else if (retval == SST_ERR_INVALID_STREAM_ID) {
+		} else if (retval == -SST_ERR_INVALID_STREAM_ID) {
 			retval = -EINVAL;
 			mutex_lock(&sst_drv_ctx->sst_lock);
 			sst_clean_stream(str_info);
-- 
2.14.3
