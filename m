Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085B7C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0AD21841
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691079;
	bh=tNKOX75pnekJKf/gmlhYfUmfvUg4FxLKHyeykOYjtaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oEtAKzVSI5MOcazlsvLGpyHvjRa+xM3kHICAs9xdM/NGKgIHUce+0ALZla1SZKRKc
	 oQYr1P7WMeN6VW9fe5BVcWIKWDQYgSrOvehmaTvXDA6HIK4cFNXWArOcjpza5JCNVc
	 y6BZXxrtKA4pztcBttMM5oCPXUyV3L/0rofbLECc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbfA1P56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:57:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:43372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730316AbfA1P55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:57:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E1F421783;
        Mon, 28 Jan 2019 15:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691076;
        bh=tNKOX75pnekJKf/gmlhYfUmfvUg4FxLKHyeykOYjtaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uyXmcAPdQEfKf6oB5g5K+6KE6XzNBngKYxB71Gpkx3tbo13KkmGyV/8NlIjBZ3HnD
         WLZ+PyGEcTLEXtCXT0RSlGLUuQEAeyd4wEs8GxuXpnYctNLQQrAdqNfNz6WSRXnEI2
         kYP4BtUZ2SxQew++slCcbHphqpKkGkc1aruhYlVY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Larry Chen <lchen@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Joseph Qi <jiangqi903@gmail.com>,
        Changwei Ge <ge.changwei@h3c.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 280/304] ocfs2: improve ocfs2 Makefile
Date:   Mon, 28 Jan 2019 10:43:17 -0500
Message-Id: <20190128154341.47195-280-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Larry Chen <lchen@suse.com>

[ Upstream commit 9e6aea22802b5684c7e1d69822aeb0844dd01953 ]

Included file path was hard-wired in the ocfs2 makefile, which might
causes some confusion when compiling ocfs2 as an external module.

Say if we compile ocfs2 module as following.
cp -r /kernel/tree/fs/ocfs2 /other/dir/ocfs2
cd /other/dir/ocfs2
make -C /path/to/kernel_source M=`pwd` modules

Acutally, the compiler wil try to find included file in
/kernel/tree/fs/ocfs2, rather than the directory /other/dir/ocfs2.

To fix this little bug, we introduce the var $(src) provided by kbuild.
$(src) means the absolute path of the running kbuild file.

Link: http://lkml.kernel.org/r/20181108085546.15149-1-lchen@suse.com
Signed-off-by: Larry Chen <lchen@suse.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Joseph Qi <jiangqi903@gmail.com>
Cc: Changwei Ge <ge.changwei@h3c.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.19.1

