Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeBRWDW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 17:03:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751754AbeBRWBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 17:01:52 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] ASoC: Intel: sst: Remove unnecessary sst_init_stream() function
Date: Sun, 18 Feb 2018 23:01:40 +0100
Message-Id: <20180218220146.22485-4-hdegoede@redhat.com>
In-Reply-To: <20180218220146.22485-1-hdegoede@redhat.com>
References: <20180218220146.22485-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sst_init_stream() has only one caller and all its function arguments are
unused. Inline it on the one call site and remove it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/atom/sst/sst.h        | 2 --
 sound/soc/intel/atom/sst/sst_pvt.c    | 7 -------
 sound/soc/intel/atom/sst/sst_stream.c | 5 ++---
 3 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
index 1f3107909044..164b0f674c20 100644
--- a/sound/soc/intel/atom/sst/sst.h
+++ b/sound/soc/intel/atom/sst/sst.h
@@ -494,8 +494,6 @@ int sst_prepare_and_post_msg(struct intel_sst_drv *sst,
 
 void sst_process_pending_msg(struct work_struct *work);
 int sst_assign_pvt_id(struct intel_sst_drv *sst_drv_ctx);
-void sst_init_stream(struct stream_info *stream,
-		int codec, int sst_id, int ops, u8 slot);
 int sst_validate_strid(struct intel_sst_drv *sst_drv_ctx, int str_id);
 struct stream_info *get_stream_info(struct intel_sst_drv *sst_drv_ctx,
 		int str_id);
diff --git a/sound/soc/intel/atom/sst/sst_pvt.c b/sound/soc/intel/atom/sst/sst_pvt.c
index d7d38b0f68db..af93244b4868 100644
--- a/sound/soc/intel/atom/sst/sst_pvt.c
+++ b/sound/soc/intel/atom/sst/sst_pvt.c
@@ -360,13 +360,6 @@ int sst_assign_pvt_id(struct intel_sst_drv *drv)
 	return local;
 }
 
-void sst_init_stream(struct stream_info *stream,
-		int codec, int sst_id, int ops, u8 slot)
-{
-	stream->status = STREAM_INIT;
-	stream->prev = STREAM_UN_INIT;
-}
-
 int sst_validate_strid(
 		struct intel_sst_drv *sst_drv_ctx, int str_id)
 {
diff --git a/sound/soc/intel/atom/sst/sst_stream.c b/sound/soc/intel/atom/sst/sst_stream.c
index b082b0922a7a..7cf5dd1993bc 100644
--- a/sound/soc/intel/atom/sst/sst_stream.c
+++ b/sound/soc/intel/atom/sst/sst_stream.c
@@ -83,6 +83,8 @@ int sst_alloc_stream_mrfld(struct intel_sst_drv *sst_drv_ctx, void *params)
 
 	pipe_id = str_params->device_type;
 	task_id = str_params->task;
+	sst_drv_ctx->streams[str_id].status = STREAM_INIT;
+	sst_drv_ctx->streams[str_id].prev = STREAM_UN_INIT;
 	sst_drv_ctx->streams[str_id].pipe_id = pipe_id;
 	sst_drv_ctx->streams[str_id].task_id = task_id;
 	sst_drv_ctx->streams[str_id].num_ch = num_ch;
@@ -100,9 +102,6 @@ int sst_alloc_stream_mrfld(struct intel_sst_drv *sst_drv_ctx, void *params)
 			pipe_id, task_id);
 
 	/* allocate device type context */
-	sst_init_stream(&sst_drv_ctx->streams[str_id], alloc_param.codec_type,
-			str_id, alloc_param.operation, 0);
-
 	dev_dbg(sst_drv_ctx->dev, "Alloc for str %d pipe %#x\n",
 			str_id, pipe_id);
 	ret = sst_prepare_and_post_msg(sst_drv_ctx, task_id, IPC_CMD,
-- 
2.14.3
