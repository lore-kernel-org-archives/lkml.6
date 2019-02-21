Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8654C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842A02083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfBUSWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:22:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:59562 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726155AbfBUSWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:22:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B3A69AFC0;
        Thu, 21 Feb 2019 18:22:42 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] nvmet: disable direct I/O when unavailable
Date:   Thu, 21 Feb 2019 19:22:34 +0100
Message-Id: <20190221182234.22345-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some file-systems, like tmpfs, do not support direct IO, but file-backed
namespaces default to using direct IO. If direct IO is unavailable fall
back to using buffered IO for the file-backed namespace.

This might not ultimately be a solution for production environments but
for test environments it sometimes is feasible to use tmpfs.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/nvme/target/io-cmd-file.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 517522305e5c..8a861cc0160e 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -38,11 +38,21 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 
 	ns->file = filp_open(ns->device_path, flags, 0);
 	if (IS_ERR(ns->file)) {
+		if (ns->file == ERR_PTR(-EINVAL) && (flags & O_DIRECT)) {
+			flags &= ~O_DIRECT;
+			ns->buffered_io = 0;
+			ns->file = filp_open(ns->device_path, flags, 0);
+			if (!IS_ERR(ns->file)) {
+				pr_info("direct I/O unavailable, falling back to buffered I/O\n");
+				goto getattr;
+			}
+		}
 		pr_err("failed to open file %s: (%ld)\n",
 				ns->device_path, PTR_ERR(ns->file));
 		return PTR_ERR(ns->file);
 	}
 
+getattr:
 	ret = vfs_getattr(&ns->file->f_path,
 			&stat, STATX_SIZE, AT_STATX_FORCE_SYNC);
 	if (ret)
-- 
2.16.4

