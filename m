Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423076AbeE1MOc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:14:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422952AbeE1LDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:03:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Deepak Rawat <drawat@vmware.com>,
        Sinclair Yeh <syeh@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH 4.14 496/496] drm/vmwgfx: Set dmabuf_size when vmw_dmabuf_init is successful
Date: Mon, 28 May 2018 12:04:41 +0200
Message-Id: <20180528100340.780737750@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Deepak Rawat <drawat@vmware.com>

commit 91ba9f28a3de97761c2b5fd5df5d88421268e507 upstream.

SOU primary plane prepare_fb hook depends upon dmabuf_size to pin up BO
(and not call a new vmw_dmabuf_init) when a new fb size is same as
current fb. This was changed in a recent commit which is causing
page_flip to fail on VM with low display memory and multi-mon failure
when cycle monitors from secondary display.

Cc: <stable@vger.kernel.org> # 4.14, 4.16
Fixes: 20fb5a635a0c ("drm/vmwgfx: Unpin the screen object backup buffer when not used")
Signed-off-by: Deepak Rawat <drawat@vmware.com>
Reviewed-by: Sinclair Yeh <syeh@vmware.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
@@ -530,6 +530,8 @@ vmw_sou_primary_plane_prepare_fb(struct
 		return ret;
 	}
 
+	vps->dmabuf_size = size;
+
 	/*
 	 * TTM already thinks the buffer is pinned, but make sure the
 	 * pin_count is upped.
