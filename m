Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A31FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C7321855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900240;
	bh=bkpvYDWVUoXICxx2YrmekWRJpiMXK1Ifq7q+ewo1U2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yH9oJreJuZg3FX5and/QEcENtct7D9luxklvKZzk4WSpGe/Rn4XNtfHxLMLOVp9hW
	 awUFQ7sQzSaBG2rGJtxFHMdEn13V//9Q6GJVPdntk7EqURhbliWX9IWYGbTyeLB3Ih
	 bQ7GrZ4+sAWWFi4EtWnjBkjusIILcpnFnHJCDxR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732772AbfBKPui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:50:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:49036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731063AbfBKOi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:38:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5376620700;
        Mon, 11 Feb 2019 14:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895937;
        bh=bkpvYDWVUoXICxx2YrmekWRJpiMXK1Ifq7q+ewo1U2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kh3o4IWa2RH59cP//wyUXkWO3BSEQ3vfLOiNhPhvADUg0ROacVHyWWICNyqjLRU1D
         yEH1EmZRmEPyqljDMc51sLKBPjm5MQSSLjg8Q9yyTht6Eed+hWpS38zs+wubRLwlYl
         TmlEkzBReYHh76eQvarIvKQ8Mx7YIgFJJutsiUB0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 002/313] drm/bufs: Fix Spectre v1 vulnerability
Date:   Mon, 11 Feb 2019 15:14:42 +0100
Message-Id: <20190211141852.914831347@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a37805098900a6e73a55b3a43b7d3bcd987bb3f4 ]

idx can be indirectly controlled by user-space, hence leading to a
potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/gpu/drm/drm_bufs.c:1420 drm_legacy_freebufs() warn: potential
spectre issue 'dma->buflist' [r] (local cap)

Fix this by sanitizing idx before using it to index dma->buflist

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20181016095549.GA23586@embeddedor.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_bufs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
index ba8cfe65c65b..e2f775d1c112 100644
--- a/drivers/gpu/drm/drm_bufs.c
+++ b/drivers/gpu/drm/drm_bufs.c
@@ -36,6 +36,8 @@
 #include <drm/drmP.h>
 #include "drm_legacy.h"
 
+#include <linux/nospec.h>
+
 static struct drm_map_list *drm_find_matching_map(struct drm_device *dev,
 						  struct drm_local_map *map)
 {
@@ -1417,6 +1419,7 @@ int drm_legacy_freebufs(struct drm_device *dev, void *data,
 				  idx, dma->buf_count - 1);
 			return -EINVAL;
 		}
+		idx = array_index_nospec(idx, dma->buf_count);
 		buf = dma->buflist[idx];
 		if (buf->file_priv != file_priv) {
 			DRM_ERROR("Process %d freeing buffer not owned\n",
-- 
2.19.1



