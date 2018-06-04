Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753637AbeFDHDx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:03:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752713AbeFDHDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:03:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Himanshu Jha <himanshujha199640@gmail.com>,
        Sinclair Yeh <syeh@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH 4.16 08/47] drm/vmwgfx: Use kasprintf
Date: Mon,  4 Jun 2018 08:58:20 +0200
Message-Id: <20180604065549.840192006@linuxfoundation.org>
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

From: Himanshu Jha <himanshujha199640@gmail.com>

commit 6073a09210e06f39adabd682c282b3ee14c3d33d upstream.

Use kasprintf instead of combination of kmalloc and sprintf. Also,
remove the local variables used for storing the string length as they
are not required now.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
Reviewed-by: Sinclair Yeh <syeh@vmware.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -328,7 +328,7 @@ int vmw_host_get_guestinfo(const char *g
 {
 	struct rpc_channel channel;
 	char *msg, *reply = NULL;
-	size_t msg_len, reply_len = 0;
+	size_t reply_len = 0;
 	int ret = 0;
 
 
@@ -338,15 +338,12 @@ int vmw_host_get_guestinfo(const char *g
 	if (!guest_info_param || !length)
 		return -EINVAL;
 
-	msg_len = strlen(guest_info_param) + strlen("info-get ") + 1;
-	msg = kzalloc(msg_len, GFP_KERNEL);
+	msg = kasprintf(GFP_KERNEL, "info-get %s", guest_info_param);
 	if (!msg) {
 		DRM_ERROR("Cannot allocate memory to get %s", guest_info_param);
 		return -ENOMEM;
 	}
 
-	sprintf(msg, "info-get %s", guest_info_param);
-
 	if (vmw_open_channel(&channel, RPCI_PROTOCOL_NUM) ||
 	    vmw_send_msg(&channel, msg) ||
 	    vmw_recv_msg(&channel, (void *) &reply, &reply_len) ||
@@ -388,7 +385,6 @@ int vmw_host_log(const char *log)
 {
 	struct rpc_channel channel;
 	char *msg;
-	int msg_len;
 	int ret = 0;
 
 
@@ -398,15 +394,12 @@ int vmw_host_log(const char *log)
 	if (!log)
 		return ret;
 
-	msg_len = strlen(log) + strlen("log ") + 1;
-	msg = kzalloc(msg_len, GFP_KERNEL);
+	msg = kasprintf(GFP_KERNEL, "log %s", log);
 	if (!msg) {
 		DRM_ERROR("Cannot allocate memory for log message\n");
 		return -ENOMEM;
 	}
 
-	sprintf(msg, "log %s", log);
-
 	if (vmw_open_channel(&channel, RPCI_PROTOCOL_NUM) ||
 	    vmw_send_msg(&channel, msg) ||
 	    vmw_close_channel(&channel)) {
