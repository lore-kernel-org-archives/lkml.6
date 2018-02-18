Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbeBRWBy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 17:01:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751813AbeBRWBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 17:01:52 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] ASoC: Intel: sst: Remove unused STREAM_DECODE and STREAM_RESET states
Date: Sun, 18 Feb 2018 23:01:41 +0100
Message-Id: <20180218220146.22485-5-hdegoede@redhat.com>
In-Reply-To: <20180218220146.22485-1-hdegoede@redhat.com>
References: <20180218220146.22485-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STREAM_DECODE is completely unused, status == STREAM_RESET was checked
for, but never set, remove both.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/atom/sst/sst.h               |  4 +---
 sound/soc/intel/atom/sst/sst_drv_interface.c | 19 -------------------
 2 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
index 164b0f674c20..f4fd442080b2 100644
--- a/sound/soc/intel/atom/sst/sst.h
+++ b/sound/soc/intel/atom/sst/sst.h
@@ -65,9 +65,7 @@ enum sst_stream_states {
 	STREAM_UN_INIT	= 0,	/* Freed/Not used stream */
 	STREAM_RUNNING	= 1,	/* Running */
 	STREAM_PAUSED	= 2,	/* Paused stream */
-	STREAM_DECODE	= 3,	/* stream is in decoding only state */
-	STREAM_INIT	= 4,	/* stream init, waiting for data */
-	STREAM_RESET	= 5,	/* force reset on recovery */
+	STREAM_INIT	= 3,	/* stream init, waiting for data */
 };
 
 enum sst_ram_type {
diff --git a/sound/soc/intel/atom/sst/sst_drv_interface.c b/sound/soc/intel/atom/sst/sst_drv_interface.c
index 71af5449be90..6a8b253c58d2 100644
--- a/sound/soc/intel/atom/sst/sst_drv_interface.c
+++ b/sound/soc/intel/atom/sst/sst_drv_interface.c
@@ -238,16 +238,7 @@ static int sst_cdev_close(struct device *dev, unsigned int str_id)
 		return -EINVAL;
 	}
 
-	if (stream->status == STREAM_RESET) {
-		dev_dbg(dev, "stream in reset state...\n");
-		stream->status = STREAM_UN_INIT;
-
-		retval = 0;
-		goto put;
-	}
-
 	retval = sst_free_stream(ctx, str_id);
-put:
 	stream->compr_cb_param = NULL;
 	stream->compr_cb = NULL;
 
@@ -256,7 +247,6 @@ static int sst_cdev_close(struct device *dev, unsigned int str_id)
 
 	dev_dbg(dev, "End\n");
 	return retval;
-
 }
 
 static int sst_cdev_ack(struct device *dev, unsigned int str_id,
@@ -486,16 +476,7 @@ static int sst_close_pcm_stream(struct device *dev, unsigned int str_id)
 		return -EINVAL;
 	}
 
-	if (stream->status == STREAM_RESET) {
-		/* silently fail here as we have cleaned the stream earlier */
-		dev_dbg(ctx->dev, "stream in reset state...\n");
-
-		retval = 0;
-		goto put;
-	}
-
 	retval = free_stream_context(ctx, str_id);
-put:
 	stream->pcm_substream = NULL;
 	stream->status = STREAM_UN_INIT;
 	stream->period_elapsed = NULL;
-- 
2.14.3
