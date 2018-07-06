Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C43C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F40D2404E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F40D2404E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933109AbeGFFsK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:48:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59748 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932726AbeGFFsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:48:08 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D1AC886A;
        Fri,  6 Jul 2018 05:48:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeremy Cline <jcline@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 4.17 25/46] drm/qxl: Call qxl_bo_unref outside atomic context
Date:   Fri,  6 Jul 2018 07:46:46 +0200
Message-Id: <20180706054525.798595965@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054524.595521988@linuxfoundation.org>
References: <20180706054524.595521988@linuxfoundation.org>
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

From: Jeremy Cline <jcline@redhat.com>

commit 889ad63d41eea20184b0483e7e585e5b20fb6cfe upstream.

"qxl_bo_unref" may sleep, but calling "qxl_release_map" causes
"preempt_disable()" to be called and "preempt_enable()" isn't called
until "qxl_release_unmap" is used. Move the call to "qxl_bo_unref" out
from in between the two to avoid sleeping from an atomic context.

This issue can be demonstrated on a kernel with CONFIG_LOCKDEP=y by
creating a VM using QXL, using a desktop environment using Xorg, then
moving the cursor on or off a window.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1571128
Fixes: 9428088c90b6 ("drm/qxl: reapply cursor after resetting primary")
Cc: stable@vger.kernel.org
Signed-off-by: Jeremy Cline <jcline@redhat.com>
Link: http://patchwork.freedesktop.org/patch/msgid/20180601200532.13619-1-jcline@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/qxl/qxl_display.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -630,7 +630,7 @@ static void qxl_cursor_atomic_update(str
 	struct qxl_cursor_cmd *cmd;
 	struct qxl_cursor *cursor;
 	struct drm_gem_object *obj;
-	struct qxl_bo *cursor_bo = NULL, *user_bo = NULL;
+	struct qxl_bo *cursor_bo = NULL, *user_bo = NULL, *old_cursor_bo = NULL;
 	int ret;
 	void *user_ptr;
 	int size = 64*64*4;
@@ -684,7 +684,7 @@ static void qxl_cursor_atomic_update(str
 							   cursor_bo, 0);
 		cmd->type = QXL_CURSOR_SET;
 
-		qxl_bo_unref(&qcrtc->cursor_bo);
+		old_cursor_bo = qcrtc->cursor_bo;
 		qcrtc->cursor_bo = cursor_bo;
 		cursor_bo = NULL;
 	} else {
@@ -704,6 +704,9 @@ static void qxl_cursor_atomic_update(str
 	qxl_push_cursor_ring_release(qdev, release, QXL_CMD_CURSOR, false);
 	qxl_release_fence_buffer_objects(release);
 
+	if (old_cursor_bo)
+		qxl_bo_unref(&old_cursor_bo);
+
 	qxl_bo_unref(&cursor_bo);
 
 	return;


