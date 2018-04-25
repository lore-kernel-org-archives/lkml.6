Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753350AbeDYLdq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:33:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752868AbeDYLdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:33:44 -0400
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        ocfs2-devel <ocfs2-devel@oss.oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC: Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>,
        "Kefeng Wang" <wangkefeng.wang@huawei.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] ocfs2: eliminate a misreported warning
Date: Wed, 25 Apr 2018 19:29:59 +0800
Message-ID: <1524655799-12112-1-git-send-email-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below warning can not be happened, because the parameter chunksize passed
from ocfs2_info_freefrag_scan_chain-->ocfs2_info_update_ffg is guaranteed
to be positive. So __ilog2_u32 is impossible return -1.

fs/ocfs2/ioctl.c: In function 'ocfs2_info_update_ffg':
fs/ocfs2/ioctl.c:411:17: warning: array subscript is below array bounds [-Warray-bounds]
  hist->fc_chunks[index]++;
                 ^
fs/ocfs2/ioctl.c:411:17: warning: array subscript is below array bounds [-Warray-bounds]

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 fs/ocfs2/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/ioctl.c b/fs/ocfs2/ioctl.c
index ab30c005..994726a 100644
--- a/fs/ocfs2/ioctl.c
+++ b/fs/ocfs2/ioctl.c
@@ -402,7 +402,7 @@ static int ocfs2_info_handle_freeinode(struct inode *inode,
 static void o2ffg_update_histogram(struct ocfs2_info_free_chunk_list *hist,
 				   unsigned int chunksize)
 {
-	int index;
+	u32 index;

 	index = __ilog2_u32(chunksize);
 	if (index >= OCFS2_INFO_MAX_HIST)
--
1.8.3
