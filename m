Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9EDC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830D2213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0BMx8v3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830D2213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbeJKXMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729994AbeJKXMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:12:52 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C003D2098A;
        Thu, 11 Oct 2018 15:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272707;
        bh=IDv1LAzL/Tj4z5eiXV0G72yXwHSZPlQVXshP6MWfJMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0BMx8v3hnIGuSEOfWTptJzzyGxm3E/MLvJbbRt141asi98laBfp9eSMMC7n3Ew9/O
         iZcT9fcAQLBlxyjiUCG+8OBbTahiv+v897LdFelDEGln+EOEiFVNewg+jSCjx+T1Nc
         PL2fy7Bryz7TCasLDiD3DL37Ul4PvTkw4rnEZSJU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH 4.14 11/45] drm/syncobj: Dont leak fences when WAIT_FOR_SUBMIT is set
Date:   Thu, 11 Oct 2018 17:39:38 +0200
Message-Id: <20181011152509.336749977@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152508.885515042@linuxfoundation.org>
References: <20181011152508.885515042@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Ekstrand <jason@jlekstrand.net>

commit 337fe9f5c1e7de1f391c6a692531379d2aa2ee11 upstream.

We attempt to get fences earlier in the hopes that everything will
already have fences and no callbacks will be needed.  If we do succeed
in getting a fence, getting one a second time will result in a duplicate
ref with no unref.  This is causing memory leaks in Vulkan applications
that create a lot of fences; playing for a few hours can, apparently,
bring down the system.

Cc: stable@vger.kernel.org
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=107899
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Jason Ekstrand <jason@jlekstrand.net>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20180926071703.15257-1-jason.ekstrand@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_syncobj.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -96,6 +96,8 @@ static int drm_syncobj_fence_get_or_add_
 {
 	int ret;
 
+	WARN_ON(*fence);
+
 	*fence = drm_syncobj_fence_get(syncobj);
 	if (*fence)
 		return 1;
@@ -656,6 +658,9 @@ static signed long drm_syncobj_array_wai
 
 	if (flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
 		for (i = 0; i < count; ++i) {
+			if (entries[i].fence)
+				continue;
+
 			drm_syncobj_fence_get_or_add_callback(syncobjs[i],
 							      &entries[i].fence,
 							      &entries[i].syncobj_cb,


