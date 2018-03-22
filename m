Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeCVXba (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 19:31:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53434 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751823AbeCVXb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 19:31:29 -0400
From: Colin King <colin.king@canonical.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>,
        Tony Cheng <tony.cheng@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: don't pass large struct stream_res by value
Date: Thu, 22 Mar 2018 23:31:25 +0000
Message-Id: <20180322233125.17251-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Passing stream_res by value is inefficient as it requires a large copy
of 320 bytes.  Instead, pass it by reference and also use a pointer to
stream_res->tg and also stream_res->abm to clean up the code a little.

Detected by CoverityScan, CID#1466432 ("Big parameter passed by value")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  | 30 +++++++++++-----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 8b0f6b8a5627..222d78fc733d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1812,32 +1812,32 @@ static void update_dchubp_dpp(
 
 static void dcn10_otg_blank(
 		struct dc *dc,
-		struct stream_resource stream_res,
+		struct stream_resource *stream_res,
 		struct dc_stream_state *stream,
 		bool blank)
 {
 	enum dc_color_space color_space;
 	struct tg_color black_color = {0};
+	struct timing_generator *tg = stream_res->tg;
+	struct abm *abm = stream_res->abm;
 
 	/* program otg blank color */
 	color_space = stream->output_color_space;
 	color_space_to_black_color(dc, color_space, &black_color);
 
-	if (stream_res.tg->funcs->set_blank_color)
-		stream_res.tg->funcs->set_blank_color(
-				stream_res.tg,
-				&black_color);
+	if (tg->funcs->set_blank_color)
+		tg->funcs->set_blank_color(tg, &black_color);
 
 	if (!blank) {
-		if (stream_res.tg->funcs->set_blank)
-			stream_res.tg->funcs->set_blank(stream_res.tg, blank);
-		if (stream_res.abm)
-			stream_res.abm->funcs->set_abm_level(stream_res.abm, stream->abm_level);
+		if (tg->funcs->set_blank)
+			tg->funcs->set_blank(tg, blank);
+		if (abm)
+			abm->funcs->set_abm_level(abm, stream->abm_level);
 	} else if (blank) {
-		if (stream_res.abm)
-			stream_res.abm->funcs->set_abm_immediate_disable(stream_res.abm);
-		if (stream_res.tg->funcs->set_blank)
-			stream_res.tg->funcs->set_blank(stream_res.tg, blank);
+		if (abm)
+			abm->funcs->set_abm_immediate_disable(abm);
+		if (tg->funcs->set_blank)
+			tg->funcs->set_blank(tg, blank);
 	}
 }
 
@@ -1876,7 +1876,7 @@ static void program_all_pipe_in_tree(
 		pipe_ctx->stream_res.tg->funcs->program_global_sync(
 				pipe_ctx->stream_res.tg);
 
-		dcn10_otg_blank(dc, pipe_ctx->stream_res,
+		dcn10_otg_blank(dc, &pipe_ctx->stream_res,
 				pipe_ctx->stream, blank);
 	}
 
@@ -1996,7 +1996,7 @@ static void dcn10_apply_ctx_for_surface(
 
 	if (num_planes == 0) {
 		/* OTG blank before remove all front end */
-		dcn10_otg_blank(dc, top_pipe_to_program->stream_res, top_pipe_to_program->stream, true);
+		dcn10_otg_blank(dc, &top_pipe_to_program->stream_res, top_pipe_to_program->stream, true);
 	}
 
 	/* Disconnect unused mpcc */
-- 
2.15.1
