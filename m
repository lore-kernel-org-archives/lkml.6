Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CB8C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07AAE20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07AAE20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeKHSaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:30:35 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:46635 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKHSaf (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 8 Nov 2018 13:30:35 -0500
Received: from Alpha.suse.asia (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (NOT encrypted); Thu, 08 Nov 2018 01:55:55 -0700
From:   Larry Chen <lchen@suse.com>
To:     mark@fasheh.com, jlbec@evilplan.org
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        akpm@linux-foundation.org
Subject: [PATCH] ocfs2: Improve ocfs2 Makefile
Date:   Thu,  8 Nov 2018 16:55:46 +0800
Message-Id: <20181108085546.15149-1-lchen@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Included file path was fixed in ocfs2 makefile, which might causes some
confusion when compiling ocfs2 as an external module.

Say if we compile ocfs2 module as following.
cp -r /kernel/tree/fs/ocfs2 /other/dir/ocfs2
cd /other/dir/ocfs2
make -C /path/to/kernel_source M=`pwd` modules

Acutally, the compiler wil try to find included file in
/kernel/tree/fs/ocfs2, rather than the directory /other/dir/ocfs2.

To fix this little bug, we introduce the var $(src) provided by kbuild.
$(src) means the absolute path of the running kbuild file.

Signed-off-by: Larry Chen <lchen@suse.com>
---
 fs/ocfs2/Makefile       | 2 +-
 fs/ocfs2/dlm/Makefile   | 2 +-
 fs/ocfs2/dlmfs/Makefile | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/Makefile b/fs/ocfs2/Makefile
index 99ee093182cb..cc9b32b9db7c 100644
--- a/fs/ocfs2/Makefile
+++ b/fs/ocfs2/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ccflags-y := -Ifs/ocfs2
+ccflags-y := -I$(src)
 
 obj-$(CONFIG_OCFS2_FS) += 	\
 	ocfs2.o			\
diff --git a/fs/ocfs2/dlm/Makefile b/fs/ocfs2/dlm/Makefile
index bd1aab1f49a4..ef2854422a6e 100644
--- a/fs/ocfs2/dlm/Makefile
+++ b/fs/ocfs2/dlm/Makefile
@@ -1,4 +1,4 @@
-ccflags-y := -Ifs/ocfs2
+ccflags-y := -I$(src)/..
 
 obj-$(CONFIG_OCFS2_FS_O2CB) += ocfs2_dlm.o
 
diff --git a/fs/ocfs2/dlmfs/Makefile b/fs/ocfs2/dlmfs/Makefile
index eed3db8c5b49..33431a0296a3 100644
--- a/fs/ocfs2/dlmfs/Makefile
+++ b/fs/ocfs2/dlmfs/Makefile
@@ -1,4 +1,4 @@
-ccflags-y := -Ifs/ocfs2
+ccflags-y := -I$(src)/..
 
 obj-$(CONFIG_OCFS2_FS) += ocfs2_dlmfs.o
 
-- 
2.16.4

