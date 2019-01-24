Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB421C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA5F218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359062;
	bh=Q0Ae1N+x7l3zGqXQEx3RftmXUjQZ/bLHFXDsh9WTGEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BkL8FFcNM6dOLKEXYwXJ24zI3Q5mLilJzzjTqHjRVL8dpFndv+9Wxo0BzVnB2rPry
	 a5Xq3wY5o6CMEjziJdeDmE794ylEzAOcP30uZZnhrt6Gl299RkFK4Vw14pTjAuDH6J
	 40zekROrbH3HX13h6kE0uRbTSe4Q9AE0BDt5BsM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388074AbfAXToV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:44:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388065AbfAXToR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:44:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B83620663;
        Thu, 24 Jan 2019 19:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548359056;
        bh=Q0Ae1N+x7l3zGqXQEx3RftmXUjQZ/bLHFXDsh9WTGEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PUA7CEvWjMdKqK3Xl0ptbA2hZLfEcNJKO52OOu9tFIUzOcysnviYXTYz0bXtnXop+
         e27Y5tiQZkk+yQq6ycuif1yKb+wUS29CkZ5VqHPw+p+30N3p+lKfxIhSDmzg/lwfLH
         mxO/VryhbVcgjMZ28KlkfkWNjrb8C+T0C+uK+82o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.20 121/127] drm/amd/display: Fix disabled cursor on top screen edge
Date:   Thu, 24 Jan 2019 20:21:07 +0100
Message-Id: <20190124190217.079914320@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

commit ae1cf20df7a9c60ff5ef41c3315c33c1a5fafd77 upstream.

[Why]
The cursor vanishes when touching the top of edge of the screen for
Raven on Linux.

This occurs because the cursor height is not taken into account when
deciding to disable the cursor.

[How]
Factor in the cursor height into the cursor calculations - and mimic
the existing x position calculations.

Fixes: 94a4ffd1d40b ("drm/amd/display: fix PIP bugs on Dal3")

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c  |    2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c
@@ -463,7 +463,7 @@ void dpp1_set_cursor_position(
 	if (src_y_offset >= (int)param->viewport.height)
 		cur_en = 0;  /* not visible beyond bottom edge*/
 
-	if (src_y_offset < 0)
+	if (src_y_offset + (int)height <= 0)
 		cur_en = 0;  /* not visible beyond top edge*/
 
 	REG_UPDATE(CURSOR0_CONTROL,
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
@@ -1134,7 +1134,7 @@ void hubp1_cursor_set_position(
 	if (src_y_offset >= (int)param->viewport.height)
 		cur_en = 0;  /* not visible beyond bottom edge*/
 
-	if (src_y_offset < 0) //+ (int)hubp->curs_attr.height
+	if (src_y_offset + (int)hubp->curs_attr.height <= 0)
 		cur_en = 0;  /* not visible beyond top edge*/
 
 	if (cur_en && REG_READ(CURSOR_SURFACE_ADDRESS) == 0)


