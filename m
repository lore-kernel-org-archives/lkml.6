Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EBFC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD6020645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/GfzTvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD6020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbeJICFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbeJICFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:05:18 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3014A20645;
        Mon,  8 Oct 2018 18:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024730;
        bh=+/W9j0Qrs5iJFVWUadykvhEjiGEqb19C18Zk2C4m6BI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u/GfzTvJ6xce5n+O5ePfNSR95/My4ntfIg0/DYCwzJ3Mf8Ow2jsOudrPXgTpHbhvn
         +9Xxv6gyLkTRMP7If7TCkFB1hQqhPDMBXO9438qXi1Uy4HNyD3aeEDtjwWE1WvOTaN
         eZKNX86dYDkK/pWZaL7JUiYzaRygO0sAgk4B6cic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 134/168] drm/amdgpu: fix error handling in amdgpu_cs_user_fence_chunk
Date:   Mon,  8 Oct 2018 20:31:54 +0200
Message-Id: <20181008175625.138805888@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Christian König" <christian.koenig@amd.com>

[ Upstream commit 0165de983272d1fae0809ed9db47c46a412279bc ]

Slowly leaking memory one page at a time :)

Signed-off-by: Christian KÃ¶nig <christian.koenig@amd.com>
Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -38,6 +38,7 @@ static int amdgpu_cs_user_fence_chunk(st
 {
 	struct drm_gem_object *gobj;
 	unsigned long size;
+	int r;
 
 	gobj = drm_gem_object_lookup(p->filp, data->handle);
 	if (gobj == NULL)
@@ -49,20 +50,26 @@ static int amdgpu_cs_user_fence_chunk(st
 	p->uf_entry.tv.shared = true;
 	p->uf_entry.user_pages = NULL;
 
-	size = amdgpu_bo_size(p->uf_entry.robj);
-	if (size != PAGE_SIZE || (data->offset + 8) > size)
-		return -EINVAL;
-
-	*offset = data->offset;
-
 	drm_gem_object_put_unlocked(gobj);
 
+	size = amdgpu_bo_size(p->uf_entry.robj);
+	if (size != PAGE_SIZE || (data->offset + 8) > size) {
+		r = -EINVAL;
+		goto error_unref;
+	}
+
 	if (amdgpu_ttm_tt_get_usermm(p->uf_entry.robj->tbo.ttm)) {
-		amdgpu_bo_unref(&p->uf_entry.robj);
-		return -EINVAL;
+		r = -EINVAL;
+		goto error_unref;
 	}
 
+	*offset = data->offset;
+
 	return 0;
+
+error_unref:
+	amdgpu_bo_unref(&p->uf_entry.robj);
+	return r;
 }
 
 static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, void *data)


