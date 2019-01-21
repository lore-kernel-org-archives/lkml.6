Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504EBC2F3D5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B3920861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080309;
	bh=9OPBJRMHtMAZ2AEq59NtEzk8JJRBCGkultQqq4wz9DE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eQzPLAVyJGk9n1j3uorH8CvrX3w+qsW1Q525OdhUjNh1W+ehE3OffJVhMjJijmbX/
	 BgNBD+h9HhxCq24bbRfybzlc3ZJh13RbYDGFDG3X9lwjbMcP+KaxpDE4hcqHG4yQYO
	 SDfd6guOnTWktzadCTn0GwPnEf7nONMkBZZ+j8Hk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbfAUOS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:18:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:60456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729712AbfAUNtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:49:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E846220879;
        Mon, 21 Jan 2019 13:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078584;
        bh=9OPBJRMHtMAZ2AEq59NtEzk8JJRBCGkultQqq4wz9DE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D/M8gqAXqB+Lck2eDpUoCQAY6PioRmE1i12+h02Wge4/vZvTMgs+6B2a5T0BF+2Ny
         8VOOR2SP3M+zaR7+2i3wSEupXhprY0mWaaPo01tJ+NIpWsYozEDTjZJyqgg9F8vTe4
         a76yBAdhE2K6cRPbjLn6/4j84IHSPHeBCE5CVqDM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+eb6e5365f23c02517dda@syzkaller.appspotmail.com,
        Daniel Vetter <daniel.vetter@intel.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 4.20 082/111] drm/vkms: Fix plane duplicate_state
Date:   Mon, 21 Jan 2019 14:43:16 +0100
Message-Id: <20190121122505.295469164@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

From: Daniel Vetter <daniel.vetter@ffwll.ch>

commit 7cdf33ab02e01300e7e6289acbac9cd8759f8712 upstream.

We need to handle allocation failures and bail out. While at it, tune
the allocation failures down to debug level.

syzbot injected an allocation failure and then hit this WARN_ON.

Reported-by: syzbot+eb6e5365f23c02517dda@syzkaller.appspotmail.com
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Gustavo Padovan <gustavo.padovan@collabora.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20181128101033.4840-1-daniel.vetter@ffwll.ch
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vkms/vkms_plane.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -23,8 +23,11 @@ vkms_plane_duplicate_state(struct drm_pl
 		return NULL;
 
 	crc_data = kzalloc(sizeof(*crc_data), GFP_KERNEL);
-	if (WARN_ON(!crc_data))
-		DRM_INFO("Couldn't allocate crc_data");
+	if (!crc_data) {
+		DRM_DEBUG_KMS("Couldn't allocate crc_data\n");
+		kfree(vkms_state);
+		return NULL;
+	}
 
 	vkms_state->crc_data = crc_data;
 


