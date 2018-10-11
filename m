Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CF0C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489462147C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQW8wS69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489462147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbeJKXPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbeJKXPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:15:17 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1B25213A2;
        Thu, 11 Oct 2018 15:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272852;
        bh=9QCuywmfBYfLQxPJdiDDQJgi2OBnFKz4QENqNreM0wU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQW8wS69n3h+W5S3IXvxSJ5bJDJitPaJ+V+hWBevOuQXebcd1bfIE/1lG7GN7gzvp
         VaTF4dbf6fbXKYVveCO2bR3GTb7gL0i9uw+llFbGrnljFG9qu+Ce8GhXchyU3FuW5h
         NOVmRxiU6qrxkYGWoGhzX0KDFdjTQQcDq+qDQmsE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.18 17/44] drm: fix use-after-free read in drm_mode_create_lease_ioctl()
Date:   Thu, 11 Oct 2018 17:39:55 +0200
Message-Id: <20181011152453.238337437@linuxfoundation.org>
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

From: Jann Horn <jannh@google.com>

commit 12d43deb1ee639d01a2a8d2a7a4cc8ad31224475 upstream.

fd_install() moves the reference given to it into the file descriptor table
of the current process. If the current process is multithreaded, then
immediately after fd_install(), another thread can close() the file
descriptor and cause the file's resources to be cleaned up.

Since the reference to "lessee" is held by the file, we must not access
"lessee" after the fd_install() call.

As far as I can tell, to reach this codepath, the caller must have an open
file descriptor to a DRI device in master mode. I'm not sure what the
requirements for that are.

Signed-off-by: Jann Horn <jannh@google.com>
Fixes: 62884cd386b8 ("drm: Add four ioctls for managing drm mode object leases [v7]")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20181001153117.216923-1-jannh@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_lease.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -566,14 +566,14 @@ int drm_mode_create_lease_ioctl(struct d
 	lessee_priv->is_master = 1;
 	lessee_priv->authenticated = 1;
 
-	/* Hook up the fd */
-	fd_install(fd, lessee_file);
-
 	/* Pass fd back to userspace */
 	DRM_DEBUG_LEASE("Returning fd %d id %d\n", fd, lessee->lessee_id);
 	cl->fd = fd;
 	cl->lessee_id = lessee->lessee_id;
 
+	/* Hook up the fd */
+	fd_install(fd, lessee_file);
+
 	DRM_DEBUG_LEASE("drm_mode_create_lease_ioctl succeeded\n");
 	return 0;
 


