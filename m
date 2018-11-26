Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D645AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D28A2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQGxWtIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D28A2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbeKZVvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:51:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:60748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbeKZVvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:51:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EABC920817;
        Mon, 26 Nov 2018 10:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229857;
        bh=J9Dxg/TeLt9QEYntGwZ8T0NkCJ+Oa9vzGuflROqBAUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQGxWtIY2ZIV40z/ANu5u6059krk6PzMbfTo9xcPwbokrnqBHhFriZe7Y1kMWljbi
         liRdnkIj1KrBst4/9wlYNH5CBwwqDB/rCHdPq0dQyGNaXw8k521D6AerFj82vrQz10
         HFAwsnuJhIE+T9INGqvyz3Oiv+Z994KKQutNBJBw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 27/46] gfs2: Put bitmap buffers in put_super
Date:   Mon, 26 Nov 2018 11:51:16 +0100
Message-Id: <20181126105048.717816306@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105045.447291262@linuxfoundation.org>
References: <20181126105045.447291262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 10283ea525d30f2e99828978fd04d8427876a7ad upstream.

gfs2_put_super calls gfs2_clear_rgrpd to destroy the gfs2_rgrpd objects
attached to the resource group glocks.  That function should release the
buffers attached to the gfs2_bitmap objects (bi_bh), but the call to
gfs2_rgrp_brelse for doing that is missing.

When gfs2_releasepage later runs across these buffers which are still
referenced, it refuses to free them.  This causes the pages the buffers
are attached to to remain referenced as well.  With enough mount/unmount
cycles, the system will eventually run out of memory.

Fix this by adding the missing call to gfs2_rgrp_brelse in
gfs2_clear_rgrpd.

(Also fix a gfs2_rgrp_relse -> gfs2_rgrp_brelse typo in a comment.)

Fixes: 39b0f1e92908 ("GFS2: Don't brelse rgrp buffer_heads every allocation")
Cc: stable@vger.kernel.org # v4.9
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/rgrp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 832824994aae..073126707270 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -715,6 +715,7 @@ void gfs2_clear_rgrpd(struct gfs2_sbd *sdp)
 			spin_lock(&gl->gl_lockref.lock);
 			gl->gl_object = NULL;
 			spin_unlock(&gl->gl_lockref.lock);
+			gfs2_rgrp_brelse(rgd);
 			gfs2_glock_add_to_lru(gl);
 			gfs2_glock_put(gl);
 		}
@@ -1125,7 +1126,7 @@ static u32 count_unlinked(struct gfs2_rgrpd *rgd)
  * @rgd: the struct gfs2_rgrpd describing the RG to read in
  *
  * Read in all of a Resource Group's header and bitmap blocks.
- * Caller must eventually call gfs2_rgrp_relse() to free the bitmaps.
+ * Caller must eventually call gfs2_rgrp_brelse() to free the bitmaps.
  *
  * Returns: errno
  */
-- 
2.17.1



