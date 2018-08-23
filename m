Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B12C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AE8208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AE8208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388446AbeHWMaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:30:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55652 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHWMaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:30:12 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 30C84C83;
        Thu, 23 Aug 2018 09:01:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Francis <David.Francis@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 250/324] amd/dc/dce100: On dce100, set clocks to 0 on suspend
Date:   Thu, 23 Aug 2018 09:55:16 +0200
Message-Id: <20180823075008.562512221@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Francis <David.Francis@amd.com>

[ Upstream commit 8d4235f71513cdccd9dc52b674323c3591552bc1 ]

[Why]
When a dce100 asic was suspended, the clocks were not set to 0.
Upon resume, the new clock was compared to the existing clock,
they were found to be the same, and so the clock was not set.
This resulted in a pernicious blackscreen.

[How]
In atomic commit, check to see if there are any active pipes.
If no, set clocks to 0

Signed-off-by: David Francis <David.Francis@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c |   19 +++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
@@ -678,9 +678,22 @@ bool dce100_validate_bandwidth(
 	struct dc  *dc,
 	struct dc_state *context)
 {
-	/* TODO implement when needed but for now hardcode max value*/
-	context->bw.dce.dispclk_khz = 681000;
-	context->bw.dce.yclk_khz = 250000 * MEMORY_TYPE_MULTIPLIER;
+	int i;
+	bool at_least_one_pipe = false;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (context->res_ctx.pipe_ctx[i].stream)
+			at_least_one_pipe = true;
+	}
+
+	if (at_least_one_pipe) {
+		/* TODO implement when needed but for now hardcode max value*/
+		context->bw.dce.dispclk_khz = 681000;
+		context->bw.dce.yclk_khz = 250000 * MEMORY_TYPE_MULTIPLIER;
+	} else {
+		context->bw.dce.dispclk_khz = 0;
+		context->bw.dce.yclk_khz = 0;
+	}
 
 	return true;
 }


