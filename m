Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B23C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6962081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895633;
	bh=VsPTs9RkOfcvTZuFOLuAyOIN3r3cGypf5HAWRH8E6Cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j9Zrv0pJunnbFMVOn6aMV8xYACX8PgUxh1tDymWnbzDEvUAPRmOQC5teg6pDT37Fe
	 oAxjWYUUxbCk7qOwN+krlISRN/pB6KIs2Q4i5pWp+qJlTac3N2bjdHGjvzX0i4+i8i
	 L/DgvowHXmfv23UqnJoexQEAP3EULJJqKFECGTqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbfBKOdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:33:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:41640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730176AbfBKOdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:33:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63D2F222A1;
        Mon, 11 Feb 2019 14:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895625;
        bh=VsPTs9RkOfcvTZuFOLuAyOIN3r3cGypf5HAWRH8E6Cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RBieidmWdwAqPJ3Bfxy462CdpWPrZ1jSQ6Y6A1HNGZeMOi2pV9SGA7+rYul89tmtx
         MzFOiuItDr30iKlQwW/cOtNlCklZzVemf8pIq5L8NrOSANzjrUPDscRhZnp5t75P/U
         c/wjHUOWquHbWsSs093YAbMwwZr8SrfQUCQmxGoQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Larry Chen <lchen@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Joseph Qi <jiangqi903@gmail.com>,
        Changwei Ge <ge.changwei@h3c.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 267/352] ocfs2: improve ocfs2 Makefile
Date:   Mon, 11 Feb 2019 15:18:14 +0100
Message-Id: <20190211141904.015468198@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



