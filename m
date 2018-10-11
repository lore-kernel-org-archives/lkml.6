Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA614C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F9421470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqgjgL3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F9421470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbeJKXPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbeJKXPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:15:15 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F9612085B;
        Thu, 11 Oct 2018 15:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272849;
        bh=GpoGZRrhwMV2iPluu18rrw7i1K3qmpE5wKXGn76r6YI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NqgjgL3Yd6QEY5XBA3O8Bjx04dzfh92za+PtE1MvwqKHDClayIhhsWX+Ya2gFIVMY
         hJcrEg4+aYK+hd7Fq4GnpnqkxUFeugzEGL7OZFghn5ZPRbyWH7kP1HM2PeZEA6MLUA
         zeJX4k0/L4jideg08tU6g1ZFsN/E5DucG6OJ72wU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH 4.18 16/44] drm/syncobj: Dont leak fences when WAIT_FOR_SUBMIT is set
Date:   Thu, 11 Oct 2018 17:39:54 +0200
Message-Id: <20181011152453.198717531@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152452.571669983@linuxfoundation.org>
References: <20181011152452.571669983@linuxfoundation.org>
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
@@ -97,6 +97,8 @@ static int drm_syncobj_fence_get_or_add_
 {
 	int ret;
 
+	WARN_ON(*fence);
+
 	*fence = drm_syncobj_fence_get(syncobj);
 	if (*fence)
 		return 1;
@@ -744,6 +746,9 @@ static signed long drm_syncobj_array_wai
 
 	if (flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
 		for (i = 0; i < count; ++i) {
+			if (entries[i].fence)
+				continue;
+
 			drm_syncobj_fence_get_or_add_callback(syncobjs[i],
 							      &entries[i].fence,
 							      &entries[i].syncobj_cb,


