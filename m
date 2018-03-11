Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932215AbeCKQ2G (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 12:28:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44011 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932136AbeCKQ2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 12:28:05 -0400
From: Colin King <colin.king@canonical.com>
To: Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][rds-next] rds: remove redundant variable 'sg_off'
Date: Sun, 11 Mar 2018 17:27:56 +0100
Message-Id: <20180311162756.26950-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable sg_off is assigned a value but it is never read, hence it is
redundant and can be removed.

Cleans up clang warning:
net/rds/message.c:373:2: warning: Value stored to 'sg_off' is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/rds/message.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/rds/message.c b/net/rds/message.c
index 90dcdcfe9f62..9c41bdd9e444 100644
--- a/net/rds/message.c
+++ b/net/rds/message.c
@@ -357,7 +357,6 @@ struct rds_message *rds_message_map_pages(unsigned long *page_addrs, unsigned in
 
 int rds_message_zcopy_from_user(struct rds_message *rm, struct iov_iter *from)
 {
-	unsigned long sg_off;
 	struct scatterlist *sg;
 	int ret = 0;
 	int length = iov_iter_count(from);
@@ -370,7 +369,6 @@ int rds_message_zcopy_from_user(struct rds_message *rm, struct iov_iter *from)
 	 * now allocate and copy in the data payload.
 	 */
 	sg = rm->data.op_sg;
-	sg_off = 0; /* Dear gcc, sg->page will be null from kzalloc. */
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
-- 
2.15.1
