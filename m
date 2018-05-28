Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938222AbeE1L1R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424474AbeE1LPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:15:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tao <xtao@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 244/272] drm/amd/display: Set vsc pack revision when DPCD revision is >= 1.2
Date: Mon, 28 May 2018 12:04:37 +0200
Message-Id: <20180528100300.807929884@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tao <xtao@amd.com>

[ Upstream commit 3b94a4007dcfd4ac5780cd3d8a2d99979c966073 ]

Brightness couldn't change when booting up in DC mode.
It was because "psr_enabled" flag was not set to true before
setting vsc packet revision, causing packet rev setup was skipped.
Now instead of checking the psr flag, it checks if the DPCD_REV >= 1.2
and set the vsc packet revision.

Signed-off-by: Tao <xtao@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -35,6 +35,7 @@
 #include "core_types.h"
 #include "set_mode_types.h"
 #include "virtual/virtual_stream_encoder.h"
+#include "dpcd_defs.h"
 
 #include "dce80/dce80_resource.h"
 #include "dce100/dce100_resource.h"
@@ -2428,7 +2429,8 @@ static void set_vsc_info_packet(
 	unsigned int vscPacketRevision = 0;
 	unsigned int i;
 
-	if (stream->sink->link->psr_enabled) {
+	/*VSC packet set to 2 when DP revision >= 1.2*/
+	if (stream->sink->link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_12) {
 		vscPacketRevision = 2;
 	}
 
