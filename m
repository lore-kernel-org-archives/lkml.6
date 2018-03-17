Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbeCQQoY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 12:44:24 -0400
Received: from p3plsmtpa07-05.prod.phx3.secureserver.net ([173.201.192.234]:36469
        "EHLO p3plsmtpa07-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751304AbeCQQoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 12:44:21 -0400
From: Kyle Spiers <kyle@spiers.me>
To: idryomov@gmail.com
Cc: sage@redhat.com, elder@kernel.org, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org, me@tobin.cc,
        Kyle Spiers <kyle@spiers.me>
Subject: [PATCH v3] rbd: Remove VLA usage
Date: Sat, 17 Mar 2018 09:44:01 -0700
Message-Id: <1521305041-18181-1-git-send-email-kyle@spiers.me>
X-Mailer: git-send-email 2.7.4
X-CMAE-Envelope: MS4wfON3VnCVQJhfJWjTyCr+FFfDy/E3u1Qigv//j6kJgeaAlsIuNf2Y8RF2gCDBorkunvQccqYRJM/eLhOkld8zjlRxMnriqnInf+tZR/v/36EqfTcD7fdZ
 5ggwN6LWZrmHFtZPdAPbj4hxnvV4YDLfjRFmxDDZvn/NNqRHQjMnbL55sYQ+VipEs2cYO/42picYgqqF7KFucAZ6ufM6UauMM3UeZgsQuB7Vbecberr9wqX0
 BXB/e78tY0j/9Y3dGPweVxXLMsQzCLNhR0I/B7PaWeua27YZuuBaClqh9Xp3qZ1/9dz26Hz16g+FwwRu+N7u3977J+7FBaerO4aG6TYkIxzghXYlNwPItvwI
 lHa2RHcdj48zjZUF+PlNXNGTOPoH9gwTwFBvAY1NO03x7T1iV1k=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 
As part of the effort to remove VLAs from the kernel[1], this moves
the literal values into the stack array calculation instead of using a
variable for the sizing. The resulting size can be found from
sizeof(buf).

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Kyle Spiers <kyle@spiers.me>
---
 drivers/block/rbd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8e40da0..46893e0 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3100,8 +3100,8 @@ static int __rbd_notify_op_lock(struct rbd_device *rbd_dev,
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	struct rbd_client_id cid = rbd_get_cid(rbd_dev);
-	int buf_size = 4 + 8 + 8 + CEPH_ENCODING_START_BLK_LEN;
-	char buf[buf_size];
+	char buf[4 + 8 + 8 + CEPH_ENCODING_START_BLK_LEN];
+	int buf_size = sizeof(buf);
 	void *p = buf;
 
 	dout("%s rbd_dev %p notify_op %d\n", __func__, rbd_dev, notify_op);
@@ -3619,8 +3619,8 @@ static void __rbd_acknowledge_notify(struct rbd_device *rbd_dev,
 				     u64 notify_id, u64 cookie, s32 *result)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
-	int buf_size = 4 + CEPH_ENCODING_START_BLK_LEN;
-	char buf[buf_size];
+	char buf[4 + CEPH_ENCODING_START_BLK_LEN];
+	int buf_size = sizeof(buf);
 	int ret;
 
 	if (result) {
-- 
2.7.4
