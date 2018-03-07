Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754632AbeCGSD6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:03:58 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:32860 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753949AbeCGSDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:03:52 -0500
X-Google-Smtp-Source: AG47ELtfvZ1xWFwNLt0kxmx1mcUbnlwaKA8nLjUY5eHyHBqBZouGNo0SUtDU8tJ9Yv56XWkV6js/CA==
From: Himanshu Jha <himanshujha199640@gmail.com>
To: linux-graphics-maintainer@vmware.com, airlied@linux.ie
Cc: syeh@vmware.com, thellstrom@vmware.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH] drm/vmwgfx: Use kasprintf
Date: Wed,  7 Mar 2018 23:33:22 +0530
Message-Id: <1520445802-11894-1-git-send-email-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kasprintf instead of combination of kmalloc and sprintf. Also,
remove the local variables used for storing the string length as they
are not required now.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index 9700099..cdff992 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -328,7 +328,7 @@ int vmw_host_get_guestinfo(const char *guest_info_param,
 {
 	struct rpc_channel channel;
 	char *msg, *reply = NULL;
-	size_t msg_len, reply_len = 0;
+	size_t reply_len = 0;
 	int ret = 0;
 
 
@@ -338,15 +338,12 @@ int vmw_host_get_guestinfo(const char *guest_info_param,
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
-- 
2.7.4
