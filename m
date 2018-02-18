Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeBRWB4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 17:01:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36506 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751845AbeBRWBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 17:01:54 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] ASoC: Intel: sst: Free streams on suspend, re-alloc on resume
Date: Sun, 18 Feb 2018 23:01:43 +0100
Message-Id: <20180218220146.22485-7-hdegoede@redhat.com>
In-Reply-To: <20180218220146.22485-1-hdegoede@redhat.com>
References: <20180218220146.22485-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Bay Trail SST-DSP firmware version looses track of all streams over a
suspend/resume, failing any attempts to resume and/or free streams, with
a SST_ERR_INVALID_STREAM_ID error.

This commit adds support for free-ing the streams on suspend and
re-allocating them on resume, fixing suspend/resume issues on devices
using this firmware version.

This new behavior gets triggered by a new flag in sst_platform_info which
only gets set on Bay Trail platforms.

This has been tested on the following devices:
-Asus T100TA,    Bay Trail    + ALC5642 codec
-Ployer MOMO7W,  Bay Trail CR + ALC5652 codec

Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/include/asm/platform_sst_audio.h |  1 +
 sound/soc/intel/atom/sst/sst.c            | 24 +++++++++++++++++++++++-
 sound/soc/intel/atom/sst/sst.h            |  4 ++++
 sound/soc/intel/atom/sst/sst_acpi.c       |  3 ++-
 sound/soc/intel/atom/sst/sst_stream.c     | 24 +++++++++++++++++++++++-
 5 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/platform_sst_audio.h b/arch/x86/include/asm/platform_sst_audio.h
index 5973a2f3db3d..059823bb8af7 100644
--- a/arch/x86/include/asm/platform_sst_audio.h
+++ b/arch/x86/include/asm/platform_sst_audio.h
@@ -135,6 +135,7 @@ struct sst_platform_info {
 	const struct sst_res_info *res_info;
 	const struct sst_lib_dnld_info *lib_info;
 	const char *platform;
+	bool streams_lost_on_suspend;
 };
 int add_sst_platform_device(void);
 #endif
diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index 8afdff457579..0962bc9adc62 100644
--- a/sound/soc/intel/atom/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -449,6 +449,13 @@ static int intel_sst_suspend(struct device *dev)
 			dev_err(dev, "stream %d is running, can't suspend, abort\n", i);
 			return -EBUSY;
 		}
+
+		if (ctx->pdata->streams_lost_on_suspend) {
+			stream->resume_status = stream->status;
+			stream->resume_prev = stream->prev;
+			if (stream->status != STREAM_UN_INIT)
+				sst_free_stream(ctx, i);
+		}
 	}
 	synchronize_irq(ctx->irq_num);
 	flush_workqueue(ctx->post_msg_wq);
@@ -509,8 +516,8 @@ static int intel_sst_resume(struct device *dev)
 {
 	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
 	struct sst_fw_save *fw_save = ctx->fw_save;
-	int ret = 0;
 	struct sst_block *block;
+	int i, ret = 0;
 
 	if (!fw_save)
 		return 0;
@@ -550,6 +557,21 @@ static int intel_sst_resume(struct device *dev)
 		sst_set_fw_state_locked(ctx, SST_FW_RUNNING);
 	}
 
+	if (ctx->pdata->streams_lost_on_suspend) {
+		for (i = 1; i <= ctx->info.max_streams; i++) {
+			struct stream_info *stream = &ctx->streams[i];
+
+			if (stream->resume_status != STREAM_UN_INIT) {
+				dev_dbg(ctx->dev, "Re-allocing stream %d status %d prev %d\n",
+					i, stream->resume_status,
+					stream->resume_prev);
+				sst_realloc_stream(ctx, i);
+				stream->status = stream->resume_status;
+				stream->prev = stream->resume_prev;
+			}
+		}
+	}
+
 	sst_free_block(ctx, block);
 	return ret;
 }
diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
index a357cd615b59..b2a705dc9304 100644
--- a/sound/soc/intel/atom/sst/sst.h
+++ b/sound/soc/intel/atom/sst/sst.h
@@ -179,6 +179,8 @@ struct sst_block {
  *
  * @status : stream current state
  * @prev : stream prev state
+ * @resume_status : stream current state to restore on resume
+ * @resume_prev : stream prev state to restore on resume
  * @lock : stream mutex for protecting state
  * @alloc_param : parameters used for stream (re-)allocation
  * @pcm_substream : PCM substream
@@ -189,6 +191,8 @@ struct sst_block {
 struct stream_info {
 	unsigned int		status;
 	unsigned int		prev;
+	unsigned int		resume_status;
+	unsigned int		resume_prev;
 	struct mutex		lock;
 	struct snd_sst_alloc_mrfld alloc_param;
 
diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 6cd481bec275..c90b04cc071d 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -143,10 +143,11 @@ static struct sst_platform_info byt_rvp_platform_data = {
 	.lib_info = &byt_lib_dnld_info,
 	.res_info = &byt_rvp_res_info,
 	.platform = "sst-mfld-platform",
+	.streams_lost_on_suspend = true,
 };
 
 /* Cherryview (Cherrytrail and Braswell) uses same mrfld dpcm fw as Baytrail,
- * so pdata is same as Baytrail.
+ * so pdata is same as Baytrail, minus the streams_lost_on_suspend quirk.
  */
 static struct sst_platform_info chv_platform_data = {
 	.probe_data = &byt_fwparse_info,
diff --git a/sound/soc/intel/atom/sst/sst_stream.c b/sound/soc/intel/atom/sst/sst_stream.c
index fcedaa237505..107271f7dd63 100644
--- a/sound/soc/intel/atom/sst/sst_stream.c
+++ b/sound/soc/intel/atom/sst/sst_stream.c
@@ -302,7 +302,29 @@ int sst_resume_stream(struct intel_sst_drv *sst_drv_ctx, int str_id)
 		return -EINVAL;
 	if (str_info->status == STREAM_RUNNING)
 		return 0;
-	if (str_info->status == STREAM_PAUSED) {
+
+	if (str_info->resume_status == STREAM_PAUSED &&
+	    str_info->resume_prev == STREAM_RUNNING) {
+		/*
+		 * Stream was running before suspend and re-created on resume,
+		 * start it to get back to running state.
+		 */
+		dev_dbg(sst_drv_ctx->dev, "restart recreated stream after resume\n");
+		str_info->status = STREAM_RUNNING;
+		str_info->prev = STREAM_PAUSED;
+		retval = sst_start_stream(sst_drv_ctx, str_id);
+		str_info->resume_status = STREAM_UN_INIT;
+	} else if (str_info->resume_status == STREAM_PAUSED &&
+		   str_info->resume_prev == STREAM_INIT) {
+		/*
+		 * Stream was idle before suspend and re-created on resume,
+		 * keep it as is.
+		 */
+		dev_dbg(sst_drv_ctx->dev, "leaving recreated stream idle after resume\n");
+		str_info->status = STREAM_INIT;
+		str_info->prev = STREAM_PAUSED;
+		str_info->resume_status = STREAM_UN_INIT;
+	} else if (str_info->status == STREAM_PAUSED) {
 		retval = sst_prepare_and_post_msg(sst_drv_ctx, str_info->task_id,
 				IPC_CMD, IPC_IA_RESUME_STREAM_MRFLD,
 				str_info->pipe_id, 0, NULL, NULL,
-- 
2.14.3
