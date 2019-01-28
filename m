Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C6EC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49AC2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691856;
	bh=tNKOX75pnekJKf/gmlhYfUmfvUg4FxLKHyeykOYjtaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1G3ljrfdK3NW6M6X5Py4dh5oMqrwA8B/e+94qKiT7uX12AcOwX6jH+4nPy+FuiZV2
	 fE+9tHLUrUioqJa8vAkCm9HjLhoHqCZIZOkQSwW5XHRGE/6Fz/UrtBcsCk8/0lATf6
	 9tCbaI36xtuOP3kgpUUFZsLY3W0p1ungVIvK91Vc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732885AbfA1QKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:10:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731666AbfA1QKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:10:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFDFC2084A;
        Mon, 28 Jan 2019 16:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691852;
        bh=tNKOX75pnekJKf/gmlhYfUmfvUg4FxLKHyeykOYjtaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JoHKvhZoRxZFRKYWhicHqWYP85m80GK8nLmK0wMe6moIZEr9u9Z9Fm40bKo6EXvAn
         AeETepY8tMZsSl0QRNIdXvxPAS/sl3L5tX7voQYyB4M9HWPukUULhQg52Hv+PLg6+b
         T50HaCxb6ufh5k+wzZyY4rrttGeNIrymdzrxXhhc=
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
Subject: [PATCH AUTOSEL 4.19 237/258] ocfs2: improve ocfs2 Makefile
Date:   Mon, 28 Jan 2019 10:59:03 -0500
Message-Id: <20190128155924.51521-237-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
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

