Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750757AbeCPEdP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 00:33:15 -0400
Received: from p3plsmtpa12-07.prod.phx3.secureserver.net ([68.178.252.236]:59069
        "EHLO p3plsmtpa12-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750847AbeCPEdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 00:33:13 -0400
From: Kyle Spiers <kyle@spiers.me>
To: idryomov@gmail.com
Cc: sage@redhat.com, elder@kernel.org, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org, me@tobin.cc,
        Kyle Spiers <kyle@spiers.me>
Subject: [PATCH v2] rbd: Remove VLA usage
Date: Thu, 15 Mar 2018 21:32:43 -0700
Message-Id: <1521174763-13282-1-git-send-email-kyle@spiers.me>
X-Mailer: git-send-email 2.7.4
X-CMAE-Envelope: MS4wfIbdVyIEGPveWOMcqjjd+vopCcCADHOoeNMqoKSysOU+fvkNyqKBdqamXhH4TcIN4ejZ8FOc63X87ERyf59xW02hVLFZ8TIbrKf3q8AiyWHtFGqkSkob
 iprCN12lDcDbog6nIUBFnLDb9P5J1mXk/eDnjn8P5moCr0ea5CAXYAiozyJhJocIbxTOR5BAJohuNse7fcQigWmb5D0ny0x1O/VN3mhM/og1WTHHunI8u11c
 +WiX/5Eq6cwSggJ3F1BDm30+dBhOQnWCsRsfy3htbGZZYNaMTXNpytdBVuN5Id7rE8pkkfxTPYG75hlooKSUqVaKRQVO13nZ2OLZtYhF0dOvdlDLKoPAcdGS
 yjIrykcGTlFCEeEtA3fDqCfLt4yx/CkS/GI0OIi2XrV7mwfGyF0=
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
index 8e40da0..0e94e1f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3100,8 +3100,8 @@ static int __rbd_notify_op_lock(struct rbd_device *rbd_dev,
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	struct rbd_client_id cid = rbd_get_cid(rbd_dev);
-	int buf_size = 4 + 8 + 8 + CEPH_ENCODING_START_BLK_LEN;
-	char buf[buf_size];
+	char buf[4 + 4 + 8 + 8 + CEPH_ENCODING_START_BLK_LEN];
+	int buf_size = sizeof(buf)
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
