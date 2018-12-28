Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5ADC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB328218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999413;
	bh=hSoUSRntLY29uPkLS7rCGNzylYTx6HVPTSPeFLEqWHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K97Mv2txh1WIu4yv4FuyxaMa5OaU4DEh0PRb4IyBcafdZNjRFfS6S1dt7wQfWfWLO
	 oTByxmhAENG8i758Cog+XIkmR7mGI7sTINxUxfX0iqXOset4akkJdF7u2hHfCZKFes
	 vNPmgnOXK1KjT1OSYMTTB2IZV35BI0JNefNWPJzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732793AbeL1MQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:16:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:35896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732777AbeL1MQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:16:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 676EF2148E;
        Fri, 28 Dec 2018 12:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999406;
        bh=hSoUSRntLY29uPkLS7rCGNzylYTx6HVPTSPeFLEqWHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XafhEYNJfPe/tV0KOtUjQAqjVOTs+hSJT9voYVLqtEqIGR91fCk6TuT/E/1LJpm+U
         njVi+6UrVnf8xzxloW37m2foux5NT6NXOwbhc9G395m3+spMrhvFtSYXoxL6RJDKBK
         Qu9D03OhuiFBK+uXfreWzdroB4fV7HD3L6pJqvCQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.14 36/36] drm/ioctl: Fix Spectre v1 vulnerabilities
Date:   Fri, 28 Dec 2018 12:52:52 +0100
Message-Id: <20181228113128.729676917@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.526729877@linuxfoundation.org>
References: <20181228113126.526729877@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 505b5240329b922f21f91d5b5d1e535c805eca6d upstream.

nr is indirectly controlled by user-space, hence leading to a
potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/gpu/drm/drm_ioctl.c:805 drm_ioctl() warn: potential spectre issue 'dev->driver->ioctls' [r]
drivers/gpu/drm/drm_ioctl.c:810 drm_ioctl() warn: potential spectre issue 'drm_ioctls' [r] (local cap)
drivers/gpu/drm/drm_ioctl.c:892 drm_ioctl_flags() warn: potential spectre issue 'drm_ioctls' [r] (local cap)

Fix this by sanitizing nr before using it to index dev->driver->ioctls
and drm_ioctls.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20181220000015.GA18973@embeddedor
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_ioctl.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -37,6 +37,7 @@
 
 #include <linux/pci.h>
 #include <linux/export.h>
+#include <linux/nospec.h>
 
 /**
  * DOC: getunique and setversion story
@@ -778,13 +779,17 @@ long drm_ioctl(struct file *filp,
 
 	if (is_driver_ioctl) {
 		/* driver ioctl */
-		if (nr - DRM_COMMAND_BASE >= dev->driver->num_ioctls)
+		unsigned int index = nr - DRM_COMMAND_BASE;
+
+		if (index >= dev->driver->num_ioctls)
 			goto err_i1;
-		ioctl = &dev->driver->ioctls[nr - DRM_COMMAND_BASE];
+		index = array_index_nospec(index, dev->driver->num_ioctls);
+		ioctl = &dev->driver->ioctls[index];
 	} else {
 		/* core ioctl */
 		if (nr >= DRM_CORE_IOCTL_COUNT)
 			goto err_i1;
+		nr = array_index_nospec(nr, DRM_CORE_IOCTL_COUNT);
 		ioctl = &drm_ioctls[nr];
 	}
 
@@ -866,6 +871,7 @@ bool drm_ioctl_flags(unsigned int nr, un
 
 	if (nr >= DRM_CORE_IOCTL_COUNT)
 		return false;
+	nr = array_index_nospec(nr, DRM_CORE_IOCTL_COUNT);
 
 	*flags = drm_ioctls[nr].flags;
 	return true;


