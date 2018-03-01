Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935723AbeCACFh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 21:05:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932134AbeCACFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 21:05:36 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C102B21771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sstabellini@kernel.org
Date: Wed, 28 Feb 2018 18:05:34 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To: jgross@suse.com, boris.ostrovsky@oracle.com
cc: sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] pvcalls-front: 64-bit align flags
Message-ID: <alpine.DEB.2.10.1802281803430.4239@sstabellini-ThinkPad-X260>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are using test_and_* operations on the status and flag fields of
struct sock_mapping. However, these functions require the operand to be
64-bit aligned on arm64. Currently, only status is 64-bit aligned.

Make status and flags explicitly 64-bit aligned.

Signed-off-by: Stefano Stabellini <stefano@aporeto.com>

---
Changes in v2:
- use __attribute__((aligned(8)))
- add comments

diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index ca5b773..582929e 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -73,20 +73,25 @@ struct sock_mapping {
 			wait_queue_head_t inflight_conn_req;
 		} active;
 		struct {
-		/* Socket status */
+		/*
+		 * Socket status, needs to be 64-bit aligned due to the
+		 * test_and_* functions which have this requirement on arm64.
+		 */
 #define PVCALLS_STATUS_UNINITALIZED  0
 #define PVCALLS_STATUS_BIND          1
 #define PVCALLS_STATUS_LISTEN        2
-			uint8_t status;
+			uint8_t status __attribute__((aligned(8)));
 		/*
 		 * Internal state-machine flags.
 		 * Only one accept operation can be inflight for a socket.
 		 * Only one poll operation can be inflight for a given socket.
+		 * flags needs to be 64-bit aligned due to the test_and_*
+		 * functions which have this requirement on arm64.
 		 */
 #define PVCALLS_FLAG_ACCEPT_INFLIGHT 0
 #define PVCALLS_FLAG_POLL_INFLIGHT   1
 #define PVCALLS_FLAG_POLL_RET        2
-			uint8_t flags;
+			uint8_t flags __attribute__((aligned(8)));
 			uint32_t inflight_req_id;
 			struct sock_mapping *accept_map;
 			wait_queue_head_t inflight_accept_req;
