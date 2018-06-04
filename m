Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753829AbeFDHPh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753620AbeFDHDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:03:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Hellstrom <thellstrom@vmware.com>,
        Brian Paul <brianp@vmware.com>, Sinclair Yeh <syeh@vmware.com>
Subject: [PATCH 4.16 09/47] drm/vmwgfx: Fix host logging / guestinfo reading error paths
Date: Mon,  4 Jun 2018 08:58:21 +0200
Message-Id: <20180604065549.875848533@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065549.468488465@linuxfoundation.org>
References: <20180604065549.468488465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Hellstrom <thellstrom@vmware.com>

commit f37230c0ad481091bc136788ff8b37dc86300c6d upstream.

The error paths were leaking opened channels.
Fix by using dedicated error paths.

Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Brian Paul <brianp@vmware.com>
Reviewed-by: Sinclair Yeh <syeh@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c |   48 +++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 17 deletions(-)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -329,8 +329,6 @@ int vmw_host_get_guestinfo(const char *g
 	struct rpc_channel channel;
 	char *msg, *reply = NULL;
 	size_t reply_len = 0;
-	int ret = 0;
-
 
 	if (!vmw_msg_enabled)
 		return -ENODEV;
@@ -344,15 +342,14 @@ int vmw_host_get_guestinfo(const char *g
 		return -ENOMEM;
 	}
 
-	if (vmw_open_channel(&channel, RPCI_PROTOCOL_NUM) ||
-	    vmw_send_msg(&channel, msg) ||
-	    vmw_recv_msg(&channel, (void *) &reply, &reply_len) ||
-	    vmw_close_channel(&channel)) {
-		DRM_ERROR("Failed to get %s", guest_info_param);
+	if (vmw_open_channel(&channel, RPCI_PROTOCOL_NUM))
+		goto out_open;
 
-		ret = -EINVAL;
-	}
+	if (vmw_send_msg(&channel, msg) ||
+	    vmw_recv_msg(&channel, (void *) &reply, &reply_len))
+		goto out_msg;
 
+	vmw_close_channel(&channel);
 	if (buffer && reply && reply_len > 0) {
 		/* Remove reply code, which are the first 2 characters of
 		 * the reply
@@ -369,7 +366,17 @@ int vmw_host_get_guestinfo(const char *g
 	kfree(reply);
 	kfree(msg);
 
-	return ret;
+	return 0;
+
+out_msg:
+	vmw_close_channel(&channel);
+	kfree(reply);
+out_open:
+	*length = 0;
+	kfree(msg);
+	DRM_ERROR("Failed to get %s", guest_info_param);
+
+	return -EINVAL;
 }
 
 
@@ -400,15 +407,22 @@ int vmw_host_log(const char *log)
 		return -ENOMEM;
 	}
 
-	if (vmw_open_channel(&channel, RPCI_PROTOCOL_NUM) ||
-	    vmw_send_msg(&channel, msg) ||
-	    vmw_close_channel(&channel)) {
-		DRM_ERROR("Failed to send log\n");
+	if (vmw_open_channel(&channel, RPCI_PROTOCOL_NUM))
+		goto out_open;
 
-		ret = -EINVAL;
-	}
+	if (vmw_send_msg(&channel, msg))
+		goto out_msg;
+
+	vmw_close_channel(&channel);
+	kfree(msg);
+
+	return 0;
 
+out_msg:
+	vmw_close_channel(&channel);
+out_open:
 	kfree(msg);
+	DRM_ERROR("Failed to send log\n");
 
-	return ret;
+	return -EINVAL;
 }
