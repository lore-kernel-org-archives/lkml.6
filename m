Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753261AbeE3LhU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:37:20 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60802 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752318AbeE3LHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:02 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Doug Ledford" <dledford@redhat.com>,
        "Leon Romanovsky" <leonro@mellanox.com>,
        syzbot+a38b0e9f694c379ca7ce@syzkaller.appspotmail.com
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.610345481@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 117/153] RDMA/ucma: Limit possible option size
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit 6a21dfc0d0db7b7e0acedce67ca533a6eb19283c upstream.

Users of ucma are supposed to provide size of option level,
in most paths it is supposed to be equal to u8 or u16, but
it is not the case for the IB path record, where it can be
multiple of struct ib_path_rec_data.

This patch takes simplest possible approach and prevents providing
values more than possible to allocate.

Reported-by: syzbot+a38b0e9f694c379ca7ce@syzkaller.appspotmail.com
Fixes: 7ce86409adcd ("RDMA/ucma: Allow user space to set service type")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/core/ucma.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1000,6 +1000,9 @@ static ssize_t ucma_set_option(struct uc
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
+	if (unlikely(cmd.optval > KMALLOC_MAX_SIZE))
+		return -EINVAL;
+
 	optval = kmalloc(cmd.optlen, GFP_KERNEL);
 	if (!optval) {
 		ret = -ENOMEM;
